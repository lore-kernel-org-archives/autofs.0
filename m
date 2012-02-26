From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] autofs4: fix compilation without CONFIG_COMPAT
Date: Sat, 25 Feb 2012 17:53:10 -0800
Message-ID: <CA+55aFxwZt3xwo6+KKCDYSXE78+uAVe49mZOyiO3n=ZOEa+Wxg@mail.gmail.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
 <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
 <1329889428.2193.45.camel@perseus.themaw.net> <1329890027.2193.48.camel@perseus.themaw.net>
 <1329890251.2193.50.camel@perseus.themaw.net> <m2vcmuh8dg.fsf_-_@igel.home>
 <CA+55aFxH4_gucG7vpdV5NJPNHoXy5bSGtr0yHqmobvYO6PmjNw@mail.gmail.com> <4F498EFF.6040309@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=dq3+1OiwequVNWmzL5ga26+qMLgkSB0M1LU6u/EUN5s=;
        b=ERbJ/h8+I4yGwruvPeWzsHSDhxFOKZskrlVjVNlF78lezSLbs1u/AISRQPQsKhxxEY
         H2AG2Rr1xiLOMVYh9xSWCxbayvxauVNp//M+siiesJuOC+GSZcodyPQnCfKjyPz6m1sO
         C6n2kPcvRF25HdMetJVbbqN2DmYWzw8K6/kDk=
In-Reply-To: <4F498EFF.6040309@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Ian Kent <raven@themaw.net>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Sat, Feb 25, 2012 at 5:46 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> I think this patch could help clean up other places, too.

Grepping for CONFIG_COMPAT shows that the most common test is for some
local variable that indicates "compatness".

The "is_compat_task()" test is actually surprisingly rare.

                    Linus
