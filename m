From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: Use wait_event_killable
Date: Tue, 20 Mar 2018 10:42:34 +0800
Message-ID: <daecdffe-b768-9c69-8609-b899ddde720c@themaw.net>
References: <20180319191609.23880-1-willy@infradead.org>
 <alpine.DEB.2.20.1803191218210.114201@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=ovxptibihKsCZlm8g7JXjSGnoMsbK
        xrF08t5M9WO/is=; b=RlfMhwk8+w5eC7FonTostNvV9Rk6ek2fVLnyMXG39SjKy
        8xmnYRTeDbm+WVJY/P67ogkT4VETSZZEymfTuUvPqslv2KSaTs8JO7wPmLPR8t1k
        EpKRBy5PwYxGpz6DX7FNWdBNhZMTQaCpVfUxjx72H0gCGwKCnYFxTG443NcMVyWB
        8N63yip45hclSx+P7txKlj/Ajwie4/jir+FhJ+muWHEzgYfg0CkJoTD4PI2W/Hqz
        ssa2QhVzxtWtebteEAe8L2ADpkCkHp3yYpfcGeM0AQ+gSfGxGXHjAIVvXc/JX7ev
        y0c+O3l1xT9pz6R9wU9JJS9TkDvChWrT/0pkd2Myg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ovxpti
        bihKsCZlm8g7JXjSGnoMsbKxrF08t5M9WO/is=; b=QnCqfftxjtGamQCdmc/iVd
        kTkAfrTX0X1R6P4o9v7UeNxJgYT2P3+p6D199osXmPF8p6mTS7HG8/gYiMTZNY3k
        7IYET7m9g0Sz1wrpxTjdk6t7ZRoq4NsPshQElqv6b4WB/+TTJ2FbWqAEdQ/3a8R6
        WdMDmKO16IWQGipBmk47DW60W0bo0+xnWcnmue4qvcIbvq4HtG5uSXJeUJE0SHQj
        D1ukYjH82h29oEoIgkLQhAq19yXD7ce5xoc5+tNnXSvyxbWiA4SQ27RJo3Q4ULLV
        QSk4LgNVKExNGp7OZVYD2wg3MT9Q+G78fMyr608Q4/t5MSfP0TU3nvsCheDFrL9w
        ==
In-Reply-To: <alpine.DEB.2.20.1803191218210.114201@chino.kir.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Rientjes <rientjes@google.com>, Matthew Wilcox <willy@infradead.org>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>

On 20/03/18 03:25, David Rientjes wrote:
> On Mon, 19 Mar 2018, Matthew Wilcox wrote:
> 
>> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
>> index a0c57c37fa21..c160e9b3aa0f 100644
>> --- a/fs/autofs4/waitq.c
>> +++ b/fs/autofs4/waitq.c
>> @@ -19,9 +19,6 @@
>>   */
>>  static autofs_wqt_t autofs4_next_wait_queue = 1;
>>  
>> -/* These are the signals we allow interrupting a pending mount */
>> -#define SHUTDOWN_SIGS	(sigmask(SIGKILL) | sigmask(SIGINT) | sigmask(SIGQUIT))
>> -
>>  void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
>>  {
>>  	struct autofs_wait_queue *wq, *nwq;
>> @@ -486,29 +483,7 @@ int autofs4_wait(struct autofs_sb_info *sbi,
>>  	 * wq->name.name is NULL iff the lock is already released
>>  	 * or the mount has been made catatonic.
>>  	 */
>> -	if (wq->name.name) {
>> -		/* Block all but "shutdown" signals while waiting */
>> -		unsigned long shutdown_sigs_mask;
>> -		unsigned long irqflags;
>> -		sigset_t oldset;
>> -
>> -		spin_lock_irqsave(&current->sighand->siglock, irqflags);
>> -		oldset = current->blocked;
>> -		shutdown_sigs_mask = SHUTDOWN_SIGS & ~oldset.sig[0];
>> -		siginitsetinv(&current->blocked, shutdown_sigs_mask);
>> -		recalc_sigpending();
>> -		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
>> -
>> -		wait_event_interruptible(wq->queue, wq->name.name == NULL);
>> -
>> -		spin_lock_irqsave(&current->sighand->siglock, irqflags);
>> -		current->blocked = oldset;
>> -		recalc_sigpending();
>> -		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
>> -	} else {
>> -		pr_debug("skipped sleeping\n");
>> -	}
>> -
>> +	wait_event_killable(wq->queue, wq->name.name == NULL);
>>  	status = wq->status;
>>  
>>  	/*
> 
> I understand converting the wait_event_interruptible() to 
> wait_event_killable(), but why was the above wait_event_interruptible() 
> only called when wq->name.name != NULL?  

The code pre-dates my involvement in autofs too.

I always thought it was because wq->name.name can become NULL before
the wait is reached. Such as if the user space daemon manages to invoke
autofs4_wait_release() before the wait call.

And if the autofs mount is made catatonic before the wait is reached
wq->name.name will be set to NULL and wake up called for each waiter
so that doesn't seem to require the if conditional either.

Both of these cases to fit with what Matthew has already said and I
can't think of any others.

There may have been other reasons at some point, a lot has changed
over (a long) time.

Ian
