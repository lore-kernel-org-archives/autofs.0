From: michael@cadilhac.name (=?iso-8859-1?Q?Micha=EBl?= Cadilhac)
Subject: Re: Autofs screwed by getopt?
Date: Mon, 23 Jul 2007 17:07:14 +0200
Message-ID: <87ejizxiot.fsf@lrde.org>
References: <87vecbxmzt.fsf@lrde.org>
	<x49y7h7qkki.fsf@segfault.boston.devel.redhat.com>
	<87myxnxkt4.fsf@lrde.org>
	<x49ejizqjgj.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0683239129239414213=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49ejizqjgj.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
	message of "Mon, 23 Jul 2007 10:32:28 -0400")
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

--===============0683239129239414213==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Moyer <jmoyer@redhat.com> writes:

> So, can you get me the output from, 'ps auxwww | grep automount'?

Here you are=A0:-)=A0:

/usr/sbin/automount --pid-file /var/run/autofs.special.pid /special yp auto=
.special -rw,intr,soft
/usr/sbin/automount --pid-file /var/run/autofs.servers.pid /servers yp auto=
.servers -rw,intr,soft
/usr/sbin/automount --pid-file /var/run/autofs.local.pid /local yp auto.loc=
al -rw,intr,soft
/usr/sbin/automount --pid-file /var/run/autofs.u.pid /u yp auto.u -rw,intr,=
soft,nosuid
/usr/sbin/automount --pid-file /var/run/autofs.tmpsim.pid /tmpsim yp auto.t=
mpsim -rw,intr,soft
/usr/sbin/automount --pid-file /var/run/autofs.users.pid /users yp auto.use=
rs -rw,intr,hard,nosuid,tcp,nfsvers=3D3,timeo=3D600,retrans=3D2

>>> I have a couple of patches to fix that up.  I don't have a gentoo
>>> source tree, though.  If you can point me at one, I can likely send
>>> you a patch to try.
>
> Micha=EBl> I'm running a Gentoo, I'm root and all the stuff so I can try
> Micha=EBl> your patch.
>
> Yes, but I don't know where to get source packages for gentoo.  I'll
> look into it if I have time.

Here's how autofs is installed=A0:

>>> Emerging (1 of 1) net-fs/autofs-4.1.3-r7 to /
 'http://gentoo.modulix.net/gentoo/distfiles/autofs-4.1.3-sock-leak-fix.pat=
ch'
 'http://gentoo.modulix.net/gentoo/distfiles/autofs-4.1.3-strict.patch'
 'http://gentoo.modulix.net/gentoo/distfiles/autofs-4.1.3-replicated_server=
_select.patch'
 'http://gentoo.modulix.net/gentoo/distfiles/autofs-4.1.3-miscfixes.patch.g=
z'
 'http://gentoo.modulix.net/gentoo/distfiles/autofs-4.1.3.tar.bz2'
 'http://gentoo.modulix.net/gentoo/distfiles/autofs-4.1.3-non_block_ping.pa=
tch'
 'http://gentoo.modulix.net/gentoo/distfiles/autofs-4.1.3-mtab_lock.patch'
 'http://gentoo.modulix.net/gentoo/distfiles/autofs-4.1.3-bad_chdir.patch'

>>> Unpacking autofs-4.1.3.tar.bz2 to /var/tmp/portage/net-fs/autofs-4.1.3-=
r7/work
 * Applying autofs-4.1.3-strict.patch ...
 * Applying autofs-4.1.3-mtab_lock.patch ...
 * Applying autofs-4.1.3-bad_chdir.patch ...
 * Applying autofs-4.1.3-non_block_ping.patch ...
 * Applying autofs-4.1.3-sock-leak-fix.patch ...
 * Applying autofs-4.1.3-replicated_server_select.patch ...
 * Applying autofs-4.1.3-miscfixes.patch.gz ...
 * Applying autofs-4.1.3-signal-race-fix.patch ...

And signal-race-fix.patch is :

=2D-- autofs-4.1.3/daemon/automount.c.orig        2004-08-18 11:23:49.43047=
0256 -0400
+++ autofs-4.1.3/daemon/automount.c     2004-08-18 11:24:45.047015256 -0400
@@ -848,10 +848,10 @@ static int st_prepare_shutdown(void)
        alarm(0);
=20
        /* Prevent any new mounts */
=2D       ap.state =3D ST_SHUTDOWN_PENDING;
=2D
        sigprocmask(SIG_SETMASK, &lock_sigs, NULL);
=20
+       ap.state =3D ST_SHUTDOWN_PENDING;
+
        /* Unmount everything */
        exp =3D expire_proc(1);
=20

I've tarball'ed the ending patched directory at
http://www.lrde.org/~cadilh_m/autofs-4.1.3.tar.bz2 .

Thanks=A0!

=2D-=20
 |   Micha=EBl `Micha' Cadilhac       |    Un paradoxe autor=E9f=E9rent=A0?=
          |
 |   http://michael.cadilhac.name   |                                      =
  |
 |   JID/MSN:                       |       ... Je dis pas non=A0!         =
    |
 `----  michael.cadilhac@gmail.com  |                                   -  =
--'

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQFGpMQiUJhDmOfFA3URAj7DAKCYQcGBzpvt349yM6cLlx9fcpP5sgCfciV5
K1ZZwNfNl6AsuFABmM9iaCE=
=uGTe
-----END PGP SIGNATURE-----
--=-=-=--


--===============0683239129239414213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0683239129239414213==--

