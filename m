From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: fix compilation without CONFIG_COMPAT
Date: Mon, 27 Feb 2012 17:20:40 +0800
Message-ID: <1330334440.2490.40.camel@perseus.themaw.net>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
	 <20120221.221609.218135609185671883.davem@davemloft.net>
	 <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
	 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
	 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
	 <1329889428.2193.45.camel@perseus.themaw.net>
	 <1329890027.2193.48.camel@perseus.themaw.net>
	 <1329890251.2193.50.camel@perseus.themaw.net> <m2vcmuh8dg.fsf_-_@igel.home>
	 <CA+55aFxH4_gucG7vpdV5NJPNHoXy5bSGtr0yHqmobvYO6PmjNw@mail.gmail.com>
	 <4F4B30D5.6050305@de.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=6pK1rr+Q8Iae+j8jKwBDmXvW8Iw=; b=yxjcB4CysGw0YznAJOjs9c/rpWVl
	aZAlYGQxKBEcfbGyagsBqoie+AVvZPHCJgMhMBSq2WRx6TS2yr93WaCT0iD4DNz5
	iTCWmHZuulKMLDyhUy4q3z0qxBaqJ1j55rS61AyRW6rMG2FSpr4qUwT1lullK1fp
	pqGw5P8+pXv2olU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=6pK1rr+Q8Iae+j8jKwBDmXvW8Iw=; b=d2G
	4AAwsBzHelG9Xg8g8r3cOYq8B9BOy4oz54T2qa4cbjVk3nAn3DnFakAKZFBuSZ9k
	9n13l73ybHDnsN2eYXq2oAvO4fvluWtNDPPSM4wdEySRYkIx2JC5oxZ96/cqhk2m
	npJg5hEBktLNPeJc5BayT4QU1JiQZFMjeqonJoro=
In-Reply-To: <4F4B30D5.6050305@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Schwab <schwab@linux-m68k.org>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Mon, 2012-02-27 at 08:29 +0100, Christian Borntraeger wrote:
> On 26/02/12 02:31, Linus Torvalds wrote:
> >  
> > +#else
> > +
> > +#define is_compat_task() (0)
> > +
> 
> Linus,
> 
> this breaks 32bit builds of s390 (and maybe others), since several platforms already
> define a is_compat_task. This macro then destroys the definition of the function
> making

It looks like s390 is the only arch that uses a #else (CONFIG_COMPAT) so
maybe it is the only breakage.

Perhaps using a function instead of a define in include/linux/compat.h
and removing the else from arch/s390/include/asm/compat.h is the
sensible thing to do here or maybe just removing the #else from
arch/s390/include/asm/compat.h since it just returns 0 anyway?

> 
> static inline int is_compat_task(void)
> {
>         return 0;
> }
> 
> 
> into
> 
> static inline int 0
> {
>         return 0;
> }
> 
> e.g.
> 
> In file included from arch/s390/mm/fault.c:39:0:
> /home/autobuild/BUILD/linux-3.3.0-rc5.00060.g203738e.49.x.20120227/arch/s390/include/asm/compat.h:177:38: error: macro "is_compat_task" passed 1 arguments, but takes just 0
> /home/autobuild/BUILD/linux-3.3.0-rc5.00060.g203738e.49.x.20120227/arch/s390/include/asm/compat.h:178:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
>   CC      arch/s390/kernel/time.o
> 
> 
> 
> 
> Christian
> 

