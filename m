From: michael@cadilhac.name (=?iso-8859-1?Q?Micha=EBl?= Cadilhac)
Subject: Autofs screwed by getopt?
Date: Mon, 23 Jul 2007 15:34:14 +0200
Message-ID: <87vecbxmzt.fsf@lrde.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1858002854058558846=="
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

--===============1858002854058558846==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi guys!

I have a NIS based automount configuration that reads like that=A0:

lri4-154 linux # ypcat -k auto.master
/special auto.special  -rw,intr,soft
/servers auto.servers  -rw,intr,soft
/local auto.local    -rw,intr,soft
/u auto.u            -rw,intr,soft,nosuid
/tmpsim auto.tmpsim     -rw,intr,soft
/users auto.users    -rw,intr,hard,nosuid,tcp,nfsvers=3D3,timeo=3D600,retra=
ns=3D2

Didn't seem like a badly formatted one. So I launched autofs, and here's
what it said=A0:

 * Starting automounter ...
 /special/usr/sbin/automount: option -t requires a numeric argument, got r,=
soft
 * Failure on /special
 /servers/usr/sbin/automount: option -t requires a numeric argument, got r,=
soft
 * Failure on /servers
 /local/usr/sbin/automount: option -t requires a numeric argument, got r,so=
ft
 * Failure on /local
 /u/usr/sbin/automount: option -t requires a numeric argument, got r,soft,n=
osuid
 * Failure on /u
 /tmpsim/usr/sbin/automount: option -t requires a numeric argument, got r,s=
oft
 * Failure on /tmpsim
 /users/usr/sbin/automount: option -t requires a numeric argument, got r,ha=
rd,nosuid,tcp,nfsvers=3D3,timeo=3D600,retrans=3D2
 * Failure on /users

Point is that the `-rw,int' is interpreted by the getopt like a bunch of
not understood options then a `t', as in `timeout'. So the next part,
e.g. `r,soft', is considered as the argument of `timeout' which is not
quite good.

What I did is that I removed the short opts for getopt in the init.d
script, but I'm not quite sure it's The Right Thing to Do.

Maybe the config got from nis is faulty, if so, just tell me, I'll
despise my sysadmin.

Thanks!

PS: In fact, it seems that the mount options are not applied at
all. Don't have a clue why.

=2D-----------------------------------------------------------------------
lri4-154 linux # automount --version
Linux automount version 4.1.3
lri4-154 linux # uname -a
Linux lri4-154 2.6.22-gentoo-r1 #1 SMP Thu Jul 19 16:20:19 CEST 2007
i686 Intel(R) Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
=2D-----------------------------------------------------------------------

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

iD8DBQFGpK5bUJhDmOfFA3URAobvAKCo6C+H0TvNJqy3aVM/j20dqvMRTACfenpM
mbeTDkHGJHnPS+0Id5KsQGQ=
=GWzh
-----END PGP SIGNATURE-----
--=-=-=--


--===============1858002854058558846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1858002854058558846==--

