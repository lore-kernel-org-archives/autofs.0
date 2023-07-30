From: Sven Joachim <svenjoac@gmx.de>
Subject: Re: [PATCH] arch/*/configs/*defconfig: Replace AUTOFS4_FS by AUTOFS_FS
Date: Sun, 30 Jul 2023 08:06:16 +0200
Message-ID: <87sf96kk6f.fsf@turtle.gmx.de>
References: <20230727200041.21404-1-svenjoac@gmx.de>
        <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690697177; x=1691301977; i=svenjoac@gmx.de;
 bh=F5U0XWlMGWxKX4lJcQ4zQRqGGIsSKTzGOyOlXbi2bUk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:References:Date;
 b=C7n28bjHHQR62VwOqATdh0g6/yDqte4WhoKxzGUQ2znaVOwoUIJRXmOkHpATXFQfDykn3ad
 /jVwZXitr2HPX4ghCgIR4NDfasMKIcGnh8odMgGhcNQPVgRXIor2F6o0HDZKg1KHFCLoPObQr
 7jfQfwOzyX0gpxZRjdBuF4WCJaYQNQrKvAUmhOqzGgUve2m0E04PdEB+pbfoJBAYoFfuE+SYi
 qEF1gkj364lWokVH69zKQlrJwh7+bqpfJr4ALxH0aBwnD81T5jYm7xU0rRSGf8sIhGEwFbpCc
 iacQohzkOQlivgY6Oc5Nz/vi5DR/HIiNw+YQdhsbMOk2M5ETziDQ==
In-Reply-To: <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 29 Jul 2023 14:07:41 -0700")
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On 2023-07-29 14:07 -0700, Linus Torvalds wrote:

> On Thu, 27 Jul 2023 at 13:01, Sven Joachim <svenjoac@gmx.de> wrote:
>>
>> Commit a2225d931f75 ("autofs: remove left-over autofs4 stubs")
>> promised the removal of the fs/autofs/Kconfig fragment for AUTOFS4_FS
>> within a couple of releases, but five years later this still has not
>> happened yet, and AUTOFS4_FS is still enabled in 63 defconfigs.
>
> Ok, I ran the script, and also decided that we might as well remove
> the AUTOFS4 legacy naming stub entry by now.
>
> It has been five years, and people will have either picked up the new
> name with 'make oldconfig', or they just don't use 'make oldconfig' at
> all.

I had not added the suggested the removal of AUTOFS4_FS from the Kconfig
in my patch, because some projects seem to have have copy-pasted from
the kernel's defconfig files, e.g. systemd[1].  Hopefully not a big deal
for actual users, but worth mentioning.

Cheers,
       Sven


1. https://github.com/systemd/systemd/pull/28561
