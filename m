From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Sun, 4 Dec 2005 17:39:53 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512041733300.1564@donald.themaw.net>
References: <20051116101740.GA9551@RAM>
	<17292.64892.680738.833917@segfault.boston.redhat.com>
	<1133315771.8978.65.camel@lade.trondhjem.org>
	<438E0C66.6040607@us.ibm.com>
	<1133384015.8974.35.camel@lade.trondhjem.org>
	<438E1A05.7000308@us.ibm.com>
	<Pine.LNX.4.63.0512011917010.3189@donald.themaw.net>
	<438F251B.7060602@us.ibm.com>
	<Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>
	<43906968.6080508@us.ibm.com>
	<Pine.LNX.4.63.0512030115310.2632@donald.themaw.net>
	<43909AA6.5050605@us.ibm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43909AA6.5050605@us.ibm.com>
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
To: Will Taber <wtaber@us.ibm.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Trond Myklebust <trond.myklebust@fys.uio.no>

On Fri, 2 Dec 2005, Will Taber wrote:

> Ian Kent wrote:
> > On Fri, 2 Dec 2005, Will Taber wrote:
> > 
> > 
> > > Ian Kent wrote:
> > > 
> > > > On Thu, 1 Dec 2005, William H. Taber wrote:
> > > > 
> > > > 
> > > > 
> > > > > Ian Kent wrote:
> > > > > 
> > > > > 
> > > > > > On Wed, 30 Nov 2005, William H. Taber wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > Trond Myklebust wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > > On Wed, 2005-11-30 at 15:32 -0500, William H. Taber wrote:
> > > > > > > > 
> > > > > > 
> > > > > > Lets see if I can keep this explaination simple.
> > > > > > 
> > > > > > The user space process using the autofs filesystem (autodir or
> > > > > > automount)
> > > > > > needs to be able to call mkdir at mount time as a result of a
> > > > > > callback
> > > > > > from
> > > > > > revalidate. Sometimes this comes indirectly from lookup (if the
> > > > > > directory
> > > > > > does not already exist).
> > > > > > 
> > > > > > lookup_one_len requires the i_sem to be held so two instances of a
> > > > > > filesystem calling it lead to a deadlock when mkdir is called from
> > > > > > userspace
> > > > > > (the third process). In the case we are discussing this happens
> > > > > > because
> > > > > > the
> > > > > > first process calls lookup which releases the i_sem and calls
> > > > > > revalidate
> > > > > > itself. The second calls revalidate which doesn't release the i_sem
> > > > > > and
> > > > > > is
> > > > > > places on a wait queue for mount completion. Consequently the mkdir
> > > > > > blocks.
> > > > > > 
> > > > > > So the requirement is that autofs release the i_sem during the
> > > > > > callback,
> > > > > > not
> > > > > > obtain it.
> > > > > > 
> > > > > > Will believes that it is not safe for autofs to release i_sem for
> > > > > > the
> > > > > > callback to user space because it is possible that path that aquired
> > > > > > it
> > > > > > may
> > > > > > not be the path that has called revalidate and I can see his point.
> > > > > > 
> > > > > > Never the less I'm still not convinced that this is possible given
> > > > > > the
> > > > > > restrictions of autofs.
> > > > > > 
> > > > > > Let me try and describe this, hopefully more clearly than I've done
> > > > > > so
> > > > > > far.
> > > > > > 
> > > > > > The only operations defined for autofs are:
> > > > > > 
> > > > > > mkdir, rmdir, symlink and unlink and the only processes that can do
> > > > > > these operations must be in the same
> > > > > > process group that mounted the filesystem. EACCESS is returned for
> > > > > > all
> > > > > > other
> > > > > > processes attempting these operations.
> > > > > > 
> > > > > > The other functionality is read-only (and perhaps triggers a mount)
> > > > > > being
> > > > > > lookup, revalidate and readdir.
> > > > > > 
> > > > > > So the question is, can anyone provide an example of a path that,
> > > > > > upon
> > > > > > calling autofs revalidate or lookup with the i_sem held, not be the
> > > > > > path
> > > > > > that aquired it?
> > > > 
> > > > 
> > > > So still no counter example!
> > > > 
> > > > 
> > > > 
> > > > > Any other process calling lookup_one_len on a file in /net.
> > > > 
> > > > 
> > > > I'm afraid this is not an example it's an assertion.
> > > > "Any other process" is a little broad I think.
> > > > You'll need to be more specific.
> > > > 
> > > > Consider the example reported by yourself and Ram.
> > > > 
> > > > In that example we have processes P1, P2 and lets call the user space
> > > > callback P1(mount). Also assume there is a mechamism to check the
> > > > semaphore,
> > > > release it if held and later re-take it if previously held, like the
> > > > patch I
> > > > offered before.
> > > > 
> > > > Correct me if I'm wrong but, with the assumption above, you report goes
> > > > like:
> > > > 
> > > > P1 - calls lookup_one_len, takes i_sem and eventually calls
> > > > autofs4_lookup
> > > > and indirectly autofs4_revalidate.
> > > > 
> > > > P2 - comes along and waits on i_sem.
> > > 
> > > And what happens if P3 comes in with a normal lookup without i_sem held
> > > and
> > > calls autofs4_revalidate from do_lookup and wakes up P2? Think both about
> > > what
> > > will happen later in your code path and also what happens when P2 tries to
> > > release the lock that was no longer held.
> > 
> > 
> > P3 goes to the wait queue it can't wake up the waiters only mount completion
> > can do that.
> 
> 
> But I understood your proposal to be that it d_revalidate would be
> unconditionally releasing the i_sem before went on the wait queue.  My point
> here was that P3 does not hold the i_sem lock so if it releases i_sem here, it
> will be waking up P2 before P1 has finished and released the lock.  Even if
> you don't end up in trouble from accessing something that hasn't been
> initialized yet, the counts on the semaphore are messed up because up has been
> called more often than down.

I wasn't saying unconditionally but never the less Jeffs argument points 
out the error of my ways quite well.

> 
> > 
> > 
> > > > P1 - autofs4_revalidate releases i_sem and posts a user space callback.
> > > > 
> > > > P2 - aquires i_sem and eventually calls autofs4_revalidate, releases
> > > > i_sem
> > > > and is posted to the wait queue for mount completion.
> > > > 
> > > > P1(mount) - calls mkdir, aquires i_sem, and calls autofs4_dir_mkdir,
> > > > i_sem
> > > > is then released.
> > > > 
> > > > Mount completion is signaled back to autofs4 and the waiters are
> > > > released.
> > > > 
> > > > P1, P2, in any order each (one after the other due to the semaphore)
> > > > re-take
> > > > i_sem and each complete their lookup_one_len calls.
> > > > 
> > > > On both calls to autofs4_revalidate the calling process is itself the
> > > > holder
> > > > of i_sem.
> > > > 
> > > > Further, any other process that does a path walk during this time has
> > > > two
> > > > possible paths.
> > > > 
> > > > First case, the dentry exists, the process is placed on the wait queue
> > > > along
> > > > with P1 and P2 awaiting mount completion without taking i_sem.
> > > > 
> > > > Second case, the dentry does not yet exist, this process either aquires
> > > > the
> > > > i_sem in do_lookup and follows a similar path to P1 and waits on the
> > > > queue
> > > > for mount completion or it waits on the i_sem while P1 does the lookup
> > > > and
> > > > triggers the mount request, it the aquires i_sem find the dentry exists,
> > > > releases i_sem and calls autofs4_revalidate without i_sem held and is
> > > > sent
> > > > to the wait queue to wait for mount completion.
> > > > 
> > > > Again in both these cases a process that enters autofs4_revalidate when
> > > > the
> > > > i_sem is held is the process that aquired it.
> > > 
> > > But a regular lookup can enter autofs4_revalidate at anytime without
> > > holding
> > > i_sem.
> > 
> > 
> > And is a noop as far the semaphore is concerned. Neither taken or released.
> 
> Only if you have the code in to check which code path you came from before you
> release the lock in d_revalidate.
> 
> 
> > 
> > 
> > > The main lookup path does not hold i_sem and Trond was pretty clear about
> > > why
> > > it cannot.  That is why devfs has the code which tries to guess whether it
> > > is
> > > the person holding the lock before it releases it. If you put similar code
> > > into autofs4_revalidate before you release i_sem it would probably work.
> > > This
> > > of course makes your code sensitive to changes in the lookup code because
> > > the
> > > devfs code makes assumptions about what flags are set on different
> > > lookups.
> > > The best fix would be to move all of the waiting into autofs4_lookup and
> > > not
> > > hash the dentry until the mount was ready to run.  That is necessarily a
> > > large
> > > piece of coding and would require a lot of testing.  That is why I am
> > > suggesting for now a patch that determines if the lock was held by the
> > > caller
> > > or not and releasing i_sem if it was, before waiting in
> > > autofs4_revalidate.
> > > And of course remembering whether or not it needs to retake the lock after
> > > the
> > > wait completes.
> > 
> > 
> > It's sufficient to recognize the nameidata struct is NULL on a call from
> > lookup_hash nothing more that I'm aware of is needed. If that changes then
> > of course autofs will need to be changed. autofs also makes assumptions
> > about what flags are set for different reasons.
> > 
> > Your assuming that mount point directories don't exist before they are
> > mounted upon which is not the case.
> 
> OK.  I forgot that.  But I would still want you to think about the open case.
> The only reason I say that is because, more times than I would like to admit,
> I am preparing to cd into a directory and vi a file to look at it, except that
> I get ahead of myself and I end up trying to vi the directory.  The
> automounter may never try to open the directory but you also have to consider
> fat fingered fools like myself.
> 

Of course it doesn't yet exist.

Yes.

Ian
