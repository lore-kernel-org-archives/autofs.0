From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: Mounts not expiring in setups with nested submounts
Date: Mon, 8 Apr 2013 22:24:38 -0300
Message-ID: <CAEySpB7THFRcL+q9Y+gseY42JQVLKP59amHoGf_WGes33KMPAg@mail.gmail.com>
References: <CAEySpB6ZRVmtbFmPuL-k1fVxeHdtnKm8ncmXGt5R0ZTL2dXr1w@mail.gmail.com>
	<1365407320.2409.6.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=WErEUfcghGqRc8eEoQSZtSxwSBKHQwScl0ks5fSgOdY=;
        b=Urc6HDisqtvJxSZWy/QodJDKHz4UATnYSGXHW2BQaDr+EnKQ3kZ6j6Fzq1M5sgeU7K
         FxlMgJ+F2AAIxTGPat7ZsW+O8BLglWO0DQgrhxiuZ8JNOhvUjtSV9SSNffyUkx7D83kd
         i226D1sp72GPaPDyQODs/9VyhjhAT2gTkgUPDRVCMJjypbAyt1oGPBKEwsYrRLusfz8A
         p5UxrZcUmfWOpQtQf7Ge7RgfhzQgna0Eun1QZEFtzvkVrSTGcEqzUGIOCpZkaUsiH++x
         m0yofiLUOAg81Xq3Z/d8yRbD3uGvWaTklLSqc0fQv361u4ruyKMjw5BBFYGSm5ZNfu0V
         H51A==
In-Reply-To: <1365407320.2409.6.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>

On Mon, Apr 8, 2013 at 4:48 AM, Ian Kent <raven@themaw.net> wrote:
> On Fri, 2013-03-29 at 17:33 -0300, Leonardo Chiquitto wrote:
>>
>> Ian: do you think the "occasional deadlocks" mentioned in the
>> expire-specific-submount-only patch might have been addressed
>> by other changes (so we can use the patch below)? Or do you
>> see another way to fix the problem?
>
> Think so.
>
>>
>> diff --git a/lib/master.c b/lib/master.c
>> index a0e62f2..99b1092 100644
>> --- a/lib/master.c
>> +++ b/lib/master.c
>> @@ -906,8 +906,10 @@ int master_notify_submount(struct autofs_point
>> *ap, const char *path, enum state
>>               p = p->prev;
>>
>>               if (!master_submount_list_empty(this)) {
>> -                     mounts_mutex_unlock(ap);
>> -                     return master_notify_submount(this, path, state);
>> +                     if (!master_notify_submount(this, path, state)) {
>> +                             ret = 0;
>> +                             break;
>> +                     }
>>               }
>>
>>               /* path not the same */
>
> I think the mounts mutex needs to be re-taken and then check if the
> submount has gone away.
>
> The list curor for the next one to check (set to p->prev) should always
> be ok because there's only one expire process for a given mount but the
> one we are checking (this) could go away, in which case we're done.
>
> This patch seems to work.
>
> autofs-5.0.7 - fix submount tree not all expiring
>
> From: Ian Kent <ikent@redhat.com>
>
> Due to the change in the expire-specific-submount-only patch, sub-mounts
> within an indirect mount that follow a submount (in the check order) won't
> be expired if that submount is busy.
> ---
>  lib/master.c |   24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/lib/master.c b/lib/master.c
> index a0e62f2..64dbcb1 100644
> --- a/lib/master.c
> +++ b/lib/master.c
> @@ -905,15 +905,24 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
>                 this = list_entry(p, struct autofs_point, mounts);
>                 p = p->prev;
>
> -               if (!master_submount_list_empty(this)) {
> -                       mounts_mutex_unlock(ap);
> -                       return master_notify_submount(this, path, state);
> -               }
> -
>                 /* path not the same */
>                 if (strcmp(this->path, path))
>                         continue;
>
> +               if (!master_submount_list_empty(this)) {
> +                       char *this_path = strdup(this->path);
> +                       if (this_path) {
> +                               mounts_mutex_unlock(ap);
> +                               master_notify_submount(this, path, state);
> +                               mounts_mutex_lock(ap);
> +                               if (!__master_find_submount(ap, this_path)) {
> +                                       free(this_path);
> +                                       continue;
> +                               }
> +                               free(this_path);
> +                       }
> +               }
> +
>                 /* Now we have found the submount we want to expire */
>
>                 st_mutex_lock();
> @@ -959,10 +968,7 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
>                         st_mutex_lock();
>                 }
>                 st_mutex_unlock();
> -               mounts_mutex_unlock(ap);
> -
> -               return ret;
> -
> +               break;
>         }
>
>         mounts_mutex_unlock(ap);

Hi Ian,

I tested the patch and verified that it resolves the problem.

Thanks,
Leonardo
