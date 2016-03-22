From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH] autofs: improve scalability of direct mount path
 component creation
Date: Tue, 22 Mar 2016 10:38:37 -0400
Message-ID: <56F158ED.5070001@suse.com>
References: <56EC6897.7040409@suse.com> <56EC7267.6000103@suse.com>
 <1458531845.3042.36.camel@themaw.net> <56F070F6.7030802@suse.com>
 <1458606264.3014.20.camel@themaw.net> <56F0C11B.9000005@suse.com>
 <56F152FA.1000205@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JtavMm4IpT3E72vsSVX1PPeoOmK8OKTMn"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <56F152FA.1000205@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JtavMm4IpT3E72vsSVX1PPeoOmK8OKTMn
Content-Type: multipart/mixed; boundary="WxCVlbaaKjj0CjU5oXTftmD2jbLjpdB8C"
From: Jeff Mahoney <jeffm@suse.com>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org
Message-ID: <56F158ED.5070001@suse.com>
Subject: Re: [PATCH] autofs: improve scalability of direct mount path
 component creation
References: <56EC6897.7040409@suse.com> <56EC7267.6000103@suse.com>
 <1458531845.3042.36.camel@themaw.net> <56F070F6.7030802@suse.com>
 <1458606264.3014.20.camel@themaw.net> <56F0C11B.9000005@suse.com>
 <56F152FA.1000205@suse.com>
In-Reply-To: <56F152FA.1000205@suse.com>

--WxCVlbaaKjj0CjU5oXTftmD2jbLjpdB8C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/22/16 10:13 AM, Jeff Mahoney wrote:
> With direct mounts, we want to avoid creating path components on
> remote file systems unless that file system is the root file system.
>=20
> The check boils down to allowing the mkdir if:
> 1/ If it's the root directory, or
> 2/ If it's not a remote file system, or
> 3/ If it's a remote file system that's the root file system
>=20
> We can do that without parsing the mount table and can
> improve startup time for all cases.

I did test this in the expected scenarios:

- With an NFS (ch)root, direct mount on NFS root, created.
- With an NFS (ch)root, direct mount on NFS mount, did not create.
- With a local root, direct mount on root fs, created.
- With a local root, direct mount on another local fs, created.
- With a local root, direct mount on NFS, did not create.

-Jeff

> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  daemon/automount.c  | 56 +++++++++++++++++++++++++++++++++++++++------=
--------
>  include/automount.h |  2 ++
>  include/mounts.h    |  1 -
>  lib/mounts.c        | 45 ------------------------------------------
>  4 files changed, 44 insertions(+), 60 deletions(-)
>=20
> diff --git a/daemon/automount.c b/daemon/automount.c
> index 74e62a1..9d07425 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -98,10 +98,25 @@ static int umount_all(struct autofs_point *ap, int =
force);
> =20
>  extern struct master *master_list;
> =20
> +static int is_remote_fstype(unsigned int fs_type)
> +{
> +	int ret =3D 0;
> +	switch (fs_type) {
> +	case SMB_SUPER_MAGIC:
> +	case CIFS_MAGIC_NUMBER:
> +	case NCP_SUPER_MAGIC:
> +	case NFS_SUPER_MAGIC:
> +		ret =3D 1;
> +		break;
> +	};
> +	return ret;
> +}
> +
>  static int do_mkdir(const char *parent, const char *path, mode_t mode)=

>  {
>  	int status;
> -	struct stat st;
> +	mode_t mask;
> +	struct stat st, root;
>  	struct statfs fs;
> =20
>  	/* If path exists we're done */
> @@ -114,24 +129,37 @@ static int do_mkdir(const char *parent, const cha=
r *path, mode_t mode)
>  	}
> =20
>  	/*
> -	 * If we're trying to create a directory within an autofs fs
> -	 * or the path is contained in a localy mounted fs go ahead.
> +	 * We don't want to create the path on a remote file system
> +	 * unless it's the root file system.
> +	 * An empty parent means it's the root directory and always ok.
>  	 */
> -	status =3D -1;
> -	if (*parent)
> +	if (*parent) {
>  		status =3D statfs(parent, &fs);
> -	if ((status !=3D -1 && fs.f_type =3D=3D (__SWORD_TYPE) AUTOFS_SUPER_M=
AGIC) ||
> -	    contained_in_local_fs(path)) {
> -		mode_t mask =3D umask(0022);
> -		int ret =3D mkdir(path, mode);
> -		(void) umask(mask);
> -		if (ret =3D=3D -1) {
> -			errno =3D EACCES;
> -			return 0;
> +		if (status =3D=3D -1)
> +			goto fail;
> +
> +		if (is_remote_fstype(fs.f_type)) {
> +			status =3D stat(parent, &st);
> +			if (status =3D=3D -1)
> +				goto fail;
> +
> +			status =3D stat("/", &root);
> +			if (status =3D=3D -1)
> +				goto fail;
> +
> +			if (st.st_dev !=3D root.st_dev)
> +				goto fail;
>  		}
> -		return 1;
>  	}
> =20
> +	mask =3D umask(0022);
> +	status =3D mkdir(path, mode);
> +	(void) umask(mask);
> +	if (status =3D=3D -1)
> +		goto fail;
> +
> +	return 1;
> +fail:
>  	errno =3D EACCES;
>  	return 0;
>  }
> diff --git a/include/automount.h b/include/automount.h
> index 2cf0611..c0f5fbf 100644
> --- a/include/automount.h
> +++ b/include/automount.h
> @@ -75,6 +75,8 @@ int load_autofs4_module(void);
>  #define AUTOFS_SUPER_MAGIC 0x00000187L
>  #define SMB_SUPER_MAGIC    0x0000517BL
>  #define CIFS_MAGIC_NUMBER  0xFF534D42L
> +#define NCP_SUPER_MAGIC    0x0000564CL
> +#define NFS_SUPER_MAGIC    0x00006969L
> =20
>  /* This sould be enough for at least 20 host aliases */
>  #define HOST_ENT_BUF_SIZE	2048
> diff --git a/include/mounts.h b/include/mounts.h
> index cce646a..489025c 100644
> --- a/include/mounts.h
> +++ b/include/mounts.h
> @@ -101,7 +101,6 @@ int ext_mount_remove(struct list_head *, const char=
 *);
>  struct mnt_list *get_mnt_list(const char *table, const char *path, int=
 include);
>  struct mnt_list *reverse_mnt_list(struct mnt_list *list);
>  void free_mnt_list(struct mnt_list *list);
> -int contained_in_local_fs(const char *path);
>  int is_mounted(const char *table, const char *path, unsigned int type)=
;
>  int has_fstab_option(const char *opt);
>  void tree_free_mnt_tree(struct mnt_list *tree);
> diff --git a/lib/mounts.c b/lib/mounts.c
> index 455bdca..1d1b4da 100644
> --- a/lib/mounts.c
> +++ b/lib/mounts.c
> @@ -941,51 +941,6 @@ void free_mnt_list(struct mnt_list *list)
>  	}
>  }
> =20
> -int contained_in_local_fs(const char *path)
> -{
> -	struct mnt_list *mnts, *this;
> -	size_t pathlen =3D strlen(path);
> -	int ret;
> -
> -	if (!path || !pathlen || pathlen > PATH_MAX)
> -		return 0;
> -
> -	mnts =3D get_mnt_list(_PATH_MOUNTED, "/", 1);
> -	if (!mnts)
> -		return 0;
> -
> -	ret =3D 0;
> -
> -	for (this =3D mnts; this !=3D NULL; this =3D this->next) {
> -		size_t len =3D strlen(this->path);
> -
> -		if (!strncmp(path, this->path, len)) {
> -			if (len > 1 && pathlen > len && path[len] !=3D '/')
> -				continue;
> -			else if (len =3D=3D 1 && this->path[0] =3D=3D '/') {
> -				/*
> -				 * always return true on rootfs, we don't
> -				 * want to break diskless clients.
> -				 */
> -				ret =3D 1;
> -			} else if (this->fs_name[0] =3D=3D '/') {
> -				if (strlen(this->fs_name) > 1) {
> -					if (this->fs_name[1] !=3D '/')
> -						ret =3D 1;
> -				} else
> -					ret =3D 1;
> -			} else if (!strncmp("LABEL=3D", this->fs_name, 6) ||
> -				   !strncmp("UUID=3D", this->fs_name, 5))
> -				ret =3D 1;
> -			break;
> -		}
> -	}
> -
> -	free_mnt_list(mnts);
> -
> -	return ret;
> -}
> -
>  static int table_is_mounted(const char *table, const char *path, unsig=
ned int type)
>  {
>  	struct mntent *mnt;
>=20


--=20
Jeff Mahoney
SUSE Labs


--WxCVlbaaKjj0CjU5oXTftmD2jbLjpdB8C--

--JtavMm4IpT3E72vsSVX1PPeoOmK8OKTMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJW8Vj0AAoJEB57S2MheeWy4igP/jhiwjcmkjTJXLfOUy6R14pU
lqON8a80noecGVOS4IlqlWxSpEMLGS69qiKZAQFCZjT+jDXEtl5r15UwPBEpkb/9
lsTkuWeyuXd6cigq3TflSPXMCHBECx4kKHgo+7AEd2xEd1QOx2Bl16UoeG/Aku/h
Z8VQUFRcUM3kmB2KfwRuAsyH8kst8OlQP62vEnp+nAU2KdcUCEvr1tNjp4tq3C+W
/rfRkoOA2Ufle1gxmCxoazbjbzGKkLUhqItkG/35YOrAFG9Ul6gz1umrOg+mwtro
4I63cLdKf8iXxLjrryysqVLORP369YRjj/7cfduuZNZb/qT+QK4ib8TLMseR0N3I
ZO4S/+4JzH2dEgZ/xAYEaA8v4aa2k8dJNA95HH6cFdOiay+BZSCGRzri4B3Jdscb
byqOZYg5mXT0Wj/mKNBJjl+fFd+IA+Rz6e7aSJU347Ka7zv659tsZd5abLfCOTIN
tAqSi/Pbm/0Ed6/pbtLzHb5HwNnfsq3P7K7JGR2s4iW6cQJmWui4SmJfU2+yDQFl
uxTMjmoc2FOD3WBqGSBzH5gx0lw7tDD9dMovnHAktAqs31BpwJZDBE2N3hkOM20H
ia58m4d90Yg5LIqxZaGIZ9PDhx2voO6lca9V4LCgW4PL/twbCmRfBHUTnfz8rkDq
T6Edz6qa+xIFxeDA/dgX
=vnZf
-----END PGP SIGNATURE-----

--JtavMm4IpT3E72vsSVX1PPeoOmK8OKTMn--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
