From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Wed, 04 May 2016 15:20:53 +0800
Message-ID: <1462346453.6523.18.camel@themaw.net>
References: <20160428091019.GO30271@bccms.uni-bremen.de>
	 <1461840658.3063.18.camel@themaw.net>
	 <20160428112648.GS30271@bccms.uni-bremen.de>
	 <1461894846.3033.14.camel@themaw.net>
	 <20160429141044.GA30271@bccms.uni-bremen.de>
	 <1461986471.3848.84.camel@themaw.net>
	 <20160430113600.GI30271@bccms.uni-bremen.de>
	 <1462168902.2983.72.camel@themaw.net>
	 <20160502160810.GE6794@bccms.uni-bremen.de>
	 <1462262318.3034.35.camel@themaw.net>
	 <20160503151345.GH6794@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=4PQ404t64oewBsdZD0EkRiNfDKE=; b=P4AQqj
	mBWf9g4+YemWBh26VnQCtoSugsHhZVdJUFPnzFh1ELqng+IPo5bpA1BFaY3wY4mh
	kr3o7+AArD7sNURHmMNuCqEfPLRHJ7IJ8W0X8QxcNDOupsMNUSlwVRecXzb/6U6u
	LM8Uijvs+7w4RIDoRxlfM4tFpQFjoAObxFXsw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4PQ404t64oewBsd
	ZD0EkRiNfDKE=; b=PGosMw9+TUFPBako/Va4oOL9NKYY0fWGT1DgfNNTEwISXb6
	zACuv9GkzaPe57hmooV/d/12qU5Ceyt/i+Uc034kYsEnPcPtqjndibtRFPgf7hec
	W6lrHQdw3AGqPP5GRdwFe/YOqr28EBO7L9Ms4yllmWK+qvL6olZdQ/LhCKfY=
In-Reply-To: <20160503151345.GH6794@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Tue, 2016-05-03 at 17:13 +0200, Christof Koehler wrote:
> Hello,
> 
> On Tue, May 03, 2016 at 03:58:38PM +0800, Ian Kent wrote:
> > On Mon, 2016-05-02 at 18:08 +0200, Christof Koehler wrote:
> > > We are still using NIS and actually we had the autofs map in  NIS
> > > for years. 
> > 
> > Actually I hadn't thought about NIS and IPv6 and I haven't seen any
> > discussion about it so it probably isn't ok with IPv6.
> Still, if you need any tests ...

Right, thanks.

> 
> > 
> > The autofs LDAP code is complicated, it's difficult to work with.
> > 
> > Anyway, for my part, if you have a system that your site is
> > comfortable
> > with that suits your needs, and you don't have a compelling reason
> > to
> > move to LDAP, I'd recommend holding back from moving to it.
> 
> I believe that, especially considering that there are three (?)
> different
> schemas for storing them. That's sufficient to convince me to not
> store our 
> non-executable maps in LDAP (if I ever move to LDAP). I can manage
> them
> fine using ansible I believe.

There's really only two when it comes down to it.

I get confused about the rfc designations for these.

I think rfc2307 is what I have called the NIS schema and rfc2307bis is
what I usually call, well, rfc2307bis.

The rfc 2307 rfc is a subset of rfc 2307bis so they are really just one
schema. The bis schema adds automount* attributes to the existing nis*
attributes.

One might use the nis* attribute names if coming from a NIS environment,
especially if there were conversion utilities available.

But the bis schema is preferred IMHO.

The main advantage of the bis schema is the automountKey attribute is
case sensitive, the NIS schema uses the cn attribute which IIRC is not
case sensitive.

There is another schema which I think have mistakenly called rfc 2307 in
the past but I think that one uses incorrect OID assignments so it
shouldn't be used.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
