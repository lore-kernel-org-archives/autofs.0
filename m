From: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
Date: Wed, 24 Sep 2003 15:09:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1064408962.5074.2.camel@laptop.fenrus.com>
References: <Pine.LNX.4.44.0309242059120.4975-100000@raven.themaw.net>
Reply-To: arjanv@redhat.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q+31+NTK/aqQ7VVAJFPi"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309242059120.4975-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>


--=-Q+31+NTK/aqQ7VVAJFPi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-24 at 15:01, Ian Kent wrote:
> This is a corrected patch for the autofs4 daedlock problem I posted about=
=20
> @@ -206,6 +207,11 @@
> =20
>  		interruptible_sleep_on(&wq->queue);
> =20
> +		if (waitqueue_active(&wq->queue) && current !=3D wq->owner) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule_timeout(wq->wait_ctr * (HZ/10));
> +		}
> +

this really really looks like you're trying to pamper over a bug by
changing the timing somewhere instead of fixing it...

also are you sure the deadlock isn't because of the racey use of
interruptible_sleep_on ?

--=-Q+31+NTK/aqQ7VVAJFPi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/cZeCxULwo51rQBIRAkDHAJ4qCLI7pnWgAclLCYY1SGcdAW8pigCgjSCT
G07Mo5b63x517h+48RMPTjw=
=kfzT
-----END PGP SIGNATURE-----

--=-Q+31+NTK/aqQ7VVAJFPi--
