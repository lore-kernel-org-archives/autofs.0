From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 4/6 v2] autofs4: factor should_expire() out of
 autofs4_expire_indirect.
Date: Thu, 17 Jul 2014 14:34:35 +1000
Message-ID: <20140717143435.2fc69837@notabene.brown>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	<20140709234114.4525.25725.stgit@notabene.brown>
	<20140714105359.4415aab4@notabene.brown>
	<1405497017.2527.89.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/=PE+AHc+SOMeN=N=c=zw6lS"; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1405497017.2527.89.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

--Sig_/=PE+AHc+SOMeN=N=c=zw6lS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jul 2014 15:50:17 +0800 Ian Kent <raven@themaw.net> wrote:


> > +	if (simple_empty(dentry))
> > +		return NULL;
> > +
> > +	/* Case 2: tree mount, expire iff entire tree is not busy */
> > +	if (!exp_leaves) {
> > +		/* Path walk currently on this dentry? */
> > +		ino_count =3D atomic_read(&ino->count) + 1;
> > +		if (d_count(dentry) > ino_count)
> > +			return NULL;
> > +
> > +		if (!autofs4_tree_busy(mnt, dentry, timeout, do_now))
> > +			return dentry;
> > +		/*
> > +		 * Case 3: pseudo direct mount, expire individual leaves
> > +		 *	   (autofs-4.1).
> > +		 */
>=20
> I recommend removing one of the tab stops on this since it relates to
> the else case but feels like it's "attached" to the code above the else.

The auto-reindent feature of emacs put it there and I didn't double check.
I've fix it.


>=20
> > +	} else {
> > +		/* Path walk currently on this dentry? */
> > +		struct dentry *expired;
> > +		ino_count =3D atomic_read(&ino->count) + 1;
> > +		if (d_count(dentry) > ino_count)
> > +			return NULL;
> > +
> > +		expired =3D autofs4_check_leaves(mnt, dentry, timeout, do_now);
> > +		if (expired) {
> > +			if (expired =3D=3D dentry)
> > +				dput(dentry);
> > +			return dentry;
>=20
> Umm .. I think this should be "return expired".

Yes, of course it should.  Fixed.

>=20
> Otherwise this looks like a straight refactor.

Thanks,
NeilBrown

--Sig_/=PE+AHc+SOMeN=N=c=zw6lS
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUBU8dSWznsnt1WYoG5AQLlYBAApd5Yf+k/kyaTcqXxFmaeBqxeChQzOK9X
jNqttzEIDAapShyePQg6XNbBLCJV2+4Cm9OhVXcVO48z35daIvB5lZUlMCWjTpH9
pOTutQB40Uk1pWaj+D0EzbY+JEVRFkl/cmQVtLLp7+Qs2pKDQJtXZrD22mL3p3ab
6sK9xjlE9fWTjFjhyhjUn7BRAtHkzrtpeTzF7Z8JKIEpSaIoSEG3wLgvu5lGZZLu
jmNzcwgW5mjUPxO/Qu37V8/cRXFOvd+hNj7z23xMYzk9FnoP9Helz94I5RiJe3Gb
bBVcCDAZ+LdJMckK/c7xW2C55TtlX3bgdA/17slcm4xPLA4I6Q+Z3I5xgrXztUq0
5EWPLuxjcYkVViDDIrQ9QhoufbYdj5VOe+rAfitm9fBNzFT8pMBsjq+yay+MK3bI
Y62UrInmBjYRu2qfEBP/sylNO1WJMSJ+U3pH/sy2jUonr0sLXsTu66E/Rl2Ch9CE
mUpCi6cd7g9xIh4jN7ypqJu4/nUgGAkxiel+wuNmd7UQNyEbA7kOudbPEbAYNv+r
mfAW98KmyIL52KSQKT922E8va9Zez81vgllJ9rsVPE2L7f38VSZ6pCpWci3+hGyv
k11aCIyQ6lCnmaKL7kdo+nTJ8by3pbyw9OqS4EnrcokS/y+293HEfE54TmM63Hi3
P5BNwWbWHQQ=
=LC1B
-----END PGP SIGNATURE-----

--Sig_/=PE+AHc+SOMeN=N=c=zw6lS--
