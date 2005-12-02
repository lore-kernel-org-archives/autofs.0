From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Fri, 2 Dec 2005 23:21:14 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512022301280.2070@donald.themaw.net>
References: <20051116101740.GA9551@RAM>
	<17292.64892.680738.833917@segfault.boston.redhat.com>
	<1133315771.8978.65.camel@lade.trondhjem.org>
	<438E0C66.6040607@us.ibm.com>
	<1133384015.8974.35.camel@lade.trondhjem.org>
	<438E1A05.7000308@us.ibm.com>
	<Pine.LNX.4.63.0512011917010.3189@donald.themaw.net>
	<438F251B.7060602@us.ibm.com>
	<Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>
	<17296.21777.592381.958840@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17296.21777.592381.958840@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "William H. Taber" <wtaber@us.ibm.com>, Trond Myklebust <trond.myklebust@fys.uio.no>

On Fri, 2 Dec 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Thu, 1 Dec 2005, William H. Taber wrote:
> >> Ian Kent wrote: > On Wed, 30 Nov 2005, William H. Taber wrote:
> >> > 
> >> > 
> >> > > Trond Myklebust wrote:
> >> > > 
> >> > > > On Wed, 2005-11-30 at 15:32 -0500, William H. Taber wrote:
> >> > > > 
> >> > > > 
> >> > > > 
> >> > > > > Not only is there this case, but the original premise is wrong
> >> as > > > > well.  > > > > There is a second case in which a d_revalidate
> >> function is called with > > > > the > > > > parent i_sem and that is
> >> when it is called from inside of > > > > lookup_one_len.  > > > > What
> >> makes this tricky is that lookup_one_len is called from > > > >
> >> nfs_sillyrename from inside of nfs_rename which is called, naturally > >
> >> > > enough by sys_rename.  The rename code is very careful about the
> >> order > > > > in > > > > which it obtains the parent semaphores because
> >> it needs to get two of > > > > them.  It must always obtain the locks in
> >> the same order so that does > > > > not > > > > get into a deadly
> >> embrace.  If we start arbitrarily releasing a parent > > > > semaphore
> >> in cached_lookup and taking it again after the revalidate, > > > > we >
> >> > > > risk breaking the lock ordering and creating a deadly embrace.
> >> > > > > 
> >> > > > > When I started writing this I thought that it would be safe for
> >> the > > > > autofs > > > > revalidate code to release the parent
> >> semaphore because they do not > > > > have a > > > > rename callback.
> >> But I looked again at the rename code and it calls > > > > lookup_hash
> >> on the final source and destination files after locking > > > > the > >
> >> > > parents so the potential for a deadly embrace still exists unless >
> >> > > > there is > > > > some other assurance that these final lookups
> >> will never pend waiting > > > > on > > > > the automounter in either
> >> their revalidate or lookup routines.  > > > > (Actually > > > > the
> >> requirement is that they never give up the parent i_sem lock, but > > >
> >> > the > > > > lookup code has to give up the lock so that the autofs
> >> demon can run > > > > and > > > > perform the mount so it amounts to the
> >> same thing.)
> >> > > > > 
> >> > > > > The same issue exists for devfs which also releases the parent
> >> i_sem > > > > lock > > > > so that it can wait inside its revalidation
> >> routine.
> >> > > > 
> >> > > > 
> >> > > > So exactly why does autofs4 want to hold the dir->i_sem in
> >> d_revalidate > > > in the first place? Can't we move any code that
> >> requires dir->i_sem to > > > be held into a ->lookup() method?
> >> > > 
> >> > > It's not that d_revalidate wants or doesn't want to hold the lock.
> >> The > > caller > > of lookup_one_len is required to get the lock and
> >> this function calls > > lookup_hash which calls cached_lookup which
> >> calls d_revalidate.
> >> > > 
> >> > > 
> >> > > > Trivially, if you have a d_revalidate that does something like
> >> > > > 
> >> > > > int autofs_revalidate(struct dentry *dentry, struct nameidata *nd)
> >> > > > { > > > d_drop(dentry); > > > return 0; > > > }
> >> > > > 
> >> > > > then the VFS will currently allocate a new dentry with the same
> >> name, > > > and call ->lookup() on it without dropping dir->i_sem. If
> >> you still need > > > to reference the old dentry, then put it on a
> >> private list somewhere.  > > > That would also allow you to return the
> >> old dentry as the result of the > > > ->lookup() operation if that is
> >> desirable.
> >> > > 
> >> > > Problem with that, as I understand it and Ian Kent knows better than
> >> I, is > > that the autofs lookup code creates the dentry and fills it in
> >> partially > > and > > marks it as waiting for mounting and wakes up the
> >> automount demon.  The > > demon > > completes the mount and finishes
> >> filling in the dentry.  So we cannot have > > some other lookup coming
> >> in and removing the dentry on us.  At least that > > is > > what I
> >> understand from Ian's answer when I proposed the same sort of thing > >
> >> to > > him.  Even if they end up doing something like that in a future
> >> version > > of > > the automounter, I would still like a simple patch
> >> that can be applied to > > existing systems as an interim fix.
> >> > 
> >> > 
> >> > Lets see if I can keep this explaination simple.
> >> > 
> >> > The user space process using the autofs filesystem (autodir or
> >> automount) > needs to be able to call mkdir at mount time as a result of
> >> a callback from > revalidate. Sometimes this comes indirectly from
> >> lookup (if the directory > does not already exist).
> >> > 
> >> > lookup_one_len requires the i_sem to be held so two instances of a >
> >> filesystem calling it lead to a deadlock when mkdir is called from
> >> userspace > (the third process). In the case we are discussing this
> >> happens because the > first process calls lookup which releases the
> >> i_sem and calls revalidate > itself. The second calls revalidate which
> >> doesn't release the i_sem and is > places on a wait queue for mount
> >> completion. Consequently the mkdir blocks.
> >> > 
> >> > So the requirement is that autofs release the i_sem during the
> >> callback, not > obtain it.
> >> > 
> >> > Will believes that it is not safe for autofs to release i_sem for the
> >> > callback to user space because it is possible that path that aquired
> >> it may > not be the path that has called revalidate and I can see his
> >> point.
> >> > 
> >> > Never the less I'm still not convinced that this is possible given the
> >> > restrictions of autofs.
> >> > 
> >> > Let me try and describe this, hopefully more clearly than I've done so
> >> far.
> >> > 
> >> > The only operations defined for autofs are:
> >> > 
> >> > mkdir, rmdir, symlink and unlink > and the only processes that can do
> >> these operations must be in the same > process group that mounted the
> >> filesystem. EACCESS is returned for all other > processes attempting
> >> these operations.
> >> > 
> >> > The other functionality is read-only (and perhaps triggers a mount)
> >> being > lookup, revalidate and readdir.
> >> > 
> >> > So the question is, can anyone provide an example of a path that, upon
> >> > calling autofs revalidate or lookup with the i_sem held, not be the
> >> path > that aquired it?
> 
> raven> So still no counter example!
> 
> >> Any other process calling lookup_one_len on a file in /net.
> 
> raven> I'm afraid this is not an example it's an assertion.  "Any other
> raven> process" is a little broad I think.  You'll need to be more
> raven> specific.
> 
> raven> Consider the example reported by yourself and Ram.
> 
> raven> In that example we have processes P1, P2 and lets call the user
> raven> space callback P1(mount). Also assume there is a mechamism to check
> raven> the semaphore, release it if held and later re-take it if previously
> raven> held, like the patch I offered before.
> 
> raven> Correct me if I'm wrong but, with the assumption above, you report
> raven> goes like:
> 
> raven> P1 - calls lookup_one_len, takes i_sem and eventually calls
> raven> autofs4_lookup and indirectly autofs4_revalidate.
> 
> raven> P2 - comes along and waits on i_sem.
> 
> raven> P1 - autofs4_revalidate releases i_sem and posts a user space
> raven> callback.
> 
> raven> P2 - aquires i_sem and eventually calls autofs4_revalidate, releases
> raven> i_sem and is posted to the wait queue for mount completion.
> 
> raven> P1(mount) - calls mkdir, aquires i_sem, and calls autofs4_dir_mkdir,
> raven> i_sem is then released.
> 
> raven> Mount completion is signaled back to autofs4 and the waiters are
> raven> released.
> 
> raven> P1, P2, in any order each (one after the other due to the semaphore)
> raven> re-take i_sem and each complete their lookup_one_len calls.
> 
> raven> On both calls to autofs4_revalidate the calling process is itself
> raven> the holder of i_sem.
> 
> raven> Further, any other process that does a path walk during this time
> raven> has two possible paths.
> 
> raven> First case, the dentry exists, the process is placed on the wait
> raven> queue along with P1 and P2 awaiting mount completion without taking
> raven> i_sem.
> 
> raven> Second case, the dentry does not yet exist, this process either
> raven> aquires the i_sem in do_lookup and follows a similar path to P1 and
> raven> waits on the queue for mount completion or it waits on the i_sem
> raven> while P1 does the lookup and triggers the mount request, it the
> raven> aquires i_sem find the dentry exists, releases i_sem and calls
> raven> autofs4_revalidate without i_sem held and is sent to the wait queue
> raven> to wait for mount completion.
> 
> raven> Again in both these cases a process that enters autofs4_revalidate
> raven> when the i_sem is held is the process that aquired it.
> 
> Now consider that revalidate is called without semaphore held.  Also
> consider that another process holds this semaphore for any valid reason
> (could be mkdir or whatever[1]).  Now, you're code says, hey, the semaphore is
> held, let's drop it!  Bad juju follows.
> 
> You can't do this.

Good call. A single example is sufficient to refute my assertion.

But to focus the discussion, the goal is to identify that the calling 
process is the one that holds the semaphore to justify releasing it. For 
lookup it's easy as it's always called with it held. lookup_hash will 
always call revalidate or lookup with the nameidata struct NULL and 
so can be used to identify the semaphore ownership similar to the devfs 
code Will mentioned. I don't think the other tests there are relevant to 
autofs. The patch will require some rework but still the same general 
idea.

Can you think of an example code path where __lookup_hash is called with a 
non null nameidata struct which leads to autofs4 revalidate or lookup.

Ian
