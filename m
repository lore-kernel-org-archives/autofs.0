From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Sun, 29 Apr 2012 00:19:50 -0700
Message-ID: <CA+55aFyS9VYT50JAXeGrLrtFVWSGr+DMTA1hhrcPYzmjrSV5+A@mail.gmail.com>
References: <20120427.151433.1007849975903946491.davem@davemloft.net>
 <20120427.151651.2274764174217164454.davem@davemloft.net> <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
 <20120427.152404.2292425516870981391.davem@davemloft.net> <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
 <20120427234215.079a1565@pyramind.ukuu.org.uk> <CA+55aFxq4TunFa8mqJk5MHfvvFSg7Dr54acW7Cnqc5amOPdqrg@mail.gmail.com>
 <CA+55aFzdEcfXVXXqCumVJo=9+fK+1HvH6L4qY03HfTTvCs1Fwg@mail.gmail.com> <4F9CE18C.2060806@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=DBZqTrYVPLFL7VzpyKjgrOTY5xyGEgFUtoGHC2+CXkE=;
        b=araz+/5jK8d+Y5e0kwaiqa7vb2V4e0b0iNnjOwTvfgTWDlBsPK4C2TdFKJA/bzxzQ5
         zkl5EbVzVYPrLWguaNkcFVsaxO0Yl0hl64iW5/YH3xgxkuHnQnpZLzOurxekStZmCo5L
         1BhOJEhTMMkbea5GGEzMPr/jCEcnXIV6c3bLT2xF4PmHgc2n1/OjqWSTmKSXzdCOdRoI
         aYg7NQw6ccA6MogpMz815ro+MeuYqKomp9YH8WQSRqapLzfv57790DO8zFhJrh76g4dm
         1RIDC8PF7RRPNoMWhbI8dKOIS1uqFcIlHd9XTb2COYELcS4ll6diDyNMc5bZYkgNJEr7
         VFeg==
In-Reply-To: <4F9CE18C.2060806@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Meyer <thomas@m3y3r.de>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, stable@kernel.org

On Sat, Apr 28, 2012 at 11:37 PM, Michael Tokarev <mjt@tls.msk.ru> wrot=
e:
>
> And no, it does not quite work. =A0Strace shows that systemd correctl=
y
> reads first 300 bytes, but next read returns 4 bytes, so it reads
> these and waits for next 300-4 =3D 296 bytes of data.
>
> /proc/1/fdinfo/16 =A0-- the autofs pipe fd# -- shows flags=3D02004000
> which is O_CLOEXEC|O_NONBLOCK, but this is the other end of the
> pipe.. =A0shouldn't the READ side of the pipe have O_DIRECT flag now?

Gaah, it should, but it won't.

I bet my original patch worked fine, because the pipe has only one
inode and pipe structure. But it has *two* 'struct file's associated
with it, and autofs only ever sees the writing side, and never gets to
mark the reading side O_DIRECT. So yeah, the reading side won't do the
proper packetized read.

Duh. So we need to put the flag back in the pipe_inode_info. Too bad -
because the O_DIRECT approach was so nice in other ways.

                     Linus
