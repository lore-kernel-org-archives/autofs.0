From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: Re: [PATCH 03/12] autofs: Fix AUTOFS_DEV_IOCTL_IOC_COUNT value
Date: Wed, 20 Jul 2016 04:29:04 +0900
Message-ID: <CAHndrBmcKOk+YMxfNcBOX8jJj1H96=WpQNw1bMzL0sRhRP4Tdg@mail.gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
 <1468138073-4870-3-git-send-email-kusumi.tomohiro@gmail.com> <1468892055.5120.29.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NGDQWLWkaUMEqZX3NWUVwXmmcZtliwfLbqjb1eMQ31I=;
        b=cSRO4DnMSjlz4bMw0YtDxcSM6NUB2xP8XUwQ7XH1mEFHJU3ii6KWH1vZuE9PQFpuVR
         2na1x4nsy6ZNP2fyUjZRl+/dG1NK4cgqLAiiwDbJPpE01Slnv9NLykWnR1NH7r1zceQz
         haHR5yLJ8zYXNlD9US7wuT/3ykD7Zty4mDsOghXeLa3TPccko62em5hPOdkcv8nPFDD+
         mtAfvkHw4VlCJb+wmFoKORuY6X62NqzIT7uvid4X8ZqWyKAn9agpj8elFQ/wxlbBEjr0
         NsRDV3+R8ESEBCxiCLRD+S/SmzYC5bXwyAs0LDpix7j+bep73/+9LHAfJWp9E2pn4P41
         k8/Q==
In-Reply-To: <1468892055.5120.29.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Thanks for your review,

Yes, yours apparently works and that's exactly the right test based on
currently existing ioctl cmds.
I first thought about changing it like you did, but thought about
meaning of AUTOFS_IOC_COUNT which is 32.

I took this 32 as some sort of reserved range for autofs ioctl cmds,
where the whole ioctl cmds are designed to be somewhere in 0x60-0x80
range, and /dev/autofs ioctl cmds are in 0x71-0x80 range.
So in theory a potential ioctl cmd for /dev/autofs counting from the
smallest cmd must be no larger than 32-0x11 (or 0x80-0x71).

I've no idea what this reservation/limitation up to 0x80 is supposed
to mean though, as ioctl has 8 bits for nr part.
If you say this 32 is meaningless, I'll resubmit it with your proposed change.


     0x60               0x71            0x80
-----+------------------+---------------+------------------> NR
     <----------------------------------> AUTOFS_IOC_COUNT (32)
                        <---------------> AUTOFS_DEV_IOCTL_IOC_COUNT


2016-07-19 10:34 GMT+09:00 Ian Kent <raven@themaw.net>:
> On Sun, 2016-07-10 at 17:07 +0900, Tomohiro Kusumi wrote:
>> According to include/uapi/linux/auto_fs.h, include/uapi/linux/auto_fs4.h,
>> and include/linux/auto_dev-ioctl.h, nr part of
>> AUTOFS_IOC_XXX starts off from 0x60 and
>> AUTOFS_DEV_IOCTL_XXX starts off from 0x71 which is 0x60+0x11.
>>
>> From the way above macros are defined, it seems
>> AUTOFS_DEV_IOCTL_IOC_COUNT should be (0x20-0x11) instead of (0x20-11).
>> (Otherwise it's hard to figure out where 11 comes from)
>
> You're correct, this is wrong but I think this change is also wrong.
>
> And so is the range check in dev-ioctl.c.
>
> There's no check for an ioctl number greater than the range claimed by autofs
> and the check in dev-ioctl.c seeks to check the number used is within the range
> used by the dev ioctls.
>
> Essentially
>
> AUTOFS_DEV_IOCTL_VERSION_CMD - AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD = 0xd
>
> 14 ioctls ranging from 0x71 - 0x7e (inclusive).
>
> The range check in dev-ioctl.c is:
>
>         if (_IOC_TYPE(command) != _IOC_TYPE(AUTOFS_DEV_IOCTL_IOC_FIRST) ||
>             cmd - cmd_first >= AUTOFS_DEV_IOCTL_IOC_COUNT) {
>                 return -ENOTTY;
>         }
>
> so I think AUTOFS_DEV_IOCTL_IOC_COUNT should be:
>
> #define AUTOFS_DEV_IOCTL_IOC_COUNT \
>         (AUTOFS_DEV_IOCTL_VERSION_CMD - AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
>
> and the check should be:
>
>         if (_IOC_TYPE(command) != _IOC_TYPE(AUTOFS_DEV_IOCTL_IOC_FIRST) ||
>
>       cmd_first - cmd >= AUTOFS_DEV_IOCTL_IOC_COUNT) {
>                 return
> -ENOTTY;
>         }
>
> What do you think?
>
>>
>> COUNT macros are being used to test distance of an ioctl command
>> in question from the smallest one, so we don't want it to be
>> larger than necessary.
>>
>> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
>> ---
>>  fs/autofs4/autofs_i.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
>> index 73e3d38..7ef4d08 100644
>> --- a/fs/autofs4/autofs_i.h
>> +++ b/fs/autofs4/autofs_i.h
>> @@ -20,7 +20,7 @@
>>  #define AUTOFS_IOC_COUNT     32
>>
>>  #define AUTOFS_DEV_IOCTL_IOC_FIRST   (AUTOFS_DEV_IOCTL_VERSION)
>> -#define AUTOFS_DEV_IOCTL_IOC_COUNT   (AUTOFS_IOC_COUNT - 11)
>> +#define AUTOFS_DEV_IOCTL_IOC_COUNT   (AUTOFS_IOC_COUNT - 0x11)
>>
>>  #include <linux/kernel.h>
>>  #include <linux/slab.h>
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
