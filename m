From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 11:05:59 +0800
Message-ID: <1442199959.3030.40.camel@themaw.net>
References: <55F58085.4090509@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=AWUgkylTwrulxAdhZlL49iF4vrQ=; b=WGrUn7
	m4vMjWlrQOK0iaS4Lqky0M7ToNAvKOiZv2XK1UG9XAt8pIouKyzm/C1icLbrkKvo
	ki/Z6Z2iDQi3FxIt02WI9tgGDxTjqEh5/Y1AYjwvlkspN4kR88+x+eYL3i2bkOiw
	ZvL5ny2yMS7+OLHQNDC0UiL8rEKQibpCfXQJg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=AWUgkylTwrulxAd
	hZlL49iF4vrQ=; b=TxIVsNKK28eQzmSX2ssZWfGSFddbyGbbTFmNmz/UslEOEgx
	5ICpCBpiu/dxXPIcP+hyvbtyU4vJzkbO4XXsxVTN3xzIL943gwy9/El0QO9X73/h
	OrZHJsF0ZQ7PMmCdFun4hhZqSLxrS6k9R49H8pQnBO6ywW8me+BOP7vYWJuM=
In-Reply-To: <55F58085.4090509@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Sun, 2015-09-13 at 15:56 +0200, Cyril B. wrote:
> 
> My solution was to add a --mode option to autofs, with the included 
> patch. I'm not familiar with autofs's code or even Lex and Yacc, so my 
> code is probably more of a proof of concept. It seems to work fine in my 
> use case, though.

If you want to contribute patches then post then in-line as text without
any additional change (eg. ensure the mailer doesn't split lines therby
corrupting the patch).

I can't properly comment on the patch, even if I wanted too, because it
isn't in-line.

Anyway, what about updating the man pages with your new option?
Should text modes be considered, perhaps octal modes are sufficient, and
should be all that's allowed, to keep the change as simple (generally a
good idea) ...

Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
