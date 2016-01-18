From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] prevent autofs to try the wrong IP protocol
Date: Mon, 18 Jan 2016 09:04:10 +0800
Message-ID: <1453079050.3005.7.camel@themaw.net>
References: <1453065279.8867.21.camel@domdv.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=c61t+kOeYzaCzQEpyOF56TZLC40=; b=HLMhb5
	8qRehUCQWasE3ze2RqGZMyJAkGHdZfewbnwXqhbvWqC8+EepZM5APTfYBB437JW7
	AhQlOGh5UuDUqtLJAYGQuZ8t//ZOKmPu8kZlsCywW8dF6cYEcQ3gQtWIsMtP5NTk
	HLfqPeDNLIOwvqqZfQ+5SrhVR15w6hZ9H/pY0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=c61t+kOeYzaCzQE
	pyOF56TZLC40=; b=lUISWZH0yjPPZVBsbAoeSzadtBDd18UbApZ3zS6q/PPvwWC
	x6/MHkaaBpkVk4tgCLnK4EfbDwg7jOhsTeUi26ZLQ6B7wQg+3+bF/WcC/rVqrbQR
	if02YTod5sinXuhvPtdsG8RIJQnyEe3zBO66Flu7hqqebX+pSKYaxaad+IWw=
In-Reply-To: <1453065279.8867.21.camel@domdv.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Steinmetz <ast@domdv.de>, autofs@vger.kernel.org

On Sun, 2016-01-17 at 22:14 +0100, Andreas Steinmetz wrote:
> [please CC me on replies, I'm not subscribed]
> 
> If the user configures an IPv6 protocol for nfs, autofs tries IPv4
> too,
> and vice versa. The attached patch against autofs-5.1.1 prevents
> this.
> 
> The additional tries for the wrong IP protocol can be quite costly if
> e.g. an IPSec tunnel must be brought up.

I get what your trying to say and agree that it should be fixed but I
wouldn't do it quite this way.

The method you have used is not in line with the way the code currently
works so I'll need to have a look at it when I get some time.

For example, it would probably be better to define TCP6_SUPPORTED, and
a corresponding define for UDP, and use that to determine which of UDP
or TCP should be tried in the same way that TCP_SUPPORTED and
UDP_SUPPORTED is used.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
