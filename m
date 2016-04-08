From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 08 Apr 2016 18:14:07 +0800
Message-ID: <1460110447.2979.39.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net> <1460110224.2979.35.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=u93qxGpAmkOrFliWerES7ef+1kQ=; b=fyKxn+
	rY49mZD0SNvohh91HqRH3s4qNe6nn72QRWNmaGJXiKwa/orIiO4LgskaYkh9jjSC
	VZwKGKiLZpGdcMM8n5oumoilfv/8nfAu8Pjw3o4o05FhXVXuy3zVmZA/Kgc8bJ87
	0gIuZvWZtPOCPqd2t/C7pVEWDhNcRwDgML9iQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=u93qxGpAmkOrFli
	WerES7ef+1kQ=; b=t2z0ljO2EyIcxauQKSEGeSEIE3tQByzf43h/wNT2ntNpob6
	bMAtKbd/oOwfSwZyYN6aWQm5QTy31QsRjfx2JnVRDqqEyzYBDly/rcTph9i7A1Db
	1iwGgj28thgjvgwThPVA+JQ0Lp8ztoX60s9k169Gp6aOWI44/jewIS6ekuvw=
In-Reply-To: <1460110224.2979.35.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de, autofs@vger.kernel.org

On Fri, 2016-04-08 at 18:10 +0800, Ian Kent wrote:
> I've been using libtirpc in Fedora and RHEL builds for nearly 10 years
> so I don't think the library problem is with autofs.

Umm .. that might not be true.

Amend that to read I've been using libtirpc with autofs since not long
after it was available, feels like it could be 10 years though, ;)

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
