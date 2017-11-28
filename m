From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 1/2] autofs: revert take more care to not update last_used on path walk
Date: Wed, 29 Nov 2017 09:48:09 +1100
Message-ID: <87d142xbo6.fsf@notabene.neil.brown.name>
References: <151174729420.6162.1832622523537052460.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151174729420.6162.1832622523537052460.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27 2017, Ian Kent wrote:

> While the patch of commit 092a53452b helped (partially) resolve a
> problem where automounts were not expiring due to aggressive accesses
> from user space it has a side effect for very large environments.
>
> This change helps with the expire problem by making the expire more
> aggressive but, for very large environments, that means more mount
> requests from clients. When there are a lot of clients that can mean
> fairly significant server load increases.
>
> It turns out I put the last_used in this position to solve this
> very problem and failed to update my own thinking of the autofs
> expire policy. So the patch being reverted introduces a regression
> which should be fixed.
>
> Reverts: 092a53452b

I would add:
 Fixes: 092a53452bb7 ("autofs: take more care to not update last_used on pa=
th walk")
 Cc: stable@vger.kernel.org (v4.11+)

to ensure these are picked up as needed (different Fixes line for second
of course).

Reviewed-by: NeilBrown <neilb@suse.com>

Thanks,
NeilBrown

>
> Signed-off-by: Ian Kent <raven@themaw.net>
> Cc: Neil Brown <neilb@suse.com>
> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> ---
>  fs/autofs4/root.c |   17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index d79ced925861..82e8f6edfb48 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -281,8 +281,8 @@ static int autofs4_mount_wait(const struct path *path=
, bool rcu_walk)
>  		pr_debug("waiting for mount name=3D%pd\n", path->dentry);
>  		status =3D autofs4_wait(sbi, path, NFY_MOUNT);
>  		pr_debug("mount wait done status=3D%d\n", status);
> -		ino->last_used =3D jiffies;
>  	}
> +	ino->last_used =3D jiffies;
>  	return status;
>  }
>=20=20
> @@ -321,21 +321,16 @@ static struct dentry *autofs4_mountpoint_changed(st=
ruct path *path)
>  	 */
>  	if (autofs_type_indirect(sbi->type) && d_unhashed(dentry)) {
>  		struct dentry *parent =3D dentry->d_parent;
> +		struct autofs_info *ino;
>  		struct dentry *new;
>=20=20
>  		new =3D d_lookup(parent, &dentry->d_name);
>  		if (!new)
>  			return NULL;
> -		if (new =3D=3D dentry)
> -			dput(new);
> -		else {
> -			struct autofs_info *ino;
> -
> -			ino =3D autofs4_dentry_ino(new);
> -			ino->last_used =3D jiffies;
> -			dput(path->dentry);
> -			path->dentry =3D new;
> -		}
> +		ino =3D autofs4_dentry_ino(new);
> +		ino->last_used =3D jiffies;
> +		dput(path->dentry);
> +		path->dentry =3D new;
>  	}
>  	return path->dentry;
>  }

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlod56kACgkQOeye3VZi
gbm8EQ/+IdtQN4t0rIcqHqIF9btEA6vKXcM/ByGmVYaEel93akVBupBSKsjTemJk
osDyP1vPCRXyeHlZ1wCKxeM9MPic+dWgUDhK1HJaF4umbpNsXgLqSTd6j1zyUvvi
DzMamwxPVfy3u/hsvAxOOim6ZxcpnAZdnnm9XUDaog5/nSOlNWCD+AghtRkBXeOx
f15O3aBHooqrfEwnzprTZNUcF+akCcV9k/StEo1GvUIS72KWRvbti514RIKdbYEU
JP3eLyr4bOBw8iHle/raOfbSGhyS3zzoVMUsfyGYc4V3QCysE/NJt0snc5oYSo/4
agdJVbNMga/6yb9JbDteLwRfz5IB98FIibd9h0kMYq3PoVfyxusvTn1GC05Me6CW
xcV2HW+gvn3SUwtFa/dSZCT6NKBCLv0dFYBvD9sdRyHzZoII+u3L11Nx7A2j27ss
37GzAD6KrqVgNKQFjj/83KbfjkT0isb+37bNYI92ViXCq3d8KIX0zBSesEc/hA3Z
d75Yk6gFMqxNiR0VFsMk58dl7gTaxnwPd2gXMKplgp7718WUXia1zfciVR4Uc0DV
eS7iD9bdx2+sd7SibQqpWS1vhhbCO/DHZOUGXMwE2GtSRGjm4RS9jl5WHcCJ5+FN
RgnPXIOlGqjQrLNA9jqv1W7VGT9fpW5oWqKaT5f+DIKS3xBYb9Q=
=um4t
-----END PGP SIGNATURE-----
--=-=-=--
