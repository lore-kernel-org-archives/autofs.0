From: Neal Becker <ndbecker2@verizon.net>
Subject: Help with ldap + autofs please
Date: Thu, 18 Mar 2004 11:18:32 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403181118.34039.ndbecker2@verizon.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: Text/Plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Can anyone help me with migrating autofs to ldap?

To test, I added this line to /etc/auto.master:

/test=C2=A0=C2=A0=C2=A0ldap:rpppc1.md.hns.com:ou=3Dauto.test,dc=3Dadg,dc=3D=
hns,dc=3Dcom=C2=A0

Here is the corresponding ldif:
dn: nisMapName=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom
objectClass: top
objectClass: nisMap
nisMapName: auto.test

dn: cn=3Dtest,nisMapName=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom
objectClass: nisObject
cn: test
nisMapEntry:=C2=A0=C2=A0=C2=A0=C2=A0rpppc1.md.hns.com:/disk1/test
nisMapName: auto.test

If I do /sbin/service autofs reload, I get:

Mar 18 09:19:40 rpppc1 automount[19312]: starting automounter version 4.1=
.0,
path =3D /test, maptype =3D ldap, mapname =3D
rpppc1.md.hns.com:ou=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom
Mar 18 09:19:40 rpppc1 automount[19312]: using kernel protocol version 4.=
00
Mar 18 09:19:40 rpppc1 automount[19312]: using timeout 300 seconds; freq =
75
secs
Mar 18 09:19:40 rpppc1 automount[19312]: lookup(ldap): query failed for
(&(objectclass=3DnisObject))
Mar 18 09:19:40 rpppc1 automount[19312]: lookup(ldap): query failed for
(&(objectclass=3Dautomount))
Mar 18 09:19:40 rpppc1 automount[19312]: failed to load map, exiting
Mar 18 09:19:40 rpppc1 automount[19312]: failed to remove dir @ $(J`S (BI=
 -
=A7f: No such file or directory -A

(Yes, the garbage characters are there in the log)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWcvYMDqogpR5tkMRArIuAKCDCsCk/iYysbHdnkKyYv72+HgXzACaAp4Z
BzDuH2wgqXHKnyFiGAFiEgA=3D
=3Dyazv
-----END PGP SIGNATURE-----
