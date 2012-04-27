From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 23:42:15 +0100
Message-ID: <20120427234215.079a1565@pyramind.ukuu.org.uk>
References: <20120427.151433.1007849975903946491.davem@davemloft.net>
	<20120427.151651.2274764174217164454.davem@davemloft.net>
	<CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
	<20120427.152404.2292425516870981391.davem@davemloft.net>
	<CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

> Comments? The patch looks fairly simple. The "packetized pipe" might
> even be useful for other users and maybe we might want to expose it as
> an actual pipe fcntl, but right now the only thing that sets that flag
> is autofs.

The obvious way to set the flag would seem to me to also btake O_DIRECT
on the pipe as meaning this ?

Alan
