From: Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH] autofs: don't stuck in a loop if vfs_write returns an error
Date: Mon, 23 May 2016 14:50:17 -0700
Message-ID: <CANaxB-wWRaQYz5cku5iQ=HpA34Fzijz0UvYvFJnbCgrXHwX12A@mail.gmail.com>
References: <1459487558-21258-1-git-send-email-avagin@gmail.com>
	<1459496266.2974.1.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=d7lZDA2qfJ9MGSQ2xY2Zf8LBOjP6H/84rq/gWnz+9Ug=;
        b=ER6aOYQzVM19x9kKhXTRvLrTcnvVh5CX9WSR+jBdfZXVyH1XuSD82xjgvYreznT9yK
         TetAbxLRkJn5otEio7c3Zs99ECGnMJxwIhum6c5x8iIY1LvZQJqEq5F4AuYjFrKvRS4P
         d8Kz056flHVriUAV3nanNgOZ99pGRJGPQ2Ba0Pyrfje7xu3XJOxRtEZl4bYpwZh54jKS
         cBEBHEXk49WqNI9JLLvXNoy1UwyM+iqsl2go5z2BJ8FjytrGtaEtkiDEAnx8I5Cxvok5
         k7xcDRUjiyMuhZLfj2dNwdkBheVws3P3YnlXYhcZQndVlb2twjHiVg7WN1XM45KgRU4W
         49Cg==
In-Reply-To: <1459496266.2974.1.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Ian,

When are you going to apply this patch? We can't test linux-next without it.

Thanks,
Andrew


On Fri, Apr 1, 2016 at 12:37 AM, Ian Kent <raven@themaw.net> wrote:
> On Thu, 2016-03-31 at 22:12 -0700, Andrey Vagin wrote:
>> From: Andrey Vagin <avagin@openvz.org>
>>
>> __vfs_write() returns a negative value in a error case.
>
> Ha, right, I'll send this along to Andrew with my next series which
> should be soon.
>
>>
>> Cc: Ian Kent <raven@themaw.net>
>> Signed-off-by: Andrey Vagin <avagin@openvz.org>
>> ---
>>  fs/autofs4/waitq.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
>> index 0146d91..631f155 100644
>> --- a/fs/autofs4/waitq.c
>> +++ b/fs/autofs4/waitq.c
>> @@ -66,11 +66,12 @@ static int autofs4_write(struct autofs_sb_info
>> *sbi,
>>       set_fs(KERNEL_DS);
>>
>>       mutex_lock(&sbi->pipe_mutex);
>> -     wr = __vfs_write(file, data, bytes, &file->f_pos);
>> -     while (bytes && wr) {
>> +     while (bytes) {
>> +             wr = __vfs_write(file, data, bytes, &file->f_pos);
>> +             if (wr <= 0)
>> +                     break;
>>               data += wr;
>>               bytes -= wr;
>> -             wr = __vfs_write(file, data, bytes, &file->f_pos);
>>       }
>>       mutex_unlock(&sbi->pipe_mutex);
>>
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
