From: raven@themaw.net
Subject: Re: [patch, rfc] fix hung automounter issues
Date: Sat, 16 Apr 2005 12:46:21 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504161225590.8246@donald.themaw.net>
References: <16990.26693.814813.479017@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0504150932070.30832@wombat.indigo.net.au>
	<16991.44158.799389.569339@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16991.44158.799389.569339@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Dan.Berrange@ubs.com

On Fri, 15 Apr 2005, Jeff Moyer wrote:

> ==> Regarding Re: [patch, rfc] fix hung automounter issues; Ian Kent <raven@themaw.net> adds:
>
> raven> On Thu, 14 Apr 2005, Jeff Moyer wrote: I'm inpressed, this looks
> raven> like a fine piece of work guys.  It's going to take a while to work
> raven> through this.
>
> raven> Also This is bound to make merging Denis Vlasenkos' logging patches
> raven> really hard. So there's potentially a fair bit of work in this.
>
> Well, you can go ahead and apply his patches, and I'll merge this stuff in
> afterwards.  Just let me know when you have that all set in CVS.
>
>>> Hi, Ian,
>>>
>>> Dan Berrange did a spectacular job of diagnosing some autofs hangs he
>>> was experiencing.  The automount daemon would appear hung, and an an
>>> strace of the process would show sys_futex on the call stack.  Through
>>> his debugging, he figured out that the problem was autofs issuing syslog
>>> calls while in a signal handler.
>
> raven> One, probably stupid question (humour me).
>
> raven> Shouldn't we be able use syslog in a signal handler?
>
> Nope:
>
> http://www.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_04.html#tag_02_04

I have to plead guilty to the screw up (at least I'm not the only 
guilty party) here and point out that there's also a few ioctl calls in 
the signal handling execution paths.

I should be able to the move the ioctl in ST_SHUTDOWN_PENDING to the 
st_shutdown_pending function but moving them in send_ready and send_fail 
will be somewhat harder.

What else have we missed?

>
>>> So, there are a few ways to fix this that come to mind.
>>>
>>> o We could not log in signal handlers.  I don't consider this an
>>> acceptable solution, as we really need the debug messages generated
>>> there.  o We could defer logging to non-signal handler context.  This is
>>> in fact what the attached pattch does.  It queues the syslog messages,
>>> and flushes them upon the next syslog that occurs outside of signal
>>> handler context.  o We could open /dev/log directly.  This is likely a
>>> bad idea as there is no standard for the interface there.  o We could
>>> have a separate logging process, which we write to via a pipe.  I'm not
>>> keen on this as it adds yet another process, and makes shutdown that
>>> much more complicated.
>>>
>
> raven> I actually like the last option but a multi threaded autofs is not
> raven> likely to happen for a long time.
>
> It does not imply threading.  You can simply fork().
>
> raven> Would another option be to make autofs signal safe by doing all the
> raven> work in subprocesses?
>
> There are a number of ways to address this by changing the control
> structure of the daemon.  However, that seemed way to invasive at this
> stage of the game.  The ideal solution is to do less in the sig_child
> handler, deferring the work just like we do for all of the other caught
> signals.
>
>>> Note that in all of the above cases, we still need to implement a
>>> signal-safe vsprintf.  That is what the bulk of this patch is.
>
> raven> What about a signal safe syslog?  Is this something we push to the
> raven> libc guys, both a signal safe vsprintf and syslog?
>
> Well, we can certainly try, but this won't gain you anything in the short
> term.
>
> I'll think more about having a separate logging process.  If it seems easy
> enough to implement, I'll post a first whack at it.  In the mean time, I
> think we should continue to discuss our alternatives.

I must admit, the more I delve into this, the more the deffered logging 
idea grows on me.

Let me look at the patches a while longer.

Ian
