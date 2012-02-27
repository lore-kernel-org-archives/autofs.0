From: Ian Kent <raven@themaw.net>
Subject: Re: Kernel 3.3.0 autofs v5 packet size change
Date: Mon, 27 Feb 2012 10:40:18 +0800
Message-ID: <1330310418.2490.34.camel@perseus.themaw.net>
References: <1330307187.2490.13.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=CNmMTkJwURqjyVS5caf8DlmLBwQ=; b=huD9JeuRMNbuz4L+TZrlr3Bvaf+q
	OrG9R+EphvwQRfjAF6BsOdiYEECxcuheEb36r/EwRdCckfi5tY0yb5BvTkCE6inS
	bikpMJrfoC6O8SvnxYOjjo1pE/hFtCQiBh4sRo3N31GmiUfwErfrC/45eQ2EFSR0
	TWkykk5FrRijxEU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=CNmMTkJwURqjyVS5caf8DlmLBwQ=; b=lpv
	xP4af1Z/9jixNNzafz7bFaxBR8XYrlmDmdsIEOqwfhbmaRKwBsD/CxeQuOs2P2PC
	aFEe2R7SlBk1hNuf2+LdE2mwEJSLKSgF8cxHWD5RBWmW/I2Hz9F2y4fRaXXsp7xC
	n7CTQZFxctHbh2J3M/5YmjdEW0wVSZK1d0b4ZOhU=
In-Reply-To: <1330307187.2490.13.camel@perseus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org
Cc: intraperson-autodir@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

On Mon, 2012-02-27 at 09:46 +0800, Ian Kent wrote:
> Hi all,
> 
> Just a heads up for everyone regarding a recent kernel change.
> 
> The description from the autofs user space patch describes the issue:
> 
> "Kernel 3.3.0 has a patch to allow for the original missdesign of
> the autofs v5 kernel packet.
> 
> The problem is that while all the structure fields are alligned
> correctly structure allignment on x86-64 causes the packet size
> to be 4 bytes larger than on x86. So when running an x86 binary
> on an x86-64 install the packet size did not match causing user
> space pipe reads to hang."
> 
> If you are an upstream package maintainer and your distro is likley to
> migrate to kernel 3.3.0 or later or you are planning using kernel 3.3.0
> or later then you will need these patches:
> http://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.0.7/autofs-5.0.6-add-kernel-verion-check-function.patch
> http://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.0.7/autofs-5.0.6-allow-for-kernel-packet-size-change.patch

and, of course, a fix for mistakes I made:
http://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.0.7/autofs-5.0.6-fix-allow-for-kernel-packet-size-change.patch

> 
> If you use rc kernels and you plan on using 3.3.0-rc5 you will also need
> commit 3c761ea05a8900a907f32b628611873f6bef24b2 from the linus kernel
> tree to fix a compile mistake.
> 
> Sorry for the inconvenience.
> Ian


