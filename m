From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs - fix log print messages
Date: Thu, 13 Nov 2014 11:50:06 +0800
Message-ID: <1415850606.2631.19.camel@perseus.themaw.net>
References: <20141111012954.25773.4002.stgit@perseus.themaw.net>
	 <1415676341.16070.0.camel@perches.com>
	 <1415684245.2486.9.camel@perseus.themaw.net>
	 <1415684989.16070.2.camel@perches.com>
	 <1415685712.2486.17.camel@perseus.themaw.net>
	 <20141112150700.bbb0d82dad1b133fccc1a0ec@linux-foundation.org>
	 <1415837458.2631.13.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=V/kHnYp6rX2y71kaLWu5cGXqhVg=; b=hQG1+OYYM93x8LZweX
	hEuQx5Zsw/AxRlRNtkRyjr5b+pfZuVdPku5E07UmaODtmw88u7Xssj89b9itE83k
	D3sPjW7gjwsz0F+DgM0YCgpyH8tBzn2RoOPmueeWAunLli47MtvOMkSeBebdk8Qn
	NvnjdAWxp1KAU1fH4wgZUHuV8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=V/kHnYp6rX2y71kaLWu5cG
	XqhVg=; b=IyfudGComCyl3ahylX08tiQKpw34wKn0ARiFcS1g7kZI9pjuWB7l89
	qbAhZiE4T4pA9U1RgJtamFZLxBmbG/RV+rKiguY1Uhtrte1KBfd31q817uXb9o5Z
	TJP7YliOhPN6PuBD57WHhgNDNZAc6B2PGmUgLOEQQeeASIOco+tn4=
In-Reply-To: <1415837458.2631.13.camel@perseus.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2014-11-13 at 08:10 +0800, Ian Kent wrote:
> > 
> > The tree which these patches were based on seem to have more than a
> > plain rename.  For example I get
> 
> Right, looks like something has gone missing along the way. 

Ahh .. I get it now.

> The tree the patches are against is just a local clone of the Linus tree
> with the patches I'd sent previously applied.
> 
> Folding these recent patches into the original series and sending one
> series only that applies on the current Linus tree should sort out the
> problem.
> 
> > 
> > --- fs/autofs4/autofs_i.h
> > +++ fs/autofs4/autofs_i.h

Looks like the patches I sent on 3rd Dec, which is what Joe commented
on, were missed.

It's probably better for me to start over once its decided how I'll be
sending the patches.

Ian


