From: Axel Thimm <Axel.Thimm@atrpms.net>
Subject: util-linux rpms for sloppy/noacl/non-selinux (was: mount 2.12:
	proplist and failed mounts)
Date: Fri, 25 Jun 2004 22:59:32 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040625205932.GC1056@neu.nirvana>
References: <20040625110243.GH22003@neu.nirvana>
	<16604.6212.198799.326752@segfault.boston.redhat.com>
	<20040625172316.GI22003@neu.nirvana>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============18011575369622879=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040625172316.GI22003@neu.nirvana>
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
Cc: autofs@linux.kernel.org, sopwith@redhat.com, M.A.Young@durham.ac.uk


--===============18011575369622879==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 25, 2004 at 07:23:16PM +0200, Axel Thimm wrote:
> On Fri, Jun 25, 2004 at 08:19:16AM -0400, Jeff Moyer wrote:
> > I had a bug filed here (on FC2, I think) which described your
> > situation.  [...] It has since been fixed.
>=20
> Now, that I know what to look for I found the bugzilla entry:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D122448
>=20
> Looks like the fix is not yet in rawhide :( :( :(
>=20
> BTW, here are my patches to make util-linux build again on non-selinux
> systems:
>=20
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D126720

I put together util-linux rpms which include

o the (no)selinux patches
o the sloppy fixes by Michael Young
o the [no]acl patches by Andreas Gruenbacher
  (http://bugzilla.atrpms.net/show_bug.cgi?id=3D73)

The work fine in mixed autofs'ed environments of OSF1s, acled and
non-acled NFS servers and acled NFS clients.
--=20
Axel.Thimm at ATrpms.net

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3JIzQBVS1GOamfERAsNJAJ99/TyYIuqYBZhZMJMa1/flM5IdlQCghrlB
UYORy4EuqhKKaPK6g7Jyyj4=
=YiPl
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--


--===============18011575369622879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============18011575369622879==--

