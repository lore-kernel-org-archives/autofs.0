From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/1] autofs: fix memory leak of waitqueues in
 autofs_catatonic_mode
Date: Mon, 13 Feb 2023 12:37:16 +0800
Message-ID: <2f87a31c-7879-dce8-9c4b-01d2e781e22c@themaw.net>
References: <20230211195950.452364-1-pchelkin@ispras.ru>
 <5b86f03b-020b-1584-be8f-b7dc7277fa0a@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1676263052; x=
        1676349452; bh=mO/skRdP/IBSykel8yPB35AeJijN59VzcVuiESBHB3Y=; b=A
        gMW6EBVkhAxoqTGyfVvxaHMTLvgW4Clr449iXCfx3OSWD3mQqCF8+tc+Cd5PkzUv
        7yNndVQV2FeIu7g/nNzerw0RRLYuwhYrDr/wTWBL9OZ7TQIm7gl/a84UDnB0+/xY
        civ/CC/YKKrqvq5Pp8+5fw9mTG2/pNhgPgooAImzwK0ezt6wTvXKQW7pxes1SEjq
        ihizxcmPmuo/Lj5GHKQotunj25SagTJU0gYAiT1vM+IEa6sskPF21wITos/jUmnT
        yljimrY3SKy/cE04/6VcwA5CBo10ON0ajDcdBJzonS6desS5YfAOJljlvlYMUbRN
        huLawt6e80mQ/ccWPec4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676263052; x=
        1676349452; bh=mO/skRdP/IBSykel8yPB35AeJijN59VzcVuiESBHB3Y=; b=L
        NW9P1mvxWWVE2ghc0A3TQPoiA1ExWfg27XmkjhFrU/HAfw+MO5RSyr2WnMUXOZvc
        g4XZFnoaxjcOMsmksafBapnB1855FLrStGU6JcoNdwSLRpShhMzykY3sNHv7jbeq
        /kwqYC3cBbM6mk0EFZvcX7h9/0oiSBc4G3fkfhefAIPMe+WupO0j5uhZgH5Oc0uM
        rILu4PkPAGTWEvHVK1AF0QGT5q5dyhGY8tvmWvO0TqesrXLL7UgNss241dd3gt6L
        3vfgxEEPoXqAhtDX2y3uSoVDUDvfodawy+jxG5eS4GPTqP/i2wgyzfiCPwQmtpOi
        RcFb+WHt6XptJRkXivvNQ==
Content-Language: en-US
In-Reply-To: <5b86f03b-020b-1584-be8f-b7dc7277fa0a@themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Fedor Pchelkin <pchelkin@ispras.ru>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Andrei Vagin <avagin@gmail.com>, Takeshi Misawa <jeliantsurux@gmail.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org

On 13/2/23 12:27, Ian Kent wrote:
> On 12/2/23 03:59, Fedor Pchelkin wrote:
>> Syzkaller reports the leak [1]. It is reproducible.
>>
>> The following patch fixes the leak. It was proposed by Takeshi Misawa 
>> and
>> tested by Syzbot.
>>
>> In other places of the code the waitqueue is freed when its wait_ctr
>> becomes zero (see autofs_wait_release). So I think it is not actually
>> supposed that inside autofs_catatonic_mode wait_ctr cannot be 
>> decreased to
>> zero. Please correct me if I'm wrong.
>
> This is a bit had to read but I think your saying there's an assumption
>
> that wait_ctr can't become zero in autofs_catatonic_mode().
>
>
> That's correct, the case of a waiting process getting sent a signal is
>
> not accounted for and this can (as you observed) lead to the wait not
>
> being freed and also not being freed at umount.
>
>
> I think the change here should be sufficient to resolve the leak and
>
> I can't think of any cases where this could cause a further problem.
>
>
>>
>> Also, looking at the discussion [2] of the '[PATCH] autofs4: use 
>> wake_up()
>> instead of wake_up_interruptible', shouldn't wake_up_interruptible()
>> inside autofs_catatonic_mode() be replaced with wake_up()?
>
> This does imply that [2] should have been applied to 
> autofs_catatonic_mode()
>
> as well, I'm still trying to grok if that change would cause side effects
>
> for the change here but I think not.

I was going to Ack the patch but I wondering if we should wait a little

while and perhaps (probably) include the wake up call change as well.


In any case we need Al to accept it (cc'd).

Hopefully Al will offer his opinion on the changes too.


>
>
> Ian
>
