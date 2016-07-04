From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: Test autofs versions first on sb initialization
Date: Mon, 04 Jul 2016 10:18:49 +0800
Message-ID: <1467598729.3317.6.camel@themaw.net>
References: <1467466183-7058-1-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=krOwzxOQ4+FWil1TsrzBJ6WzPY0=; b=dsC6sp
	j2eK1EHcxutk7DG4sZoXcauJYcEhLPBUP0I6wVp94kw76hI6X2HtSBqigDo/lL7K
	SZ4I5GYau1vkSgasghqJW5Onweh3D6P1jxLF/3A+7anJrwE9mVKVQdBNp2B84oUt
	D81lfIR6aWrz4/uFD4/wjmjrnorAUVuuSzp+o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=krOwzxOQ4+FWil1
	TsrzBJ6WzPY0=; b=Tr1iiBu9IjkKDX3RnrkqqQv6xSpfQQ7DhI0JFi72MhZ93FO
	k/Pk/Ppb69nUAT6qHIqKgk2CkYCNY7vv99Nohg4Gj4iyHkLKmg+mdbguBHU3z9N9
	1g5mvDzLNAWCHbj4cJss2gnQY3gwyv/ZAPm0pMC/Tq3veLnjsOERyu/cSINk=
In-Reply-To: <1467466183-7058-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Sat, 2016-07-02 at 22:29 +0900, Tomohiro Kusumi wrote:
> This patch does what the below comment says.
> It could be and it's considered better to do this first
> before various functions get called during initialization.

I don't really see the importance of this but ok.

Though looking at it I think a problem with the error handling gotos has crept
in (I think prior to your patch).

I'll need to look more closely at that when I get time.

> 
> /* Couldn't this be tested earlier? */
> ---
>  fs/autofs4/inode.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> index 61b2105..8357544 100644
> --- a/fs/autofs4/inode.c
> +++ b/fs/autofs4/inode.c
> @@ -274,6 +274,23 @@ int autofs4_fill_super(struct super_block *s, void *data,
> int silent)
>  		goto fail_dput;
>  	}
>  
> +	/* Test versions first */
> +	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
> +	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
> +		pr_err("kernel does not match daemon version "
> +		       "daemon (%d, %d) kernel (%d, %d)\n",
> +		       sbi->min_proto, sbi->max_proto,
> +		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
> +		goto fail_dput;
> +	}
> +
> +	/* Establish highest kernel protocol version */
> +	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
> +		sbi->version = AUTOFS_MAX_PROTO_VERSION;
> +	else
> +		sbi->version = sbi->max_proto;
> +	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
> +
>  	if (pgrp_set) {
>  		sbi->oz_pgrp = find_get_pid(pgrp);
>  		if (!sbi->oz_pgrp) {
> @@ -291,23 +308,6 @@ int autofs4_fill_super(struct super_block *s, void *data,
> int silent)
>  	root_inode->i_fop = &autofs4_root_operations;
>  	root_inode->i_op = &autofs4_dir_inode_operations;
>  
> -	/* Couldn't this be tested earlier? */
> -	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
> -	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
> -		pr_err("kernel does not match daemon version "
> -		       "daemon (%d, %d) kernel (%d, %d)\n",
> -		       sbi->min_proto, sbi->max_proto,
> -		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
> -		goto fail_dput;
> -	}
> -
> -	/* Establish highest kernel protocol version */
> -	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
> -		sbi->version = AUTOFS_MAX_PROTO_VERSION;
> -	else
> -		sbi->version = sbi->max_proto;
> -	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
> -
>  	pr_debug("pipe fd = %d, pgrp = %u\n", pipefd, pid_nr(sbi->oz_pgrp));
>  	pipe = fget(pipefd);
>  
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
