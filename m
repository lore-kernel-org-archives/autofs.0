From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH] autofs-5.1.3 - fix ordering of seteuid/setegid in
 do_spawn
Date: Wed, 18 Oct 2017 17:07:34 -0400
Message-ID: <d37ba465-6d83-b71b-e94a-cf473d213913@suse.com>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net>
 <cf4f19a9-cbf4-2077-a26a-922268c80507@suse.com>
 <28261d95-ead4-3566-d035-624cdbdafbbe@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XOFvTL6ItcOjL2SM30x9aOTKHj9k2KC95"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <28261d95-ead4-3566-d035-624cdbdafbbe@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XOFvTL6ItcOjL2SM30x9aOTKHj9k2KC95
Content-Type: multipart/mixed; boundary="13g173BfV619InskSJoCSFJte0E3EkkXA";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>
Message-ID: <d37ba465-6d83-b71b-e94a-cf473d213913@suse.com>
Subject: Re: [PATCH] autofs-5.1.3 - fix ordering of seteuid/setegid in
 do_spawn
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net>
 <cf4f19a9-cbf4-2077-a26a-922268c80507@suse.com>
 <28261d95-ead4-3566-d035-624cdbdafbbe@suse.com>
In-Reply-To: <28261d95-ead4-3566-d035-624cdbdafbbe@suse.com>

--13g173BfV619InskSJoCSFJte0E3EkkXA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/18/17 4:57 PM, Jeff Mahoney wrote:
> In do_spawn, We call seteuid() prior to calling setegid() which means
> that, when we're using an unprivileged uid, we won't have permissions
> to set the effective group anymore.
>=20
> We also don't touch the group memberships so the permissions used to
> open the directory will will include all of root's supplementary groups=

> and none of the user's.
>=20
> This patch reverses the ordering and uses initgroups() to reset the
> supplementary groups to the unprivileged user's groups.
>=20
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  daemon/spawn.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/daemon/spawn.c b/daemon/spawn.c
> index c640d97..62e9f02 100644
> --- a/daemon/spawn.c
> +++ b/daemon/spawn.c
> @@ -20,6 +20,7 @@
>  #include <string.h>
>  #include <sys/types.h>
>  #include <dirent.h>
> +#include <grp.h>
>  #include <time.h>
>  #include <poll.h>
>  #include <sys/wait.h>

Whoops:

> @@ -195,8 +196,18 @@ static int do_spawn(unsigned logopt, unsigned int =
wait,
>  			 * program group to trigger mount
>  			 */
>  			if (euid) {
> -				seteuid(euid);
> -				setegid(egid);
> +				if (initgroups(rsv->user, egid) =3D=3D -1)
					       tsv->user

> +					fprintf(stderr,
> +						"warning: initgroups: %s\n",
> +						strerror(errno));
> +				if (setegid(egid) =3D=3D -1)
> +					fprintf(stderr,
> +						"warning: setegid: %s\n",
> +						strerror(errno));
> +				if (seteuid(euid) =3D=3D -1)
> +					fprintf(stderr,
> +						"warning: seteuid: %s\n",
> +						strerror(errno));
>  			}
>  			setpgrp();
> =20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
>=20


--=20
Jeff Mahoney
SUSE Labs


--13g173BfV619InskSJoCSFJte0E3EkkXA--

--XOFvTL6ItcOjL2SM30x9aOTKHj9k2KC95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2

iQIVAwUBWefClh57S2MheeWyAQiAVg//ZBNW0ceHNY/2d4XPL5hMa5Gxqzu+t6wz
ZhqIO15BYD2nCDjZ/QL0Fs9BGfZbVLM7o7+dkUL+WFwwS5HVCF4kdZ9778gyGljX
Sjs94J1bN484RetdewjzCzjQM1b0KdItx3fZUOlCGFj5kyaacDaTM3Rk3rMDLfi7
WyBnksVAqkduDQGxcpqCvHHMIpdD43bf70DjxNB4g6Y3zrh+jAS2wuqVMh/QKPFe
iku+x6efo9hz5zeyk633w7PPzFet2RUncrQJPl7gh9Q3hOzIYGdj7arjHDzaymIW
jceDa9aETZi7BAH46dDydA7a67BlvUN0E1RARvyKB9ro261NuxJlTClFsaB3Smgq
a3TqHpKpQ/sVuFw2Clnp2nDF8TBSbTMxYoyoJIz2b2Phr2mjYTm/lSEMD4yYC0sC
oePaGfcJR7UuXVGSztTGyMUMqHjSMeb2mc1vOQbxn/MpZPf2bMHUlCnI7uaMfOGO
Crv0mEDup2fjc5iq+mwGXjnnVVby0nXVPVuIWDB067L95ITAAHpXF59ZKw94nZTE
4yty65JwTtq3P5VZtwEKW5Yt2DhsPhJrhhs0KItG5kTUL3QVE6S1qAQ2HM53ZNvO
dbGmHtwuvhDAH6dDLcWWfJIFO8tubHG3U7BNSA89oRyTUicjg63XNppdCYBNfAvN
1OpISwMKjp0=
=nvzK
-----END PGP SIGNATURE-----

--XOFvTL6ItcOjL2SM30x9aOTKHj9k2KC95--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
