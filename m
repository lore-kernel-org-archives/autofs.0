From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Harden autofs ioctl table
Date: Thu, 20 Aug 2020 13:11:11 +0800
Message-ID: <5ce39603821b0108a58d3be547d97b65b9c31fdb.camel@themaw.net>
References: <20200818122203.GO17456@casper.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        qb+mCp0+4Ji9umLMBVjHosMeZEnBLxEOXmbaqA2ZQjQ=; b=BH+HaXcoHeFz5Dqy
        tyKn/5HBEEfS4dqi+GizBF3KgvQNb3P4/UFDyttp8qE9YNvGh5RYaLWeL8wZdm2H
        Fu+srhCFN7j75dWeKKD3DxBXhnYNRyGT22GG91NgoARGkUX03d03EVraHKrdIvXo
        0BZ4WAfQvzof4Zofgt05BE9i1BtnQBKWvZAJNp6N5T1Col3BLDxaojPWFxw1p+Nm
        qJ4h9cNW9PnVdSmfkzOn3I6RfghFuv4QRCniHQoJeK3NM6trI0bZtiavRHLK0FXy
        fBQTz4YOk4MzQFDJ/bP9FUyxdQ+uSLVVgFkqz1WldPM0uz2UHDajJJVMZ8CthwZc
        /WJoWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=qb+mCp0+4Ji9umLMBVjHosMeZEnBLxEOXmbaqA2ZQ
        jQ=; b=jR3R0+94F/5mjIWrx678KAZ7ht1yFrHkX9S+S6LefVNGMYYKiZaA4ooYB
        wqzn8oQZrdQvgG7F/2yccF6SjDq5U3xAMwqrL51P3+HNbdsy4OW/AfDmnECXFIJT
        SSeod6nL+Hs2OCISFHySAMqdU0DlJlTuum9mlYs+PveGYKiC26cmHP9Ovcii4YRG
        yx91L+FlBxdQH1CRbfO85XQPh3e1ifNpFyotNsH9YttNMyedAZeUENJ+pXhzN6HF
        M52wNHPH08pZXVk0Oe/cp96QtTtWxMTfJJgOb70IcnbSX8BVGOjnA5H+8bcdLtYs
        8UL/Fu/Z837v/SWyrXBtQXgI+6KVA==
In-Reply-To: <20200818122203.GO17456@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Matthew Wilcox <willy@infradead.org>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, 2020-08-18 at 13:22 +0100, Matthew Wilcox wrote:
> The table of ioctl functions should be marked const in order to put
> them
> in read-only memory, and we should use array_index_nospec() to avoid
> speculation disclosing the contents of kernel memory to userspace.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Ian Kent <raven@themaw.net>

Thanks Matthew, I certainly want to know about changes to autofs
made by others so thanks for sending this to me.

At the same time I need to send my patches via someone else as
Linus asked me to do ages ago now.

So, once again Andrew, if you would be so kind as to include this
in your tree please.

Ian

> 
> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> index 75105f45c51a..322b7dfb4ea0 100644
> --- a/fs/autofs/dev-ioctl.c
> +++ b/fs/autofs/dev-ioctl.c
> @@ -8,6 +8,7 @@
>  #include <linux/compat.h>
>  #include <linux/syscalls.h>
>  #include <linux/magic.h>
> +#include <linux/nospec.h>
>  
>  #include "autofs_i.h"
>  
> @@ -563,7 +564,7 @@ static int autofs_dev_ioctl_ismountpoint(struct
> file *fp,
>  
>  static ioctl_fn lookup_dev_ioctl(unsigned int cmd)
>  {
> -	static ioctl_fn _ioctls[] = {
> +	static const ioctl_fn _ioctls[] = {
>  		autofs_dev_ioctl_version,
>  		autofs_dev_ioctl_protover,
>  		autofs_dev_ioctl_protosubver,
> @@ -581,7 +582,10 @@ static ioctl_fn lookup_dev_ioctl(unsigned int
> cmd)
>  	};
>  	unsigned int idx = cmd_idx(cmd);
>  
> -	return (idx >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[idx];
> +	if (idx >= ARRAY_SIZE(_ioctls))
> +		return NULL;
> +	idx = array_index_nospec(idx, ARRAY_SIZE(_ioctls));
> +	return _ioctls[idx];
>  }
>  
>  /* ioctl dispatcher */

