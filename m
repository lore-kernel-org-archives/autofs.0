From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Sat, 22 Nov 2003 16:20:15 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0311221605300.3608-100000@raven.themaw.net>
References: <Pine.LNX.4.53.0311211053490.20421@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0311211053490.20421@simba.math.ucla.edu>
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

On Fri, 21 Nov 2003, Jim Carter wrote:

> Here at UCLA-Mathnet we use the automounter extensively, and we have had
> a couple of associated problems:

Thanks for your efforts but ...

> 
> A.  Our NFS mounted filesystems invariably require submounts, and they
> are not auto-dismounted.  Ever.  This proved to be due to a duplicated
> slash between the main and sub mount points.  Once this was fixed,
> auto-dismount started working.  There is a rumor that a related fix was
> posted somewhere, but I couldn't find it.

I believe I fixed this in the 4.0.0 release. There are a couple of other 
fixes in it also.

> 
> B.  If the daemon is hit with SIGUSR1, it goes into an infinite loop
> trying unsuccessfully to dismount eligible filesystems, spitting out
> typically 1000 syslog messages over 2 seconds until item C (below)
> supervenes.  I put in both a rate throttle (20/second) and a dynamic
> limit on the number of dismounts.

This sounds like a problem that needs to be identified and fixed.
Rate throttling seems more of a workaround that a solution.
Can you give more information please.

Come to think about it this might have already been fixed in ????
Maybe it's not in the 4.0.0 release. I'll check.

> 
> C.  Upon auto-dismount or SIGUSR1 looping, st_prepare_shutdown is called
> when ap.state != ST_READY and an assertion fails, killing the thread.
> I changed it to die on ST_SHUTDOWN_PENDING, i.e. a recursive call.  I'm
> not 100% sure that this is the correct contingency, but automount does
> dismount the unused filesystems and does exit.

Have seen this. I'm not sure if I fixed this in the 4.0.0 release either.
Will check into it.

> 
> D.  It would appear that a maliciously constructed directory name could
> overflow a buffer in several places, at least causing denial of service
> and possibly allowing the execution of code.  Perhaps other O.S. limits
> on the length of a filename (PATH_MAX) invariably protect the daemon
> from this exposure, but defense in depth in this area seems both
> warranted and not burdensome.  I changed sprintf to snprintf wherever
> occurring, and the subroutine which joins the dirname and basename
> checks the buffer size.

Definately will check into this for 4.0 and 4.1.

> 
> E.  There were a few cases where size_t and int were mixed together,
> causing compiler warnings.  As there have been exploits against mixed
> signed-unsigned variables, I took the opportunity to fix this issue.

Ditto.

> 
> On one machine we have been running the patched automount for a week,
> and all Linux boxes have had it in production for 48 hours.  No peculiar
> log messages or crashes have been seen.  In one test, various random NFS
> filesystems were automounted and allowed to time out, with varying
> numbers of filesystems simultaneously mounted.  Almost 500
> mount-autodismount pairs were done; processes always exited when they
> should, and no error messages appeared.  There's a pretty good chance
> that this patch is working.

Assume you mean the attached patch.

> 
> The patches follow.  They are against autofs-4.0.0pre10, which is the
> version distributed with SuSE 8.2, the distro we are using.

The SuSE maintainer contacted me a while ago, sent me a copy of his 
autofs which was much appreciated. I merged some of the SuSE patches into 
the current 4.1.0 beta.

I hope to encourage him to adopt 4.1.0 when a final version is released.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
