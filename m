From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Wed, 26 Nov 2003 10:39:45 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0311261008100.2363@xena.cft.ca.us>
References: <Pine.LNX.4.44.0311221605300.3608-100000@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0311221605300.3608-100000@raven.themaw.net>
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

On Sat, 22 Nov 2003, Ian Kent wrote:
> On Fri, 21 Nov 2003, Jim Carter wrote:
> > B.  If the daemon is hit with SIGUSR1, it goes into an infinite loop
> > trying unsuccessfully to dismount eligible filesystems, spitting out
> > typically 1000 syslog messages over 2 seconds until item C (below)
> > supervenes.  I put in both a rate throttle (20/second) and a dynamic
> > limit on the number of dismounts.
>
> This sounds like a problem that needs to be identified and fixed.
> Rate throttling seems more of a workaround that a solution.
> Can you give more information please.

This part of the patch is efinitely a kludge.  The daemon's logic goes like
this:  When it's time to purge mounts, it sends a packet to the driver
saying "find an expired mount".  The driver sends up a packet saying
"dismount /net/tupelo//h1". The daemon tries to do that, but the filesystem
is not actually dismounted (lots of possible reasons this could happen).
Repeating the loop, the daemon asks "find an expired mount".  The driver
sends up a packet saying "dismount /net/tupelo//h1"...

A possible non-kludge fix might go like this.  The daemon walks the tree of
(its own sub-) mounts and for each, it may or may not make a judgment that
the mount might (or might not) be expired.  On likely-looking mounts, it
asks the driver "is this expired" or "when was it really last used"?
If the mount is really expired, the daemon attempts to dismounts it.  But,
if the filesystem fails to go away, the daemon will not return to it until
the next USR1 or ALRM, avoiding the infinite loop.

Here's another possibility: you shouldn't go around updating the atime of
the mounted filesystem, but the mount point belongs to the driver, and if
you stat the mount point's inode, the driver can provide the last access
time (what it uses to decide about expiration) as the atime of that inode.
Then the daemon can do the entire logic of picking expired mounts.  That
would be preferable as design, and it avoids all infinite loop
possibilities.  Presumably to stat the inode, you would open(2) the mount
point directory before mounting on it, and then use lstat.  I hope that
will actually work.  Of course, both of these fixes require protocol
changes in the driver.

> > C.  Upon auto-dismount or SIGUSR1 looping, st_prepare_shutdown is called
> > when ap.state != ST_READY and an assertion fails, killing the thread.
> > I changed it to die on ST_SHUTDOWN_PENDING, i.e. a recursive call.  I'm
> > not 100% sure that this is the correct contingency, but automount does
> > dismount the unused filesystems and does exit.
>
> Have seen this. I'm not sure if I fixed this in the 4.0.0 release either.
> Will check into it.

When the submounted daemon dismounts its last filesystem, it's in ST_EXPIRE
(I think that's the spelling), but correctly calls st_prepare_shutdown.  I
don't know if there are any other non-obvious but correct transitions into
SHUTDOWN state.

> > The patches follow.  They are against autofs-4.0.0pre10, which is the
> > version distributed with SuSE 8.2, the distro we are using.
>
> The SuSE maintainer contacted me a while ago, sent me a copy of his
> autofs which was much appreciated. I merged some of the SuSE patches into
> the current 4.1.0 beta.
>
> I hope to encourage him to adopt 4.1.0 when a final version is released.

We're definitely looking forward to it.  We're pretty aggressive about
patching machines and auditing software, and when we make private patches a
big problem is making sure they stay installed.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
