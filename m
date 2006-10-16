From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: automounted filesystems being unmounted and mounted every
	minute
Date: Mon, 16 Oct 2006 09:30:17 -0400
Message-ID: <1161005417.3184.5.camel@pc.ilinx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3173365035411692328=="
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


--===============3173365035411692328==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-dvAvp8E+aS3hn1kfARN1"


--=-dvAvp8E+aS3hn1kfARN1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Autofs 5.0.1 seems to be doing an unmount/mount of my home dir
filesystems every minute or so.  Verbose output from autofs shows:

Oct 16 09:27:23 jenny automount[18632]: expiring path /autohome/share
Oct 16 09:27:23 jenny automount[18632]: unmounting dir =3D /autohome/share
Oct 16 09:27:23 jenny automount[18632]: expired /autohome/share
Oct 16 09:27:23 jenny automount[18632]: expiring path /autohome/brian
Oct 16 09:27:23 jenny automount[18632]: unmounting dir =3D /autohome/brian
Oct 16 09:27:23 jenny automount[18632]: expired /autohome/brian
Oct 16 09:27:24 jenny automount[18632]: attempting to mount entry /autohome=
/share
Oct 16 09:27:24 jenny automount[18632]: mount(nfs): mounted linux:/home/sha=
re on /autohome/share
Oct 16 09:27:24 jenny automount[18632]: mounted /autohome/share
Oct 16 09:27:24 jenny automount[18632]: mount still busy /autohome

Why is it in the same window of operation expiring, unmounting and
remounting filesystems?

My configuration for the above:

/autohome       /etc/autofs/auto.home  --timeout=3D60

brian           -rw,soft,intr,rsize=3D8192,wsize=3D8192     pc:/home/brian
share           -rw,soft,intr,rsize=3D8192,wsize=3D8192     linux:/home/sha=
re

Any ideas?

b.

--=20
My other computer is your Microsoft Windows server.

Brian J. Murrell

--=-dvAvp8E+aS3hn1kfARN1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFM4lpl3EQlGLyuXARAveLAKD1Qlo3eI/xifCdtHE6sti/RbEITQCg2/Kb
gcssQqHpoeHX+ygi7sjHMkQ=
=WvgH
-----END PGP SIGNATURE-----

--=-dvAvp8E+aS3hn1kfARN1--


--===============3173365035411692328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3173365035411692328==--

