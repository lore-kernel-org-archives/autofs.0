From: Axel Thimm <Axel.Thimm@atrpms.net>
Subject: Re: mount 2.12: proplist and failed mounts
Date: Fri, 25 Jun 2004 19:23:16 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040625172316.GI22003@neu.nirvana>
References: <20040625110243.GH22003@neu.nirvana>
	<16604.6212.198799.326752@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70928360254776091=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16604.6212.198799.326752@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org


--===============70928360254776091==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zq44+AAfm4giZpo5"
Content-Disposition: inline


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 25, 2004 at 08:19:16AM -0400, Jeff Moyer wrote:
> =3D=3D> Regarding [autofs] mount 2.12: proplist and failed mounts; Axel T=
himm <Axel.Thimm@atrpms.net> adds:
>=20
> Axel.Thimm> Hi, I was happily using autofs 4.1.3 with mount 2.11y. The ma=
ps
> Axel.Thimm> contained the proplist option (we share the maps with some OS=
F1
> Axel.Thimm> boxes), but that did not disturb.
>=20
> Axel.Thimm> for other reasons I had to upgrade mount to 2.11 (part of
> Axel.Thimm> util-linux). Suddenly autofs will not mount anymore with erro=
rs
> Axel.Thimm> like:
>=20
> Axel.Thimm> Jun 25 12:25:50 heretic automount[12646]: failed to mount
> Axel.Thimm> /home/thimm Jun 25 12:25:50 heretic automount[12648]: >>
> Axel.Thimm> Unsupported nfs mount option: proplist Jun 25 12:25:50 heretic
> Axel.Thimm> automount[12648]: mount(nfs): nfs: mount failure
> Axel.Thimm> nukleon:/amd/nukleon/1/home/ag-linke/thimm on /home/thimm

> You need to specify the sloppy mount option (-s) for this to work.  It
> basically tells mount to not be so picky about options it doesn't
> understand.  (Note that autofs uses this option.)
>=20
> As for your experience, were you using Red Hat packages per chance?

Yes, I "backported" util-linux-2.12-18 (rawhide/fc2) to non-selinux
setups (needed to tweak the nfssloppy patch) ...

> I had a bug filed here (on FC2, I think) which described your
> situation.  The problem was that someone (not naming names)
> accidentally committed some code which did not allow sloppy mounts
> for NFS.  It has since been fixed.

Now, that I know what to look for I found the bugzilla entry:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D122448

Looks like the fix is not yet in rawhide :( :( :(

BTW, here are my patches to make util-linux build again on non-selinux
systems:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D126720

> Please let me know if you need more help tracking this down.
>=20
> Thanks!
>=20
> Jeff

--=20
Axel.Thimm at ATrpms.net

--zq44+AAfm4giZpo5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3F+DQBVS1GOamfERApk7AJ98XlWWufpRyx8Tq2wR8bHOWnKtHACfVliS
5TieJS2U4ED7v69hs+ArJn4=
=KDrT
-----END PGP SIGNATURE-----

--zq44+AAfm4giZpo5--


--===============70928360254776091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============70928360254776091==--

