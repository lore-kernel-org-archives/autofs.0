From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: Drop unnecessary extern in .h
Date: Thu, 07 Jul 2016 12:31:27 +0800
Message-ID: <1467865887.3206.15.camel@themaw.net>
References: <1467532606-6510-1-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=MD6pEooXe6KdGAtFxLaUeZ4jAQg=; b=kqzscD
	+zwRpyZSIaTqo4k6X+/hL8OassvVfZfrhJ4SeBAvo1XmmFmpnBM7mHKvJu55Rsr+
	1r1jqha1pFLlXsYHJJjQ0u74C9sTuCFaG4fDBbl1v8NiDyoCNo0TJKRoaiPKxHsc
	o2T2e31i8A53UhtJRFetmg1iZRp1KQf/b9Z1g=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=MD6pEooXe6KdGAt
	FxLaUeZ4jAQg=; b=eBjwb0ddLsvajJV+y74c1LEocWcpk7MSDbyJJSD+KE3xbL2
	eKeL0wa36ZzMMdXmBVkGpEfd6FmhDhdhvZ9taKMOrw/1kPCs9s8lJGKJIc0zBrWG
	AatmNO2L/oOViEuzU50tJnIwJFSikZMZPh2Rf7Hklv8bFI4rDQkL1ltmBOQE=
In-Reply-To: <1467532606-6510-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Sun, 2016-07-03 at 16:56 +0900, Tomohiro Kusumi wrote:
> autofs4_kill_sb() doesn't need to be declared as extern,
> and no other functions in .h are explicitly declared as extern.

Straight forward, also added to the list.

> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  fs/autofs4/autofs_i.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
> index a439548..eb87055 100644
> --- a/fs/autofs4/autofs_i.h
> +++ b/fs/autofs4/autofs_i.h
> @@ -271,4 +271,4 @@ static inline void autofs4_del_expiring(struct dentry
> *dentry)
>  	}
>  }
>  
> -extern void autofs4_kill_sb(struct super_block *);
> +void autofs4_kill_sb(struct super_block *);
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
