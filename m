From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch, rfc] fix hung automounter issues
Date: Mon, 18 Apr 2005 20:08:50 -0400
Message-ID: <16996.19474.178922.255503@segfault.boston.redhat.com>
References: <16990.26693.814813.479017@segfault.boston.redhat.com>
	<Pine.LNX.4.62.0504182108230.14946@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504182108230.14946@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org, Dan.Berrange@ubs.com

==> Regarding Re: [patch, rfc] fix hung automounter issues; raven@themaw.net adds:

raven> On Thu, 14 Apr 2005, Jeff Moyer wrote:
>> Hi, Ian,
>> 
>> Dan Berrange did a spectacular job of diagnosing some autofs hangs he was
>> experiencing.  The automount daemon would appear hung, and an an strace of
>> the process would show sys_futex on the call stack.  Through his
>> debugging, he figured out that the problem was autofs issuing syslog calls
>> while in a signal handler.
>> 
>> So, there are a few ways to fix this that come to mind.
>> 
>> o We could not log in signal handlers.  I don't consider this an acceptable
>> solution, as we really need the debug messages generated there.
>> o We could defer logging to non-signal handler context.  This is in fact
>> what the attached pattch does.  It queues the syslog messages, and
>> flushes them upon the next syslog that occurs outside of signal handler
>> context.
>> o We could open /dev/log directly.  This is likely a bad idea as there is
>> no standard for the interface there.
>> o We could have a separate logging process, which we write to via a pipe.
>> I'm not keen on this as it adds yet another process, and makes shutdown
>> that much more complicated.
>> 
>> Note that in all of the above cases, we still need to implement a
>> signal-safe vsprintf.  That is what the bulk of this patch is.
>> 
>> So, here is a rough take on implementing the second bullet point.  I
>> wholesale copied a bunch of code from the linux kernel for doing vsprintf.
>> That bit is ugly.  I'd also move the definition of the new logging routines
>> into the vsprintf file, and rename it.  In short, this is a proof of
>> concept (shown to resolve the issues).  I'm happy to clean it up, but I
>> want to be sure that this is the direction we want to go in, first.
>> 
>> Limitations of this approach: we won't flush the logs that were issued in
>> signal handler context until another syslog call is made.  One improvement
>> that could be made straight-away is to have all of the logging routines
>> call flush_logs, even if the log priority is set low enough that they
>> wouldn't otherwise log.
>> 
>> Comments encouraged.  Thanks again to Dan!

raven> Hi Jeff,

raven> There were a few things missed in the patch as there's a few other 
raven> places that calls to illegal routines are made.

raven> I did a bit of work on it over the weekend.

raven> Basically the changes I have made are:

raven> - moved calls to signal_children out of signal handler.
raven> - created seperate module for safe_syslog implementation.
raven> - changed assert to use safe_syslog also.
raven> - removed assertions from safe logging routines as it also calls
raven>    (safe_)syslog.
raven> - added attempt at last gasp message in queue_syslog.
raven> - added some string termination logic to queue_syslog.

raven> There's probably stuff that I've missed.
raven> I've done some basic testing but more is needed.

raven> Can you review this and alter as you see fit please Jeff?

Done, and sent in a separate message.

raven> This just leaves the ioctl calls.
raven> I'm hoping we can verify they are safe. We can check the kernel control 
raven> path and if we can verify that the glibc code is suitably reentrant 
raven> they are probably OK. I'm having trouble finding the right code in 
raven> glibc. Do you have a glibc person that could point us in the right
raven> direction Jeff?

I think you've moved the ioctl calls from signal handler context, right?  I
think this is resolved.

raven> We probably should agree on a name for the patch to avoid confusion 
raven> later. I've called mine autofs-4.1.4-signal-safe-logging.patch. What
raven> name do you like?

That's fine with me.  It certainly isn't important enough to fret over. ;)

-Jeff
