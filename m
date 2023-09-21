From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/8] autofs - convert to to use mount api
Date: Thu, 21 Sep 2023 20:35:56 +0800
Message-ID: <df932642-4c78-768d-2f6d-aaa9ae960c8f@themaw.net>
References: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
 <20230921-altpapier-knien-1dd29cd78a2f@brauner>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695299763; x=1695386163; bh=rfl8F4CyNg3EmdUb8W4wwAH01ChxlJcbD3i
        dNI4QWvg=; b=CLqK/AzUzlihIUEIkRgqLCdvU8tzTIpAOMw5hKZhxE01Ge51xg2
        2jCOE9K9QR6N6ztyc/j1IUTWivE81Sb76k76zGPK+OlFaGSQUK7g459EL0mvtzV9
        De84R3Aq6eyiIR3obtPlzrgGqgbU9nzaQ1jc+vA3xa5eWQgf6nDwQHYHTiMmZLvY
        w8r4EXIcolN6vknBc0GGhNtmcSuX1CqVLzUO8BRlr45cMMkw0pJ+huyP6jkOJ/wy
        KRZC9F/Ck7fi9CB3WSXoGvA7PpldGPUIogFya/mJXYBwEBLzwA5ZVX/9YMyPtZd8
        2iAIHEVUnynDhjmPR2dp3Q6mO3wRGEUzEZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695299763; x=1695386163; bh=rfl8F4CyNg3EmdUb8W4wwAH01ChxlJcbD3i
        dNI4QWvg=; b=lrJvS4taD7NXi0UngiiQWgJPZG/9nl1RR4Zm568zJy4dKiKUdwg
        GnGIAKZcRi6uy8MwejlGFToZREYG0qfAEBWVD3KXym7s7kQ898i1ERDHd/HJ5KFK
        VtUKJSiVbmGiq/6m6ImrPpFydTkgw0kA79Dbf/52ewGWKB8BUsHhoUQetI2vEtCo
        cwsnew5CHFvKKU1ymcYt3DuksV+eWVULeU3/JeUOPTbd1cmLUZgzDJIMardnRtmr
        HEorNcoQBuArlGPdkZnVlzFZHy4YyD/y1VnBjHvaZNWuJ9GJyYH7tzdsztPguEuz
        PM7OSYvmub+E4xGiSM5znbNf/w9zN0du3Bg==
Content-Language: en-US
In-Reply-To: <20230921-altpapier-knien-1dd29cd78a2f@brauner>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill O'Donnell <billodo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>


On 21/9/23 17:13, Christian Brauner wrote:
> On Thu, Sep 21, 2023 at 03:03:26PM +0800, Ian Kent wrote:
>> There was a patch from David Howells to convert autofs to use the mount
>> api but it was never merged.
>>
>> I have taken David's patch and refactored it to make the change easier
>> to review in the hope of having it merged.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> ---
>>
>> Ian Kent (8):
>>        autofs: refactor autofs_prepare_pipe()
>>        autofs: add autofs_parse_fd()
>>        autofs - refactor super block info init
>>        autofs: reformat 0pt enum declaration
>>        autofs: refactor parse_options()
>>        autofs: validate protocol version
>>        autofs: convert autofs to use the new mount api
>>        autofs: fix protocol sub version setting
>>
> Yeah sure, but I only see 4 patches on the list? Is my setup broken or
> did you accidently forget to send some patches?

Sorry, but no, my email has gone very pair shaped.


The above send failed part way through and I haven't been able to send

anything via the command line since. I'm guessing the email app I'm

using to send this will work and the other email accounts I use will

probably work from an app too but the command line is broken for some

unknown reason.


Please ignore these, I'll send them when I can get my problem fixed ...

*sigh*!


Ian

