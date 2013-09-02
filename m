From: Martin Wilck <martin.wilck@ts.fujitsu.com>
Subject: Re: [PATCH 00/25] Current autofs patch queue
Date: Mon, 02 Sep 2013 13:04:51 +0200
Message-ID: <522470D3.3050105@ts.fujitsu.com>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box> <522469BD.1030709@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ts.fujitsu.com; i=@ts.fujitsu.com; q=dns/txt;
  s=s1536b; t=1378119886; x=1409655886;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=biIs8q3zef1ZCpZINBUmtfIlRXLoxRD4E0FGpUMVVGs=;
  b=fMbVhBR29IJ36Y4853LqvmD7rdG8Z4JBTzrXGAzfWL9qktJjbawxxTCz
   msIyxDDAi6mwudIV89IHy0B48/mp2EiftJuMA/M4+NcVuF0wagE86T5wv
   a7WzE7Hqt9vbcxEaHk3Fmz8ZSEpaIkVcm+ccAn2Imx/LM0MzWGXc/iNj2
   nyhwIcYFtF/YAFtD4J0CzPbqqqsJd/9LR862cu3bJlPIayb3WpGml50Q/
   Kxv99g3p5xyym0Z6ABqD5zywxPAQA;
In-Reply-To: <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Gordon Lack <gordon.m.lack@gsk.com>
Cc: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

On 09/02/2013 12:41 PM, Gordon Lack wrote:
> I am wondering about my auto.smb patch (see http://www.spinics.net/lists/autofs/msg00402.html).
> 
> I can add a comment about that link...
> 
> 
>>> OTOH, setting the uid to
>>> the caller is definitely what should be done, IMHO.
> 
> That only makes sense if the result is only going to be visible to that one individual.
> 
> Linux is a multi-user system, so having automounts that depend on who made the request to do the mount makes no sense if the result is going to be visible to everyone.
> I've not seen a system whereby different people have different views
> of what is mounted.

I'm not sure what you mean. Users can create user-specific CIFS mounts
today with "sudo mount -t cifs -o sec=krb5,cruid=$UID,...". The
intention of my patch is just to enable autofs to create such mounts.

It would certainly be reasonable to setup autofs such that a separate
mount point is used for each user, but that's a configuration issue. In
as properly configured environment, the "multiuser" option of mount.cifs
can be used to deal with local multiuser/permission issues.

Regards
Martin

P.S.: You are correct that there is an issue with autofs caching the
list of mount points if the list of mountable shares returned by a
server depends on the credentials provided. AFAICS that can be fixed by
configuring the such that all users can see the same shares (but not
necessarily access/mount them all).


> 
> ________________________________
> 
> This e-mail was sent by GlaxoSmithKline Services Unlimited
> (registered in England and Wales No. 1047315), which is a
> member of the GlaxoSmithKline group of companies. The
> registered address of GlaxoSmithKline Services Unlimited
> is 980 Great West Road, Brentford, Middlesex TW8 9GS.
> 


-- 
Dr. Martin Wilck
PRIMERGY System Software Engineer
x86 Server Engineering

FUJITSU
Fujitsu Technology Solutions GmbH
Heinz-Nixdorf-Ring 1
33106 Paderborn, Germany
Phone:			++49 5251 525 2796
Fax:			++49 5251 525 2820
Email:			martin.wilck@ts.fujitsu.com
Internet:		http://ts.fujitsu.com
Company Details:	http://ts.fujitsu.com/imprint
