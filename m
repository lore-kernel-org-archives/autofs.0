From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/1] autofs: fix memory leak of waitqueues in
 autofs_catatonic_mode
Date: Mon, 13 Feb 2023 12:27:55 +0800
Message-ID: <5b86f03b-020b-1584-be8f-b7dc7277fa0a@themaw.net>
References: <20230211195950.452364-1-pchelkin@ispras.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1676262493; x=
        1676348893; bh=0i5TurBb3X4wdi823xN8BxjMRfYoHg+NNXP0jPnU5RY=; b=e
        FGdztbJWaVqSFr0mK4refTYRRpk4q1isnVhU+a10fSwuznf9R7HpMkKA3V42MBWx
        OVr4pK3HwUKA/91K8bJUIb9pTD2dgyCRISJoCJ8s7fuPK50oL2iYsrvuuS6mXDP6
        3hNfpO/sAKTGDn8hocvT86NSo4q4Ni4Zjaeo0rCJfxpSUOOF9kViStbCiIbBDhVa
        5AvFnq8+XA2K4xVMuf3UWrjZBj/cmLa5L4H/gA+DQhCPiabA9hjwJM6NCjs/wMzl
        xRmo9RGGfFHfOAUTmk/UA4vgSgMw0g8j8gyx6rGEbZSlJB6ksYEkL6N7eGa0RpvO
        7iFKEA6W0VOcCIAizuJ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676262493; x=
        1676348893; bh=0i5TurBb3X4wdi823xN8BxjMRfYoHg+NNXP0jPnU5RY=; b=q
        mjrCA4TVAt3+EyqMOC3MDxZuXOGpbS3CCjhD+kpugy90P4BHABs1FD8VRZYThcPv
        Obp5KsVSLyGfQvGl31t199TYXsX7apvnVTuekn1etjzKk+51ZoiHfQ0E634jebgX
        XjHGHKhD2dRIpbOrT/jF1VKFoz98BEh2LXn3y7yQPaJ2HhqTXyzeXOomnVBBchtX
        XD1G8kyzbdK1WDscgIn3RHrDvuSquAA30kYB9QVRYfAl0D1TVtvt9Jrz9a2/gyQF
        jbuEjlsMFG1x/uejZk3eD3FhR9/R7BLWpV+ibNpxU/lYJIOMP08anhvtrrL3qIkk
        w6cOgVxN8ybRZGe2WgnMw==
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

This is a bit had to read but I think your saying there's an assumption

that wait_ctr can't become zero in autofs_catatonic_mode().


That's correct, the case of a waiting process getting sent a signal is

not accounted for and this can (as you observed) lead to the wait not

being freed and also not being freed at umount.


I think the change here should be sufficient to resolve the leak and

I can't think of any cases where this could cause a further problem.


>
> Also, looking at the discussion [2] of the '[PATCH] autofs4: use wake_up()
> instead of wake_up_interruptible', shouldn't wake_up_interruptible()
> inside autofs_catatonic_mode() be replaced with wake_up()?

This does imply that [2] should have been applied to autofs_catatonic_mode()

as well, I'm still trying to grok if that change would cause side effects

for the change here but I think not.


Ian

