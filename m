From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH] autofs: fix contained_in_local_fs and improve scalability
Date: Sat, 19 Mar 2016 16:58:17 -0400
Message-ID: <56EDBD69.3020903@suse.com>
References: <56EC6897.7040409@suse.com> <56EC7267.6000103@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GtQQC4jBj3sX8h76etRl8gMbN5bN27VaM"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <56EC7267.6000103@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GtQQC4jBj3sX8h76etRl8gMbN5bN27VaM
Content-Type: multipart/mixed; boundary="Qob6V9BECm18wWC7wLsI8SI5bA9NcjTXn"
From: Jeff Mahoney <jeffm@suse.com>
To: autofs@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>
Message-ID: <56EDBD69.3020903@suse.com>
Subject: Re: [PATCH] autofs: fix contained_in_local_fs and improve scalability
References: <56EC6897.7040409@suse.com> <56EC7267.6000103@suse.com>
In-Reply-To: <56EC7267.6000103@suse.com>

--Qob6V9BECm18wWC7wLsI8SI5bA9NcjTXn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/18/16 5:25 PM, Jeff Mahoney wrote:
> Commit d3ce65e05d1 (autofs-5.0.3 - allow directory create on NFS root),=

> introduced a bug where contained_in_local_fs would *always* return true=
=2E=20
>=20
> Since the goal of contained_in_local_fs is only to determine if the
> path would be created on a local file system, it's enough to check a
> few things directly without parsing the mount table at all.
>=20
> We can check via stat calls:
> 1) If parent is the root directory
> 2) If the parent is located on the root file system
> 3) If the parent is located within a file system mounted
>    via a block device

This test will actually fail for btrfs, but I suppose that could be
special cased.

-Jeff

> Large numbers of direct mounts when using /proc/self/mounts instead
> of /etc/mtab result in very slow startup time.  In testing, we observed=

> ~8k mounts taking over 6 hours to complete.
>=20
> This is due to reading /proc/self/mounts for every path component of
> every mount.  For my test case, that turns out to be about 119k times
> for a total of just under 400 GB read.  If it were a flat file, it
> would be also be slow, but /proc/self/mounts is dynamically generated
> every time it's read.
>=20
> By avoiding reading /proc/self/mounts many times, startup time with 8k
> direct mounts drops from ~6 hours to about 25 seconds.
>=20
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  daemon/automount.c |   47 ++++++++++++++++++++++++++++++++++++++++++++=
---
>  include/mounts.h   |    1 -
>  lib/mounts.c       |   45 --------------------------------------------=
-
>  3 files changed, 44 insertions(+), 49 deletions(-)
>=20
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -98,6 +98,46 @@ static int umount_all(struct autofs_poin
> =20
>  extern struct master *master_list;
> =20
> +#define SYSFS_PATTERN "/sys/dev/block/%d:%d"
> +static int contained_in_local_fs(const char *parent)
> +{
> +	char buf[128];
> +	struct stat st, root;
> +	int ret;
> +
> +	/* The root directory is always considered local, even if it's not. *=
/
> +	if (!*parent)
> +		return 1;
> +
> +	ret =3D stat("/", &root);
> +	if (ret !=3D 0) {
> +		logerr("error: stat failed on /: %s", strerror(errno));
> +		return 0;
> +	}
> +
> +	ret =3D stat(parent, &st);
> +	if (ret)
> +		return 0;
> +	/*
> +	 * If the parent is on the root file system, it's local.
> +	 */
> +	if (root.st_dev =3D=3D st.st_dev)
> +		return 1;
> +
> +	/*
> +	 * If the sysfs node for the block device exists, it's local.
> +	 */
> +	ret =3D snprintf(buf, sizeof(buf), SYSFS_PATTERN,
> +		       major(st.st_dev), minor(st.st_dev));
> +	if (ret !=3D 0) {
> +		logerr("error: not enough space for sysfs path");
> +		return 0;
> +	}
> +
> +	ret =3D stat(buf, &st);
> +	return (ret =3D=3D 0);
> +}
> +
>  static int do_mkdir(const char *parent, const char *path, mode_t mode)=

>  {
>  	int status;
> @@ -114,14 +154,15 @@ static int do_mkdir(const char *parent,
>  	}
> =20
>  	/*
> -	 * If we're trying to create a directory within an autofs fs
> -	 * or the path is contained in a localy mounted fs go ahead.
> +	 * If we're trying to create a directory within an autofs fs,
> +	 * the parent is the root directory, or the path is contained
> +	 * in a locally mounted fs go ahead.
>  	 */
>  	status =3D -1;
>  	if (*parent)
>  		status =3D statfs(parent, &fs);
>  	if ((status !=3D -1 && fs.f_type =3D=3D (__SWORD_TYPE) AUTOFS_SUPER_M=
AGIC) ||
> -	    contained_in_local_fs(path)) {
> +	    contained_in_local_fs(parent)) {
>  		mode_t mask =3D umask(0022);
>  		int ret =3D mkdir(path, mode);
>  		(void) umask(mask);
> --- a/include/mounts.h
> +++ b/include/mounts.h
> @@ -96,7 +96,6 @@ char *make_mnt_name_string(char *path);
>  struct mnt_list *get_mnt_list(const char *table, const char *path, int=
 include);
>  struct mnt_list *reverse_mnt_list(struct mnt_list *list);
>  void free_mnt_list(struct mnt_list *list);
> -int contained_in_local_fs(const char *path);
>  int is_mounted(const char *table, const char *path, unsigned int type)=
;
>  int has_fstab_option(const char *opt);
>  char *get_offset(const char *prefix, char *offset,
> --- a/lib/mounts.c
> +++ b/lib/mounts.c
> @@ -636,51 +636,6 @@ void free_mnt_list(struct mnt_list *list
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


--Qob6V9BECm18wWC7wLsI8SI5bA9NcjTXn--

--GtQQC4jBj3sX8h76etRl8gMbN5bN27VaM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJW7b1tAAoJEB57S2MheeWyQxUQALOuRhAtbqb7s5XzEZsKtXMk
Abqn1t7UqfOyCRUCHTznbGRJ1ryE+G5ENtDrUpT4eO7QPLf1RNHzaOp/XwGL1bMd
PXjF2NhNwaLF4KRSuTeYM2HbBXvF6MUNSLoNqZFplxp7AHRB5Hi6AY6f/cD0z8k1
clYe22YF0we4m+vShIK+2WO4C5QpBCaHlPBp5bH796wCGFWd5khTmD+R3x4NSKfn
du+2rczE6qoiUyG8Teomq2lgOcs0qgGr/7Tl0m3Wjz9lWK0ZMXg+mTscsEP+5Trx
mxwnO02JMphI5dbm8NjtP6TTsWgldbrILGtWv/28+5kdGsexd3Gsc4QivIJR7A9U
SE5ecEMRvuL1PunvGZUt3+fgEefDt7XPVdvQBRLkDAa7eGBC3k2CxW6UVsB2Vl3A
mqJOyAZguLCzxH/KYgr4TdHagKr90vCCwo5xU6c8gchtlrD4Z/Bqg5njXoiNUly8
kWNxfxaxHe6FCCQo4O4OOMtuEOn2L2cr12jQmQaWHBMfkCE5gX57HnwlpmvRp/Q8
nuvoS0AOTi//rD2TMOdEkf4YUwO9Cr3sMhBRqidor8BEnWNk6SnxIcZBJlUtb1sL
/CZbVRCwVploLPdzUJD+uo/YZUaMpGadGzycoJfGfoifAe8fjOn1Su59CiIMbk6j
ERjuS3SXtlULFHc0bJEu
=XNCz
-----END PGP SIGNATURE-----

--GtQQC4jBj3sX8h76etRl8gMbN5bN27VaM--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
