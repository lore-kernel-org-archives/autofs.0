From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Thu, 27 Nov 2003 22:08:03 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0311272153290.3287-100000@raven.themaw.net>
References: <Pine.LNX.4.53.0311261008100.2363@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0311261008100.2363@xena.cft.ca.us>
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

On Wed, 26 Nov 2003, Jim Carter wrote:

> On Sat, 22 Nov 2003, Ian Kent wrote:
> > On Fri, 21 Nov 2003, Jim Carter wrote:
> > > B.  If the daemon is hit with SIGUSR1, it goes into an infinite loop
> > > trying unsuccessfully to dismount eligible filesystems, spitting out
> > > typically 1000 syslog messages over 2 seconds until item C (below)
> > > supervenes.  I put in both a rate throttle (20/second) and a dynamic
> > > limit on the number of dismounts.
> >
> > This sounds like a problem that needs to be identified and fixed.
> > Rate throttling seems more of a workaround that a solution.
> > Can you give more information please.
> 
> This part of the patch is efinitely a kludge.  The daemon's logic goes like
> this:  When it's time to purge mounts, it sends a packet to the driver
> saying "find an expired mount".  The driver sends up a packet saying
> "dismount /net/tupelo//h1". The daemon tries to do that, but the filesystem
> is not actually dismounted (lots of possible reasons this could happen).
> Repeating the loop, the daemon asks "find an expired mount".  The driver
> sends up a packet saying "dismount /net/tupelo//h1"...

Ahhh. I remember now. This was something I can across ages ago. I altered 
the kernel module.

The situation was that during a normal expire the candidates' info struct 
last_used field is updated to the current time to stop this. I saw that 
change months later and couldn't work out what it was for and removed it. 
You are right the problem still exists.

I take the point that many do not want to alter the kernel source anyway.

I don't want to regress back to a develop, test and beta again so I will 
add this to the growing list of stuff for 4.1.1 and work on it as a bug 
fix for 4.0.1 when I get to the next development cycle (hope in early 
December).

Thanks for you contribution. 

> > > C.  Upon auto-dismount or SIGUSR1 looping, st_prepare_shutdown is called
> > > when ap.state != ST_READY and an assertion fails, killing the thread.
> > > I changed it to die on ST_SHUTDOWN_PENDING, i.e. a recursive call.  I'm
> > > not 100% sure that this is the correct contingency, but automount does
> > > dismount the unused filesystems and does exit.
> >
> > Have seen this. I'm not sure if I fixed this in the 4.0.0 release either.
> > Will check into it.
> 
> When the submounted daemon dismounts its last filesystem, it's in ST_EXPIRE
> (I think that's the spelling), but correctly calls st_prepare_shutdown.  I
> don't know if there are any other non-obvious but correct transitions into
> SHUTDOWN state.

As I said previously I've seen this. I believe this was an error in the 
state machine that Jeremy originally implemented. It seemed to work fine 
with the change to the assertion.

Again I'll check and merge your patch as a bug fix in 4.0.1 if it's 
not already there.

> 
> We're definitely looking forward to it.  We're pretty aggressive about
> patching machines and auditing software, and when we make private patches a
> big problem is making sure they stay installed.

Understand that very well.

I really must contact the maintainer to see what his plans are for SuSE 
antofs. I'll do my best.

Thanks again.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
