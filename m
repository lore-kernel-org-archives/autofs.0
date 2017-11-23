From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Thu, 23 Nov 2017 15:49:03 +1100
Message-ID: <87r2spzjk0.fsf@notabene.neil.brown.name>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net> <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net> <874lpo2y9e.fsf@notabene.neil.brown.name> <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net> <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net> <87375520qy.fsf@notabene.neil.brown.name> <0672986d-0ede-95e7-b393-c4029766b58a@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0672986d-0ede-95e7-b393-c4029766b58a@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23 2017, Ian Kent wrote:

> On 23/11/17 10:21, NeilBrown wrote:
>> On Thu, Nov 23 2017, Ian Kent wrote:
>>=20
>>>
>>> Hey Neil, I'm looking at this again because RH QE have complained about
>>> a regression test failing with a kernel that has this change.
>>>
>>> Maybe I'm just dumb but I though a "find <base directory> <options>"
>>> would, well, just look at the contents below <base directory> but an
>>> strace shows that it reads and calls fstatat() on "every entry in the
>>> mount table" regardless of the path.
>>=20
>> weird ... I can only get find to look at the mount table if given the
>> -fstyp option, and even then it doesn't fstatat anything that isn't in
>> the tree it is searching.
>
> It's probably the -xautofs (exclude autofs fs'es) that was used in
> the test that requires reading the mount table to get info about
> excluding autofs mounts but the fstatat() on all the entries,
> regardless of path, that was a surprise to me.
>
> find did use AT_SYMLINK_NOFOLLOW which historically behaved like
> AT_NO_AUTOMOUNT.
>
>>=20
>>=20
>>>
>>> And with the move of userspace to use /proc based mount tables (one
>>> example being the symlink of /etc/mtab into /proc) even modest sized
>>> direct mount maps will be a problem with every entry getting mounted.
>>=20
>> But the patch in question is only about indirect mount maps, isn't it?
>> How is it relevant to direct mount maps?
>
> The change here will cause fstatat() to trigger direct mounts on access
> if it doesn't use AT_NO_AUTOMOUNT.

Ahhh... light dawns.
This is about this bit of the patch:

 static inline int vfs_fstatat(int dfd, const char __user *filename,
                              struct kstat *stat, int flags)
 {
=2D       return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
=2D                        stat, STATX_BASIC_STATS);
+       return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
 }

I hadn't paid much attention to that.

I before this patch:
  stat and lstat act as you would expect AT_NO_AUTOMOUNT to act on
      direct mount and browseable indirect mount, but not on unbrowseable
      indirect mounts
  fstatat appeared to accept the AT_NO_AUTOMOUNT flag, but actually
      assumed it was always set, but acted like stat and lstat
  xstatat actually accepted the AT_NO_AUTOMOUNT flag, but it had no
      effect on unbrowseable indirect mounts.

after the patch, the distinction between direct and indirect was gone,
and fstatat now handles AT_NO_AUTOMOUNT the same as xstatat.
So:
  stat and lstat now don't trigger automounts even on indirect, but
    this is a mixed blessing as they don't even trigger the mkdir
  fstatat without AT_NO_AUTOMOUNT now always triggers an automount
    This is a problematic regression that you have noticed and
    likely needs to be reverted.  Maybe we can assume
    AT_NO_AUTOMOUNT when AT_SYMLINK_NOFOLLOW is set, and require
    people to use xstatat if they need to set the flags separately
  xstatat now correctly honours AT_NO_AUTOMOUNT for indirect mounts
    but is otherwise unchanged.

What would you think of changing the above to

 static inline int vfs_fstatat(int dfd, const char __user *filename,
                              struct kstat *stat, int flags)
 {
=2D       return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
=2D                        stat, STATX_BASIC_STATS);
+       return vfs_statx(dfd, filename,
+                        (flags & AT_SYMLINK_NOFOLLOW) ? (flags |
+                             AT_NO_AUTOMOUNT) : flags,
+                             stat, STATX_BASIC_STATS);
 }

??

Thanks,
NeilBrown

>
> It's not a problem for browse indirect mounts because they are plain
> directories within the autofs mount point not individual autofs mount
> triggers.
>
>>=20
>>>
>>> Systems will cope with this fine but larger systems not so much.
>>>
>>> If find does this then the user space changes needed to accommodate
>>> this sort of change are almost certainly far more than I expected.
>>>
>>> I think this is an example of the larger problem I'm faced with and
>>> this change was was meant to be a starting point for resolution.
>>>
>>> The most obvious symptom of the problem is auto-mounts no longer able
>>> to be expired due to being re-mounted immediately after expire. Another
>>> symptom is unwanted (by the user) accesses causing unexpected auto-mount
>>> attempts.
>>>
>>> I believe this monitoring of the mount table is what leads to excessive
>>> CPU consumption I've seen, usually around six processes, under heavy
>>> mount activity. And following this, when the mount table is large and
>>> there is "no mount activity" two of the six processes continue to consu=
me
>>> excessive CPU, until the mount table shrinks.
>>>
>>> So now I'm coming around to the idea of reverting this change ..... and
>>> going back to the drawing board.
>>=20
>> I can well imaging that a large mount table could cause problems for
>> applications that are written to expect one, and I can imagine that
>> autofs could cause extra issues for such a program as it might change
>> the mount table more often.  But I haven't yet worked out how this is
>> related to the patch in question....
>>=20
>> Thanks,
>> NeilBrown
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAloWU0AACgkQOeye3VZi
gbmrRg/+OoXPmtcNCwGcA0Dtlb1nsVrYJYuHPS/PCnTte1gSVNQ/WryF6tkDnyyg
mBLIuiEYpfmUWDc/FuESef90Uu/hp4c8zNH1jB8US2w1mh4M/EGZlResc2WrVRIQ
oMi4iLfpZOGovGwbKZIoekReh2x5WnMajTHFwCCDGsfsH9bC648VYwS/NH4dYBZG
KdYX4/7P5XQyXoORprfVT2BAPoSdOwhh2LaAjA5VNP76oHFqKsRW5TYpeqmI9EJv
6RQsr7Y8Mp1Cbn1aoFhkGVOxW//jGStwuogMhVFvypQYM1hPTJhcXlHkpyYNjQPP
PLar2biQ4lNN9OkfFmgP3nFjenwle9gVrd7yDF72ZYxUySq8I6Wh1zc1VbcMEDcI
OuciagyXa+mvistNW0b9KXBFiY/wrjndgXAP4oqau7cgSct1t8cdWIgAmZS5a5sR
BlCU19L2asZ1qInbao+uXUcpRaLno1tkND4SZ4UAGPr96tKJCdkYnrTeWrvnhg2f
t8PvR991EtR72o6KUWYlLs3zlmUcvYtqD7gzXUBTYm2EiBdyqoug1v3dV5yh7cLq
+2BMpFgKLt9sV2ziRbjt5B7N2lLMl31AhKb2HxVoyEJTACjhcwBekDCt/2kZ0xvg
EIMGW883wRhJA+jHODpIyMyGIRrSDpypUV/+o7TQZHd5zc0SjCA=
=0cWi
-----END PGP SIGNATURE-----
--=-=-=--
