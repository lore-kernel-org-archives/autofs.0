From: Ian Kent <raven@themaw.net>
Subject: Re: Help with ldap + autofs please
Date: Sun, 21 Mar 2004 23:30:46 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403212326530.4690@raven.themaw.net>
References: <200403181118.34039.ndbecker2@verizon.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403181118.34039.ndbecker2@verizon.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Neal Becker <ndbecker2@verizon.net>
Cc: autofs@linux.kernel.org

On Thu, 18 Mar 2004, Neal Becker wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Can anyone help me with migrating autofs to ldap?
>=20
> To test, I added this line to /etc/auto.master:
>=20
> /test=C2=A0=C2=A0=C2=A0ldap:rpppc1.md.hns.com:ou=3Dauto.test,dc=3Dadg,d=
c=3Dhns,dc=3Dcom=C2=A0

Try

/test	ldap //rpppc1.md.hns.com/ou=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom

>=20
> Here is the corresponding ldif:
> dn: nisMapName=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom
> objectClass: top
> objectClass: nisMap
> nisMapName: auto.test
>=20
> dn: cn=3Dtest,nisMapName=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom
> objectClass: nisObject
> cn: test
> nisMapEntry:=C2=A0=C2=A0=C2=A0=C2=A0rpppc1.md.hns.com:/disk1/test
> nisMapName: auto.test
>=20
> If I do /sbin/service autofs reload, I get:
>=20
> Mar 18 09:19:40 rpppc1 automount[19312]: starting automounter version 4=
.1.0,
> path =3D /test, maptype =3D ldap, mapname =3D
> rpppc1.md.hns.com:ou=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom
> Mar 18 09:19:40 rpppc1 automount[19312]: using kernel protocol version =
4.00
> Mar 18 09:19:40 rpppc1 automount[19312]: using timeout 300 seconds; fre=
q 75
> secs
> Mar 18 09:19:40 rpppc1 automount[19312]: lookup(ldap): query failed for
> (&(objectclass=3DnisObject))
> Mar 18 09:19:40 rpppc1 automount[19312]: lookup(ldap): query failed for
> (&(objectclass=3Dautomount))
> Mar 18 09:19:40 rpppc1 automount[19312]: failed to load map, exiting
> Mar 18 09:19:40 rpppc1 automount[19312]: failed to remove dir @ $(J`S (=
BI -
> =A7f: No such file or directory -A
>=20
> (Yes, the garbage characters are there in the log)

Garbage chars fixed in 4.1.1.

Also if you use=20

/test	ldap //rpppc1.md.hns.com/ou=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom =
--debug

with 4.1.1 you will get more info in wherever you log debug output=20
(/var/log/debug.log in RedHat).

Ian
