From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH linux-next] autofs4: autofs4_catatonic_mode(): remove
 redundant null check on kfree()
Date: Wed, 13 Feb 2013 15:20:08 +0800
Message-ID: <1360740008.2288.3.camel@perseus.themaw.net>
References: <1360689138-59191-1-git-send-email-tim.gardner@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=sX5hAKBVY8uHRqU7y6SoY8ue7SI=; b=qCGsKqS4csH9BkYaMNZbY46v9x6f
	txE+xMgUZtPQs1nP2qDkIbwhM9aEnIDASkLZWreceMQbr/Fyu32O3qeTm8/ccJ2N
	5lUcVwXz7jAOeyvYMlfMZusWxupuwRlpT9+qrLvr3Xed1ByZy4f/eZEgk5x8+708
	y960Nw6JnSAxPFI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=sX5hAKBVY8uHRqU7y6SoY8ue7SI=; b=FVB
	jWLB9M5KHHcxV76qrDNYb5qtfqJo/GTup+fcleFnKelKJrtfw2ZwgYvRt4g+n/5q
	cvfW/GGWgHk1EPBT/VSi3VHBKYb46Efv0dtE5xi9+RJKQt4Bv1tlzetjy/+SgR5D
	uoVkepNnwI9FipuH9JY/YZzUJTiB/8bgLhgbx+us=
In-Reply-To: <1360689138-59191-1-git-send-email-tim.gardner@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tim Gardner <tim.gardner@canonical.com>
Cc: linux-kernel@vger.kernel.org, autofs@vger.kernel.org

On Tue, 2013-02-12 at 10:12 -0700, Tim Gardner wrote:
> smatch analysis:
> 
> fs/autofs4/waitq.c:46 autofs4_catatonic_mode() info: redundant null
>  check on wq->name.name calling kfree()

I'm not sure about this change.

autofs4_catatonic_mode() could be called when there are remaining
entries in the wait queue, which is nulled, so autofs4_wait_release()
won't see the the discarded waits if it is called.

> 
> Cc: Ian Kent <raven@themaw.net>
> Cc: autofs@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
>  fs/autofs4/waitq.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> index 03bc1d3..3db70da 100644
> --- a/fs/autofs4/waitq.c
> +++ b/fs/autofs4/waitq.c
> @@ -42,10 +42,8 @@ void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
>  	while (wq) {
>  		nwq = wq->next;
>  		wq->status = -ENOENT; /* Magic is gone - report failure */
> -		if (wq->name.name) {
> -			kfree(wq->name.name);
> -			wq->name.name = NULL;
> -		}
> +		kfree(wq->name.name);
> +		wq->name.name = NULL;
>  		wq->wait_ctr--;
>  		wake_up_interruptible(&wq->queue);
>  		wq = nwq;

