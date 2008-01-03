From: "Knops, Manfred" <Manfred.KNOPS@3ds.com>
Subject: master_notify: syntax error in map near [ bogus option ]
Date: Thu, 03 Jan 2008 13:40:24 +0100
Message-ID: <477CD7B8.1070002@3ds.com>
Reply-To: Manfred.KNOPS@3ds.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hello,

please can you help me.
I configured autofs in version 5.0.1 on a Fedora release 7 (Moonshine) 
system to use ldap for the automount information.

The configuration is:
[userB@hostB ~]# egrep -v "^$|^#" /etc/sysconfig/autofs
MASTER_MAP_NAME="auto.master"
TIMEOUT=300
BROWSE_MODE="yes"
APPEND_OPTIONS="yes"
LOGGING="debug"
MAP_OBJECT_CLASS="automountMap"
ENTRY_OBJECT_CLASS="automount"
MAP_ATTRIBUTE="automountMapName"
ENTRY_ATTRIBUTE="automountKey"
VALUE_ATTRIBUTE="automountInformation"
AUTH_CONF_FILE="/etc/autofs_ldap_auth.conf"

[userB@hostB ~]# tail -n 8 /etc/autofs_ldap_auth.conf
<autofs_ldap_sasl_conf
         usetls="no"
         tlsrequired="no"
         authrequired="yes"
         authtype="DIGEST-MD5"
         user="ldap"
         secret="ldap"
/>

[userB@hostB ~]# egrep -v "^$|^#" /etc/auto.master
+auto.master


The automount info's are:
[userB@hostB ~]# ldapsearch "(objectClass=automountMap)"
...
...
# auto.master, automount, abaqus.de
dn: automountMapName=auto.master,ou=automount,dc=abaqus,dc=de
objectClass: top
objectClass: automountMap
automountMapName: auto.master
description: This chapter is analog to the file /etc/auto.master

# auto.home, automount, abaqus.de
dn: automountMapName=auto.home,ou=automount,dc=abaqus,dc=de
objectClass: top
objectClass: automountMap
automountMapName: auto.home
description: This chapter is analog to /etc/auto.home

[userB@hostB ~]# ldapsearch 
"(&(objectClass=automount)(|(automountKey=/home)(automountKey=/net)))"
...
...
# /net, auto.master, automount, abaqus.de
dn: 
automountKey=/net,automountMapName=auto.master,ou=automount,dc=abaqus,dc=de
objectClass: top
objectClass: automount
automountKey: /net
automountInformation: /etc/auto.net --timeout=60

# /home, auto.master, automount, abaqus.de
dn: 
automountKey=/home,automountMapName=auto.master,ou=automount,dc=abaqus,dc=de
objectClass: top
objectClass: automount
automountKey: /home
automountInformation: ldap 
192.168.1.2:automountMapName=auto.home,ou=automount,dc=abaqus,dc=de 
--timeout=60

[userB@hostB ~]# ldapsearch "(&(objectClass=automount)(automountKey=userA))"
...
...
# userA, auto.home, automount, abaqus.de
dn: 
automountKey=userA,automountMapName=auto.home,ou=automount,dc=abaqus,dc=de
objectClass: top
objectClass: automount
automountKey: userA
automountInformation: -fstype=nfs,hard,intr,nodev,nosuid hostA:/home/userA
description: ldap entry for /etc/auto.home

When I start I got this information in /var/log/message:
Jan  3 13:37:52 kerberos automount[12728]: Starting automounter version 
5.0.1-31, master map auto.master
Jan  3 13:37:52 kerberos automount[12728]: using kernel protocol version 
5.00
Jan  3 13:37:52 kerberos automount[12728]: master_error: syntax error 
while parsing map.
Jan  3 13:37:52 kerberos automount[12728]: master_notify: syntax error 
in map near [ bogus option ]
Jan  3 13:37:52 kerberos automount[12728]: master_error: syntax error 
while parsing map.
Jan  3 13:37:52 kerberos automount[12728]: master_read_master: no mounts 
in table

On Opensuse 10.3 this configuration works.
Please can anyone tell me, what does it means syntax error in map near [ 
bogus option ].

With best regard
Manfred
-- 
Manfred Knops
Abaqus Deutschland GmbH
Elisabethstrasse 16
D-52062 Aachen
