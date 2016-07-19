From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 04/12] autofs: Change _LINUX_AUTO_FS4_H to
 _UAPI_LINUX_AUTO_FS4_H
Date: Tue, 19 Jul 2016 09:40:47 +0800
Message-ID: <1468892447.5120.33.camel@themaw.net>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
	 <1468138073-4870-4-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=JXWQPRIsVrnoxW/P4TcCrxUklKE=; b=hwHQbB
	flqcC7/FKb4aaWCWyKjGspb5ZC5nrfiGsjD4pVuFqtQRIftAyPsJ6MP69eMZHWY9
	gMU2TtgHc0LNOPJS+Z+K2AMLV/ED25hNodVZA52/O6OuRF5XWsWMiezN++AQk8p8
	J00/TIFwZCnbmtGnY7zE9Rbf/yxXMcAZ6RJJI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=JXWQPRIsVrnoxW/
	P4TcCrxUklKE=; b=l3vIBF9u+i9e8o/D0SzhH+7wHYPhLejOB8U0/TbHjOhouos
	F1q1MiFrj7kcgodKGG0Jpk7bF9rv5un07O+vE5eS6siWvd1qjYhPLmuWcs0iHLKP
	zsvAoqVM9oxXuH83J6uQk4ygP/8/ieDG3G3Ou52CawghTwYYhPluufp+DGbs=
In-Reply-To: <1468138073-4870-4-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs@vger.kernel.org

On Sun, 2016-07-10 at 17:07 +0900, Tomohiro Kusumi wrote:
> 607ca46e which introduced uapi to Linux kernel added "_UAPI" to
> include/uapi/linux/auto_fs.h, but not to include/uapi/linux/auto_fs4.h.
> 
> Headers under include/linux which only include uapi headers
> generally have different names for include guard without "_UAPI",
> so follow that.

Yeah, and my series to rename autofs4 to autofs fixes this (if I can ever get to
posting it, it's been a long time), along with moving auto_dev-ioctl.h to
uapi/linux, where it should be.

Also it merges auto_fs4.h and auto_fs.h, leaving a stub for auto_fs4.h for
backward compatibility.

> 
> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  include/uapi/linux/auto_fs4.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/auto_fs4.h b/include/uapi/linux/auto_fs4.h
> index 8f8f1bd..3c7ed14 100644
> --- a/include/uapi/linux/auto_fs4.h
> +++ b/include/uapi/linux/auto_fs4.h
> @@ -6,8 +6,8 @@
>   * option, any later version, incorporated herein by reference.
>   */
>  
> -#ifndef _LINUX_AUTO_FS4_H
> -#define _LINUX_AUTO_FS4_H
> +#ifndef _UAPI_LINUX_AUTO_FS4_H
> +#define _UAPI_LINUX_AUTO_FS4_H
>  
>  /* Include common v3 definitions */
>  #include <linux/types.h>
> @@ -154,4 +154,4 @@ union autofs_v5_packet_union {
>  #define AUTOFS_IOC_PROTOSUBVER		_IOR(0x93, 0x67, int)
>  #define AUTOFS_IOC_ASKUMOUNT		_IOR(0x93, 0x70, int)
>  
> -#endif /* _LINUX_AUTO_FS4_H */
> +#endif /* _UAPI_LINUX_AUTO_FS4_H */
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
