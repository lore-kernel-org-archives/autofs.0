From: raven@themaw.net
Subject: Re: Re: [patch, rfc] fix hung automounter issues
Date: Tue, 19 Apr 2005 01:15:58 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504190115210.14946@donald.themaw.net>
References: <16990.26693.814813.479017@segfault.boston.redhat.com>
	<Pine.LNX.4.62.0504182108230.14946@donald.themaw.net>
	<Pine.LNX.4.62.0504182136110.14946@donald.themaw.net>
	<16995.47597.676985.360271@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16995.47597.676985.360271@segfault.boston.redhat.com>
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

On Mon, 18 Apr 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] Re: [patch, rfc] fix hung automounter issues; raven@themaw.net adds:
>
> raven> On Mon, 18 Apr 2005 raven@themaw.net wrote:
>
> raven> Hang on, I think I've got a problem with white space and my mailer.
>
> raven> If you have problems with the patch in the previous mail try this one
> raven> instead (maybe just use this one).
>
> Oops, we need to disable signals when flushing the logs.  The following is
> unsafe:
>
>> +static void flush_log(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ringlen; i++)
>> +		syslog(logbuf[i].pri, logbuf[i].buf);
>> +	ringlen = 0;
>> +}
>> +

But it's static and only called when signals are blocked.

Ian
