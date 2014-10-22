From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs and ldap
Date: Wed, 22 Oct 2014 10:39:10 +0800
Message-ID: <1413945550.2504.35.camel@perseus.themaw.net>
References: <543E6912.8050109@tudelft.nl> <5440D89C.6040001@themaw.net>
	 <54465F56.8060701@tudelft.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=BbUYVJFT11qXD/NS8heZJgthO58=; b=gKLE2ymLfvAm09tg8u
	FQQi/tOKXfSF8xu3Za7bBuDhDftxVKuxGNm/KMFnPb4m0NtuJ92TRl9eYttOnqGp
	uGe0P5wYnVD4uxIVOPSMWrgf/A3OPh1aVh6b4XL3GZXRUHf3bVK6/j+U4OS1WR4M
	BWTJgWyZGDY/ojprWT6ir2FqU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=BbUYVJFT11qXD/NS8heZJg
	thO58=; b=fXSBiutVuS0nUuL0ysUsSs1iYlGhf0PFGTqYRvg+Fzxus+y4/1mJsD
	ibEfrEt8TcZp5fV9Bovb8uxuqroKtVHJF6F0Ahgl/+l386R9+bzWfpNbBERVuUJE
	oSslEsfqR2Uh+5UWEgB2pLS9qDGHpOQpy9r5cFZ6KJ/pVFD3h63G0=
In-Reply-To: <54465F56.8060701@tudelft.nl>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rsmits-l <rsmits-l@tudelft.nl>
Cc: autofs@vger.kernel.org

On Tue, 2014-10-21 at 15:27 +0200, rsmits-l wrote:
> 
> >>
> >> When I do a autofs reload maybe 90 % of the time I see all entry's. I am
> >> having this issue on Redhat 6 and Suse 11. Strange thing is that the
> >> autofs logging (debug) shows always all the entry's but are not
> >> reflected in the filesystem structure.
> >
> > I can't remember now what gets logged for the ldap map reads so how have
> > you established the read gets all the entries (and what rel6 version of
> > autofs are you using)?
> 
> The read gets all the entry's but just doesn't show it in the directory 
> structure. I am having this issue on Redhat 6.5 (autofs 5.0.5-89)

It might be worth checking if the current rhel-6.5 release helps, if you
have access to it.

* Thu May 15 2014 Ian Kent <ikent@redhat.cem> - 5.0.5-89.el6_5.2
- bz1089889 - autofs can ghost non-existent map entries given the right timing
  - fix use cache entry after free in lookup_prune_one_cache().
  - check for non existent negative entries in lookup_ghost().
- Resolves: rhbz#1089889

* Thu Feb 27 2014 Ian Kent <ikent@redhat.cem> - 5.0.5-89.el6_5.1
- bz1067774 - autofs-5.0.5-88.el6 breaks maps that have a -v in the options
  - fix fix options compare.
- Related: rhbz#1067774

* Fri Feb 21 2014 Ian Kent <ikent@redhat.cem> - 5.0.5-89
- bz1067774 - autofs-5.0.5-88.el6 breaks maps that have a -v in the options
  - fix options compare.
- Resolves: rhbz#1067774

Ian

