From: "Arthur Korn" <arthur@korn.ch>
Subject: Re: automounter
Date: Thu, 9 Sep 2004 17:47:02 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040909154701.GA13397@turing>
References: <4389DC3E2E59694D8B01794D38C1499C13A365@il-tlv-mail02.comverse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============75920207170015064=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4389DC3E2E59694D8B01794D38C1499C13A365@il-tlv-mail02.comverse.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Ben-Nun Gil <Gil.Ben-nun@comverse.com>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>


--===============75920207170015064==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

Ben-Nun Gil schrieb:
> Can I use the auto mounter in Linux redhat to mount or ftp
> remote servers ?

You can use autofs to automount anything "mount" can mount (sounds
kinda logical, doesn't it? ;))

So with FTP you're out of luck unless you use one of these
userspace filesystems, which can mount FTP.

> Can it work without running a nis service ?

Perfectly, yes.

> As I understand I have two files :/etc/auto.master which
> directs to the map file /etc/auto.misc.

Yes, auto.master lists maps (not necessarily files).

> I added a line to the /etc/auto.misc : dsu                      -fstype=
=3Dauto
> 1.1.1.1:/share

Per default (depends on your mount configuration) fstype=3Dauto
will not work for any network filesystems.

Use fstype=3Dnfs for NFS, for windows shares fstype=3Dsmbfs or
fstype=3Dcifs (beware that autofs can't ask you for a password, so
you must pass username/password as options in auto.misc if
necessary).

ciao, 2ri
--=20
Securine email, spread GPG, clearsign all mail. http://www.gnupg.org
=2E
Norwegen ist das teuerste Land Europas. Eine Schachtel Marlboro=20
kostet umgerechnet 14,22 Mark, eine Flasche Jonny Walker kostet 78,00=20
Mark und eine Dose Becks 6,79 Mark. In Norwegen -- und das ist der=20
Unterschied zu Deutschland -- erkennt man Besserverdienende daran,=20
dass sie besoffen auf dem Hauptbahnhof rumliegen.
 -- Harald Schmidt

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBQHr1NgpsykSg/LgRAjbjAJ0aTpw5LWAhSQW2nqSY9VbgOPLO0gCgttzd
CjKB0cOiy+pS7a4lnb3raaM=
=jCfc
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


--===============75920207170015064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============75920207170015064==--

