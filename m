From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: fix doubled word
Date: Thu, 16 Jul 2020 10:45:54 +0800
Message-ID: <0b503a7ffb1d80b5f54bb73f360836ce326957b7.camel@themaw.net>
References: <5a82befd-40f8-8dc0-3498-cbc0436cad9b@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        RK6X2jS67N6+KCtzTA8njDUA4e35g7s8yrXJmhHU/FI=; b=J3BlXMnIIL+TSLgF
        nH+atEKDOjZuUSq91An9c3SdEhta/0ejPupNmujChgartH1L7wzWv4jgKJwvGbxX
        tKSMcmes5XL9tgZz5Ht5D83eR+B17fCfB0zYvkBR46/5u+FRC/NwF9eJDmJ6DQ51
        Kh9llvfFBtI/h0Qzc+poc6fgt4j8ca2R1EmSnpJTnM+9vKfSY5CcHlzCOKXUDiL3
        AR0jNHIT3fS3B2vlvcHvNM5Jc8XOYOK6ttsHgIRvXjuhrtdGHjAsGi3h7lwGIprY
        YvdFSNhR/A7Bcjh5Kp7mY94w4REZsrIFWT7omFFoB+OI5y9dPQ/SQZ/lYZx5ze06
        13We8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=RK6X2jS67N6+KCtzTA8njDUA4e35g7s8yrXJmhHU/
        FI=; b=RDAITSwL/AHinOHUg1RZrw/MBawTOOhNDKw+wsZ22JFCmqTGErjSNy/7b
        aAK2+S9eo2kQ67fsqC8gZCDf84XNk4o4bjaPayKTNozdkBtJj8Wx5DHVitFCZaPC
        L0egYKEs2monxOCKISTRf15CW0hZxPjug+PULRdtuOWAgNm0r6Krb2aEG3XRJGUZ
        1LLg0QEvrJXwC3HTypTiB5rTfcmW/yAzWgA8KHPqh5v+/Ubd1zbMVpGd+piWIJxu
        n7bsjevrOXa1U+Dkh03zxrYoQ0rJXOCUFlENWMD0/cOiBdnOgfGU0ktxT1ifcl0H
        R7Q7afvJFtBt9gP1845tDwqYUPprw==
In-Reply-To: <5a82befd-40f8-8dc0-3498-cbc0436cad9b@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 2020-07-15 at 18:28 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Change doubled word "is" to "it is".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ian Kent <raven@themaw.net>
> Cc: autofs@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Ian Kent <raven@themaw.net>

> ---
>  include/uapi/linux/auto_dev-ioctl.h |    2 +-Acked-by: Ian Kent <
> raven@themaw.net>
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200714.orig/include/uapi/linux/auto_dev-ioctl.h
> +++ linux-next-20200714/include/uapi/linux/auto_dev-ioctl.h
> @@ -82,7 +82,7 @@ struct args_ismountpoint {
>  /*
>   * All the ioctls use this structure.
>   * When sending a path size must account for the total length
> - * of the chunk of memory otherwise is is the size of the
> + * of the chunk of memory otherwise it is the size of the
>   * structure.
>   */
>  
> 

