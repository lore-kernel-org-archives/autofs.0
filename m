From: Chris Feist <cfeist@redhat.com>
Subject: Re: Race in expire code
Date: Mon, 31 Jan 2005 10:47:47 -0600
Message-ID: <41FE6133.3070802@redhat.com>
References: <Pine.LNX.4.61.0501292129280.14112@donald.themaw.net>	<20050129135126.GA24017@uio.no>	<Pine.LNX.4.61.0501292209240.14112@donald.themaw.net>
	<16894.20494.352068.720924@segfault.boston.redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16894.20494.352068.720924@segfault.boston.redhat.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: jmoyer@redhat.com, autofs@linux.kernel.org

Jeff Moyer wrote:
> ==> Regarding Re: [autofs] Race in expire code; raven@themaw.net adds:
> 
> raven> On Sat, 29 Jan 2005, Steinar H. Gunderson wrote:
> 
>>>On Sat, Jan 29, 2005 at 09:36:31PM +0800, raven@themaw.net wrote:
>>>
>>>>Can everyone who is maintaining downstream packages please chaeck that
>>>>the code in their package ends up looking like what the patch below
>>>>acheives.
>>>>
>>>>[...]
>>>>
>>>>case EXP_STARTED: - sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
>>>>ap.state = ST_EXPIRE; + sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
>>>>return 0; } return 1;
>>>
>>>The Debian packages are close, but not quite:
>>>
>>>case EXP_STARTED: sigprocmask(SIG_SETMASK, &lock_sigs, NULL); ap.state =
>>>ST_EXPIRE; sigprocmask(SIG_SETMASK, &ready_sigs, NULL); return 0;
>>>
>>>I have no idea what lock_sigs does, but this should be OK, no?
> 
> 
> raven> It's just the list of signals that are blocked while we do "stuff"
> raven> that we don`t want interrupted by something else.
> 
> raven> Similarly ready_sigs contains the signals we expect to be received
> raven> in normal operation.
> 
> raven> The first sigprocmask call above does nothing as signals are already
> raven> blocked at that point.
> 
> The Red Hat package also has the two calls to sigprocmask.  When "fixing"
> signal races, I definitely managed to introduce a similar bug.  Chris Feist
> fixed it.  Chris, do you agree with Ian on this matter, that the first
> sigprocmask is superfluous?

Yes, I think I just included it to be safe, but it should be able to be 
safely removed.

The reason that we needed to make the 'ap.state = ST_EXPIRE' run before 
enabling ready_sigs, is as soon as we enable sigprocmask the kernel 
sends down a queued up SIGCHLD which then runs the sigchld event handler 
which doesn't realize that we're in ST_EXPIRE (because it hasn't been 
set yet).

Thanks,
Chris
