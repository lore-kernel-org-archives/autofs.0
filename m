From: Peter Staubach <staubach@redhat.com>
Subject: Re: [patch] Underscore in hostnames
Date: Wed, 13 Dec 2006 08:26:32 -0500
Message-ID: <457FFF88.9020601@redhat.com>
References: <20061207232212.GA1994@sleipnir.redhat.com>	<1165809391.3380.8.camel@raven.themaw.net>	<20061211120507.GA2629@sleipnir.redhat.com>	<x49lkler00t.fsf@segfault.boston.devel.redhat.com>	<1165851275.3380.42.camel@raven.themaw.net>	<457D7FD7.5030702@redhat.com>	<x494ps2quec.fsf@segfault.boston.devel.redhat.com>	<20061211165824.GB2629@sleipnir.redhat.com>
	<1165979036.3332.15.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1165979036.3332.15.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> On Mon, 2006-12-11 at 14:58 -0200, Fabio Olive Leite wrote:
>   
>> On Mon, Dec 11, 2006 at 11:17:31AM -0500, Jeff Moyer wrote:
>>     
>>> If you want to disallow this, then surely it is best to simply "fix"
>>> the name resolution routines in libc.  At this point, however, that
>>> could be viewed as a regression.
>>>       
>
> I've thought more about this and Peter certainly has a valid concern.
>
> However, I think that the decision as to whether a host name may contain
> an "_" is the responsibility of the service that resolves names, such as
> FNS, and not of an application that uses the names. If the name resolves
> I think we should just use it.
>
>   

This sounds very reasonable to me.

       ps

> So I'm going to add the original patch when I get a chance..
>
>   
>> Even though I do my own RFC evangelizing at times, I can't help but
>> think: why limit automount with a hostname validation routine when
>> automount is *not* the authoritative entity that decides what is a
>> valid hostname? Will you want to patch automount again whenever the
>> RFCs get updated?
>>
>> automount should regard the hostname as a string, and if it can be
>> resolved, great. If it cannot, complain in the logs and exit. But it
>> should not enforce validation on top of something that can be
>> redefined under its feet anytime in the future.
>>
>> Will you also include validation for bracketed IPv6 literals? And
>> whatever comes next?
>>     
>
> Basically, yes.
> I want input validation and will have to deal with it as and when
> needed.
>
> Ian
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>   
