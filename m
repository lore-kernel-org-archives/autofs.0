From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: Use wait_event_killable
Date: Tue, 20 Mar 2018 09:58:59 +0800
Message-ID: <7dae3cc8-bad1-ec18-bcf1-ae91a87f74fa@themaw.net>
References: <20180319191609.23880-1-willy@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=hOv22WVa9+uuHnSf3bVzXOqxM0s3o
        p+Dd6Csu8c3KPI=; b=R7FfAkJm84TcKmeWcl7bCsfM4bR1uCc+tOcDJj/6RyeID
        B6s33NyexnlNA7xdBTq4GkFONrId905xnqWxgp2zzMXal8xNd8x8XsBrdBrBl4yv
        OdCeWcIOPreIAtiXtCnAhFfUXaPgHIeGLRMh5/4FjXsAAZAruTxs3Bjq9tAscLMk
        +tFUGhhM3gcGVRMEyTWdHqLlwJ07V4F1NQMIQRsmTx/6wySWfDk67BcS/fbxp30+
        umiQSkkDtMZJ6VrkJjdtgQzedpGrIy+3ugCEkwkuU0izBMHfmT1cfNWB3a8NbaSZ
        xnc0addeeq+uc/v4cRYSskBXX7qslaXl1b7Z2r1+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hOv22W
        Va9+uuHnSf3bVzXOqxM0s3op+Dd6Csu8c3KPI=; b=hZleam2up1Zbe5ajhlqWuw
        Qpxg6JbwTTQIs0QpQ8mRyI0c0RDLBP/ENEUv6NqwOGq5IuOLwV0NLu7ri6mQrI0x
        lyXALSci1wTB24vH4AtBIiLYOPV96MG+g+lBkIqHVh00bMpwX7mduJbU41GROVQA
        upUUc/TUbPcFOcXALdG3HmmdE2ZjI11fo4l6ns20xDcFJ3O28j3/2Oc5Q9i2htJl
        bSnGlXe/eHkFUqgaMYFSyOJ6LQYUL//ClpUM5I6utK+y8zPJxGfaz+i+fjPtuCNz
        PUF0kaYQ0d1I+xooZwZH897+wkApjGVdJ6CY/mI7eFSmDjzJ4MsQbikahZukbyoQ
        ==
In-Reply-To: <20180319191609.23880-1-willy@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On 20/03/18 03:16, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>

Hi Matthew,

> 
> This playing with signals to allow only fatal signals appears to predate
> the introduction of wait_event_killable(), and I'm fairly sure that
> wait_event_killable is what was meant to happen here.

Predates is an understatement, this is really, really old code.
Do I need to forward this to Al or Andrew?

> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/autofs4/waitq.c | 27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> index a0c57c37fa21..c160e9b3aa0f 100644
> --- a/fs/autofs4/waitq.c
> +++ b/fs/autofs4/waitq.c
> @@ -19,9 +19,6 @@
>   */
>  static autofs_wqt_t autofs4_next_wait_queue = 1;
>  
> -/* These are the signals we allow interrupting a pending mount */
> -#define SHUTDOWN_SIGS	(sigmask(SIGKILL) | sigmask(SIGINT) | sigmask(SIGQUIT))
> -
>  void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
>  {
>  	struct autofs_wait_queue *wq, *nwq;
> @@ -486,29 +483,7 @@ int autofs4_wait(struct autofs_sb_info *sbi,
>  	 * wq->name.name is NULL iff the lock is already released
>  	 * or the mount has been made catatonic.
>  	 */
> -	if (wq->name.name) {
> -		/* Block all but "shutdown" signals while waiting */
> -		unsigned long shutdown_sigs_mask;
> -		unsigned long irqflags;
> -		sigset_t oldset;
> -
> -		spin_lock_irqsave(&current->sighand->siglock, irqflags);
> -		oldset = current->blocked;
> -		shutdown_sigs_mask = SHUTDOWN_SIGS & ~oldset.sig[0];
> -		siginitsetinv(&current->blocked, shutdown_sigs_mask);
> -		recalc_sigpending();
> -		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
> -
> -		wait_event_interruptible(wq->queue, wq->name.name == NULL);
> -
> -		spin_lock_irqsave(&current->sighand->siglock, irqflags);
> -		current->blocked = oldset;
> -		recalc_sigpending();
> -		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
> -	} else {
> -		pr_debug("skipped sleeping\n");
> -	}
> -
> +	wait_event_killable(wq->queue, wq->name.name == NULL);

The wait event code looks like this will wake up on most any unmasked signal.
But my assumption is that TASK_KILLABLE tasks are only forwarded specific
signals ...

Is that right or am I missing something?

>  	status = wq->status;
>  
>  	/*
> 

