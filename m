From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: getting rid of spurious log warnings
Date: Fri, 03 Feb 2006 17:30:25 +0100
Message-ID: <43E38521.7070002@inria.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

I get lot of similar warnings in my logs, every time I try to access an
automount-managed filesystem:
Feb  3 16:21:54 pomerol automount[8854]: lookup(ldap): got answer, but
no first entry for (&(objectclass=3DnisObject)(cn=3Dinfosystems))
Feb  3 16:21:54 pomerol automount[8854]: lookup(ldap): got answer, but
no first entry for (&(objectclass=3Dautomount)(cn=3Dinfosystems))
Feb  3 16:21:54 pomerol automount[8854]: lookup(ldap): got answer, but
no first entry for (&(objectclass=3DnisObject)(cn=3D/))

According to detailed informations found at
http://www.ldapguru.com/modules/newbb/viewtopic.php?topic_id=3D2029&forum=
=3D6&viewmode=3Dflat&order=3DASC&start=3D0
it seems to be caused by a two pass querying mechanism from autofs,
first one using Sun legacy schema, second one using autofs specific
schema. The first two queries seems to be attempts to retrieve an
explicit mapping for the first path element in the client map, the third
one a fallback to a generic root mapping.

Is there any way to configure autofs to directly use the correct schema
? I found some references to using nss_map_objectclass directives in nss
_ldap configuration, but it doesn't seem to work (and I'm not really
sure autofs rely on nss configuration). Otherwise, I could also just
change my ldap content, but I find using 'automount' instead of 'nis'
simpler.

I'm using linux-only setup, with an openldap 2.2 server. Here is an
exemple of a client map.

dn: ou=3Dauto.net.graves,ou=3Dautofs,dc=3Dvillage,dc=3Dinria,dc=3Dfr
objectClass: top
objectClass: automountMap
ou: auto.net.graves

dn: cn=3D/,ou=3Dauto.net.graves,ou=3Dautofs,dc=3Dvillage,dc=3Dinria,dc=3D=
fr
objectClass: top
objectClass: automount
cn: /
automountInformation: -fstype=3Dnfs,hard,intr graves:/home/graves/ftp/&

--=20
The bullet that is forgotten while installing an antenna systems will
always be at the base of the antenna, and discovered at 5pm on a Friday
after the tower crew has left
		-- Murphy's Laws of Broadcast Engineering n=B07
