From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Fri, 2 Jan 2004 17:03:59 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0401021608460.3551@xena.cft.ca.us>
References: <Pine.LNX.4.33.0401020813440.18518-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0401020813440.18518-100000@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 2 Jan 2004, Ian Kent wrote:
> Stat would divulge that info as the access time is generally along with
> last_used.

I wish!

> I thought you were using autofs4. autofs_dir_ent stuff is in v3.

Oops, took a wrong turn in the source tree.  I looked through the *right*
sources, and inode.c autofs4_get_inode() works the same as in v3, i.e.
sets inode->i_[amc]time = CURRENT_TIME.

> I think the autofs_read_inode is used for initialization. Tracking the
> code for sys_stat and sys_fstat it apears that this is not used.

I think you're right.  Hiss, boo.  Hmm, the dentry points to the inode
storage, and so does the autofs_info structure.  If autofs4_update_usage
updated the inode fields as well as (or instead of) inf->last_used, then
(presumably) stat() would get the right times.  Or does sys_stat go
directly to the mounted inode, ignoring the mount point?  Probably it's
smart enough to do that, but even so the mount point inode is revalidated
(autofs4_revalidate  is called).  We know this because the autofs4 module
successfully keeps track of the last usage time.  So sys_fstat on a FD open
on that inode should get the inode and not what's mounted on it.  It says
here.

> One other thing which makes this hard is that the kernel module
> will never see the opening of a path that is a mountpoint. The path walk
> in the kernel will send this to the filesystem routines of the mount.

Well, autofs4_revalidate() does get called on each open, even if not much
else gets called.

> Thinking more about it what are the situations that can cause this. If a
> mount is busy it should never be offered as expired, regardless of its
> last_used.

Right, expire.c :: autofs4_expire() bypasses a mount point if its last_used
field is too recent, and then it checks is_tree_busy().  Oh, look, a kludge
that could be added, how wonderful!  Assuming that it's feasible to get
module-provided data into the inode data returned from sys_stat or
sys_fstat, a mode bit could be set to indicate busyness, e.g. user write
implies not busy.

Of course a race condition is possible: the userspace daemon is assured by
the module that the mount point is not busy, someone uses it, the daemon
then unmounts, and the unmount fails.  As it should.  Its response should
be to poll the module again, and the module will confirm that the mount
point is really busy (and with last_used artificially advanced to
CURRENT_TIME).

> There is the possibility of a broken NFS server causing it but
> perhaps that can be dealt with using an rpc_ping type thing and adding a
> -f to the umount if it doesn't respond.

Hmm, I think you're saying (and I'm agreeing) that we're trying to solve
the wrong problem.  Before the NFS server crashes, the mount point is busy
with useful programs.  Then it crashes.  The ideal is, when it comes back
it accepts the client's NFS handle and everything starts working again, and
autofs doesn't do anything violent that would prevent that.  The reality,
at least with soft mounts, is that the programs using the mount point are
fatally wounded, but they linger.

So the key task is to bulldoze aside the wreckage so a new instance of the
revitalized NFS server can be mounted.  Killing the moribund processes and
forcibly dismounting the destroyed filesystem instance are important so as
to recover resources, but the client can continue to function for quite a
long time even if that's not done; the only totally vital action is to be
able to remount, and that can possibly be done by renaming, or by
remounting the wreckage elsewhere, deferring the actual dismount.

NFS ping should be enough for recognizing a dead server.  That means each
client's autofs would ping each mounted server once every 5 minutes.
Presumably a lot more NFS activity is done by the active programs.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
