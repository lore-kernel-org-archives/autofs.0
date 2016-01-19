From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] prevent autofs to try the wrong IP protocol
Date: Tue, 19 Jan 2016 09:33:49 +0800
Message-ID: <1453167229.3133.4.camel@themaw.net>
References: <1453065279.8867.21.camel@domdv.de>
	 <1453084618.3005.14.camel@themaw.net> <1453164331.8867.30.camel@domdv.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=cO7Offx7KvxGHUq1/yzfBVANNVQ=; b=TxnVTr
	HwkFGeUuXd8ay3VWZuOJEjj+CrV+nVVpL//Nw6M2pgqnozPOm54Q8FxVUu/x/OYL
	kqQI2QDEcrPRDzJkGDPcANJkRK18YYp1wvh71zrIVUxBWjeCGTueJzkeTLDyo1Eu
	+fQ8IgKxP7VT2+ld5r2+vFGdsqHivotdM5GHQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=cO7Offx7KvxGHUq
	1/yzfBVANNVQ=; b=s9clRfawNwPOAiWMOFvQfXLPKl39dG6jbQScJII0vttSJJ0
	KBniyWU3sPP9VS82noz8EApvDCp5r+i/LnvqrWsLQQ6iZe4Nh/vXpyxE7SrhPi9f
	8yjHy53qFpR6QRJH4GXove1ssdtVyRC2AS+sSwjUPA9LaxOmHsgJu8Ohv45w=
In-Reply-To: <1453164331.8867.30.camel@domdv.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Steinmetz <ast@domdv.de>, autofs@vger.kernel.org

On Tue, 2016-01-19 at 01:45 +0100, Andreas Steinmetz wrote:
> On Mo, 2016-01-18 at 10:36 +0800, Ian Kent wrote:
> > On Sun, 2016-01-17 at 22:14 +0100, Andreas Steinmetz wrote:
> > > [please CC me on replies, I'm not subscribed]
> > > 
> > > If the user configures an IPv6 protocol for nfs, autofs tries
> > > IPv4
> > > too,
> > > and vice versa. The attached patch against autofs-5.1.1 prevents
> > > this.
> > > 
> > > The additional tries for the wrong IP protocol can be quite
> > > costly
> > > if
> > > e.g. an IPSec tunnel must be brought up.
> > 
> > Is this close to what your asking for (not even compile tested)?
> > 
> > I'm not certain this won't have any undesired side effects AFAICS
> > it
> > looks ok.
> > 
> > autofs-5.1.1 - fix ipv6 proto option handling
> > 
> 
> Well, I had to fix up your patch slightly to work, at least for my
> IPv6
> use cases. Except for the fact that there are now new version bits in
> use which do hopefully not cause any unwanted side effects it now
> seems
> ok to me. Modified patch of yours is attached.

OK, thanks, I'll have a look at the changes and integrate them.

I think all accesses to the bit fields are bitwise or should be anyway,
I'll have a look around to see if I can see any that could be a
problem.

> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
