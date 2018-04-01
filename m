From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: use wake_up() instead of wake_up_interruptible
Date: Sun, 1 Apr 2018 10:01:41 +0800
Message-ID: <8d578e49-c1a0-a38d-3b91-f0a07de0089b@themaw.net>
References: <20180331022839.21277-1-avagin@openvz.org>
 <ebdc431d-cea8-378c-aae5-3b7441bb93c0@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=L+D1uLBkCDk/HkRjW/fr37L4dinj1
        V3xsomfz1sEoN8=; b=FJKefZ3wbKW4pd0Ts4xnzTJBBE8ZKkQYibmg/rZ5L+r2C
        i7Rd3Pi37Mir6jx1TdX0Da05suCTcLyXkT3tB+lxiqHUVAO4uYKtg99vPaLVHSoW
        aE6GS/fLjZmzYkd8GRwoS8OlmBMU4t4jy7ADybTw/2UPQhR7UzAWHLQNGNDnpWlv
        D0CspZFSc1zH/d32S6ZujcKMRao0uQ2gqIIDD3dSO52YZG+9ol+q7/+RsYUeeulA
        prCuVFG6dIvxklgO4Vw8iIra6EO5G6TEsX6B14igADErS6Tmm75zLOVM9pGyV/dT
        YIt+NmW+Nt527E0JvtUSowVBz9jVtFPyN/65gdc8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=L+D1uL
        BkCDk/HkRjW/fr37L4dinj1V3xsomfz1sEoN8=; b=KaWxgL6RNxbGYWmPVpQqTY
        Od2X/JY+LM/6lWGmmpncR/lQFwCLmLMzJpgvdMLKQufXROxfiZihDquYAGAD/9Ve
        HDs+PHJLdOhT0qOavN3Qwieu/v6b/KURdsXCMKwKaGBa87NDHu9yjfbDSj3fCvCc
        HcjkvloZTMfpbgW2yF5c6QBs/snzgBKP9vTceA1RKxzwJxsGamRlb/wrQdmno8u0
        YbtV+XNJJphfAyT1u80nMQOwMVxId/5L6e5AUmk6OsghVFfkMNkQjVpzLAOpUIxw
        boWCF6r6gYL1DLhdyuPyUHcooRSc6ZwKKtH3Fjg0wj8hdN6eTrYfm1Go9MRgGd7Q
        ==
In-Reply-To: <ebdc431d-cea8-378c-aae5-3b7441bb93c0@themaw.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrei Vagin <avagin@openvz.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On 01/04/18 09:31, Ian Kent wrote:
> On 31/03/18 10:28, Andrei Vagin wrote:
>> In "autofs4: use wait_event_killable",  wait_event_interruptible() was
>> replaced by wait_event_killable(), but in this case we have to use
>> wake_up() instead of wake_up_interruptible().
> 
> Why do you believe wake_up() is needed rather than wake_up_interruptible()?
> 
> Now that I'm thinking about the wake up I'm wondering if this is in fact
> what's needed. Rather, I think maybe wake_up_all() is probably the only
> one that will actually do what's needed.

Ok, so that 1 is the number of exclusive waiters.
So what is the difference between the two wake_up calls in this case?

> 
> There's an individual wait queue for each mount, there can be multiple
> waiters for a mount, they all should be woken up when the daemon signals
> mount completion.
> 
>>
>> Cc: Matthew Wilcox <mawilcox@microsoft.com>
>> Cc: Ian Kent <raven@themaw.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Andrei Vagin <avagin@openvz.org>
>> ---
>>  fs/autofs4/waitq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
>> index c160e9b3aa0f..be9c3dc048ab 100644
>> --- a/fs/autofs4/waitq.c
>> +++ b/fs/autofs4/waitq.c
>> @@ -549,7 +549,7 @@ int autofs4_wait_release(struct autofs_sb_info *sbi, autofs_wqt_t wait_queue_tok
>>  	kfree(wq->name.name);
>>  	wq->name.name = NULL;	/* Do not wait on this queue */
>>  	wq->status = status;
>> -	wake_up_interruptible(&wq->queue);
>> +	wake_up(&wq->queue);
>>  	if (!--wq->wait_ctr)
>>  		kfree(wq);
>>  	mutex_unlock(&sbi->wq_mutex);
>>
> 

