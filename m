From: Axel Thimm <Axel.Thimm@atrpms.net>
Subject: Re: autofs-4.1.3 rpms available
Date: Sat, 5 Jun 2004 11:22:41 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040605092241.GA4610@neu.nirvana>
References: <6AB920CC10586340BE1674976E0A991D01755BC8@slexch2.sugarland.unocal.com>
	<16576.55049.875986.881088@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============56978274924461836=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16576.55049.875986.881088@segfault.boston.redhat.com>
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


--===============56978274924461836==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2004 at 04:09:45PM -0400, Jeff Moyer wrote:
> =3D=3D> Regarding RE: [autofs] autofs-4.1.3 rpms available; "Crawford, Ph=
ilip I." <philip.crawford@unocal.com> adds:
>=20
> philip.crawford> Hi Jeff / List: With regards to your RHEL3 version of the
> philip.crawford> RPM - doesn't the kernel need to be patched first?  We
> philip.crawford> have been unable to get ghosting work just using the RPM.
> philip.crawford> If there are patches needed where can I get these?  The
> philip.crawford> ones Ian released last week aren't for RHEL and won't
> philip.crawford> patch cleanly.
>=20
> Yes, that is quite correct, though all of the features you were using in
> 3.1.7 should work fine with the autofs4 userspace and the autofs3 kernel
> module.
>=20
> I have patches for RHEL 3 which I am currently testing internally.  I'll
> let you know when they are publically available.

How about external kernel module rpms? I am providing such for
consumer line Red Hat products (RHL 7.3 to 9 and FC 1 and 2), and
these could also be built for RHEL kernels. This makes testing much
easier, as you don't need to involve the kernel masters. As soon as
the external kernel module rpms prove themselves, you can still merge
them into the kernel rpm.

Some people in RH are trying to get me a RHEL license for other
purposes, if I get one indeed, I will try to provide external kernel
modules (but there still is a tiny two-liner patch needed for enabling
the autofs external module, which needs to be in-kernel, can't say if
this aplies to the current RHEL kernel).
--=20
Axel.Thimm at ATrpms.net

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwZDhQBVS1GOamfERAuwmAKCMUJIGRXSHufoDcPWRWh/OMjjcZwCeJB52
0BPWdHU2V/DkonD2vpe22lM=
=Egbw
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--


--===============56978274924461836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============56978274924461836==--

