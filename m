From: Ian Kent <raven@themaw.net>
Subject: Re: [patch, rfc] fix hung automounter issues
Date: Fri, 15 Apr 2005 09:59:56 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504150932070.30832@wombat.indigo.net.au>
References: <16990.26693.814813.479017@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16990.26693.814813.479017@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Dan.Berrange@ubs.com

On Thu, 14 Apr 2005, Jeff Moyer wrote:

I'm inpressed, this looks like a fine piece of work guys.
It's going to take a while to work through this.

Also This is bound to make merging Denis Vlasenkos' logging patches really 
hard. So there's potentially a fair bit of work in this.

> Hi, Ian,
> 
> Dan Berrange did a spectacular job of diagnosing some autofs hangs he was
> experiencing.  The automount daemon would appear hung, and an an strace of
> the process would show sys_futex on the call stack.  Through his
> debugging, he figured out that the problem was autofs issuing syslog calls
> while in a signal handler.

One, probably stupid question (humour me).

Shouldn't we be able use syslog in a signal handler?

> 
> So, there are a few ways to fix this that come to mind.
> 
> o We could not log in signal handlers.  I don't consider this an acceptable
>   solution, as we really need the debug messages generated there.
> o We could defer logging to non-signal handler context.  This is in fact
>   what the attached pattch does.  It queues the syslog messages, and
>   flushes them upon the next syslog that occurs outside of signal handler
>   context.
> o We could open /dev/log directly.  This is likely a bad idea as there is
>   no standard for the interface there.
> o We could have a separate logging process, which we write to via a pipe.
>   I'm not keen on this as it adds yet another process, and makes shutdown
>   that much more complicated.
> 

I actually like the last option but a multi threaded autofs is not likely 
to happen for a long time.

Would another option be to make autofs signal safe by doing all the work 
in subprocesses?

> Note that in all of the above cases, we still need to implement a
> signal-safe vsprintf.  That is what the bulk of this patch is.

What about a signal safe syslog?
Is this something we push to the libc guys, both a signal safe vsprintf 
and syslog?

> 
> So, here is a rough take on implementing the second bullet point.  I
> wholesale copied a bunch of code from the linux kernel for doing vsprintf.
> That bit is ugly.  I'd also move the definition of the new logging routines
> into the vsprintf file, and rename it.  In short, this is a proof of
> concept (shown to resolve the issues).  I'm happy to clean it up, but I
> want to be sure that this is the direction we want to go in, first.
> 
> Limitations of this approach: we won't flush the logs that were issued in
> signal handler context until another syslog call is made.  One improvement
> that could be made straight-away is to have all of the logging routines
> call flush_logs, even if the log priority is set low enough that they
> wouldn't otherwise log.
> 
> Comments encouraged.  Thanks again to Dan!
> 

Ian
