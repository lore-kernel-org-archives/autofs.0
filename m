From: Pavel Machek <pavel@ucw.cz>
Subject: Re: autofs: use __kernel_write() for the autofs pipe writing causes
 regression in -next was Re: 5.9.0-next-20201015: autofs oops in
 update-binfmts
Date: Sat, 17 Oct 2020 21:47:58 +0200
Message-ID: <20201017194758.GA9904@duo.ucw.cz>
References: <20201016123530.GA30444@duo.ucw.cz>
 <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net>
 <20201017100234.GA3797@amd>
 <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ian Kent <raven@themaw.net>, Ondrej Mosnacek <omosnace@redhat.com>, Christoph Hellwig <hch@lst.de>, kernel list <linux-kernel@vger.kernel.org>, autofs@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Peter Anvin <hpa@zytor.com>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Bad Linus!
>=20
> Christ people.

https://www.christpeople.church/ ? Those are unlikely to help, I'd say :-).

> The bug is in linux-next, not in mainline.  I've told the people
> involved already over a week ago.

Yes, I reported the bug against -next.

But: you are the last one to sign it off, so I assume committed it to
git, and you are the one to talk to about fixing it.

> I can't do anything about linux-next being broken and people not
>  fixing it.

90fb702791bf99b959006972e8ee7bb4609f441b causes oops at boot for me.

So... I'm not git wizard, but... if I do log on v5.8, it is not in the
list, and if I do log on v5.9, it shows it.

So yes, I believe this in mainline.

Should I test v5.9 next? Or do you want me to test some patch?

Best regards,

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4tKbgAKCRAw5/Bqldv6
8syLAKCE6WS+jWqX5obzHcHFfaAfz97piQCglC1FqR+3LkZwDi+cFUNYzDLUtRE=
=H0CJ
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
