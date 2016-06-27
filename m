From: Ian Kent <raven@themaw.net>
Subject: Re: Regular deadlocks
Date: Mon, 27 Jun 2016 08:26:48 +0800
Message-ID: <1466987208.3191.6.camel@themaw.net>
References: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
	 <1466906389.739.25.camel@themaw.net>
	 <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=kF2mcoLKHJ/2B3sNSASHa96eyQE=; b=eWsdOf
	15oU7BF8fFSK1jWY5S/PURHVy/DENSDWwiyjbvxWTl+PrfsknoTIIdrWarK99PSu
	VHvmgmFaAdgYgXHA6xVuTAjiZECSChZ5xsjUqrOGA7N0lbGopHTBd1uyJbdK6sJt
	Z4TRtLf7/vT1tO8Yg2nACUXQY83muJ3QRSAmU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=kF2mcoLKHJ/2B3s
	NSASHa96eyQE=; b=U4h2UPOLAwYhwBtuAbrDjKc1+g0RcS3Zkk2TQT/Qyjw/iTj
	ECd/k6qc1/2F9/hYW9c++oVSOYKqtRdjN9TBgkuNgFPo+VjyKtgNuy7kcjCCb+cJ
	V/buRjqKIlMnwcw0cOJvMsILsiorrNm+CnLl05X70KbiW+YE7sMaIR3owopE=
In-Reply-To: <c4d585e4-fae9-829f-b7ad-74724af5c2f9@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>, autofs@vger.kernel.org

On Sun, 2016-06-26 at 12:02 +0200, Cyril B. wrote:
> 
> However, I've also had those "deadlocks" happen with several different 
> NFS servers at the same time (this was not the case with the traces I 
> sent in my previous email). If one NFS server was unmountable, should 
> automount be blocked when trying to mount others?
> 

How is autofs configured.

If --disable-mount-locking is not used then any mount can block all other
mounts, if it is used then there can be mtab corruption if still using a text
based mtab.

I always use --disable-mount-locking and nowadays the mtab is usually a symlink
into the proc file system so corruption isn't a problem.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
