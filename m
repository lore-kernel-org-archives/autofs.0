From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: Re: [PATCH] automount: Fix compiler warning
Date: Wed, 6 Jul 2016 18:27:55 +0900
Message-ID: <CAHndrBkCkUSPd0oQ83G-rY_zOC_hdCFHmgrjw2kFXJsQp4-7iA@mail.gmail.com>
References: <1467624743-7222-1-git-send-email-kusumi.tomohiro@gmail.com> <1467797074.4580.51.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tqEWELfQcvR3WizcCOzVQTaRViki5P4bUiv3O8Io5bo=;
        b=QdJ27yXepL2xruoQsVbtfpfFso/Xa6h2s0KZYcf1SlY7r+fsr2Lan+d/Nl44SMxE96
         mr944SZq+6yQgOncv43GAcls9MBW+m1QKqCc1CmQhmiqKNaeur1L37Dm7PRXNSHrRJPg
         W5/rSyqTL1NSanJz3gFSSkXQAHgg20zUOvWpwRTnFQi4vjqIP4Wtc76PETR1UWxqcHJf
         jnyQ74pB2+ZmG1xoi4MS5VR/pPnntB9UQK5BnobItYs3vPU0T23MeJws46PhPhj8uyUG
         lUwS5alYLKkp9sD44ZzuSyaOsqOv/Qnjxq5WFKvHiO8YYJhUxOYUzQlIp7dXdQb5X6zL
         vw0g==
In-Reply-To: <1467797074.4580.51.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Thank you.
Sure, feel free to commit it whenever you can, as it's just a cleanup.

2016-07-06 18:24 GMT+09:00 Ian Kent <raven@themaw.net>:
> On Mon, 2016-07-04 at 18:32 +0900, Tomohiro Kusumi wrote:
>> Fix below compiler (gcc5) warning which isn't autoconf result dependent.
>> mounts.c:1779:7: warning: variable 'ret' set but not used [-Wunused-but-set
>> -variable]
>
> Indeed, I've been meaning to fix that but I like to have a return assigned even
> when it's not used so I can easily identify functions that return status when
> changes are needed, so I've left it alone.
>
> I'm adding this to my list of patches (as is).
>
> Unless there is a pressing need for this to be committed to the upstream
> repository it will be done the next time I push changes and I can't say when
> that will be.
>
>>
>> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
>> ---
>>  lib/mounts.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/mounts.c b/lib/mounts.c
>> index 1d1b4da..c67548e 100644
>> --- a/lib/mounts.c
>> +++ b/lib/mounts.c
>> @@ -1776,16 +1776,15 @@ static int remount_active_mount(struct autofs_point
>> *ap,
>>                       *ioctlfd = -1;
>>               }
>>       } else {
>> -             int ret;
>>               /*
>>                * What can I do if we can't remount the existing
>>                * mount(s) (possibly a partial failure), everything
>>                * following will be broken?
>>                */
>>               if (type == t_indirect)
>> -                     ret = do_remount_indirect(ap, fd, path);
>> +                     do_remount_indirect(ap, fd, path);
>>               else
>> -                     ret = do_remount_direct(ap, fd, path);
>> +                     do_remount_direct(ap, fd, path);
>>       }
>>
>>       debug(ap->logopt, "re-connected to mount %s", path);
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
