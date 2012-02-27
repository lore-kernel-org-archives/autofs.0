From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] autofs4: fix compilation without CONFIG_COMPAT
Date: Mon, 27 Feb 2012 08:25:02 -0800
Message-ID: <CA+55aFz+JW3w06hCOL7uoiZg1ZBGoNLWfHPu_g7OJ8L1LW3iaA@mail.gmail.com>
References: <20120221.221609.218135609185671883.davem@davemloft.net>
 <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
 <1329889428.2193.45.camel@perseus.themaw.net> <1329890027.2193.48.camel@perseus.themaw.net>
 <1329890251.2193.50.camel@perseus.themaw.net> <m2vcmuh8dg.fsf_-_@igel.home>
 <CA+55aFxH4_gucG7vpdV5NJPNHoXy5bSGtr0yHqmobvYO6PmjNw@mail.gmail.com>
 <4F4B30D5.6050305@de.ibm.com> <20120227090951.GA2681@osiris.boeblingen.de.ibm.com>
 <4F4BADD2.5020908@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=kaAJtibOHskehJVG3CjCty37k2Dpzfm9+00MyeMJaPo=;
        b=i7hutJF+HEKfnUD/Yzrbfkq0HcReV3orXJ5+1saZHt4TrWLSxxHMju8Lt0vTGaPlY2
         oYc65Y+3vhq//A0hUVzkRvRhvkG2WWk3JRL1MufcSbaMVEdzM00NGJC9Ux17i3CczmE+
         vx7WvVBTIXgPeTkZy58ME6rKqhvofEJAXwVTE=
In-Reply-To: <4F4BADD2.5020908@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andreas Schwab <schwab@linux-m68k.org>, Ian Kent <raven@themaw.net>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Mon, Feb 27, 2012 at 8:22 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> This patch would seem to be The Right Thing; the combination of this really
> takes what s390 has done in arch space and globalizes it.

Yeah, I already applied that s390 fixup and pushed it out. And yes,
the fact that s390 already did the whole "is_compat_task()" dance on
its own just shows that we should have done this in <linux/compat.h>
from the very beginning.

                  Linus
