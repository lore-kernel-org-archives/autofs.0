From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Thu, 23 Nov 2017 13:21:41 +1100
Message-ID: <87375520qy.fsf@notabene.neil.brown.name>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net> <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net> <874lpo2y9e.fsf@notabene.neil.brown.name> <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net> <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Thu, Nov 23 2017, Ian Kent wrote:

>
> Hey Neil, I'm looking at this again because RH QE have complained about
> a regression test failing with a kernel that has this change.
>
> Maybe I'm just dumb but I though a "find <base directory> <options>"
> would, well, just look at the contents below <base directory> but an
> strace shows that it reads and calls fstatat() on "every entry in the
> mount table" regardless of the path.

weird ... I can only get find to look at the mount table if given the
-fstyp option, and even then it doesn't fstatat anything that isn't in
the tree it is searching.


>
> And with the move of userspace to use /proc based mount tables (one
> example being the symlink of /etc/mtab into /proc) even modest sized
> direct mount maps will be a problem with every entry getting mounted.

But the patch in question is only about indirect mount maps, isn't it?
How is it relevant to direct mount maps?

>
> Systems will cope with this fine but larger systems not so much.
>
> If find does this then the user space changes needed to accommodate
> this sort of change are almost certainly far more than I expected.
>
> I think this is an example of the larger problem I'm faced with and
> this change was was meant to be a starting point for resolution.
>
> The most obvious symptom of the problem is auto-mounts no longer able
> to be expired due to being re-mounted immediately after expire. Another
> symptom is unwanted (by the user) accesses causing unexpected auto-mount
> attempts.
>
> I believe this monitoring of the mount table is what leads to excessive
> CPU consumption I've seen, usually around six processes, under heavy
> mount activity. And following this, when the mount table is large and
> there is "no mount activity" two of the six processes continue to consume
> excessive CPU, until the mount table shrinks.
>
> So now I'm coming around to the idea of reverting this change ..... and
> going back to the drawing board.

I can well imaging that a large mount table could cause problems for
applications that are written to expect one, and I can imagine that
autofs could cause extra issues for such a program as it might change
the mount table more often.  But I haven't yet worked out how this is
related to the patch in question....

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAloWMLUACgkQOeye3VZi
gbnekxAAgzSa7hLdhLoIR88woP/dmF4DYzLOaUcAldzNMrbpDJjJqzFD3RtdkOwr
cRRt0W4k32xvo3r9NWa9rGGwKJvp2dAVjUwQJSEZcO/ujd5amtKLtmf+xPQeTKUn
JQb4dDrIcFubifdE7Mjdf7dh0GR1gFvQLo4/6ajXOfKJwEopRloZuIIv6/B/d64h
W3mQ1xcloPNz3IN6AjsTSyQ92JkfM/ac+PgntnMNTpQtqYEymla3Zu3xk02+0Iwr
UEHBMahtelDHoXIgtMhajbIhkpudtRYkPptFB/PR1fRVfDr+3S1J89XU8m+K6+xa
/OUCCQYwcjSwjS+eJcLPQF+6Ej4AYdmQAyMEmpCFtW4A0qKVj5q84tebHA4hoNNM
M7jH07//cfTDppN69bvwAs97wdZyPOO/syubD4iWhrSqHxhNV09VV71dbbpGhY/y
ZDaLNNmAqYfTJ+eiqLT1XdabdpbxPTkX3IDyfy5MtkGhOqqhmB+ILfsUVapsct4P
+QUdy9BtW1Djh88eFHVN+jSI+y9yAatQwzU5Rq/++65DlojVSlq4JVzosR8Vjqu1
Q1N/tZ8LM0KfxXbU2iiVYk8iaJKIarH1RGgiylbBQ3jfTgaKVrEQDDMAytQfuFEm
a6A6WjiK45/ocl/VF4fSgVcsPonXiYWm4DaOClJobi3pjFp4IUQ=
=taAx
-----END PGP SIGNATURE-----
--=-=-=--
