From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: drop dentry reference only when it is never used
Date: Mon, 26 Nov 2018 18:36:39 +0800
Message-ID: <9f79a8203d29f207cfb71c7aefb3c98f28a23aaf.camel@themaw.net>
References: <1543197494-15688-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        zg5/ppP+1YlqxbxHwriFrkyxzrBieQgGbr6uXoWWwbM=; b=Ib5j+RMVEhzjGDf6
        2EDVAnts1060LgwlHv9IiyDc9mkSytEgkaZpBaJdOMovFU9LOiIsE6FD4r7YnoL8
        JVXW4c9Em8ajxvFKT0yVXVAkiCUIvU4HSre2Aa7Pv9fRVpukhRV3YJkhfmjCvdVw
        i9OyEwy+VwQdSU23V/dByEewWxpnjXZ9s2BVMX92U3QuugN3JoWRORN87vHL5eze
        7JjYKgXXq/Ahdk7DAvZMd8NNxZu+wHALCnrWV1ADYYAvWSelMuOsZ/xkIIY48Nbj
        6Y1pFHwn7Hg8DKGznRVeDw6xHBqmKJkztH8AJpPfILo0+28pV1YL8BN+l7aEl1C5
        undOcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=zg5/ppP+1YlqxbxHwriFrkyxzrBieQgGbr6uXoWWw
        bM=; b=ZpCydNgTjm90AM9IltpJtBozyuUkqD/76TialjXkH6s2XJm4wjuV0dLLQ
        WIYAawP9Eco32CeX4l1RGavPdvZ8FVj+EPtvVIu7BvWDaBLf4C0pg89Bzpz9p7G2
        kPwFypEkC3ykGAGhKDuyhFOso+1qCjYW6owYLryikhmT+gKrliqDsPWTUZYIt5+G
        kZwQJr3PbvrL9qQA1U9MXBMYL24Rip5QP/jo93srMt8+ZYMxXnSFnweL44PfbreT
        9LqS++EtsxoeMIJvQYctLUj39AMZ4gSwBe4izUoIwMIHv6YiLXB28Jomt4WQA/0W
        q0UcmpWMXLyMKhfCT8x/qgG2chUpg==
In-Reply-To: <1543197494-15688-1-git-send-email-bianpan2016@163.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Pan Bian <bianpan2016@163.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 09:58 +0800, Pan Bian wrote:
> The function autofs_expire_run calls dput(dentry) to drop the reference
> count of dentry. However, dentry is read via autofs_dentry_ino(dentry)
> after that. This may result in a use-free-bug. The patch drops the
> reference count of dentry only when it is never used.

Yes, I agree this is a bug and it should be fixed.

The autofs_expire_run() function is used for autofs v3 which is
very old now so it's not likely to be called.

But I think you are correct, if it is called the copy to user
space should trigger a umount and (likley) remove the mount
point directory, maybe I broke this at some point without
realising it ...

So thanks, I'll have a closer look but even if the ref counting
isn't quite what either of us expect this is probably still worth
while.

If I don't see any reason to not do this I'll forward the patch
to Andrew.

Ian
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  fs/autofs/expire.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
> index d441244..28d9c2b 100644
> --- a/fs/autofs/expire.c
> +++ b/fs/autofs/expire.c
> @@ -596,7 +596,6 @@ int autofs_expire_run(struct super_block *sb,
>  	pkt.len = dentry->d_name.len;
>  	memcpy(pkt.name, dentry->d_name.name, pkt.len);
>  	pkt.name[pkt.len] = '\0';
> -	dput(dentry);
>  
>  	if (copy_to_user(pkt_p, &pkt, sizeof(struct autofs_packet_expire)))
>  		ret = -EFAULT;
> @@ -609,6 +608,8 @@ int autofs_expire_run(struct super_block *sb,
>  	complete_all(&ino->expire_complete);
>  	spin_unlock(&sbi->fs_lock);
>  
> +	dput(dentry);
> +
>  	return ret;
>  }
>  

