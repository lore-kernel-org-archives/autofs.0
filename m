From: "Ian Kent" <raven@themaw.net>
Subject: Re: [PATCH] arch/*/configs/*defconfig: Replace AUTOFS4_FS by AUTOFS_FS
Date: Sun, 30 Jul 2023 15:20:31 +0800
Message-ID: <016f771c-cfa7-4795-a0a4-9f486a5b5b0e@app.fastmail.com>
References: <20230727200041.21404-1-svenjoac@gmx.de>
 <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
 <87sf96kk6f.fsf@turtle.gmx.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690701651; x=1690788051; bh=L5
        yMUbQktbxKTCHMBew6jTG9neKt+p6qnBeFuafRANc=; b=QTUiE8rG2v3rmJI5GY
        VFHa7XwwgyhRBqZzwjYSYA9wl5N873SBRXZx5z8vtL8h1VUlbSLQTuZLz9d8cMWm
        dEa40v8ljTGwHlJ2lk6QA7ZlvV8QVZhyOG3Z2psbw9xd1UElqoXgXILhrWWEy6PW
        VKHgpKOUY9kRk9DTL8XV/TErPhZ//81K1zfsvi76Cst/4C4pwC5ScsNmfNaIlxJa
        +jSs1ZUkQ70XV1oB4dxzjzWEgXgc8BahtYZ3dXaleJCJic3nGbTHi3cTtE6ap6Sh
        mFaqGSobQBESE+XrWW5YJaP1L5FfocC/r/OSJBKivJ/JjHW5+oDLcGOXe6n2PuRN
        0V+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690701651; x=1690788051; bh=L5yMUbQktbxKT
        CHMBew6jTG9neKt+p6qnBeFuafRANc=; b=HsujcvwzVTo2IvA/HSoWUHMGLzW7D
        K2/s+tvdCw9uziMXCb0ehV6gIfF8rcRBs2/OxZPyXmqh86q9xhc5EoG9ggJvYUJT
        v5jfvMnoBrBotE6Rj0nsMlDMrQ/mpZ/vbAPGOj2PwBeHY92F31pIX//LH6ynSkP/
        dws8mj3FyXgus03t/0LbKtccKMD8Qd2ip9gjVx4yMEqzLpwZtRdH5CIMU5hD/TW+
        U0HR7aqCeIWJ4Lu1pTPspRmzz8SlzIu+XnNp5ZP6f/t59tVPJsSZCKNlKh5s7YJ6
        CG/+iRcBZaRx2JEUwCCkp6CnSq9YXV1OaFB2Zyr2sFJojcNlQrN2T15ZA==
In-Reply-To: <87sf96kk6f.fsf@turtle.gmx.de>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Joachim <svenjoac@gmx.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org


On Sun, Jul 30, 2023, at 2:06 PM, Sven Joachim wrote:
> On 2023-07-29 14:07 -0700, Linus Torvalds wrote:
>
>> On Thu, 27 Jul 2023 at 13:01, Sven Joachim <svenjoac@gmx.de> wrote:
>>>
>>> Commit a2225d931f75 ("autofs: remove left-over autofs4 stubs")
>>> promised the removal of the fs/autofs/Kconfig fragment for AUTOFS4_FS
>>> within a couple of releases, but five years later this still has not
>>> happened yet, and AUTOFS4_FS is still enabled in 63 defconfigs.
>>
>> Ok, I ran the script, and also decided that we might as well remove
>> the AUTOFS4 legacy naming stub entry by now.
>>
>> It has been five years, and people will have either picked up the new
>> name with 'make oldconfig', or they just don't use 'make oldconfig' at
>> all.
>
> I had not added the suggested the removal of AUTOFS4_FS from the Kconfig
> in my patch, because some projects seem to have have copy-pasted from
> the kernel's defconfig files, e.g. systemd[1].  Hopefully not a big deal
> for actual users, but worth mentioning.

Right, it's time to do this though.
Hopefully the systemd maintainers will post to the autofs mailing list for advice.

Ian
