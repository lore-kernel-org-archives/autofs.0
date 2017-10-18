From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH 12/35] autofs-5.1.3 - fix a couple of compiler warnings
Date: Wed, 18 Oct 2017 16:46:11 -0400
Message-ID: <cf4f19a9-cbf4-2077-a26a-922268c80507@suse.com>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7epRL6IJUf7LJk5VxQGwGu6dx9Baxwqow"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7epRL6IJUf7LJk5VxQGwGu6dx9Baxwqow
Content-Type: multipart/mixed; boundary="9JmJ4u5mRcEcoUIvcbdJUWaHsJB7Vb6T0";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>
Message-ID: <cf4f19a9-cbf4-2077-a26a-922268c80507@suse.com>
Subject: Re: [PATCH 12/35] autofs-5.1.3 - fix a couple of compiler warnings
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net>
In-Reply-To: <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net>

--9JmJ4u5mRcEcoUIvcbdJUWaHsJB7Vb6T0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/16/17 1:07 AM, Ian Kent wrote:
> Fix a few compiler warnings that have been around far too long.

Hi Ian -
> diff --git a/daemon/spawn.c b/daemon/spawn.c
> index 4515607b..b931d678 100644
> --- a/daemon/spawn.c
> +++ b/daemon/spawn.c
> @@ -195,8 +195,14 @@ static int do_spawn(unsigned logopt, unsigned int =
wait,
>  			 * program group to trigger mount
>  			 */
>  			if (euid) {
> -				seteuid(euid);
> -				setegid(egid);
> +				if (seteuid(euid) =3D=3D -1)
> +					fprintf(stderr,
> +						"warning: seteuid: %s\n",
> +						strerror(errno));
> +				if (setegid(egid) =3D=3D -1)
> +					fprintf(stderr,
> +						"warning: setegid: %s\n",
> +						strerror(errno));
>  			}
>  			setpgrp();


This one fixes the warning but there are a few issues with it, but none
of them are new.

1) We'll see that second warning *every* time since we just dropped root
privs and no longer have permission to change groups.  That's a bug
that's been lurking there for a while but now we're informed of it.

2) We're only changing the primary group and not the supplementary
groups, so the open is being performed with root's other group
membership (if any) and none of the user's other groups.

3) Do we really want to continue if we couldn't setuid?

I'll post a patch to address the first two as a reply to this post.
What's your take on point 3?

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--9JmJ4u5mRcEcoUIvcbdJUWaHsJB7Vb6T0--

--7epRL6IJUf7LJk5VxQGwGu6dx9Baxwqow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2

iQIVAwUBWee9lx57S2MheeWyAQh9fQ//Shv9ms94cz3tzjzdfoxXARqTjlng0zKi
AMuH5VwiAt0F53XD8OiJqXf9V7jXERHnL/BPRN6sixRUMsecRX8cg472PaDUvxA0
2BWevtz3JwQqM+aIJ2LMc7ZNJ+TN87Afe3qxyOKxGo+NXwEkJuNT6ty6ix/g5oPp
f9RHQYnLxPGhBuXkW3+JtCBQnPc1OyV0mESNPPtQ1t+GTHsqCqyIJMI4KVdRO80u
B5nFuyFT8vUfBzrwG/0+03nGs6l3ueHfPC0oWZzntVlWBpc2wzyEmnpnThZgY36F
SFotbKF2YYJhaJeEPvAsFJPfDDSdEN5tY6nX5W+unuyHMF6mQ7jJfYr7s5bdpXEb
DHmIVFumbt53BGMbOE5IJYl4WN+ytduamslwAg/x2Gfe+wEKCJmiQSXAheXIPozH
xob6vnoPZ/LVCcBoNuY+JTcWJCxkHc+rzj6v6mvK1D45aqmKnAfV+zVXq4cYIkj/
xpSr6rgCqMWN+sIpBXAYl1ujXExs98hiaeIeP/tG24AUVsVggblDTwpD1E8ITsPk
LnOjbigeuw8cRdPcNGicc2CmZjp4ZY1GvVHzUCAiaqvn4aTV4UhBT4tqbdHL65Wy
pPheGnUgi+Ga+D9SSTnLb0996Pgu81G7PmT1gPNSoJ3lC22d+juOAqpxgfyjYjcv
RYbgn7H6gho=
=J/YF
-----END PGP SIGNATURE-----

--7epRL6IJUf7LJk5VxQGwGu6dx9Baxwqow--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
