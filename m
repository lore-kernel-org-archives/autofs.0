From: Axel Thimm <Axel.Thimm@atrpms.net>
Subject: Cascading/recursive autofs mounts?
Date: Thu, 25 Aug 2005 22:13:42 +0200
Message-ID: <20050825201342.GB4935@neu.nirvana>
Reply-To: autofs@linux.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0634098268=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--===============0634098268==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

we have a setup, where we would like to have autofs mount over NFS a
certain folder and then bind-mount from subfolders to other places.

Can this work with autofs? E.g. can autofs cascade mount requests?
E.g. if the first autofs request would require a second one to be
performed first, would the second one properly mount the NFS share and
the outer one continue with bind mounting?. It looks like the first
one would lock /var/lock/autofs and the inner autofs request would
fail.

Thanks!
--=20
Axel.Thimm at ATrpms.net

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDDiZ1QBVS1GOamfERAhTuAJ9scB404DReNH1X4o2uuY3Oicx+lACfXpLy
wiDT0Zwz/1Iod9KDk++iww0=
=AcaL
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--


--===============0634098268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0634098268==--

