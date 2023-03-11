From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/1] autofs: fix memory leak of waitqueues in
 autofs_catatonic_mode
Date: Sat, 11 Mar 2023 15:01:45 +0800
Message-ID: <ff12aef6-b3a1-e8ab-45c4-0976673bce84@themaw.net>
References: <20230211195950.452364-1-pchelkin@ispras.ru>
 <5b86f03b-020b-1584-be8f-b7dc7277fa0a@themaw.net>
 <2f87a31c-7879-dce8-9c4b-01d2e781e22c@themaw.net>
 <20230310175627.dvmkyvgb7b3qehbx@fpc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1678518111; x=1678604511; bh=feqTz2HniZqY/yt47o/AlWtYhoQHaXGw7ql
        1hoEkXKY=; b=BYtuz7HWC/S3Oh0s4/uNl714hq2Bu/njK8bv3IWaYhKCllp2/0C
        Mi+prRlVDMjJoun7FFvmtcZypv0k4ZgXBq0xdWz5g89mMHLpHtghWlHqtvtt3NqP
        Yul8D0z3W1hCzYbMA4JK7Zti2pMDjMHXgVSBbE/AVFf7CSShauBEkEk4LNlZOVkT
        gz+io8HfZqQ1gX5au9ho12aTpcKQAM7AgKFpK/YMl/G46joM+wWtlNeCnvJJjs6F
        cbCZDrj1mIQJOY/4L2Cy/gMD59AOJR+iellIqquGuzRuCxBMZgUF+882WN2dmdU9
        RoBJxy9R8GmDrO7Rc7IBYyqKtjRUY3spTAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1678518111; x=1678604511; bh=feqTz2HniZqY/yt47o/AlWtYhoQHaXGw7ql
        1hoEkXKY=; b=C6COX5XoTMnu1fmW+GAFv7Jk+hkNnpaRLmmvXh0M6brkO8xUskJ
        hQFTQylX/XL5h+RMt86497enasRzFPx60Dcfx/BpyX9onmta1/igdDjOaUFpc5Cl
        mq4MD+e2eEQYeIvvkiu+05Oj0ZNkzPT7OFcby1doXAHSGn7ab2aXmiWn55znc1F2
        ftwZXJz096Qax+5xfByzJrQCmUcf0aPLKApP2Idg1dlXHYr6op7euVzUpKIww/xX
        n14ATT5ffnnG9t60AE7puYeaGEkzikwwlOR8WPpWGBZSjZ5jsoGGccmx8OWuxnzD
        nDUJOxib2qJZyTxErqIZ6Ed6J2oNSpLTm3g==
Content-Language: en-US
In-Reply-To: <20230310175627.dvmkyvgb7b3qehbx@fpc>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Fedor Pchelkin <pchelkin@ispras.ru>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Andrei Vagin <avagin@gmail.com>, Takeshi Misawa <jeliantsurux@gmail.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org


On 11/3/23 01:56, Fedor Pchelkin wrote:
> On Mon, Feb 13, 2023 at 12:37:16PM +0800, Ian Kent wrote:
>> I was going to Ack the patch but I wondering if we should wait a little
>>
>> while and perhaps (probably) include the wake up call change as well.
>>
> Hmm, those would be separate patches?
>
> An interesting thing is that the code itself supposes the wake up calls
> from autofs_wait_release() and autofs_catatonic_mode() to be related in
> some way (see autofs_wait fragment):
>
> 	/*
> 	 * wq->name.name is NULL iff the lock is already released
> 	 * or the mount has been made catatonic.
> 	 */
> 	wait_event_killable(wq->queue, wq->name.name == NULL);
> 	status = wq->status;
>
> It seems 'the lock is already released' refers to autofs_wait_release()
> as there is no alternative except the call to catatonic function where
> wq->name.name is NULL. So apparently the wake up calls should be the same
> (although I don't know if autofs_catatonic_mode has some different
> behaviour in such case, but probably it doesn't differ here).

I think that, because there are processes waiting, they will always go

via the tail of autofs_wait() so the wait will be freed at that point.


Alternately autofs_wait_release() will be called from user space daemon

to tell the kernel it's done with the current notification.


I think there was an order of execution problem at some point between

autofs_wait() and autofs_wait_release() hence the code there. The same

may be the case for autofs_catatonic_mode() which is what the patch

implies.


These mount points can be left mounted after the user space daemon

exits with the processes still blocked so umounting the mount should

trigger the freeing of the name or they may be set catatonic by the

daemon at exit, again freeing the name, and in both cases unblocking

the processes to free the wait.


So I didn't think there was a memory leak here but SyZkaller says

there is.


>
> It's also strange that autofs_kill_sb() calls autofs_catatonic_mode() and
> currently it just decrements the wait_ctr's and it is not clear to me
> where the waitqueues are eventually freed in such case. Only if
> autofs_wait_release() or autofs_wait() are called? I'm not sure whether
> they are definitely called after that or not.
>
> [1] https://www.spinics.net/lists/autofs/msg01878.html
>> In any case we need Al to accept it (cc'd).
>>
>> Hopefully Al will offer his opinion on the changes too.
>>
> It would be very nice if probably Al would make it more clear.
>
> At the moment I think that the leak issue should be fixed with the
> currenly discussed patch and the wake up call issue should be fixed like
> in [1], but perhaps I'm missing something.

The question I have is, is it possible a process waiting on the wait

queue gets unblocked after the wait is freed in autofs_catatonic_mode?


Ian



