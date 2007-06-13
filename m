From: =?iso-8859-1?b?RWRq6Q==?= <edosseh@ub.tg>
Subject: Autofs5:master_notify: syntax error in map near [ /home ]
Date: Wed, 13 Jun 2007 16:45:29 +0000
Message-ID: <1181753129.46701f29a6e26@www.univ-lome.tg>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Content-Type: text/plain; charset="macroman"
To: autofs@linux.kernel.org

Hello,
Please help with autofs5 because i tried some advices without success.
I want to mount users home with autofs5. I tried it before with nfs with
success.
My conf is:

--/etc/sysconfig/autofs:
#
# Define default options for autofs.
#
# DEFAULT_MASTER_MAP_NAME - default map name for the master map.
#
DEFAULT_MASTER_MAP_NAME=3D"auto.master"
#
# DEFAULT_TIMEOUT - set the default mount timeout (default 600).
#
DEFAULT_TIMEOUT=3D300
#
# DEFAULT_BROWSE_MODE - maps are browsable by default.
#
#DEFAULT_BROWSE_MODE=3D"no"
#
# DEFAULT_LOGGING - set default log level "none", "verbose" or "debug"
#
DEFAULT_LOGGING=3D"verbose"
#
# Define the default LDAP schema to use for lookups
#
# System default
#
#DEFAULT_MAP_OBJECT_CLASS=3D"nisMap"
#DEFAULT_ENTRY_OBJECT_CLASS=3D"nisObject"
#DEFAULT_MAP_ATTRIBUTE=3D"nisMapName"
#DEFAULT_ENTRY_ATTRIBUTE=3D"cn"
#DEFAULT_VALUE_ATTRIBUTE=3D"nisMapEntry"
#
# Other common LDAP nameing
#
DEFAULT_MAP_OBJECT_CLASS=3D"automountMap"
DEFAULT_ENTRY_OBJECT_CLASS=3D"automount"
DEFAULT_MAP_ATTRIBUTE=3D"ou"
DEFAULT_ENTRY_ATTRIBUTE=3D"cn"
DEFAULT_VALUE_ATTRIBUTE=3D"automountInformation"
#
#DEFAULT_MAP_OBJECT_CLASS=3D"automountMap"
#DEFAULT_ENTRY_OBJECT_CLASS=3D"automount"
#DEFAULT_MAP_ATTRIBUTE=3D"automountMapName"
#DEFAULT_ENTRY_ATTRIBUTE=3D"automountKey"
#DEFAULT_VALUE_ATTRIBUTE=3D"automountInformation"
#
# DEFAULT_AUTH_CONF_FILE - set the default location for the SASL
#                          authentication configuration file.
#
DEFAULT_AUTH_CONF_FILE=3D"/etc/autofs_ldap_auth.conf"
#
# General global options
#
#OPTIONS=3D""
#
--------------------My auto.master's file
+auto.master

--------------------My nsswitch.conf automount's line:
automount:  files ldap nis

--------------------auto.master ou entry in ldap:

dn: ou=3Dauto.master,ou=3Dpersonnes,o=3Dul,c=3Dtg
ou: auto.master
objectClass: top
objectClass: automountMap

dn: cn=3D/home,ou=3Dauto.master,ou=3Dpersonnes,o=3Dul,c=3Dtg
objectClass: automount
cn: /home
automountInformation: ldap//192.168.210.3/ou=3Dauto.home,ou=3Dpersonnes,o=
=3Dul,c=3Dtg

-------------------auto.home ou entry in ldap:
dn: ou=3Dauto.home,ou=3Dpersonnes,o=3Dul,c=3Dtg
ou: auto.home
objectClass: top
objectClass: organizationalUnit

dn: cn=3D/,ou=3Dauto.home,ou=3Dpersonnes,o=3Dul,c=3Dtg
objectClass: automount
automountInformation: -fstype=3Dnfs,rw 192.168.210.3:/home/&
cn: /

-------------------

That is all. But if i restart autofs i read this error in log file:

Jun 13 16:24:19 Sersau automount[18093]: Starting automounter version 5.0.1=
-1,
master map auto.master
Jun 13 16:24:19 Sersau automount[18093]: using kernel protocol version 5.00
Jun 13 16:24:19 Sersau automount[18093]: master_notify: syntax error in map=
 near
[ /home ]
Jun 13 16:24:19 Sersau automount[18093]: mounted indirect mount on /misc wi=
th
timeout 300, freq 75 seconds
Jun 13 16:24:19 Sersau automount[18093]: ghosting enabled
Jun 13 16:24:19 Sersau automount[18093]: mounted indirect mount on /net with
timeout 300, freq 75 seconds
Jun 13 16:24:19 Sersau automount[18093]: ghosting enabled

     It seems to notify one error in /home entry. I don't understand it.

Please help!
"Heureux ceux qui sont conscients de leur pauvret=E9 spirituelle." - Mat 5:=
3(Les
Saintes Ecritures - Traduction du monde nouveau).

----------------------------------------------------------------
Ce message a =C3=A9t=C3=A9 envoy=C3=A9 depuis le serveur de messagerie de l=
'Universit=C3=A9 de
Lom=C3=A9.
Universit=C3=A9 de Lom=C3=A9
BP 1515
Lom=C3=A9 TOGO.
