From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH] autofs: Add BUG_ON(1) for non dir/link inode case
Date: Sun, 3 Jul 2016 18:51:44 -0400
Message-ID: <ad28e0a0-f0b3-1934-1ef9-081c593700d0@suse.com>
References: <1467541782-1676-1-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BemcuQEHAHWJxBxVoE7oMCRJvttxGhRTB"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1467541782-1676-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, raven@themaw.net
Cc: autofs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BemcuQEHAHWJxBxVoE7oMCRJvttxGhRTB
Content-Type: multipart/mixed; boundary="GSfmxvc9aO0ogsVvJn1m193iNOAM3iSoU"
From: Jeff Mahoney <jeffm@suse.com>
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, raven@themaw.net
Cc: autofs@vger.kernel.org
Message-ID: <ad28e0a0-f0b3-1934-1ef9-081c593700d0@suse.com>
Subject: Re: [PATCH] autofs: Add BUG_ON(1) for non dir/link inode case
References: <1467541782-1676-1-git-send-email-kusumi.tomohiro@gmail.com>
In-Reply-To: <1467541782-1676-1-git-send-email-kusumi.tomohiro@gmail.com>

--GSfmxvc9aO0ogsVvJn1m193iNOAM3iSoU
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 7/3/16 6:29 AM, Tomohiro Kusumi wrote:
> It's invalid if the given mode is neither dir nor link,
> so don't let it fallthrough on else case.

Is this case really worth crashing the entire system?

Wouldn't a WARN_ON + return -EINVAL be sufficient?  At the very least it
means that a developer doesn't need to reboot to reload the module if
they hit this.

-Jeff

> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  fs/autofs4/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> index ad0ee93..7f35c82 100644
> --- a/fs/autofs4/inode.c
> +++ b/fs/autofs4/inode.c
> @@ -305,6 +305,7 @@ int autofs4_fill_super(struct super_block *s, void =
*data, int silent)
>  	if (autofs_type_trigger(sbi->type))
>  		__managed_dentry_set_managed(root);
> =20
> +	BUG_ON(!root_inode->i_fop || !root_inode->i_op);
>  	root_inode->i_fop =3D &autofs4_root_operations;
>  	root_inode->i_op =3D &autofs4_dir_inode_operations;
> =20
> @@ -368,7 +369,8 @@ struct inode *autofs4_get_inode(struct super_block =
*sb, umode_t mode)
>  		inode->i_fop =3D &autofs4_dir_operations;
>  	} else if (S_ISLNK(mode)) {
>  		inode->i_op =3D &autofs4_symlink_inode_operations;
> -	}
> +	} else
> +		BUG_ON(1);
> =20
>  	return inode;
>  }
>=20


--=20
Jeff Mahoney
SUSE Labs


--GSfmxvc9aO0ogsVvJn1m193iNOAM3iSoU--

--BemcuQEHAHWJxBxVoE7oMCRJvttxGhRTB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJXeZcGAAoJEB57S2MheeWyBmMQAL2Kpe70sZCJVASfFSiJd7jX
mdhJnTq1pYX5jIA65x6XNiw+xKsiGPnFkus3ABGfkPQiEPkSYweXvCJjxWAZRKn+
cussW9WjhV0GW8rdsvqQ/GATCBVYUNNFszpFpxH1ylrw9zdMCLHKkUbSwMTZlgLb
IqQEmsxtLCpKhtIxrHtJQRy02mhwPa35Zz1jyib72Ujpoxo0CGw6nrgA9bpPYofT
KbG/w03wJ5Zz4TQ16qcOhRIcpFGq3amYPz8AzvgoyiP86egHUJPsqqTJvFoJR9ea
0F5qk8Uhh+bEtOu3usqDervXSOLPCGr5mI+Uzlx41ylHbrXJ6vH438g2+3LO34e8
clE1Ly2GIQIpxK1Zbn6bye5cM+O4EX8PrQ53M7oiXiF+TSz0gKzn9sB+FVsjoq5V
SfkyXzbB23gFB0JjMgelCkOdzp/wyU3LFkvd9WqZcfDjEy1loGGh+PYQto+PW9Q7
s0deRo7ZCqd9mGzUaw+jd+GOGVH5r3QQGogM8PfpyYM5oQt47Xf4U/1aY0xfpcdb
MZUp+h9s9MCFyojff9lJ1uckIQATAstv15Hi9B0mtkZ9CJ+VzkMpSjhjcuE1IpCu
VAzCEPNnBONqjyXbhdTAjXhnoIA/HKAGSmogY2bkZ0KQ6iIi2lBC6HF1y0eqdYc7
LV5tSjS79YUN87BlSpJG
=2GUc
-----END PGP SIGNATURE-----

--BemcuQEHAHWJxBxVoE7oMCRJvttxGhRTB--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
