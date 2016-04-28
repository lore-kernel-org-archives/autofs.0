From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Thu, 28 Apr 2016 11:21:51 +0800
Message-ID: <1461813711.3083.111.camel@themaw.net>
References: <20160408122552.GW15153@bccms.uni-bremen.de>
	 <20160408142907.GX15153@bccms.uni-bremen.de>
	 <1460166126.3073.20.camel@themaw.net>
	 <20160409095659.GB15153@bccms.uni-bremen.de>
	 <1461559248.3012.24.camel@themaw.net>
	 <20160425150638.GC30271@bccms.uni-bremen.de>
	 <1461632818.3218.29.camel@themaw.net> <1461664433.3218.42.camel@themaw.net>
	 <20160426152711.GF30271@bccms.uni-bremen.de>
	 <1461722078.4208.31.camel@themaw.net>
	 <20160427165250.GM30271@bccms.uni-bremen.de>
	 <1461812190.3083.101.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=FaRgRmNGrGklu9whUWFkETDSuh0=; b=aPqpdk
	wvlEb2MXwmID1cvZUQZNjzh3QKcT/H2onpbuZ/dayWBcvi6obM1IkBqiGirDi9bc
	cUk1Xn2XLHkQNMgBtQCvXJkBpd3Mqs4oES5GAL76geQHjpNW2Lyg+yy3k36nQaUI
	a2LZ7o7QcsgamTeI6p5gUOlFBaKFVIIHM7bNI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=FaRgRmNGrGklu9w
	hUWFkETDSuh0=; b=T/TjvDVetl4s3cXcbKDccwAkUAbjYMxdoGdlGhtI+q27s1t
	Pdr0wgXr2+mxY6QRiKmyfjZAlBGLx38kiPi+0PLV3uWTVhJeCS725B3bo5qaobkZ
	yzRQtPSHSQen2ouWice+2AoXdypzPTaRNIjtSGVQKc7xiP4IF6CQsFHvCXVY=
In-Reply-To: <1461812190.3083.101.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Thu, 2016-04-28 at 10:56 +0800, Ian Kent wrote:
> > 
> > Another question: What is your expectation in a situation where only
> > IPv6 is available, no IPv4 for the server ? Is  the one mentioned in
> > #25 of
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=737679
> > expected to be still a working solution ? I might have an NFS server
> > soon
> > which, due to a routing conflict difficult to resolve, would only
> > get
> > an IPv6 address visible to the clients. I should test this case with
> > a
> > dedicated vm as server anyway ...
> 
> I think we've covered that above.

Actually, maybe not.

There's a rather long story associated with the use of NFSv4 and the the
associated server mount (or export) path.

It depends on kernel version and nfs-utils version.

Put simply Linux NFS originally only allowed the use of "/" for NFSv4
mounts but autofs couldn't work out if a translation was needed because
of limited information available from the server.

So Linux NFS was changed to behave like other implementations and allow
the same paths as is used in NFSv3 (and v2). That has the benefit of
allowed for consistent fall back from v4 to v3 as well.

> 
> The scenario in that bug shows autofs behaving as expected due to lack
> of IPv6 support in glibc I think.
> 
> I hope that the autofs ppa version will perform the mount fine, as
> long
> as the server is responding but that's one thing we're here to sort
> out,
> ;)
> 
> Ian
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
