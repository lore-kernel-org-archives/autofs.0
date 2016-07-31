From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: Re: [PATCH 1/3] autofs-5.1.2 - Remove unused local 2KB buffer
Date: Sun, 31 Jul 2016 20:54:09 +0900
Message-ID: <CAHndrBm9LJCn3N8ko=QaL0ckTJOP4Nw2MB_QTTV6rTvyA3WQpA@mail.gmail.com>
References: <1469853339-2291-1-git-send-email-kusumi.tomohiro@gmail.com> <1469935429.14696.6.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l9euLPu0Bz9qymw1orb56DoVrVjQBj9B5X/l1Qt9oRk=;
        b=dZxmpELF/K4xv61zk/CnJtxdK3kld6dRTWtEdtYRWm/dkTOsCVIWBmtok9HDsCGvol
         CXWbXa5ekrriiO4xcKaIHKZuZPBIg5bGc898Yz7LXv7ixWY5rlgmm0hss1YEYFpzznC2
         TDH76xpZ8bFy2i8EU0EISd113MhNAMTZw6+6Lr3e0TPG7e/xjR+S+4MJcLcsTb/7gZO3
         f8H00X1MqzokG3/Pyj8zkvBXfXHNRzkwmK9000BExt8rw9X5eQ3GN+H6pFr8D91Mr8Y2
         Ea/zUmWHbsimdHbKk8xzxnryBmT1+7dfMv9Jhm50o6Hy17xeYRpocosXvtR7gJlxNLdu
         sGzA==
In-Reply-To: <1469935429.14696.6.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Thank you.
For the rest of the kernel stuff I've sent, feel free to check
whenever you can, since they're not that big deal.


2016-07-31 12:23 GMT+09:00 Ian Kent <raven@themaw.net>:
> On Sat, 2016-07-30 at 13:35 +0900, Tomohiro Kusumi wrote:
>> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
>
> Thanks for the patches.
>
> They all look fine, they look straight forward, I'll include them in the list of
> patches for the next commit.
>
> I thought I'd take this opportunity to let you know what's going on with the
> kernel module patches.
>
> I'm having trouble getting time to update and test my module rename patch series
> so I'm planning on sending the patches I have, mostly yours and possibly one or
> two of mine, as soon as I can get a chance.
>
> Fact is I'm having trouble getting time even to do that but I am trying.
>
>> ---
>>  daemon/automount.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/daemon/automount.c b/daemon/automount.c
>> index ad5cafd..3afa860 100644
>> --- a/daemon/automount.c
>> +++ b/daemon/automount.c
>> @@ -1901,7 +1901,6 @@ static void usage(void)
>>
>>  static void show_build_info(void)
>>  {
>> -     char buf[2048];
>>       int count = 0;
>>
>>       printf("\nLinux automount version %s\n", version);
>> @@ -1913,8 +1912,6 @@ static void show_build_info(void)
>>
>>       printf("\nCompile options:\n  ");
>>
>> -     memset(buf, 0, 2048);
>> -
>>  #ifndef ENABLE_MOUNT_LOCKING
>>       printf("DISABLE_MOUNT_LOCKING ");
>>       count = 22;
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
