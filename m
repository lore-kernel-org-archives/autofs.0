From: Dirk Heinrichs <ext-dirk.heinrichs@nokia.com>
Subject: Program map for USB devices
Date: Wed, 17 Dec 2003 15:48:50 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200312171548.57310.ext-dirk.heinrichs@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============47278567908493829=="
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


--===============47278567908493829==
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_ZzG4/c49qBYoYvG";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


--Boundary-02=_ZzG4/c49qBYoYvG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I've got several USB devices which are all accessed as SCSI disc through th=
e=20
usb-storage driver. Since the device node they are attached to depends on=20
plugin order, I need to know how to find out which hardware is attached to=
=20
which /dev/sd*, so that I can write a program map.

Any hints?

Thanx...

	Dirk
=2D-=20
Dirk Heinrichs          | Tel:  +49 (0)151 1513 6954
Configuration Manager   | Fax:  +49 (0)211 47068 111
Cap Gemini Ernst & Young| Mail: dirk.heinrichs@cgey.com
Hambornerstra=DFe 55      | Web:  http://www.cgey.com
D-40472 D=FCsseldorf      | ICQ#: 110037733
GPG Public Key C2E467BB | Keyserver: www.keyserver.net

--Boundary-02=_ZzG4/c49qBYoYvG
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/4GzZ8NVtnsLkZ7sRAvWIAKCNG7Uc+vBOJWefS/iAEiKadgRTpQCgo8tU
ReJZxZVMe8VPtFacWOoGDps=
=idfo
-----END PGP SIGNATURE-----

--Boundary-02=_ZzG4/c49qBYoYvG--


--===============47278567908493829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============47278567908493829==--

