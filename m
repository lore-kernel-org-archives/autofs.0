From: Ian Kent <raven@themaw.net>
Subject: Re: Kernel 3.3.0 autofs v5 packet size change
Date: Tue, 28 Feb 2012 09:18:20 +0800
Message-ID: <1330391900.2465.1.camel@perseus.themaw.net>
References: <1330307187.2490.13.camel@perseus.themaw.net>
	 <1330310418.2490.34.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=1AqkGm38abBRKkfmS87jKnuPQtk=; b=g5A/FqLnf4oqpy1OklkMcKHHmbC+
	DKAVmMTkLO9Nhdh72pCuS5wJhHooNSmTM6QJHnneGeddTc2okB4TSLjSJQ4tMz9F
	UIKIMvQfRXD7/n15yEo/K313LSoTMfB8/AW2a3KP5x4XFPmDleo2/20C7o18wUac
	ymv4NApElITwwmY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=1AqkGm38abBRKkfmS87jKnuPQtk=; b=Pfn
	DsWKqAbWEW8IA7islTSd4+msZZPd6keLxDVlyXKDxKNdxPznLItSiOPuOuARUnVq
	9sca49cNk4KhmOvLSaQbju9Kpdp3ASkyAHgtlhLOD1o931XWHfxNAMi2rjfbQnch
	BV5MVMZlIpj174tggqdhfVdReY5t6cyACChq+ZVw=
In-Reply-To: <1330310418.2490.34.camel@perseus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org
Cc: intraperson-autodir@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

On Mon, 2012-02-27 at 10:40 +0800, Ian Kent wrote:
> On Mon, 2012-02-27 at 09:46 +0800, Ian Kent wrote:
> > Hi all,
> > 
> > Just a heads up for everyone regarding a recent kernel change.
> > 
> > The description from the autofs user space patch describes the issue:
> > 
> > "Kernel 3.3.0 has a patch to allow for the original missdesign of
> > the autofs v5 kernel packet.
> > 
> > The problem is that while all the structure fields are alligned
> > correctly structure allignment on x86-64 causes the packet size
> > to be 4 bytes larger than on x86. So when running an x86 binary
> > on an x86-64 install the packet size did not match causing user
> > space pipe reads to hang."
> > 
> > If you are an upstream package maintainer and your distro is likley to
> > migrate to kernel 3.3.0 or later or you are planning using kernel 3.3.0
> > or later then you will need these patches:
> > http://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.0.7/autofs-5.0.6-add-kernel-verion-check-function.patch
> > http://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.0.7/autofs-5.0.6-allow-for-kernel-packet-size-change.patch
> 
> and, of course, a fix for mistakes I made:
> http://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.0.7/autofs-5.0.6-fix-allow-for-kernel-packet-size-change.patch
> 
> > 
> > If you use rc kernels and you plan on using 3.3.0-rc5 you will also need
> > commit 3c761ea05a8900a907f32b628611873f6bef24b2 from the linus kernel
> > tree to fix a compile mistake.

And now also, if you are using rc kernels for s390, you'll need commit
048cd4e51d24ebf7f3552226d03c769d6ad91658 as well.

> > 
> > Sorry for the inconvenience.
> > Ian
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


