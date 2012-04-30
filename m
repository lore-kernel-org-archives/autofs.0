From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Mon, 30 Apr 2012 10:41:11 +0200
Message-ID: <1335775271.1363.4.camel@localhost.localdomain>
References: <20120427.151433.1007849975903946491.davem@davemloft.net>
	 <20120427.151651.2274764174217164454.davem@davemloft.net>
	 <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
	 <20120427.152404.2292425516870981391.davem@davemloft.net>
	 <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
	 <20120427234215.079a1565@pyramind.ukuu.org.uk>
	 <CA+55aFxq4TunFa8mqJk5MHfvvFSg7Dr54acW7Cnqc5amOPdqrg@mail.gmail.com>
	 <CA+55aFzdEcfXVXXqCumVJo=9+fK+1HvH6L4qY03HfTTvCs1Fwg@mail.gmail.com>
	 <4F9CE18C.2060806@msgid.tls.msk.ru>
	 <CA+55aFyS9VYT50JAXeGrLrtFVWSGr+DMTA1hhrcPYzmjrSV5+A@mail.gmail.com>
	 <4F9CF191.5020607@msgid.tls.msk.ru>
	 <CA+55aFzJjk8vvY7au-aUOJqJaRaFT3zqP0_H9JXS2Y93wkXwEg@mail.gmail.com>
	 <CA+55aFwTUDsefBd9c-wp8jrnp4tOh6jyJkjc_UZut-J6FHSF+w@mail.gmail.com>
	 <4F9D9C4C.7000904@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F9D9C4C.7000904@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, stable@kernel.org

Am Sonntag, den 29.04.2012, 23:53 +0400 schrieb Michael Tokarev:
> On 29.04.2012 23:09, Linus Torvalds wrote:
> > 
> > This keeps Alan's idea of using O_DIRECT, but only makes it matter for
> > the writer - because now the "packet" thing is a per-pipe-buffer state
> > (we already had per-pipe-buffer flags, so this is not anything new).
> > So when you *write* using a O_DIRECT pipe, it will create packetized
> > buffers, and the reader just sees that directly.
> > 
> > So this should "just work", and doesn't need any extra flags in the
> > pipe_inode_info. And the user space interface remains the same: you
> > can create these packet pipes with "pipe2(fd, O_DIRECT)" if you want
> > to, and my test-program gives exactly the same output.
> 
> Ok.  I verified this on 3.3 kernel (with the original fix reverted),
> and now both autofs5 and systemd works.

hi,

I can also confirm that "autofs: make the autofsv5 packet file
descriptor use a packetized pipe" and "pipes: add a "packetized pipe"
mode for writing" on top of 3.3.4 works correctly at least with the
autofs feature of systemd.

And sorry for the delayed answer, but I've been away from the internet
for a few days.

and a big sorry for all the trouble...

with kind regards
thomas
