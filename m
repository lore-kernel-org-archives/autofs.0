From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: Breaking userspace? Re: 3.0.24 broke aufofs on mixed 32/64bit
 environment
Date: Tue, 24 Apr 2012 22:42:39 +0200
Message-ID: <1335300159.1393.13.camel@localhost.localdomain>
References: <4F94222C.6080608@msgid.tls.msk.ru>
	 <1335172741.2226.10.camel@perseus.themaw.net>
	 <4F958352.7050106@msgid.tls.msk.ru> <4F95897B.2040103@msgid.tls.msk.ru>
	 <4F959A5A.8070907@msgid.tls.msk.ru>
	 <CA+55aFyQ4y9jyRXyejKwtf3yXJX52hQkLuwJ5=jfQM+yLkBNMw@mail.gmail.com>
	 <4F96D0E7.9060000@msgid.tls.msk.ru>
	 <CA+55aFw=cfYZO7PWDRRuZw1nYxvUk-63qfVVwfdJWevtmZoOig@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFw=cfYZO7PWDRRuZw1nYxvUk-63qfVVwfdJWevtmZoOig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Ian Kent <raven@themaw.net>, "stable@kernel.org" <stable@kernel.org>, autofs@vger.kernel.org, Linux-kernel <linux-kernel@vger.kernel.org>

Am Dienstag, den 24.04.2012, 12:53 -0700 schrieb Linus Torvalds:
> On Tue, Apr 24, 2012 at 9:12 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > The userspace is running debian stable (squeeze).  Debian has autofs
> > package based on upstream 5.0.4 version.  That (upstream) version has
> > the "bug-compat" code in it, in daemon/automount.c:
> >
> > static size_t get_kpkt_len(void)
> > {
> >        size_t pkt_len = sizeof(struct autofs_v5_packet);
> >        struct utsname un;
> >
> >        uname(&un);
> >
> >        if (pkt_len % 8) {
> >                if (strcmp(un.machine, "alpha") == 0 ||
> >                    strcmp(un.machine, "ia64") == 0 ||
> >                    strcmp(un.machine, "x86_64") == 0 ||
> >                    strcmp(un.machine, "ppc64") == 0)
> >                        pkt_len += 4;
> 
> Ugh.
> 
> So how did this break for Thomas Mayer (there was another person
> involved too, I forget the details)? Is this code somehow
> config-dependent so that it doesn't even get compiled for some cases?

It broke the autofs feature of systemd (32bit) on a 64bit kernel, which
resulted in an endless wait in the boot process. I don't use the autofs
tools. I guess the fix in the autofs package to compensate the kernel
bug, which has now been fixed, breaks the autofs package.
The fix in the kernel makes systemd work correctly.

thomas

