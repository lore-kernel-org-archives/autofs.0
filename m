From: michael@cadilhac.name (=?iso-8859-1?Q?Micha=EBl?= Cadilhac)
Subject: Re: Autofs screwed by getopt?
Date: Mon, 23 Jul 2007 16:21:27 +0200
Message-ID: <87myxnxkt4.fsf@lrde.org>
References: <87vecbxmzt.fsf@lrde.org>
	<x49y7h7qkki.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3234249406279418438=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

--===============3234249406279418438==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Moyer <jmoyer@redhat.com> writes:

> You are most likely running into a bug in the parsing done in the init
> script.  What does '/etc/init.d/autofs status' show?

Well, just `started'.

> I have a couple of patches to fix that up.  I don't have a gentoo
> source tree, though.  If you can point me at one, I can likely send
> you a patch to try.

I'm running a Gentoo, I'm root and all the stuff so I can try your
patch.

Micha=EBl> PS: In fact, it seems that the mount options are not applied at
Micha=EBl> all. Don't have a clue why.

Seems like=A0:

   lri4-154:/dd $ mount
[...]
automount(pid23161) on /special type autofs (rw,fd=3D4,pgrp=3D23161,minprot=
o=3D2,maxproto=3D4)
automount(pid23175) on /servers type autofs (rw,fd=3D4,pgrp=3D23175,minprot=
o=3D2,maxproto=3D4)
automount(pid23190) on /local type autofs (rw,fd=3D4,pgrp=3D23190,minproto=
=3D2,maxproto=3D4)
automount(pid23204) on /u type autofs (rw,fd=3D4,pgrp=3D23204,minproto=3D2,=
maxproto=3D4)
automount(pid23218) on /tmpsim type autofs (rw,fd=3D4,pgrp=3D23218,minproto=
=3D2,maxproto=3D4)
automount(pid23233) on /users type autofs (rw,fd=3D4,pgrp=3D23233,minproto=
=3D2,maxproto=3D4)


=2D-=20
 |   Micha=EBl `Micha' Cadilhac       |    Le copillage-collage            =
    |
 |   http://michael.cadilhac.name   |       tue le programmeur.            =
  |
 |   JID/MSN:                       |           -- Dictons LRDE            =
  |
 `----  michael.cadilhac@gmail.com  |                                   -  =
--'

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQFGpLloUJhDmOfFA3URAiCWAJwPxuuPiViBcXU2YGC9k8WEla8SDQCgxuHm
TKub7FLBmM3CqZZoydg3TRk=
=xHJq
-----END PGP SIGNATURE-----
--=-=-=--


--===============3234249406279418438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3234249406279418438==--

