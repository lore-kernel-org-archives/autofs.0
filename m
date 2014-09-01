From: Ian Kent <raven@themaw.net>
Subject: Re: configure script bug --with-flagdir
Date: Mon, 01 Sep 2014 08:43:51 +0800
Message-ID: <1409532231.2551.0.camel@perseus.themaw.net>
References: <201408311748.59806.rln-autofs@arbetsmyra.dyndns.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=p4xVocKyQaER/LVggs8M6KgOd5s=; b=iJHiKTKwS5o1G0l+q4+zI5byQ5PH
	N7vs2RUHYfJOvOEJf+HLK08OC7jgTxhEvJvuiMo4g0mtbgLMK+VxSX8MIlpTcQdb
	8Ot8FEr4V4wpJNVFNuOSlMRmc8IKENUnIqfw5LI9wrQ56jIqz9r54WFSaegSSfXo
	NNC4L5i11lYIA7M=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=p4xVocKyQaER/LVggs8M6K
	gOd5s=; b=qRd+p914tCeSXLbGD/HTQ397GoiKeBjRKAZY8IkShGSKhIT2BJMhhV
	cmWs7S8Bh8UdHWL64vSSDCx89SaJgQYR62I97HhSJnuiUFleasrcnCMvaP39UN8I
	jAU8vxOTHmmmy+/IhjV1IYrba03wnQA9WgZZKX+wWxQoZx9LgKv5M=
In-Reply-To: <201408311748.59806.rln-autofs@arbetsmyra.dyndns.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ronny Nilsson <rln-autofs@arbetsmyra.dyndns.org>
Cc: autofs@vger.kernel.org

On Sun, 2014-08-31 at 17:48 +0200, Ronny Nilsson wrote:
> Hi
> I would like to report a possible bug in the configure script. The 
> option "--with-flagdir" doesn't seem to work. Studying the source it looks 
> like the problem is a simple typo:
> 	filagdir="${withval}"
> should probably be
> 	flagdir="${withval}"

Yes, most likely, will check, thanks.

> 
> I've tried both v5.0.9 and v5.1.0.
> 
> Thanks
> /Ronny Nilsson
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


