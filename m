From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Wed, 22 Feb 2012 08:12:45 -0800
Message-ID: <CA+55aFwkYkSC1O=fWtj1CBAeKDP-ogEL4Mai8U-dd2uCMArppw@mail.gmail.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
 <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
 <1329889428.2193.45.camel@perseus.themaw.net> <1329890027.2193.48.camel@perseus.themaw.net>
 <1329890251.2193.50.camel@perseus.themaw.net> <1329903139.2193.66.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=vIRNPZWno06gRPdhZEN9hGbTofsGqmf1V5+/H/i57Jg=;
        b=kGt4fiB7k3bQKe7aqPhKQtdD7IjdJCCEJ99/sxXg0CHRvkMUnpZ4r7r9xssXwnb8Pj
         LwgUgv/R3QX4AmKy+XjH0+31pbi9WrEOPku9S55F/ZRRHI1AV+7Yex0dMjUhekwtB6Zl
         Uc/HovajaL9o+ZnW7Xl/A8pa3JLMOEzqXXRZ4=
In-Reply-To: <1329903139.2193.66.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, Feb 22, 2012 at 1:32 AM, Ian Kent <raven@themaw.net> wrote:
>
> Oh, DOH ...
>
> The process mounting the autofs mount is passing the pipe it will use
> for communication via a mount option so we can do this right in
> fill_super.

No, we really cannot.

The autofs "mount" is done by fork + execve("mount").

So fill_super doesn't actually see the *daemon*. It sees the mount binary.

So if you have a 64-bit mount binary, and a 32-bit daemon, you're screwed again.

                     Linus
