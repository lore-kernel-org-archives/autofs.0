From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Sun, 29 Apr 2012 13:53:57 -0700
Message-ID: <CA+55aFwvs35n-K5YrDxPAhPNcr2PxqOC7kEWeReQkPVP93y4uw@mail.gmail.com>
References: <20120427.151433.1007849975903946491.davem@davemloft.net>
 <20120427.151651.2274764174217164454.davem@davemloft.net> <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
 <20120427.152404.2292425516870981391.davem@davemloft.net> <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
 <20120427234215.079a1565@pyramind.ukuu.org.uk> <CA+55aFxq4TunFa8mqJk5MHfvvFSg7Dr54acW7Cnqc5amOPdqrg@mail.gmail.com>
 <CA+55aFzdEcfXVXXqCumVJo=9+fK+1HvH6L4qY03HfTTvCs1Fwg@mail.gmail.com>
 <4F9CE18C.2060806@msgid.tls.msk.ru> <CA+55aFyS9VYT50JAXeGrLrtFVWSGr+DMTA1hhrcPYzmjrSV5+A@mail.gmail.com>
 <4F9CF191.5020607@msgid.tls.msk.ru> <CA+55aFzJjk8vvY7au-aUOJqJaRaFT3zqP0_H9JXS2Y93wkXwEg@mail.gmail.com>
 <CA+55aFwTUDsefBd9c-wp8jrnp4tOh6jyJkjc_UZut-J6FHSF+w@mail.gmail.com> <4F9D9C4C.7000904@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=R5BudzZmFDXov87fBbIJNMarzvUkNLZ5IEBA8jeU+yo=;
        b=JUmVWS0SbmzMrCcIXySbIBbibaFBe+mc4J9dfWhoRaqCoT6M6MGw7tjzPO7rUgMASS
         w7IqRKCljnb+uCYhTVC7bdTBGq5/WHm8uYNf1nrXtVsGCaQNIN7PHr7536hvjY8Y/s5X
         +jhGTJVP9KhdsPe+JomxsCibKM8T1rVifAMiBce26AjoblaDO/5WPB6FAUaub8uMpaL+
         GxroGvxOnZCnHHmwzGOcniVanawFCPot5ipz+QNBL9mxytT1YZZL+lGt2LCJuSHheOuM
         yOgxToD1w6uRHfv2UOkg0P+jh4/uCLBYSDuZntwA+ihk1SUTqNTTQh+BgMXSeWKTzInG
         qSXg==
In-Reply-To: <4F9D9C4C.7000904@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Meyer <thomas@m3y3r.de>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, stable@kernel.org

On Sun, Apr 29, 2012 at 12:53 PM, Michael Tokarev <mjt@tls.msk.ru> wrot=
e:
>
> Ok. =A0I verified this on 3.3 kernel (with the original fix reverted)=
,
> and now both autofs5 and systemd works.
>
> I also verified it on 3.0 kernel (3.0.30), the patch also applies
> there just fine (with 1..2 lines offsets) and works too -- at least
> on 32/64 bits.
>
> So, the result appears to be an excellent solution to a bad problem..=
=2E
>
> Thank you all for the efforts and support!

And thank *you* for reporting and testing and staying with this.

I've committed the patch (as two separate patches: the first does the
pipe infrastructure, the second adds the code in autofs to enable the
use of it), and tried to comment on it extensively in the changelogs.

I also marked the patches for stable, but I would suggest that the
stable team wait a while before applying it, just to verify that we
don't have some crazy third autofs pipe user that does the packet as
many smaller reads. I don't think that's a sane thing to do, and I
don't think it happens, but by now I'm getting a big paranoid about
this whole thing.

Because I really hope this means that we can close this issue for good.

                      Linus
