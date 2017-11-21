From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Tue, 21 Nov 2017 12:53:17 +1100
Message-ID: <874lpo2y9e.fsf@notabene.neil.brown.name>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net> <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, May 10 2017, Ian Kent wrote:

> The fstatat(2) and statx() calls can pass the flag AT_NO_AUTOMOUNT
> which is meant to clear the LOOKUP_AUTOMOUNT flag and prevent triggering
> of an automount by the call. But this flag is unconditionally cleared
> for all stat family system calls except statx().
>
> stat family system calls have always triggered mount requests for the
> negative dentry case in follow_automount() which is intended but prevents
> the fstatat(2) and statx() AT_NO_AUTOMOUNT case from being handled.
>
> In order to handle the AT_NO_AUTOMOUNT for both system calls the
> negative dentry case in follow_automount() needs to be changed to
> return ENOENT when the LOOKUP_AUTOMOUNT flag is clear (and the other
> required flags are clear).
>
> AFAICT this change doesn't have any noticable side effects and may,
> in some use cases (although I didn't see it in testing) prevent
> unnecessary callbacks to the automount daemon.

Actually, this patch does have a noticeable side effect.

Previously, if /home were an indirect mount point so that /home/neilb
would mount my home directory, "ls -l /home/neilb" would always work.
Now it doesn't.

This happens because "ls" calls 'lstat' on the path and when that fails
with "ENOENT", it doesn't bother trying to open.

An alternate approach to the problem that this patch addresses is to
*not* change follow_automount() but instead change the automount daemon
and possibly autofs.

When a notification of access for an indirect mount point is received,
it would firstly just create the directory - not triggering a mount.
If another notification is then received (after the directory has been
created), it then triggers the mount.

I suspect this might need changes to autofs to avoid races when two
threads call lstat() on the same path at the same time.  We would need
to ensure that automount didn't see this as two requests.... though
maybe it already has enough locking.

Does that seem reasonable?  Should we revert this patch (as a
regression) and do something in automount instead?

Thanks,
NeilBrown


>
> It's also possible that a stat family call has been made with a
> path that is in the process of being mounted by some other process.
> But stat family calls should return the automount state of the path
> as it is "now" so it shouldn't wait for mount completion.
>
> This is the same semantic as the positive dentry case already
> handled.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Colin Walters <walters@redhat.com>
> Cc: Ondrej Holy <oholy@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/namei.c         |   15 ++++++++++++---
>  include/linux/fs.h |    3 +--
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 7286f87..cd74838 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1129,9 +1129,18 @@ static int follow_automount(struct path *path, str=
uct nameidata *nd,
>  	 * of the daemon to instantiate them before they can be used.
>  	 */
>  	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
> -			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
> -	    path->dentry->d_inode)
> -		return -EISDIR;
> +			   LOOKUP_OPEN | LOOKUP_CREATE |
> +			   LOOKUP_AUTOMOUNT))) {
> +		/* Positive dentry that isn't meant to trigger an
> +		 * automount, EISDIR will allow it to be used,
> +		 * otherwise there's no mount here "now" so return
> +		 * ENOENT.
> +		 */
> +		if (path->dentry->d_inode)
> +			return -EISDIR;
> +		else
> +			return -ENOENT;
> +	}
>=20=20
>  	if (path->dentry->d_sb->s_user_ns !=3D &init_user_ns)
>  		return -EACCES;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 26488b4..be09684 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2935,8 +2935,7 @@ static inline int vfs_lstat(const char __user *name=
, struct kstat *stat)
>  static inline int vfs_fstatat(int dfd, const char __user *filename,
>  			      struct kstat *stat, int flags)
>  {
> -	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
> -			 stat, STATX_BASIC_STATS);
> +	return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
>  }
>  static inline int vfs_fstat(int fd, struct kstat *stat)
>  {

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAloThw0ACgkQOeye3VZi
gblI7Q//Uj4t/jG6SGFcCz8pFNI7q4XRS9TyWKTSZDx71efn4BYEip5hwf4bWkNb
LxyuoJWAo47c9i0q0eXp1nw8nJuXK0L4hRdE+CUntM7a28H0gFkiPzGpfpt3Ga7b
t3MS5gGwrLo+kzjAeHKJB4T4lrELFBJaV8rTqlpuQz3qB/DvVY2JyA00lKodti9D
RRWZNwhS/UqI1yk6JgikCXYAUB7+BsBh019OL7/MPmQZQsxbkfCcaRcxJ2TsWviP
aB3u+Bw3Pqit3kFp1JYq1nk8pVdSSfHIXEcujDJOjYuZ75g7DSEKCk1sDV/R++tg
5s5lKB4hy3Z/uedA9UIRsdPxWmLfthAVWOo7T/X2TrC23+ET0cnZG/ZEbsVAhu4h
NYtXPJoA107MMCp9R9WwAlLfyIQdkxTk5XEAu++d+iyHOiDMsJQnJ9FgrWoX+kWd
YXWSLJb/vIa1P18DDgq8F0Glfh4w1J8q/HvEZjSYe+AXcb8cMzt66EUsnUPCTej4
stYogTJjENMkZVPjYRBeoFCQ+PEeG/25wVlqzr6CJYGx4U45bwMei3TdN8Z2MR7A
23dBCUF9xkMbTVSzWwpV0NBtgaBjJFfmjfW85b+EkZ3xqU0xQ8G4pf2UhRIIOTDt
I0wK83/LUl509ZXzi9F4uH1avCU1mmwLqBcn8aU1CW2e7pd0rH8=
=L8iZ
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
