From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: use wake_up() instead of wake_up_interruptible
Date: Sun, 1 Apr 2018 09:31:09 +0800
Message-ID: <ebdc431d-cea8-378c-aae5-3b7441bb93c0@themaw.net>
References: <20180331022839.21277-1-avagin@openvz.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=xqLnMEn5WmkCDwnmvhaEpVJsMjqhg
        Er4YoOQOOrBNc0=; b=ePrWIZPvf3Ysc9Rdoqe5DyLyejKGxv+6wZGmUxF/tzHBl
        2A0OZ+KlAjqIfhjpxzUHAjH1zbAZgnLEJji/RHWHRsedAn1xLNDpg31VYLPWW2Br
        GxGSybNrU45RduC8zTtxVn7RNAjSu8E5LSZyzobqQn+TvarrDh+d7COK13cz+tBl
        tlucgWJRTJXjbC27ViC1Mj3oKoaQM4fGSx8QTilG9OoYNEgl0Ko2ggfWwEmuz2aj
        48XP78C2/dimP8ZRt4Lifo1KZRXVisTVMAwYe0g6vbujoX51DhHMGclDup5xhK35
        mn4wrMDHPEHyY+kTBpStvLAoD8esYO9Zt4o0ILqiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=xqLnME
        n5WmkCDwnmvhaEpVJsMjqhgEr4YoOQOOrBNc0=; b=WHXkad3gNQ+TcU2qEyORjq
        LKJOBlUXb7u9/wMWwSo3Bh/lQLRDgy0iEj9OrFhgjS4bbvNSlfkV0Sfh3vRu74/4
        p7dqZ9JRZ+5OoF8DyCIBcvUFpj/ntdS55r4yYATSIYPvMa0gzyEUn1G8NBuVEQSf
        IOGExmUE98HwgubPXE4k7hZ/ki+h6yY8Nj5qJboPH1rFIQB4TI409IJbAEZ4/52t
        OCc0LvmWEu5zl1944ItvRj8JfPB551wMDO13EpTinN1CKTFkQ+JsB+QhS0lIbzFv
        yuPmtLJjqElMFWC9LTu7GefAckuN8T0Oo+uhDZu8im6LVHA2jUOO35bOxFkPxRSA
        ==
In-Reply-To: <20180331022839.21277-1-avagin@openvz.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrei Vagin <avagin@openvz.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On 31/03/18 10:28, Andrei Vagin wrote:
> In "autofs4: use wait_event_killable",  wait_event_interruptible() was
> replaced by wait_event_killable(), but in this case we have to use
> wake_up() instead of wake_up_interruptible().

Why do you believe wake_up() is needed rather than wake_up_interruptible()?

Now that I'm thinking about the wake up I'm wondering if this is in fact
what's needed. Rather, I think maybe wake_up_all() is probably the only
one that will actually do what's needed.

There's an individual wait queue for each mount, there can be multiple
waiters for a mount, they all should be woken up when the daemon signals
mount completion.

> 
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ian Kent <raven@themaw.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> ---
>  fs/autofs4/waitq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> index c160e9b3aa0f..be9c3dc048ab 100644
> --- a/fs/autofs4/waitq.c
> +++ b/fs/autofs4/waitq.c
> @@ -549,7 +549,7 @@ int autofs4_wait_release(struct autofs_sb_info *sbi, autofs_wqt_t wait_queue_tok
>  	kfree(wq->name.name);
>  	wq->name.name = NULL;	/* Do not wait on this queue */
>  	wq->status = status;
> -	wake_up_interruptible(&wq->queue);
> +	wake_up(&wq->queue);
>  	if (!--wq->wait_ctr)
>  		kfree(wq);
>  	mutex_unlock(&sbi->wq_mutex);
> 

