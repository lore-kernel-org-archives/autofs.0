From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 03/12] autofs: Fix AUTOFS_DEV_IOCTL_IOC_COUNT value
Date: Tue, 19 Jul 2016 09:34:15 +0800
Message-ID: <1468892055.5120.29.camel@themaw.net>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
	 <1468138073-4870-3-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=TtMo2x48rQychZwOcsdDHGr5omQ=; b=jLRcWx
	a3IHrIA1muhfEdYukOKOpymcxprGcqCUsvZhpwhqO3dnoGQ7nKRA4Ixj/LqNqH7d
	OkZP4afYhVj1fpJpuj4tIXlqtfc+Rk6F+F/tXd1K+fmdC7lsrU6DdUR12zyppsy8
	1AP8Uknxe3ERdgC74VMUg3ZoSi2esM9+6QSk4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=TtMo2x48rQychZw
	OcsdDHGr5omQ=; b=neUXNZq6q1fF24buerLo+XaiH0O1ahVcujepdZ3TFHyRUp+
	Ak0F5MwbcsbaPzb2Ho2f/L3g/oYWm+gDmsbXhm+zljqcj4FCZi6bfslqeW7mcHAB
	25iQZk9abHO9HSk7HMPWWjUhUA8Ag8FPeH5npqmpO1QRaNT8BKT17Oe2fZeQ=
In-Reply-To: <1468138073-4870-3-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs@vger.kernel.org

On Sun, 2016-07-10 at 17:07 +0900, Tomohiro Kusumi wrote:
> According to include/uapi/linux/auto_fs.h, include/uapi/linux/auto_fs4.h,
> and include/linux/auto_dev-ioctl.h, nr part of
> AUTOFS_IOC_XXX starts off from 0x60 and
> AUTOFS_DEV_IOCTL_XXX starts off from 0x71 which is 0x60+0x11.
> 
> From the way above macros are defined, it seems
> AUTOFS_DEV_IOCTL_IOC_COUNT should be (0x20-0x11) instead of (0x20-11).
> (Otherwise it's hard to figure out where 11 comes from)

You're correct, this is wrong but I think this change is also wrong.

And so is the range check in dev-ioctl.c.

There's no check for an ioctl number greater than the range claimed by autofs
and the check in dev-ioctl.c seeks to check the number used is within the range
used by the dev ioctls.

Essentially

AUTOFS_DEV_IOCTL_VERSION_CMD - AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD = 0xd

14 ioctls ranging from 0x71 - 0x7e (inclusive).

The range check in dev-ioctl.c is:

        if (_IOC_TYPE(command) != _IOC_TYPE(AUTOFS_DEV_IOCTL_IOC_FIRST) ||
            cmd - cmd_first >= AUTOFS_DEV_IOCTL_IOC_COUNT) {
                return -ENOTTY;
        }

so I think AUTOFS_DEV_IOCTL_IOC_COUNT should be:

#define AUTOFS_DEV_IOCTL_IOC_COUNT \
	(AUTOFS_DEV_IOCTL_VERSION_CMD - AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)

and the check should be:

        if (_IOC_TYPE(command) != _IOC_TYPE(AUTOFS_DEV_IOCTL_IOC_FIRST) ||
      
      cmd_first - cmd >= AUTOFS_DEV_IOCTL_IOC_COUNT) {
                return 
-ENOTTY;
        }

What do you think?

> 
> COUNT macros are being used to test distance of an ioctl command
> in question from the smallest one, so we don't want it to be
> larger than necessary.
> 
> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  fs/autofs4/autofs_i.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
> index 73e3d38..7ef4d08 100644
> --- a/fs/autofs4/autofs_i.h
> +++ b/fs/autofs4/autofs_i.h
> @@ -20,7 +20,7 @@
>  #define AUTOFS_IOC_COUNT     32
>  
>  #define AUTOFS_DEV_IOCTL_IOC_FIRST	(AUTOFS_DEV_IOCTL_VERSION)
> -#define AUTOFS_DEV_IOCTL_IOC_COUNT	(AUTOFS_IOC_COUNT - 11)
> +#define AUTOFS_DEV_IOCTL_IOC_COUNT	(AUTOFS_IOC_COUNT - 0x11)
>  
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
