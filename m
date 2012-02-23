From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Wed, 22 Feb 2012 18:25:09 -0800
Message-ID: <CA+55aFyRFGrT6uSSCQoX0pZPZ7j2p4oqX-dcfsFUZt4q81qMrg@mail.gmail.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
 <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
 <1329889428.2193.45.camel@perseus.themaw.net> <1329890027.2193.48.camel@perseus.themaw.net>
 <1329890251.2193.50.camel@perseus.themaw.net> <1329903139.2193.66.camel@perseus.themaw.net>
 <CA+55aFwkYkSC1O=fWtj1CBAeKDP-ogEL4Mai8U-dd2uCMArppw@mail.gmail.com>
 <1329961703.2244.8.camel@perseus.themaw.net> <CA+55aFzRQJ8YeZGnbq=OO0YgzkfrcS4r+G1cJbjtDCZe=t6DNQ@mail.gmail.com>
 <1329962955.2244.16.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=+9v46S24FTxFUKnJc87RuaYQaONNXQKPzdizYlPKJXg=;
        b=fTiOkbIN+j9NTfHNxj8elWUG7c08xAnUO7I1T3FsFgEsYU7U2KpiU14LqTOHPKJgY5
         QZ3h2DDW2R+bHe0cI5ObBcowxyCy0YdG9Pej4Wqo9K8nsDCy+kSBaFOa54kHmIRYLK49
         Q5VWmJltX+pAdRwuz4mYZedROvdahnXIYi/Ew=
In-Reply-To: <1329962955.2244.16.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, Feb 22, 2012 at 6:09 PM, Ian Kent <raven@themaw.net> wrote:
>
> Sure, that's true, and you'll see it uses the mount option maxproto with
> the value of AUTOFS_MAX_PROTO_VERSION. But autofs uses it's own copy of
> the headers so AUTOFS_MAX_PROTO_VERSION is 4 not 5 so it won't be
> affected by this change.

Ok.

I fetched your git tree, and it seems this changed to use mount()
directly in commit a74f68c99d9f ("integrated master map parsing into
daemon") back in 2006.

Which seems to be part of autofs_5_0_0_beta1, so I guess we're safe. I
hope no distro ever used any early pre-beta versions of autofs that
had the new packet support but still used the external 'mount'
command.

So looks good. I can't imagine that systemd mounts things directly,
because then you need to play with the whole pipe thing to get it to
work with the daemon. And that would just be odd.

Of course, "odd" is often par-for-the-course in user land ;)

                Linus
