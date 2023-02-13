From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/1] autofs: fix memory leak of waitqueues in
 autofs_catatonic_mode
Date: Mon, 13 Feb 2023 09:25:59 +0800
Message-ID: <0011cfb4-5dee-a1f9-ae6d-2c9e71842a52@themaw.net>
References: <20230211195950.452364-1-pchelkin@ispras.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1676251576; x=
        1676337976; bh=guqNRHcMVWDS1JdER/xG2jRdN0GsHvvgSiGFe5DcgXY=; b=e
        I6TMHYyIs5bJi5kLyccPbbwLCfxp8I0GEVNspDZrb/Fnj5YHoEG9QD9FW/Sjoe65
        ZGFWRtyjJRj8HoKWhCTiBkz4rf/e1XR3HdCxUpY9BLt2BbIs0zBkMhauAB8+mkJp
        B4iqZfFkgIjvq3vZE8u7HZvqSlbYmdjfk5mkpDZG8BPBifuYT5Oasrv9WAinDbd+
        k+zdWpnoPfi8rMwdSiigWKyxQNewURO5Ls0w5sia05lLH1DHiC7feejldYN0xRrD
        0G6Kt3cnePfaydatBd9vBu/ngmFR+tHq0cWhYaNstZZ1UAKCLbfTKPpz88oK1+UQ
        YI4gFupmE9n/QT93nnlCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676251576; x=
        1676337976; bh=guqNRHcMVWDS1JdER/xG2jRdN0GsHvvgSiGFe5DcgXY=; b=M
        vQvn4d646Z43jqisClI5d4KOLtMfslF18wt84EClUidLO5zXHsgBf8QjsGjv6Qbi
        s6dc5G+HWNRZJqkvPGsOM5tt2H3EMn/pUWmZCvpwAMziOmWlZ1+D3PO+kvHkbrnJ
        NSGWZ/mduGvJh2a9IvMAa9fLkbMc8wA1yRZU1EpcjsZdJXx7jzTsnthw9fi32fI/
        UCh8P6VRrv9zgeqRjbdz0KBDEk12i3jF9VnDKJuD8jihIS8qM2NG51gDJ90ibyGM
        xGPKPcXjObiiNin/t3oPp28Gw7YboU+GAj44/aQ7WFWKA9xtT/gPE1aSHKw+voUu
        T1FjMH7pufD1O77c/U1dQ==
Content-Language: en-US
In-Reply-To: <20230211195950.452364-1-pchelkin@ispras.ru>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Matthew Wilcox <willy@infradead.org>, Andrei Vagin <avagin@gmail.com>, Takeshi Misawa <jeliantsurux@gmail.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org

On 12/2/23 03:59, Fedor Pchelkin wrote:
> Syzkaller reports the leak [1]. It is reproducible.
>
> The following patch fixes the leak. It was proposed by Takeshi Misawa and
> tested by Syzbot.
>
> In other places of the code the waitqueue is freed when its wait_ctr
> becomes zero (see autofs_wait_release). So I think it is not actually
> supposed that inside autofs_catatonic_mode wait_ctr cannot be decreased to
> zero. Please correct me if I'm wrong.

Clearly there's a problem here but I'll need to think about what's going

a bit more myself.


>
> Also, looking at the discussion [2] of the '[PATCH] autofs4: use wake_up()
> instead of wake_up_interruptible', shouldn't wake_up_interruptible()
> inside autofs_catatonic_mode() be replaced with wake_up()?

Yes, I think so but that also deserves a bit of thought.


Ian
