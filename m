From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH] autofs - use dentry flags to block walks during expire
Date: Fri, 09 Sep 2016 11:39:00 +1000
Message-ID: <87vay57sy3.fsf@notabene.neil.brown.name>
References: <20160901012114.6476.57874.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20160901012114.6476.57874.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01 2016, Ian Kent wrote:

> Somewhere along the way the autofs expire operation has changed to
> hold a spin lock over expired dentry selection. The autofs indirect
> mount expired dentry selection is complicated and quite lengthy so
> it isn't appropriate to hold a spin lock over the operation.
>
> Commit 47be6184 added a might_sleep() to dput() causing a BUG()
> about this usage to be issued.
>
> But the spin lock doesn't need to be held over this check, the
> autofs dentry info. flags are enough to block walks into dentrys
> during the expire.
>
> I've left the direct mount expire as it is (for now) becuase it
> is much simpler and quicker than the indirect mount expire and
> adding spin lock release and re-aquires would do nothing more
> than add overhead.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/autofs4/expire.c |   55 +++++++++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 42 insertions(+), 13 deletions(-)
>
> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> index b493909..2d8e176 100644
> --- a/fs/autofs4/expire.c
> +++ b/fs/autofs4/expire.c
> @@ -417,6 +417,7 @@ static struct dentry *should_expire(struct dentry *de=
ntry,
>  	}
>  	return NULL;
>  }
> +
>  /*
>   * Find an eligible tree to time-out
>   * A tree is eligible if :-
> @@ -432,6 +433,7 @@ struct dentry *autofs4_expire_indirect(struct super_b=
lock *sb,
>  	struct dentry *root =3D sb->s_root;
>  	struct dentry *dentry;
>  	struct dentry *expired;
> +	struct dentry *found;
>  	struct autofs_info *ino;
>=20=20
>  	if (!root)
> @@ -442,31 +444,46 @@ struct dentry *autofs4_expire_indirect(struct super=
_block *sb,
>=20=20
>  	dentry =3D NULL;
>  	while ((dentry =3D get_next_positive_subdir(dentry, root))) {
> +		int flags =3D how;
> +
>  		spin_lock(&sbi->fs_lock);
>  		ino =3D autofs4_dentry_ino(dentry);
> -		if (ino->flags & AUTOFS_INF_WANT_EXPIRE)
> -			expired =3D NULL;
> -		else
> -			expired =3D should_expire(dentry, mnt, timeout, how);
> -		if (!expired) {
> +		if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
>  			spin_unlock(&sbi->fs_lock);
>  			continue;
>  		}
> +		spin_unlock(&sbi->fs_lock);
> +
> +		expired =3D should_expire(dentry, mnt, timeout, flags);
> +		if (!expired)
> +			continue;
> +
> +		spin_lock(&sbi->fs_lock);
>  		ino =3D autofs4_dentry_ino(expired);
>  		ino->flags |=3D AUTOFS_INF_WANT_EXPIRE;
>  		spin_unlock(&sbi->fs_lock);
>  		synchronize_rcu();
> -		spin_lock(&sbi->fs_lock);
> -		if (should_expire(expired, mnt, timeout, how)) {
> -			if (expired !=3D dentry)
> -				dput(dentry);
> -			goto found;
> -		}
>=20=20
> +		/* Make sure a reference is not taken on found if
> +		 * things have changed.
> +		 */
> +		flags &=3D ~AUTOFS_EXP_LEAVES;
> +		found =3D should_expire(expired, mnt, timeout, how);
> +		if (!found || found !=3D expired)
> +			/* Something has changed, continue */
> +			goto next;
> +
> +		if (expired !=3D dentry)
> +			dput(dentry);
> +
> +		spin_lock(&sbi->fs_lock);
> +		goto found;
> +next:
> +		spin_lock(&sbi->fs_lock);
>  		ino->flags &=3D ~AUTOFS_INF_WANT_EXPIRE;
> +		spin_unlock(&sbi->fs_lock);
>  		if (expired !=3D dentry)
>  			dput(expired);
> -		spin_unlock(&sbi->fs_lock);
>  	}
>  	return NULL;
>=20=20
> @@ -483,6 +500,7 @@ int autofs4_expire_wait(struct dentry *dentry, int rc=
u_walk)
>  	struct autofs_sb_info *sbi =3D autofs4_sbi(dentry->d_sb);
>  	struct autofs_info *ino =3D autofs4_dentry_ino(dentry);
>  	int status;
> +	int state;
>=20=20
>  	/* Block on any pending expire */
>  	if (!(ino->flags & AUTOFS_INF_WANT_EXPIRE))
> @@ -490,8 +508,19 @@ int autofs4_expire_wait(struct dentry *dentry, int r=
cu_walk)
>  	if (rcu_walk)
>  		return -ECHILD;
>=20=20
> +retry:
>  	spin_lock(&sbi->fs_lock);
> -	if (ino->flags & AUTOFS_INF_EXPIRING) {
> +	state =3D ino->flags & (AUTOFS_INF_WANT_EXPIRE | AUTOFS_INF_EXPIRING);
> +	if (state =3D=3D AUTOFS_INF_WANT_EXPIRE) {
> +		spin_unlock(&sbi->fs_lock);
> +		/*
> +		 * Possibly being selected for expire, wait until
> +		 * it's selected or not.
> +		 */
> +		schedule_timeout(HZ/10);

Hi Ian,

I think you want schedule_timeout_uninterruptible(HZ/10) here.
schedule_timeout() only causes a delay if the task state has been
changed from runnable.

There is a similar bug in fscache_object_sleep_till_congested().
Nothing changes the task state from TASK_RUNNING in that function
before it calls schedule_timeout(*timeoutp);

Also should this patch be marked as

Fixes: 47be61845c77 ("fs/dcache.c: avoid soft-lockup in dput()")

so it follows that patch in -stable backport?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX0hK0AAoJEDnsnt1WYoG55IgP/iDCRbDMO4tYZCY8tSkqWwRY
/vg0hPDw+YcQ4Cfx9XvZfhImXz83be+PLP1Jl5NsPu2eIm/fn8NLPwyDjaaJzaUN
4N3iDzgVgvT1rOrjiRmNFHuXzsT/Ui32zxAek5MaiAbyafgYXZEE3gO5/x//wIvs
3lm7zRvk1Yu0NsIUuZxOGCqh953lXuoHOE+hivKAAJtGvnzkLR4EJTqymY6lSX+n
g20Xlq3ST3Y8gz1UF6oarmHjzTRrFRSqMO9fCevzIpB3GTXjMkEJa0WBttIx3T1N
k2pQPNgB2bqVMi7KrnL4kWgqMNhsZ89s3FNjiBy1FizkWUb9fqV4kysOiIZ9VQL0
JdRhqKttyEiBWX7KOuzkCONujlCNV0DYtpywt+4pyi4L1CMedyp6xeNdES6xyI3s
nbRwunNnUwynrwSnZgr0v7RCO2DSO4xVQ7DGcpZ1/IgfUOkx94s2+jzDQJB6RXvX
0KkJ+Pd4V3Lrdfl1D6GfAjJ1e2vkcGJfYQEpGIsJ7D34pe740sXZ4F0YHO9DsMqM
iYdYVrXezWNvz//uwIpYYwveWKlRF/bxFZ/R7S6tGpvL+MMTrSGP/XE9TF51avLe
Vz2AVWqXFtzabGSJgxZUS/3He2OLy0qJWjcAvVkkxb/Ll4Gsv4apXRfiy2DOJ/AL
S9p0nCONtGO9vgfsr7zf
=tsA3
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
