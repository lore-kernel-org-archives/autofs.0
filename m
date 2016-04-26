From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Tue, 26 Apr 2016 09:06:58 +0800
Message-ID: <1461632818.3218.29.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net> <1460110224.2979.35.camel@themaw.net>
	 <20160408122552.GW15153@bccms.uni-bremen.de>
	 <20160408142907.GX15153@bccms.uni-bremen.de>
	 <1460166126.3073.20.camel@themaw.net>
	 <20160409095659.GB15153@bccms.uni-bremen.de>
	 <1461559248.3012.24.camel@themaw.net>
	 <20160425150638.GC30271@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=KahqM7vAAshOrqcKbIRfCUVzGQc=; b=edyN63
	L+Ev+7ax2EKh4DiBZEWQFUbXdtsKFqo6rSfJxPTfCX8i4hU7oxBV2vfD3j3GmJgJ
	mObaBlNCARcDeMv9qKpM6uueLsOSiBOlTx1Xc96KyO5uOMTn0K9LPdPBwyg1Ws8x
	kPRx1tC3jgQoBuwz58tDV1XTEWxz4qZE69hQk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=KahqM7vAAshOrqc
	KbIRfCUVzGQc=; b=ZE/XEjTGCoYR3YI5ob9IPCBKtnqKyOpPBOPAXlXuBUByqPM
	ZxE/pSOAtS//Mi0rXavIvh0nzU/xNlMuGjZAEQEknxGQ/XmSl0e+KA/lLwc2SkTz
	2GMVfVLMbod4/zHckFv7gf8x9InSSfa7qK74jaIS5MwfgkmLIQgU3xIbF9eQ=
In-Reply-To: <20160425150638.GC30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Mon, 2016-04-25 at 17:06 +0200, Christof Koehler wrote:
> Hello,
> 
> that is bad news overall, but thank you very much for testing and
> trying
> it.  I had just installed 16.04 into a vm last week and would have
> made
> first attempts with autofs this week. So you saved me quite some work
> discovering that it is broken in an interesting way (I assume the SEGV
> refers to 16.04).

Yep, that's right.

The point is there will almost certainly be changes needed even for it
to build and produce binaries with proper dependencies let alone
anything that might be needed for the IPv6 functionality.

btw, I expect there will be changes needed in the IPv6 area because when
that was done there were quite a number of things that I wasn't sure
about and guessed at or that I didn't know I didn't know, ;)

Anyway, I will check the Makefile changes don't interfere with anything
else and have a think about what's really going on then most likely
commit them to the repo.

The Makefile cleanup patch is straight forward, that'll go straight in.

It will also be a while before my next commit and push to the repo. and
longer before they are available in a release, so I'll need to provide
patches if the Ubuntu folks can be persuaded to update the package.

That's probably not as simple as it sounds for a couple of reasons to do
with the Ubuntu build subsystem, how they want things to be in it and
that the autofs build is antiquated. Basically it barely uses the
autohell tools which could be part of the problem (or not, it's already
hard enough to make changes with the simple make file setup I have).

> A very complicated and confusing situation. This is basically the same
> I was in when I first asked about IPv6 support on this list. Not
> knowing 
> what to do and whom to ask about what in which order.
> 
> I fear I can be of no actual help with the segfault, I am not a 
> C programmer at all. 

It's that much more puzzling when I can see what I'm doing is just about
identical to showmount(8) which functions as it should but autofs
doesn't.

The main difference is the RPC client creation that happens before that
and that's been ok for a while now. Unfortunately the client creation is
rather complicated because I need to control the timeouts and minimize
reserved port usage.

>  
> 
> However, if I understand the difference between direct and
> indirect maps correctly what I am using is an indirect map ? The
> auto.master line is "/local  /etc/auto.local --timeout=150" and
> /etc/auto.local is an executable map which prints [1]
> # /etc/auto.local core330
> -fstype=nfs4,rw,intr,nosuid,soft,nodev core330:/locals

Yep, that's a fairly simple indirect mount.

> 
> So re-building and testing autofs on 16.04 with IPv6 could still be
> useful assuming the segfault is a separable problem (which might not
> be
> the case of course) ?

That most likely will function ok from what I saw.

Even more surprising is the proximity and availability probe code uses
the same client creation as the code that has the problem and it seems
to work ....

Anyway I can cleanup what I have and send over what's needed to build
the debs when your ready.

> 
> 
> I can also offer to try to do it with debian testing in a vm. If it
> also
> segfaults I could file a bug report hoping to get the maintainer
> interested, especially if there are no problems with fedora. Shall I
> try
> that ? Instead or in addition to the test with IPv6 mentioned above ?

Not sure how to go about this.
I think a couple of changes are needed but fiddling with LDFLAGS
presence and position as I did might not be in line with what the Debian
folks want.

I suggest we just go along and see what we come up with.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
