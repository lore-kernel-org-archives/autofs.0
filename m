From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] autofs4: Use wait_event_killable
Date: Mon, 19 Mar 2018 12:25:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.20.1803191218210.114201@chino.kir.corp.google.com>
References: <20180319191609.23880-1-willy@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GRnLo2cI9Q6sOQhMHrLhOG/WaKMisU68MtHkuhG9CHE=;
        b=RTsfgiMc7FQmANtm9Dy/GqYt5fdlbQSInGZlEt6guQwgjU3AQt7gCgrsbDYYCR8d7u
         FQM76o6pC3WcUkBm1lqDgvSNlbSbmfDasve+kRVIpXYrIuxtqGVuEGpwA5Q3r4gAuYUn
         Y6hju1UXuhLb/J6wuZrVZJIjYQmMe6Vsi4hmj9GVOD5nCTowylNdHbN3pxjsWIQ8sj0C
         KEHWOaKsmq9zJXP7YTd1qUUQ53NbKoC6iFlsSxWWWen9KbHP1vlpxCBQ9lPKY9SZW6Lm
         DfqNgm4mCgoY1pyWLEOjRd5Mpeipxa+ZYwYn5S2A6oSvdbaUKpLSe++imR12pcKzTHdR
         YdUg==
In-Reply-To: <20180319191609.23880-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>

On Mon, 19 Mar 2018, Matthew Wilcox wrote:

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
>  	status = wq->status;
>  
>  	/*

I understand converting the wait_event_interruptible() to 
wait_event_killable(), but why was the above wait_event_interruptible() 
only called when wq->name.name != NULL?  

wait_event_{killable,interruptible}() will return without sleeping when 
wq->name.name == NULL, so I suppose it has something to do with the 
comment above it.
