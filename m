From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] arch/*/configs/*defconfig: Replace AUTOFS4_FS by
 AUTOFS_FS
Date: Sun, 30 Jul 2023 08:27:28 +0800
Message-ID: <2afc8cac-5749-f7f5-1278-2e1252924ba4@themaw.net>
References: <20230727200041.21404-1-svenjoac@gmx.de>
 <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690676854; x=1690763254; bh=5oVpB8cg24iMSoIqJPBrzh1VmgfW5bnbCkN
        cqJv/vSY=; b=NnbNweek63dx+oTkE0HkrT2cbIXFOBsFi1ljUwofsDoEoSBlgSl
        CTzCfaadIgqqaugqTvzKiqmY2itx2uY9Kgcrqa/eQEowNZebTGthd6uA2BShrEto
        gxLxJJJi6uLnrPfuxtqiiJq5n9htCzwNH7GHz9YSV4LetlCiroE3TYLPZERAlxiW
        gHzJIQWDfpVjRljBwINppGyOZG5QuVrMK48lFoKG3i7YCSg2VxoGixmJeXievni6
        m4d4PzWFVQezyB8ne01Up1E9y1yQjLwPDgJWPvjggXZgFiNF6v/NSZYhsTVUJW8v
        HWEvHnNvRiNzxQEgmKPeWud/1HRSyzIN9Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690676854; x=1690763254; bh=5oVpB8cg24iMSoIqJPBrzh1VmgfW5bnbCkN
        cqJv/vSY=; b=x5h9cydy/S0jYnVAfqDGbjqw6OL/FitloQa9bP5TsbcXzmhF+My
        T0UmtyrI8l3hV657cwcmuwUcxP9hhYok6TprtPc7G/AxK2rIySycfACGeEFeBFl8
        Kjc8D9ABYKLD4McgClcoNsO4GzqlQooHxfYMNNzps4sCR6T88htEoYWBz0BO2qNi
        Bdjj6Z6ttg9p+diLgjmkQ7956Ldfd4Q9Zs0BzVRnyX1wjz6Mpqso/pPJ7ZQzsf1T
        EeV2OibXxLE6qNmCklV/4ewmKP4j38eOSPWxNDqm4STtKLaTsYQnzWKaS0A9ke29
        umG+PwlAZkquaPWi0YPa6qTBREo7rhVDbIw==
Content-Language: en-US
In-Reply-To: <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@linux-foundation.org>, Sven Joachim <svenjoac@gmx.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org


On 30/7/23 05:07, Linus Torvalds wrote:
> On Thu, 27 Jul 2023 at 13:01, Sven Joachim <svenjoac@gmx.de> wrote:
>> Commit a2225d931f75 ("autofs: remove left-over autofs4 stubs")
>> promised the removal of the fs/autofs/Kconfig fragment for AUTOFS4_FS
>> within a couple of releases, but five years later this still has not
>> happened yet, and AUTOFS4_FS is still enabled in 63 defconfigs.
> Ok, I ran the script, and also decided that we might as well remove
> the AUTOFS4 legacy naming stub entry by now.
>
> It has been five years, and people will have either picked up the new
> name with 'make oldconfig', or they just don't use 'make oldconfig' at
> all.

Agreed, thanks Linus.


Ian

