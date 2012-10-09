From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: When ghosting is enabled, failed mounts by AutoFS leave broken directories
Date: Tue, 9 Oct 2012 08:08:18 -0300
Message-ID: <CAEySpB5c+Z2Cix62freuiH9ozu5Jx-6qFJ-mq=u9ZmPyq+EZ+A@mail.gmail.com>
References: <CAEySpB59DaMnK2Ge4r-kzZhA_mG-88Nz_sVpMv-tJDUM3CJ9-w@mail.gmail.com>
	<1348539229.2307.26.camel@perseus.themaw.net>
	<CAEySpB4v9riQgq5Hy4g-u=rdbZQEYxwQrEm3KaYsT0hW+VjEXA@mail.gmail.com>
	<1348650908.2281.21.camel@perseus.themaw.net>
	<CAEySpB4duT0r6xJTrvkS+YK4-qhVFCyxzJfF0sQdUaSmVfDfuA@mail.gmail.com>
	<1348707890.2343.11.camel@perseus.themaw.net>
	<1348720504.2563.4.camel@perseus.themaw.net>
	<CAEySpB4r6+Xdpeh97gsaXBh1dei5yH9pg7KCPsDccRoP8qWtNQ@mail.gmail.com>
	<5064A225.4090607@msgid.tls.msk.ru>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cq6bFUGYlcBjn02JhsIqqWSLG3gVwUh/7yz6NGqtgvg=;
        b=KXS3+XMbzlxkp1LGpQo7GxXKL6/K1AdScqTLqeABUKxCT/DqPpTShlgGxLKg/2vS1b
         y5PEND65kT63V5c1F/mPehtmn8kueOI5LM/0pOUA0RCU9Ex8913nbYiO2du+mMK9pJk7
         OVpOAI77Fke+J4PiaMw1ckg4tV6UnUEtEqfC79gmpUoXMxP9u2JJLkR8mQsWrLqp6ny4
         Ta7cVkKvtl9QWjuAQl+dNzs+IgIkqUhvJIuf1YScmLgmkIiHWP08NMNl1ohtsaPdbnaH
         p213cgmPpXVp8xoX8N0SlSYZMXhUHNyXfrF7rgAbbwzC6MbSOylTjR7RxU9MVe62kqKn
         0+3w==
In-Reply-To: <5064A225.4090607@msgid.tls.msk.ru>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu

On Thu, Sep 27, 2012 at 3:59 PM, Michael Tokarev <mjt@tls.msk.ru> wrote:
> On 27.09.2012 22:35, Leonardo Chiquitto wrote:
>> On Thu, Sep 27, 2012 at 1:35 AM, Ian Kent <raven@themaw.net> wrote:
> []
>>> I can confirm that there is no directory removal and re-create going on.
>>>
>>> Checking for that lead me to discover this mistake which fixes the
>>> symptom we're seeing:
>>>
>>> autofs4 - fix reset pending flag on mount fail
>>>
>>> From: Ian Kent <raven@themaw.net>
>>>
>>> In autofs4_d_automount(), if a mount fail occurs the AUTOFS_INF_PENDING
>>> mount pending flag is not cleared.
>>>
>>> One effect of this is when using the "browse" option, directory entry
>>> attributes show up with all "?"s due to the incorrect callback and
>>> subsequent failure return (when in fact no callback should be made).
>>
>> Reported-and-tested-by: Leonardo Chiquitto <lchiquitto@suse.de>
>>
>> Ian,
>>
>> I just tested the patch here and confirmed it works perfectly.
>
> Is it a -stable (kernel) material?  This and the previous change,
> the locking logic fix/rework?  Both appears to be needed for all
> current 3.x stable trees...

IMO, at least this one should be submitted to stable after it reaches
mainline.

Leonardo

>>>  fs/autofs4/root.c |    6 ++++--
>>>  1 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>>
>>> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
>>> index 75e5f1c..8c4292f 100644
>>> --- a/fs/autofs4/root.c
>>> +++ b/fs/autofs4/root.c
>>> @@ -392,10 +392,12 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
>>>                 ino->flags |= AUTOFS_INF_PENDING;
>>>                 spin_unlock(&sbi->fs_lock);
>>>                 status = autofs4_mount_wait(dentry);
>>> -               if (status)
>>> -                       return ERR_PTR(status);
>>>                 spin_lock(&sbi->fs_lock);
>>>                 ino->flags &= ~AUTOFS_INF_PENDING;
>>> +               if (status) {
>>> +                       spin_unlock(&sbi->fs_lock);
>>> +                       return ERR_PTR(status);
>>> +               }
>>>         }
>>>  done:
>>>         if (!(ino->flags & AUTOFS_INF_EXPIRING)) {
