From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Sat, 3 Jan 2004 11:47:51 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0401031051350.4413-100000@raven.themaw.net>
References: <Pine.LNX.4.53.0401021608460.3551@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0401021608460.3551@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 2 Jan 2004, Jim Carter wrote:

> On Fri, 2 Jan 2004, Ian Kent wrote:
> > Stat would divulge that info as the access time is generally along with
> > last_used.
> 
> I wish!

It is. I don't have a copy of the vanilla module source handy but I haven't 
changed autofs4_update_usage so it should be the same as mine.

> 
> > I thought you were using autofs4. autofs_dir_ent stuff is in v3.
> 
> Oops, took a wrong turn in the source tree.  I looked through the *right*
> sources, and inode.c autofs4_get_inode() works the same as in v3, i.e.
> sets inode->i_[amc]time = CURRENT_TIME.
> 
> > I think the autofs_read_inode is used for initialization. Tracking the
> > code for sys_stat and sys_fstat it apears that this is not used.
> 
> I think you're right.  Hiss, boo.  Hmm, the dentry points to the inode
> storage, and so does the autofs_info structure.  If autofs4_update_usage
> updated the inode fields as well as (or instead of) inf->last_used, then
> (presumably) stat() would get the right times.  Or does sys_stat go
> directly to the mounted inode, ignoring the mount point?  Probably it's
> smart enough to do that, but even so the mount point inode is revalidated
> (autofs4_revalidate  is called).  We know this because the autofs4 module
> successfully keeps track of the last usage time.  So sys_fstat on a FD open
> on that inode should get the inode and not what's mounted on it.  It says
> here.

I believe it does. We can rely on the inode atime being equal to 
last_used. sys_stat goes directly to the inode.

Ah. reavalidate is called frequently. If you define DEBUG in 
the source header you'll see what I mean. It's much more busy when 
directories exist in the autofs4 tree (ie. mounted filesystems). The 
difficulty here has always been that you don't know what the reason of the 
call is (ie. an ls, open, stat ....). All you know is that there is a 
path_walk going on to resolve to a dentry. Better, the path_walk 
always follows the mounts, so stat gets its values from the mount point 
inode.

> 
> > One other thing which makes this hard is that the kernel module
> > will never see the opening of a path that is a mountpoint. The path walk
> > in the kernel will send this to the filesystem routines of the mount.
> 
> Well, autofs4_revalidate() does get called on each open, even if not much
> else gets called.

See above.

> 
> > Thinking more about it what are the situations that can cause this. If a
> > mount is busy it should never be offered as expired, regardless of its
> > last_used.
> 
> Right, expire.c :: autofs4_expire() bypasses a mount point if its last_used
> field is too recent, and then it checks is_tree_busy().  Oh, look, a kludge
> that could be added, how wonderful!  Assuming that it's feasible to get
> module-provided data into the inode data returned from sys_stat or
> sys_fstat, a mode bit could be set to indicate busyness, e.g. user write
> implies not busy.

A user write implies an open file. The expire routine must identify this 
dentry as busy or it's a bug that needs to be fixed.

I believe that we should never update kernel data structures in ways that 
are not, either provided by a kernel API call or are commonly accepted 
methods.

>
> Of course a race condition is possible: the userspace daemon is assured by
> the module that the mount point is not busy, someone uses it, the daemon
> then unmounts, and the unmount fails.  As it should.  Its response should
> be to poll the module again, and the module will confirm that the mount
> point is really busy (and with last_used artificially advanced to
> CURRENT_TIME).

Not sure about this.

This has been a source of pain for me recently. On the face of it, the 
module blocks mount requests for an expired dentry during the callback to 
the daemon.

> 
> > There is the possibility of a broken NFS server causing it but
> > perhaps that can be dealt with using an rpc_ping type thing and adding a
> > -f to the umount if it doesn't respond.
> 
> Hmm, I think you're saying (and I'm agreeing) that we're trying to solve
> the wrong problem.  Before the NFS server crashes, the mount point is busy
> with useful programs.  Then it crashes.  The ideal is, when it comes back
> it accepts the client's NFS handle and everything starts working again, and
> autofs doesn't do anything violent that would prevent that.  The reality,
> at least with soft mounts, is that the programs using the mount point are
> fatally wounded, but they linger.

Stale file handles abound. Not really autofss' problem, but yes, what can 
we do to improve the situation?

> 
> So the key task is to bulldoze aside the wreckage so a new instance of the
> revitalized NFS server can be mounted.  Killing the moribund processes and
> forcibly dismounting the destroyed filesystem instance are important so as
> to recover resources, but the client can continue to function for quite a
> long time even if that's not done; the only totally vital action is to be
> able to remount, and that can possibly be done by renaming, or by
> remounting the wreckage elsewhere, deferring the actual dismount.

I'll have to think about this for a while. The rename idea might cause all 
sorts of problems.

Anyway the problem should only occur if the mount point is no longer busy 
and has expired in which case we should be free to forcibly umount it. 
A process with stuff in use on the broken mount point will have a cow when 
it tries to do something like access an open file. In this case it's 
likely to need to be put down, leaving the way clear for a forced umount. 
A kill -9 on the blocked process needs further investigation. I'm not sure 
what the situation is there (probably not good).

> 
> NFS ping should be enough for recognizing a dead server.  That means each
> client's autofs would ping each mounted server once every 5 minutes.
> Presumably a lot more NFS activity is done by the active programs.
> 

But only for mounts that are not busy and have expired. And then every 
expiry if they fail to umount and then we return to what to do about the 
original problem you described. Perhaps the limit your original patch 
implemented is in fact a good idea and possibly all that is needed. If the 
looping is detected a warning could be printed to alert one to the 
possibility of a bug in the module.

One thing I noticed in the module expire routine is that it doesn't 
progress past a failed mount on subsequent calls. A change to the 
adjustment of the d_subdirs list is probably needed (a bit difficult, but 
not impossible, in my implementation of the expire routine).

By the way. Since you are obviously interested in autofs, it would 
be best if you could use the latest version. Please see kernel.org if 
you are able to update.

Ian
