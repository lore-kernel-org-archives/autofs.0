From: "Arthur Korn" <arthur@korn.ch>
Subject: Re: autofs init script doesn't support exclude
Date: Tue, 21 Sep 2004 22:39:20 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040921203920.GA9988@turing>
References: <20040920224949.GL23879@merlins.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12651624509252457=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040920224949.GL23879@merlins.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--===============12651624509252457==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

Marc MERLIN schrieb:
> >From https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D91559

> --- autofs.FCS  2003-01-27 20:22:54.000000000 -0800
> +++ autofs      2003-05-23 18:38:27.000000000 -0700
> @@ -34,6 +34,11 @@
>  initdir=3D/etc/init.d
> =20
>  #
> +# Read configuration options
> +#
> +[ -f /etc/sysconfig/autofs ] && . /etc/sysconfig/autofs

This would be /etc/default/autofs for Debian then ...

ciao, 2ri
--=20
Secure email, spread GPG, clearsign all mail. http://www.gnupg.org
=2E
Options are optional.
 -- autofs(5)

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBUJF4NgpsykSg/LgRAiGXAJ9KijmrMeg6BLKKXgelH8SurkX+1ACeM24J
NNesfxdeMpE6pcAnXxRWkuM=
=0rMD
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--


--===============12651624509252457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============12651624509252457==--

