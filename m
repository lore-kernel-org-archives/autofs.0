From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Thu, 10 Aug 2017 10:16:02 +0800
Message-ID: <253371b7-ce7d-1b97-bbb4-cf2263d6dd28@themaw.net>
References: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
 <4689.1502267949@warthog.procyon.org.uk>
 <f7ea302d-2e17-b8bf-242e-fc06c4a0adcb@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=KvOZTXEwHzTO963W6l
        lIZv55JEAoXzLXWgb8asaNuyo=; b=M25BXCMSDbFWD4GU1XarqHRBET5XmJn8OY
        jD+S5vZJOtko/shtWNwWaxmxvk922Y7S9G21GqfTH/GZ2ZlzKv1T4IGPaAg39RGE
        KlVssN1CpWRttSYFp34063nIO6qlbqagWJhDplYiVsTS6kI47OuYNq9DSlsX1Hik
        NRsUtMUECviqn2gN2Mg+Q25Ua7SQY75B85FyPm3+67c+7PtkRel1CdnrH1f9B9kB
        SBx7clp/yerjgKjtarylqqe32HdZhVEWvZ+vVsEtro+omTHRiIe27VW98JAkLlst
        nrCTPSXZNyV001ccUO3FxpPKjQt8SyrorOCXZHcAMeasgCKp7Kyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=KvOZTXEwHzTO963W6llIZv55JEAoXzLXWgb8asaNuyo=; b=Ry4BQgIf
        MKOKrZjZzeh4U8Zwv7fCg0GWjHHTHFddW/au81d88zF+ZoGEWvYmFkbxSGFqy6hH
        C2Q79qsAgXwJu4HAltLcb/irVLI9Hz2f4aeLSDf00rm7UncRHavB+1Jcj5BGTX9q
        0nPaxvd6xcoo0rm9u6NkC/Ua82SyninsYIZydUj7b0xYLzqUHJdJvkOd2Vlg1crO
        WwbtmNABhzsK50hxGdFTfFMtPsqWuSLKSJoKoP3tUqqmP7ObnW0ZcfFXJb1IJF14
        MoB1rFAzXYootY1jzYqTuot/vIbfYBYP1xnVo1sJRZ0ACMBoDiz+OQjoy87kHK+H
        aSXI7zu5JrpvXg==
In-Reply-To: <f7ea302d-2e17-b8bf-242e-fc06c4a0adcb@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Ondrej Holy <oholy@redhat.com>, Colin Walters <walters@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 09/08/17 17:51, Ian Kent wrote:
> On 09/08/17 16:39, David Howells wrote:
>> Ian Kent <raven@themaw.net> wrote:
>>
>>> In order to handle the AT_NO_AUTOMOUNT for both system calls the
>>> negative dentry case in follow_automount() needs to be changed to
>>> return ENOENT when the LOOKUP_AUTOMOUNT flag is clear (and the other
>>> required flags are clear).
>>
>> Should the be EREMOTE instead of ENOENT?
> 
> I thought about that and ended up thinking ENOENT was more sensible
> but I'll look at it again.

I think EREMOTE and ENOENT both are inaccurate.

There's no way to know if the negative dentry corresponds to a valid map
key, and we've seen increasing lookups from userspace applications for
invalid directories, so I'm not sure.

I went with ENOENT but I guess we could use EREMOTE, what's your thinking
on why EREMOTE might be better than ENOENT?

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
