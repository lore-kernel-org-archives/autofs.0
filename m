From: Ian Kent <raven@themaw.net>
Subject: Re: Regular deadlocks
Date: Sun, 26 Jun 2016 18:59:01 +0800
Message-ID: <1466938741.739.42.camel@themaw.net>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Hg8PWcIQebBHcThxsV41MdjodjE=; b=kjgv95
	oqGU5lcM0xcCWIJEPOGyOeoevePlPjyHNqjoC4kKqob18Jo7FAiTGKdpEferlvkG
	VW4NzZtxO0AZZS2ukD2DuvrCBl/TTSnsU/7795xV1hCud2uqb6ppyuA/7wgZC3rU
	c1RJv6hSUVkXgOXdwf0ncHedYrilBimS/SPvY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Hg8PWcIQebBHcTh
	xsV41MdjodjE=; b=duLqsmoz6C4XRIxLcDhEfA8gRVeR0bM6zHoA1AMF3fcENeK
	Zy80NBxN9z/rLlye+M8x3wOEOFU3GMFTSmLY58HO6fOx+QN2g10LdDXyd6svrbcA
	bcxzgruuvDCTnFxNTnEZ7pNVHYAYMbrkLcmMz7sHQS99xgNceUq/zINTVUtI=
In-Reply-To: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>, autofs@vger.kernel.org

On Sun, 2016-06-26 at 01:41 +0200, Cyril B. wrote:
> Hello,
> 
> I have occasional deadlocks using autofs 4.1.2 (but it happened on 4.1.1 
> as well) on my servers, typically about once every 2 or 3 days.
> 
> I already posted on this mailing-list back in 2015 for a bug that also 
> triggered deadlocks (which was fixed), so I'll copy/paste parts of my 
> original message as my config hasn't changed.
> 
> /etc/auto.master:
> --
> /nfs program:/etc/auto.nfs
> /home program:/etc/auto.home
> --
> 
> /etc/auto.nfs is basically returning:
> 
> -fstype=nfs4,noatime,nosuid,_netdev,soft,intr,timeo=1000 $1:/
> 
> /etc/auto.home:
> --
> #!/bin/sh
> 
> if [ ! -h /var/home/$1 ]
> then
>     exit 1
> fi
> 
> echo -fstype=bind :$(readlink --no-newline /var/home/$1)
> --

Btw, there was a bug in 5.1.1 were a program map lookup could hang under load
due to out of order locking.

The stack traces here didn't show what I'd expect to see with that but it can be
a problem with 5.1.1.

fyi, the patch that fixed that is:
https://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.2/autofs-5.1.1-fix-out-of-order-call-in-program-map-lookup.patch

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
