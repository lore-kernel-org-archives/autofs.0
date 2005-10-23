From: Ian Kent <raven@themaw.net>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Sun, 23 Oct 2005 10:23:11 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0510231001370.7847@donald.themaw.net>
References: <200510181321.08443.krienke@uni-koblenz.de>
	<Pine.LNX.4.63.0510192336180.2071@donald.themaw.net>
	<200510210907.20809.krienke@uni-koblenz.de>
	<Pine.LNX.4.63.0510212347440.2069@donald.themaw.net>
	<17241.6728.530111.716756@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510221111420.2069@donald.themaw.net>
	<Pine.LNX.4.61.0510221821470.8952@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0510221821470.8952@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Sat, 22 Oct 2005, Jim Carter wrote:

> On Sat, 22 Oct 2005, Ian Kent wrote:
> 
> > It appears that there is a situation in which autofs thinks the lock 
> > is still held when it is not. A race (no doubt) or maybe a missing test in 
> > the wait. So my feeling of wanting to eliminate the locking returns again. 
> > Sorry.
> 
> Agreed that problems in mount's lock should be fixed, but my diagnosis of 
> the autofs situation went like this: it acquires its lock, then it tries to 
> do a nested automount, and the nested instance can't get the lock.  I 
> suggested statting the referent in advance, to trigger the nested mount 
> ahead of time.  Autofs might do this: if it decides (before acquiring the 
> mount) that it's going to do a bind mount, then it stats the referent, 
> triggering nested automount(s) if any.  Would it disrupt the logic too much 
> to recognize the bind mount before getting the lock?

Yes. I think that is an innovative way to use program maps indeed and 
should work.

But would be a little difficult to write for some.

The other reason that this is a hot issue for me is that as, Mike Jagdis 
points out, the locking as is will block all NFS mounts to all servers if 
mount hangs on a broken server. I know a lot of work has gone into code to 
check that a server is available before mounting but mount could still 
hang for some other reason.

> 
> If we trust mount's lock, and don't do locking in autofs, I wonder if 
> nested automounts would put mount into exactly the same deadlock that 
> autofs is getting into now?

I don't think so because in mount the lock is used to update the mtab 
after the mount has been completed. This won't trigger a further mount.

The problem is the broad scope of the lock when used in autofs.

Ian
