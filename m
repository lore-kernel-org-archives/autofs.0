From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] autofs4: fix compilation without CONFIG_COMPAT
Date: Sun, 26 Feb 2012 10:05:22 +0100
Message-ID: <m2399yq819.fsf@linux-m68k.org>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
	<20120221.221609.218135609185671883.davem@davemloft.net>
	<CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
	<CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
	<CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
	<1329889428.2193.45.camel@perseus.themaw.net>
	<1329890027.2193.48.camel@perseus.themaw.net>
	<1329890251.2193.50.camel@perseus.themaw.net>
	<m2vcmuh8dg.fsf_-_@igel.home>
	<CA+55aFxH4_gucG7vpdV5NJPNHoXy5bSGtr0yHqmobvYO6PmjNw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFxH4_gucG7vpdV5NJPNHoXy5bSGtr0yHqmobvYO6PmjNw@mail.gmail.com>
	(Linus Torvalds's message of "Sat, 25 Feb 2012 17:31:30 -0800")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ian Kent <raven@themaw.net>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> How about this patch instead?

Works as well.

> And if you worry about the size of autofs_sb_info, I think that could
> be made denser by using 'char' or bitfields instead of the various
> ints that hold small values or flags instead.

Since it's local to autofs4 it doesn't really matter that much.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
