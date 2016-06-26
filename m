From: Ian Kent <raven@themaw.net>
Subject: Re: Regular deadlocks
Date: Sun, 26 Jun 2016 19:02:21 +0800
Message-ID: <1466938941.739.43.camel@themaw.net>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=KhCQHW8mdKg2w93b9xwOQ/ETSv4=; b=aSWTNI
	FuRAUXoDCHPfcIiqL8NbOecE6yFQCtSVlmvk6XjWn48+ZwtkPe0LFibrqsWqYQ7o
	0hiZwTBWEllciwwIx+hmnTN9RbaMbE+SmeVqyLUwx/VocpYFXJs9xFuGXlktaJPo
	71V7jn5ws6P9KNF8OkXGGGVprXEXk/xgAd7Ds=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=KhCQHW8mdKg2w93
	b9xwOQ/ETSv4=; b=CNwwmZVZm5nf1Qw1fE72t5X0X8bWtgvkvKEjQOj0u4Z5IBT
	lDnGNqB5SkagSMIizpaq+O3qkpty8+9FAw8Trv6Bcy/k+AOl4MXIEkpViCBsDk41
	DbNi8GnPwHEXZ6XMBwkGqPvyXoIZI7py4erQPPlpFATA+wNrHsYQLuZm2aEc=
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

Ummm ... is that meant to be 5.1.1 and 5.1.2, typo perhaps?
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
