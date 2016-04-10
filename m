From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Sun, 10 Apr 2016 10:29:08 +0800
Message-ID: <1460255348.3508.21.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net> <1460110224.2979.35.camel@themaw.net>
	 <20160408122552.GW15153@bccms.uni-bremen.de>
	 <20160408142907.GX15153@bccms.uni-bremen.de>
	 <1460166126.3073.20.camel@themaw.net>
	 <20160409095659.GB15153@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=T1UHgur0dIJrENeU+g1s63aJDbM=; b=Zm+uor
	5qk4R1EGWUnFxptzKMUO8QPR5XF4eGKyl9NMGXc+ON3wGVAPadI127Vso/QoHlo0
	Z3NkW711beEYRjXGK5Iuz9yhRMn/UlmA5qaAFDJxggYXW0fHgrZ8ZVPk9GcutzRD
	RA7xaqxXWuZyDBF2BpFNmxWKt8fC+ZweEDBd8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=T1UHgur0dIJrENe
	U+g1s63aJDbM=; b=YUbasMx6bEOGwhqU921WB4j/w2El/Ch8cpcBjgqjCmrKGPZ
	3iDGnBtTfgxD56OO47IYmCu3M9pU8pGXNZKDbKgdnv7/TLQwOSkg15/F4bpn0dXc
	LxN9HmNXvjeCcVYje6qL4brPxspYoSKJ2O69gF5Et5AECGndPVAx0tfYbZ7s=
In-Reply-To: <20160409095659.GB15153@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de, autofs@vger.kernel.org

On Sat, 2016-04-09 at 11:56 +0200, Christof Koehler wrote:
> Hello,
> 
> yes, indeed the 5.0.7 source deb rebuild is very strange. I also
> checked
> the libraries under debian/usr/lib/... in the build directory and they
> do not contain a libtirpc reference.
> 
> I can see two possible strategies:
> 1.  Concentrate on the 5.1.1 deb source I grabbed from ubuntu 16.04
> and the 
> deb package rebuild from that. Those libraries obviously contain a
> reference
> to libtirpc but do not mount anything. Too old libtirpc comes to mind
> then ?

An old libtirpc is a possibility.

And I think the best chance is to use 5.1.1 and possibly back port any
changes.

But I don't have an IPv6 environment I can use to help so that's a
problem straight away.

As I say, the only other thing we can do is add some targeted debug
logging and see if we can spot what is going wrong.

There have't been any changes to the RPC code since 5.1.1 (at least none
that I remember, I'll check later) so that should be a good source base
to use regardless of whether it's built from original source or deb
package.

I know there were some changes to libtirpc but I use a lower level of
communication and those changes formed the bulk of the changes I made to
autofs for the RPC communication. Maybe I missed some dependencies
myself, hard to tell really without knowing what's going on.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
