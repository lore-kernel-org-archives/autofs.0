From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 04/13] autofs4 - change printks AUTOFS defined prints
Date: Thu, 06 Nov 2014 07:42:09 +0800
Message-ID: <1415230929.2365.26.camel@perseus.themaw.net>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
	 <20141103081234.6215.82821.stgit@perseus.themaw.net>
	 <1415003136.17743.9.camel@perches.com>
	 <1415006418.6573.6.camel@perseus.themaw.net>
	 <1415025215.17743.12.camel@perches.com>
	 <1415228573.2365.24.camel@perseus.themaw.net>
	 <1415229642.6634.32.camel@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=SWNAw4KctmHGpYAFNAnMRvHxdh0=; b=WTaGs7zphiuKSK6+su
	b54TWXVNcMjcuuQmdZ/FL40Kv1KgCNimKnTRSgXit4JUNVtw2pQVVtWfLCDmg/5G
	3v9ATSqfocSLLRinzkeKweA55BqhTrk98zU3Bdb9je2IMyY6D4GDjaOknW17IHQx
	BIgm9OpHAQdmKU+hqQmEwb61A=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=SWNAw4KctmHGpYAFNAnMRv
	Hxdh0=; b=TJuBvrjtHNCGj5IfwNp0HVYGsPNBEXV2VAt8okPJuBC5JuBXiJuqYw
	/LQy9ytqF1zInQ79mkypQtMvmgVeg0fkHKPXB3cfQTWJrmwcQH0126lJBxB/w9sX
	5sdq6Q852sRarKlPR/2K4whC2+ZDzn2gu3HjnqLGuWtbv4kgxbLjU=
In-Reply-To: <1415229642.6634.32.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2014-11-05 at 15:20 -0800, Joe Perches wrote:
> 
> > But idea of using pr_xxx() and pr_fmt() (actually that's too open to
> > name clashes so it would need to be named something like autofs_pr_fmt()
> > anyway) looks like it results in less readable code so I'd really prefer
> > not to do that.
> 
> Using pr_info/pr_debug (or any other pr_<level>) is a
> generic mechanism in the kernel.  Adding a
> #define pr_fmt is also generic thing that works with
> all the pr_<level> uses in a specific compilation unit.

LOL, so you recommend I look more closely, I will.
In the meantime I'll send the other patches to Andrew.

Ian
