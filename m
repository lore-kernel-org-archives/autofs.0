From: Matt Bernstein <mb/autofs@dcs.qmul.ac.uk>
Subject: Re: Help with ldap + autofs please
Date: Wed, 24 Mar 2004 16:41:21 +0000 (GMT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403241636220.19787@lucy.dcs.qmul.ac.uk>
References: <200403181118.34039.ndbecker2@verizon.net>
 <Pine.LNX.4.58.0403212326530.4690@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403212326530.4690@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="utf-8"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Neal Becker <ndbecker2@verizon.net>

On Mar 21 Ian Kent wrote:

>On Thu, 18 Mar 2004, Neal Becker wrote:
>
>> Can anyone help me with migrating autofs to ldap?
>>=20
>> To test, I added this line to /etc/auto.master:
>>=20
>> /test=C2=A0=C2=A0=C2=A0ldap:rpppc1.md.hns.com:ou=3Dauto.test,dc=3Dadg,=
dc=3Dhns,dc=3Dcom=C2=A0
>
>Try
>
>/test	ldap //rpppc1.md.hns.com/ou=3Dauto.test,dc=3Dadg,dc=3Dhns,dc=3Dcom

Hi, I get the same problem--this doesn't help (a space after "ldap" makes=
=20
it think it's a yp map called "ldap").

>> Mar 18 09:19:40 rpppc1 automount[19312]: lookup(ldap): query failed fo=
r (&(objectclass=3DnisObject))
>> Mar 18 09:19:40 rpppc1 automount[19312]: lookup(ldap): query failed fo=
r (&(objectclass=3Dautomount))
>> Mar 18 09:19:40 rpppc1 automount[19312]: failed to load map, exiting

Same problem here.

Mar 24 16:26:22 r2-pc automount[16114]: starting automounter version 4.1.=
1, path =3D /homes, maptype =3D ldap, mapname =3D ou=3Dauto.homes,dc=3Ddc=
s,dc=3Dqmul,dc=3Dac,dc=3Duk
Mar 24 16:26:22 r2-pc automount[16114]: lookup(ldap): server =3D "(defaul=
t)", port =3D 389, base dn =3D "ou=3Dauto.homes,dc=3Ddcs,dc=3Dqmul,dc=3Da=
c,dc=3Duk"
Mar 24 16:26:23 r2-pc automount[16114]: mount(bind): bind_works =3D 1
Mar 24 16:26:23 r2-pc automount[16114]: kproto sub: Function not implemen=
ted
Mar 24 16:26:23 r2-pc automount[16114]: using kernel protocol version 4.0=
0
Mar 24 16:26:23 r2-pc automount[16114]: using timeout 300 seconds; freq 7=
5 secs
Mar 24 16:26:23 r2-pc automount[16114]: lookup(ldap): searching for "(&(o=
bjectclass=3DnisObject))" under "ou=3Dauto.homes,dc=3Ddcs,dc=3Dqmul,dc=3D=
ac,dc=3Duk"
Mar 24 16:26:23 r2-pc automount[16114]: lookup(ldap): query succeeded, no=
 matches for (&(objectclass=3DnisObject))
Mar 24 16:26:24 r2-pc automount[16114]: lookup(ldap): searching for "(&(o=
bjectclass=3Dautomount))" under "ou=3Dauto.homes,dc=3Ddcs,dc=3Dqmul,dc=3D=
ac,dc=3Duk"
Mar 24 16:26:24 r2-pc automount[16114]: lookup(ldap): query failed for (&=
(objectclass=3Dautomount))
Mar 24 16:26:24 r2-pc automount[16114]: failed to load map, exiting
Mar 24 16:26:24 r2-pc automount[16114]: umount_multi: path=3D/homes incl=3D=
0

# ldapsearch -x '(&(objectclass=3Dautomount))' -b 'ou=3Dauto.homes,dc=3Dd=
cs,dc=3Dqmul,dc=3Dac,dc=3Duk' -z 3
# extended LDIF
#
# LDAPv3
# base <ou=3Dauto.homes,dc=3Ddcs,dc=3Dqmul,dc=3Dac,dc=3Duk> with scope su=
b
# filter: (&(objectclass=3Dautomount))
# requesting: ALL
#

# tba1, auto.homes, dcs.qmul.ac.uk
dn: cn=3Dtba1,ou=3Dauto.homes,dc=3Ddcs,dc=3Dqmul,dc=3Dac,dc=3Duk
cn: tba1
objectClass: automount
automountInformation:: Oi9ob21lL2N1c3RhcmQvM3JkL3RiYTE=3D

# shc5, auto.homes, dcs.qmul.ac.uk
dn: cn=3Dshc5,ou=3Dauto.homes,dc=3Ddcs,dc=3Dqmul,dc=3Dac,dc=3Duk
cn: shc5
objectClass: automount
automountInformation:: Oi9ob21lL2N1c3RhcmQvbXNjaXQvc2hjNQ=3D=3D

# ozm2, auto.homes, dcs.qmul.ac.uk
dn: cn=3Dozm2,ou=3Dauto.homes,dc=3Ddcs,dc=3Dqmul,dc=3Dac,dc=3Duk
cn: ozm2
objectClass: automount
automountInformation:: Oi9ob21lL2N1c3RhcmQvbXNjaXQvb3ptMg=3D=3D

# search result
search: 2
result: 4 Size limit exceeded

# numResponses: 4
# numEntries: 3


This is using autofs-4.1.1-3 from Fedora development (will probably go in=
=20
FC2), with either the v3 or v4 kernel module.

Strangely, some mounts do work and others do not. There's not enough in=20
the debug log for me to work out what's going on.

I now have no home directory! Can anyone see what's gone wrong?
