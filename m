From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling into fs
Date: Fri, 16 Jul 2010 13:05:31 +0200
Message-ID: <201007161305.31291.arnd@arndb.de>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de> <AANLkTimVzSzCl2XfWBg5HauYtIT5znxkm6M0yo_1en2b@mail.gmail.com> <1279255230.2968.24.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279255230.2968.24.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Friday 16 July 2010, Ian Kent wrote:
> On Fri, 2010-07-16 at 02:14 +0200, Frederic Weisbecker wrote:
> > 2010/7/6 Ian Kent <raven@themaw.net>:
> > In any case, can we let you handle this patch for 2.6.36 inclusion?
> 
> I think it makes more sense to keep these common patches together so
> Arnd probably should keep it with his series.

I think that's fine. Takashi Iwai took the alsa patch, but the
rest can probably be merged together.

Frederic, would you like to add the remaining ioctl removal series
into your git tree and have Stephen pull that into linux-next?
I believe he's still pulling your tree anyway, although it doesn't
have much content at the moment.

	Arnd
