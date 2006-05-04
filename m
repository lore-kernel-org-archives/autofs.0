From: Moshe Kaminsky <kaminsky@math.huji.ac.il>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Thu, 4 May 2006 20:28:29 +0300
Message-ID: <20060504172829.GA12272@kaminsky>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
	<20060503131637.GA30523@kaminsky>
	<Pine.LNX.4.64.0605032354490.31402@raven.themaw.net>
	<20060503170005.GD1982@kaminsky>
	<Pine.LNX.4.64.0605040156090.2085@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5618641287209314899=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605040156090.2085@raven.themaw.net>
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


--===============5618641287209314899==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Ian Kent <raven@themaw.net> [03/05/06 21:15]:
> On Wed, 3 May 2006, Moshe Kaminsky wrote:
>=20
> > * Ian Kent <raven@themaw.net> [03/05/06 19:15]:
> > > On Wed, 3 May 2006, Moshe Kaminsky wrote:
> > >=20
> > > >=20
> > > > I modified the ebuild for autofs4 and tried to compile. I get:
> > > >=20
> > > > gcc -g -Os -march=3Dathlon-tbird -pipe -fomit-frame-pointer -D_REEN=
TRANT -D_REENTRANT -rdynamic -fPIE -D_GNU_SOURCE -I../include -DAUTOFS_LIB_=
DIR=3D\"/usr/lib/autofs\"  -DAUTOFS_MAP_DIR=3D\"/etc/autofs\" -DAUTOFS_CONF=
_DIR=3D\"/etc/sysconfig\" -DVERSION_STRING=3D\"5.0.0_beta1\" -c direct.c
> > > > direct.c: In function `handle_packet_expire_direct':
> > > > direct.c:969: error: label at end of compound statement
> > > > direct.c: In function `handle_packet_missing_direct':
> > > > direct.c:1260: error: label at end of compound statement
> > > > make[1]: *** [direct.o] Error 1
> > > > make[1]: Leaving directory `/usr/tmp/portage/autofs-5.0.0_beta1/wor=
k/autofs-5.0.0_beta1/daemon'
> > >=20
> > > I'm not sure this will make a difference but could you give it a try.
> >=20
> > This didn't help.
> >=20
>=20
> This fixes it.
>=20
> diff --git a/daemon/direct.c b/daemon/direct.c
> index 96f934f..66d2efa 100644
> --- a/daemon/direct.c
> +++ b/daemon/direct.c
> @@ -953,6 +953,7 @@ int handle_packet_expire_direct(struct a
>  		free(mt);
>  		send_fail(mt->ioctlfd, pkt->wait_queue_token);
>  		status =3D 1;
> +		goto done;
>  	}
> =20
>  	pthread_cleanup_push(pending_cleanup, mt);
> @@ -965,9 +966,12 @@ int handle_packet_expire_direct(struct a
>  	}
> =20
>  	pthread_cleanup_pop(1);
> -done:
>  	pthread_cleanup_pop(1);
>  	return status;
> +
> +done:
> +	cache_lock_cleanup(mc);
> +	return status;
>  }
> =20
>  static void *do_mount_direct(void *arg)
> @@ -1256,8 +1260,11 @@ int handle_packet_missing_direct(struct=20
>  	}
> =20
>  	pthread_cleanup_pop(1);
> -done:
>  	pthread_cleanup_pop(1);
>  	return status;
> +
> +done:
> +	cache_lock_cleanup(mc);
> +	return status;
>  }
> =20
>=20

Thanks, that solved it.

Moshe

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEWjm9kBjmVsKMBeMRAiwtAKCI8IaimumZ0UqZKNxBd7q0aIjZMACfVywt
jWHP5+3KU5R76e08mkNGAfw=
=ZM1G
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--


--===============5618641287209314899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5618641287209314899==--

