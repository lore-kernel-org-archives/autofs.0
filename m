From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/25] autofs: move ioctl32 to autofs{,4}/root.c
Date: Mon, 7 Nov 2005 11:36:18 +0100
Message-ID: <200511071136.19087.arnd@arndb.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162716.551500000@b551138y.boeblingen.de.ibm.com> <Pine.LNX.4.63.0511061407160.2621@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750794AbVKGKfJ@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511061407160.2621@donald.themaw.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, hpa@zytor.com, autofs@linux.kernel.org

On S=FCnndag 06 November 2005 07:22, Ian Kent wrote:
> On Sat, 5 Nov 2005, Arnd Bergmann wrote:
>
> I'm not sure if I like conditional compilation in the code proper but=
 I'll=20
> leave it to you to make the final decision since your running with th=
e=20
> change. Is there a reason the definitions can't simply be left in pla=
ce?

I think the compat_ptr() macro is not defined on architectures that don=
't
have 32 bit compat code, but we could change that.
=20
> Its been a while since I trawled through the compat ioctl code (pleas=
e=20
> point me to the right place) but with this change I think that the=20
> AUTOFS_IOC_SETTIMEOUT32 is redundant. Consider a conditional define f=
or=20
> AUTOFS_IOC_SETTIMEOUT in include/linux/auto_fs.h instead. Both autofs=
 and=20
> autofs4 use that definition.

The point here is that the two are different on 64 bit platforms, since
sizeof (int) !=3D sizeof (long). You also can't do

switch (cmd) {
case AUTOFS_IOC_SETTIMEOUT32:
case AUTOFS_IOC_SETTIMEOUT:
	return do_stuff();
}

because then gcc would complain about duplicate case targets on 32 bit
targets.
=20
> The lock_kernel()/unlock_kernel() in the autofs4 patch is ineffective=
 as=20
> the BKL is not used for syncronisation anywhere else in autofs4. If=20
> removing it causes problems I need to know about'em so I can fix'em=20
> (hopefully).

I used the BKL here in order to maintain the current semantics, because
ioctl is always called with BKL held, and compat_ioctl is called withou=
t
it.

If you are sure you don't need the BKL, then you should also replace
".ioctl =3D ..." with ".unlocked_ioctl =3D ...".

	Arnd <><
