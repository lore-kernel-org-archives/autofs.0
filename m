From: Ian Kent <raven@themaw.net>
Subject: Re: Difference between '/net -hosts' and '/net /etc/auto.net'
 auto.master entries?
Date: Wed, 10 Sep 2014 09:33:50 +0800
Message-ID: <1410312830.2548.11.camel@perseus.themaw.net>
References: <CAK2T3rox0jyPQYxH60RoOLiWDOTvGYRs3Y4uZmEzgs5YaGUUyg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=EiydInq7ZnXYowMy4bCKzXahLPA=; b=HVBPBYDS9nVPMa9RnYJF38feKxxs
	lPQFj+STgq5G2BmlJGEXuFCLNL/zU4noZGKhokZRdvMxNtkB/jSo1l+tX0/fYUom
	KNFbHVovhF8gIm9SJj/G45BhvmQYhzGEcMTNHNeYp1BSLvs5zVjxiGJgqcoxDTnC
	VEaHiVlKr/Pm0ro=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=EiydInq7ZnXYowMy4bCKzX
	ahLPA=; b=hBsVz5jn+tbok7zdIPKURNxqoucNnP2KCClYEomjzwifHAh5M/qT9w
	QZxp4H6KQbJD7sLU+8x276FGJFPZwKMQXffo8gcN0yQTJOkt85LCinlh+RiFI4Ax
	JhRBkmByKCK5mcmdH2PRg6mWAxB8xw5EN/S0tAC0KSgrwiADUL5Lg=
In-Reply-To: <CAK2T3rox0jyPQYxH60RoOLiWDOTvGYRs3Y4uZmEzgs5YaGUUyg@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Rufe Glick <rufe.glick@gmail.com>
Cc: autofs@vger.kernel.org

On Tue, 2014-09-09 at 15:16 -0400, Rufe Glick wrote:
> Hello,
> 
> In my /etc/auto.master file I add the following two entries:
>     /net   -hosts
>     /net2  /etc/auto.net
> 
> After starting the autofs service I can now access the same remote NFS
> share under either of these paths:
>     ls  /net/192.168.0.50/
>     ls  /net2/192.168.0.50/
> 
> Is there any difference between those two ways of achieving the same
> result? Is -hosts option just a shortcut for the auto.net script?

The result is the same but the later is a script that depends on
external programs while the former doesn't. And the script doesn't allow
the use of the expected standard syntax, the "-hosts" option. The script
hasn't been removed because people may be using it and because it's an
example of functional program map.

Ian

