From: Rainer Krienke <krienke@uni-koblenz.de>
Subject: Looking for infor on executable map format
Date: Fri, 26 Mar 2004 10:40:03 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403261040.08085.krienke@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36838159093782075=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--===============36838159093782075==
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_4p/YAmQ9MsQy3lI";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit


--Boundary-02=_4p/YAmQ9MsQy3lI
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I am looking on the exact format that a executable map has to echo to stado=
ut=20
in order to automount something. The man page of autofs is not quite clear=
=20
about this. For example, having /etc/auto.master:

/home auto.home         -soft,retry=3D6

and a /etc/auto.home script that should mount the users home directory. Wha=
t=20
should this script echo to stdout?  I found out several alternatives but=20
since I have a strange problem that might result out out confusing autofs I=
=20
would take the right choice. By the way I want to make a bind mount. So wha=
ts=20
correct? Here are several examples of output of the auto.home script when=20
called with foo as a key:

# This seems to work, but is it correct?
=2D-bind -soft,retry=3D6 / server:/export/user/foo   =20

# This works also
=2D-bind -soft,retry=3D6 \
/ server:/export/user/foo   =20

# Also adding the key after / works
=2D-bind -soft,retry=3D6 \
/foo server:/export/user/foo

# According to the manpage, autofs (5), I would have expected this to work
# a simple map, but it does not work:
=2D-bind -soft,retry=3D6 \
foo  server:/export/user/foo   =20
=20
# Finally even leaving out the key works:
=2D-bind -soft,retry=3D6 \
server:/export/user/foo   =20

Which example is correct?

My problem is that after a while on my real server which uses lots of user=
=20
automounts like described here after shutting down autofs (switching to=20
single user) I am unable to umount the user filesystem with the users on it=
=20
since it claims to be busy. But there are no more processes (like automount=
,=20
nfsd, user processes) that could make it busy.  So I suspect that a wrong=20
format of the executable map might confuse the kernel.

Thanks a lot
Rainer
=2D-=20
=2D------------------------------------------------------------------------=
=2D-
Rainer Krienke, Universitaet Koblenz, Rechenzentrum, Raum A022
Universitaetsstrasse 1, 56070 Koblenz, Tel: +49 261287 -1312, Fax: -1001312
Mail: krienke@uni-koblenz.de, Web: http://www.uni-koblenz.de/~krienke
Get my public PGP key: http://www.uni-koblenz.de/~krienke/mypgp.html
=2D------------------------------------------------------------------------=
=2D-

--Boundary-02=_4p/YAmQ9MsQy3lI
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAY/p4aldtjc/KDEoRAoBHAKC1m8iIcARlsV1vt94NkSqQVPvO+gCdFg5O
yYJ3Ek4OLfrrdkbSZBypuK0=
=/I82
-----END PGP SIGNATURE-----

--Boundary-02=_4p/YAmQ9MsQy3lI--


--===============36838159093782075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============36838159093782075==--

