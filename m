From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than
 abusing follow_link()
Date: Thu, 13 Jan 2011 14:53:57 +1100
Message-ID: <AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
	<20110111174815.2291.41967.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1TQrPSGqTn+LHUbw3NIREws/fVWnn4yCEPtRWIlA/ko=;
        b=WRqlu4oReK0PvT9iZsorlR6fec+hLazr9Z1PsIl2fbQwFhrYqQK9UJKtA9uMZ4Cp9b
         9j6LzHUPx4TiTCf/YNdsgTmlnZWckou8+5en9mxTiS5MLIY4erFgbd3X+iqHZk8vemNe
         DcAuJRzBUhMgWuf30ARnBnlULaXvnP7u97MX4=
In-Reply-To: <20110111174815.2291.41967.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Howells <dhowells@redhat.com>
Cc: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2011 at 4:48 AM, David Howells <dhowells@redhat.com> wr=
ote:
> Add a dentry op (d_automount) to handle automounting directories rath=
er than
> abusing the follow_link() inode operation. =A0The operation is keyed =
off a new
> inode flag (S_AUTOMOUNT).
>
> This makes it easier to add an AT_ flag to suppress terminal segment =
automount
> during pathwalk. =A0It should also remove the need for the kludge cod=
e in the
> pathwalk algorithm to handle directories with follow_link() semantics=
=2E
>
> A new pathwalk subroutine, follow_automount() is added to handle moun=
tpoints.
> It will return -EREMOTE if the S_AUTOMOUNT was set, but no d_automoun=
t() op was
> supplied, -ELOOP if we've encountered too many symlinks or mountpoint=
s, -EISDIR
> if the walk point should be used without mounting and 0 if successful=
=2E =A0path
> will be updated if an automount took place to point to the mounted fi=
lesystem.
>
> I've only changed __follow_mount() to handle call follow_automount(),=
 but it
> might be necessary to change follow_mount() too. =A0The latter is onl=
y called
> from follow_dotdot(), but any automounts on ".." should be pinned whi=
lst we're
> using a child of it.
>
> I've also extracted the mount/don't-mount logic from autofs4 and incl=
uded it
> here. =A0It makes the mount go ahead anyway if someone calls open() o=
r creat(),
> tries to traverse the directory, tries to chdir/chroot/etc. into the =
directory,
> or sticks a '/' on the end of the pathname. =A0If they do a stat(), h=
owever,
> they'll only trigger the automount if they didn't also say O_NOFOLLOW=
=2E
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Ian Kent <raven@themaw.net>

I would still prefer to see a .follow_mount API, and not tie in this au=
tomount
specific inode detail to what could be a more flexible dentry-only API.

The default NULL implementation would do nothing, and follow_automount
stuff can be in fs/libfs.c to be used by filesystem, rather than fs/nam=
ei.c.

I would rather that the automount call just attach the mount and then g=
o
back to namei.c where it does the mount hash lookup.

That should take like a couple of lines in the path lookup code.


> =A0locking rules:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rename_lock =A0 =A0 ->d_lock =A0 =A0 =A0=
 =A0may block =A0 =A0 =A0 rcu-walk
> @@ -29,6 +30,7 @@ d_delete: =A0 =A0 no =A0 =A0 =A0 =A0 =A0 =A0 =A0yes=
 =A0 =A0 =A0 =A0 =A0 =A0 no =A0 =A0 =A0 =A0 =A0 =A0 =A0no
> =A0d_release: =A0 =A0 no =A0 =A0 =A0 =A0 =A0 =A0 =A0no =A0 =A0 =A0 =A0=
 =A0 =A0 =A0yes =A0 =A0 =A0 =A0 =A0 =A0 no
> =A0d_iput: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0no =A0 =A0 =A0 =A0 =A0 =A0 =
=A0no =A0 =A0 =A0 =A0 =A0 =A0 =A0yes =A0 =A0 =A0 =A0 =A0 =A0 no
> =A0d_dname: =A0 =A0 =A0 no =A0 =A0 =A0 =A0 =A0 =A0 =A0no =A0 =A0 =A0 =
=A0 =A0 =A0 =A0no =A0 =A0 =A0 =A0 =A0 =A0 =A0no
> +d_automount: =A0 no =A0 =A0 =A0 =A0 =A0 =A0 =A0no =A0 =A0 =A0 =A0 =A0=
 =A0 =A0no =A0 =A0 =A0 =A0 =A0 =A0 =A0yes

> +static void __follow_mount_rcu(struct nameidata *nd, struct path *pa=
th,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
inode **inode)
> +{
> + =A0 =A0 =A0 while (d_mountpoint(path->dentry)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct vfsmount *mounted;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mounted =3D __lookup_mnt(path->mnt, pat=
h->dentry, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mounted)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 path->mnt =3D mounted;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 path->dentry =3D mounted->mnt_root;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nd->seq =3D read_seqcount_begin(&path->=
dentry->d_seq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *inode =3D path->dentry->d_inode;
> + =A0 =A0 =A0 }
> +}

Where we have 2 functions, one with _rcu postfix, the _rcu version is u=
sed
for rcu-walk lookups, and the other one used for ref-walk lookups.

This means they have to provide the exact same functionality, or where
that isn't possible, the _rcu variant must return -ECHILD.

So something has gone wrong here. You have documented .d_automount
can be called in rcu-walk mode, but it doesn't seem to be the case. And=
 in
the _rcu variant you skip checking automount functionality entirely. So=
 at
least you'd have to check for d_automount_point and bail out if it exis=
ts. But
you need to be careful:


> +#define d_automount_point(dentry) \
> + =A0 =A0 =A0 (dentry->d_inode && IS_AUTOMOUNT(dentry->d_inode))

> @@ -277,6 +278,7 @@ struct inodes_stat_t {
> =A0#define IS_SWAPFILE(inode) =A0 =A0 ((inode)->i_flags & S_SWAPFILE)
> =A0#define IS_PRIVATE(inode) =A0 =A0 =A0((inode)->i_flags & S_PRIVATE=
)
> =A0#define IS_IMA(inode) =A0 =A0 =A0 =A0 =A0((inode)->i_flags & S_IMA=
)
> +#define IS_AUTOMOUNT(inode) =A0 =A0((inode)->i_flags & S_AUTOMOUNT)

This guy will oops in rcu-walk mode, because dentry->d_inode can go
NULL at any time.

If you do want to do this kind of thing in rcu-walk mode, the path walk=
ing
code carries the inode around for use (instead of ->d_inode).

If you make sure to have dropped out from rcu-walk mode, then d_inode
can be relied on to be stable, of course.

Thanks,
Nick
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
