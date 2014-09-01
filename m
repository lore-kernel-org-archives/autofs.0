From: Ian Kent <raven@themaw.net>
Subject: Re: configure script bug --with-flagdir
Date: Mon, 01 Sep 2014 15:06:50 +0800
Message-ID: <1409555210.2551.5.camel@perseus.themaw.net>
References: <201408311748.59806.rln-autofs@arbetsmyra.dyndns.org>
	 <5404041F.2030107@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=QjpAEfDw8X32tzji4zDpVDAJlKs=; b=xDgPE3dq868eF98bH2fbCCV5oguc
	yvMOCsNhpprXhz3ub/ztOqmboMKT7vvLMRPgtjPdNWFqwC6399WqIiAiLQO7q7X0
	+9sPEMASoLJA1TDqdk2nqIdPoZXTKLSErx7B0ZtRQbsrhUgNC83zlcG7P+pLu91s
	owJzKSvx0Yft7g4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=QjpAEfDw8X32tzji4zDpVD
	AJlKs=; b=oReAqHPMLjfJzqQEhWUdTaMt0ecImUj3ADlWhfcg0FzKKwQ5KLi9OO
	nJkKaxgwkjB30W8qGcO3nX/BQsLFg334W8odyakekiKp2twn60Y8O6W56zzFO+1p
	jpinL/AGaTo7Trp/9SfTQfznb0ogiNIZXWU6jaCBnCWWsLO8JQRi8=
In-Reply-To: <5404041F.2030107@msgid.tls.msk.ru>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Ronny Nilsson <rln-autofs@arbetsmyra.dyndns.org>, autofs@vger.kernel.org

On Mon, 2014-09-01 at 09:29 +0400, Michael Tokarev wrote:
> 31.08.2014 19:48, Ronny Nilsson wrote:
> > Hi
> > I would like to report a possible bug in the configure script. The 
> > option "--with-flagdir" doesn't seem to work. Studying the source it looks 
> 
> http://www.spinics.net/lists/autofs/msg00159.html -- I think autofs is hopeless.

LOL, right, missed that one.
Thanks for the encouragement Michael, ;)

> 
> Thanks,
> 
> /mjt
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


