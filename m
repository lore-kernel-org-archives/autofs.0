From: jimc@math.ucla.edu (Jim Carter)
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Wed,  7 May 2008 21:52:34 -0700 (PDT)
Message-ID: <20080508045235.13C9EF8ED9@serval.math.ucla.edu>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0804281422060.10684@raven.themaw.net>
	(Ian Kent "Mon, 28 Apr 2008 14:26:34 +0800")
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

On Mon, 28 Apr 2008 14:26:34 +0800 Ian Kent wrote:

> Jeff Moyer has identified a race in due to an execution order dependency
> in the autofs4 function root.c:try_to_fill_dentry().
--snip--
> After the daemon finishes the mount, it calls back into the kernel
> to release the waiters. When this happens, P1 is woken up and goes
> about clearing the DCACHE_AUTOFS_PENDING flag, but it does this in
> D1!  So, given that P1 in our case is a program that will immediately
> try to access a file under /mount/submount/foo, we end up finding the
> dentry D2 which still has the pending flag set, and we set out to
> wait for a mount *again*!

I applied the two patches (redo-lookup-in-ttfd and correct-return-in-ttfd)
and restarted/reloaded the resulting module, but unfortunately it did 
not improve the issue of hanging client processes in my submount case.

I've improved my test program and picked up some behaviors that were not
obvious before.  Expected expiration is not happening.  Some but usually
not all (once it *was* all) of the filesystems stay mounted for 900
secs, much longer than the default expiration of 300 secs.  But
eventually many of them get expired.  (There are no competing processes
that might "cd" into an automounted directory and prevent expiry, except
for the filesystem containing my home directory.)

In one case a set of 3 filesystems from the same machine (submount)
stayed mounted for 103 minutes straight (never expired as far as I can
see), being tested with successful access every 900 secs.  Then all
three became absent from /proc/mounts, and were tested.  One of them
returned ENOENT from opendir(); the other two test processes hung likely
in opendir().

In another case a machine exports only one filesystem, and it was
accessed and expired normally for about three repetitions; then it
stayed mounted for 900 secs.  It was accessed successfully, but then
after only 266 secs it disappeared from /proc/mounts, was tested, and
got ENOENT.  900 secs later it was re-tested (I assume it was not
mounted), and the test process hung.

I have the test output including backtraces with symbols, immediately
after each of the three hangs (actually, 25 secs after the process
started, which is the criterion I use for hanging).  But it's 5627 lines
or 282 Kb and it's pretty much the same as the one I sent in earlier
except for more diagnostic output.  How about I send it direct, if you
want it, rather than filling up everyone's mailbox?  Or would it be
better to have the output in the mail archive even though it's bloated?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
