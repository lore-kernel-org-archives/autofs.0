From: Ian Kent <raven@themaw.net>
Subject: Re: fix undefined authtype_requires_creds error
Date: Mon, 28 Oct 2013 16:27:44 +0800
Message-ID: <1382948864.2523.25.camel@perseus.fritz.box>
References: <CAF1ZMEc84Ep6cpEbnmYw4YJpuQJwrOVketBtNcgNZZTGTBHz_g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=MzaHCbQB1ZhXG7DAdZviGVFQPQ8=; b=P9IVAtgf3nlAYN5BAdxpjZBQehCh
	1lpNe3iVic91Ot/wz0ah1vzbolrihIC242QLH+EQs6BFQ8Gs0SRveF3wcN+x7qBC
	VSzAhfxBNiKpvUGERDuNVVgjdiwazmHiqmGTALvSOepqtOpl5Uv6LbLgw+ZLK255
	LBk2qUFFNMyK13M=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=MzaHCbQB1ZhXG7DAdZviGV
	FQPQ8=; b=bpqV+CQL0PZ6kwz1679WXvVM8FfqhnKkK11qaBWx2ia7rMgNWOtnGN
	s1u7DfA+tZxIM9LCD2CNjhfFOPyfl/7VgJPTjS8GaM4XSs/EqijjR9mGiArjujIi
	ny3tYXdarXgTci0FcGIe/I4fNKlD652RtZJB/YF+XXWxXmOeplGB0=
In-Reply-To: <CAF1ZMEc84Ep6cpEbnmYw4YJpuQJwrOVketBtNcgNZZTGTBHz_g@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Thu, 2013-10-24 at 11:34 +0800, Dennis Lan (dlan) wrote:
> HI Ian:
>   here is simple patch for fixing undefined authtype_requires_creds
> error while LDAP enabled but without SASL.
> 
>   sorry for using attached file, since I have problem to use "git
> send-email" in my office.
> 
>   also the downstream bug here, https://bugs.gentoo.org/show_bug.cgi?id=489128

Ahh ... something I missed in 5.0.8.

I've added it to the pending patch queue in the autofs-5.0 and master
branches.

Not sure yet how I'll manage the two branches but I'll see how it goes
and then decide.

The master branch will eventually become autofs-5.1.

Ian


