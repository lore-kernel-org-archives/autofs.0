From: Rowland Penny <rpenny@samba.org>
Subject: Using autofs with Active directory
Date: Mon, 2 Oct 2017 19:28:55 +0100
Message-ID: <20171002192855.554d1e3a@devstation.samdom.example.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42627210; h=Message-ID:To:From:Date:CC;
        bh=3SotMikmwpmsOLbjT8DpbzKVcS4Rwc/EYnvNqt2jHhg=; b=T+QJUd9VFyFlkxlc4yHf49Vvx5
        iShQOFz8F9Ar4Nc+yNjaHAAMk46NNUa4tpl/3vQRN2/5LwzHPXdp/X61qvEslsMZpaF1cAbVMWPxu
        SPENNAc5DnFeqebTDx5hHlE1jvmN4lX99ZzOZmcY3s4B7KEVfzKJRkrwEd8Njg/gfQ6k=;
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org


Hi, I hope this is the right place to send this to, but if not, can you
advise just where I should send it to ;-)


I am trying to get Automount to work with a Samba AD DC and I am struggling. 
I think I might have read just about everything there is on the internet, but there isn't much for using Autofs with ldap and even less about AD.

I have extended the AD schema and added these objects:

dn: OU=automount,DC=example,DC=com
objectClass: top
objectClass: organizationalUnit
ou: automount
name: automount
distinguishedName: OU=automount,DC=example,DC=com

dn: OU=auto.master,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automountMap
objectClass: organizationalUnit
ou: auto.master
name: auto.master
automountMapName: auto.master

dn: OU=auto.home,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automountMap
objectClass: organizationalUnit
ou: auto.home
name: auto.home
automountMapName: auto.home

dn: CN=user,OU=auto.home,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automount
objectClass: container
cn: user
name: user
automountKey: user
automountInformation: -fstype=nfs4,rw,sec=krb5 dc1.example.com:/home/user/&

dn: CN=/home,OU=auto.master,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automount
objectClass: container
cn: /home
name: /home
automountKey: /home
automountInformation: ldap:ou=auto.home,ou=Automount,dc=example,dc=com rsize=8192,wsize=8192


Set /etc/default/autofs to this:

USE_MISC_DEVICE="yes"
#OPTIONS=""
MASTER_MAP_NAME="ldap:ou=auto.master,ou=automount,dc=example,dc=com"
#MASTER_MAP_NAME="ou=auto.master,ou=automount,dc=example,dc=com"
LDAP_URI="ldaps://dc1.example.com" # AD server name
SEARCH_BASE="ou=automount,dc=example,dc=com"
#LOGGING="verbose"
LOGGING="debug"
#LDAP_URI="ldap://dc1.example.com" # AD server name
#LDAP_URI="ldap:///dc=example,dc=com" # AD server name
MAP_OBJECT_CLASS="automountMap"
ENTRY_OBJECT_CLASS="automount"
MAP_ATTRIBUTE="automountMapName"
ENTRY_ATTRIBUTE="automountKey"
VALUE_ATTRIBUTE="automountInformation"
AUTH_CONF_FILE="/etc/autofs_ldap_auth.conf"

Set /etc/autofs_ldap_auth.conf to this:

<?xml version="1.0" ?>
<!--
This files contains a single entry with multiple attributes tied to it.
See autofs_ldap_auth.conf(5) for more information.
-->

<autofs_ldap_sasl_conf
        usetls="no"
        tlsrequired="yes"
        authrequired="yes"
        authtype="GSSAPI"
        clientprinc="asciiclient$@EXAMPLE.COM"
/>


Set /etc/ldap/ldap.conf to this:

BASE    dc=example,dc=com
URI     ldaps://dc1.example.com
HOST dc1.example.com
TLS_CACERT /etc/ssl/certs/dc1cert.pem
TLS_REQCERT never

It doesn't work, I get this in /var/log/syslog:

Oct  2 15:47:22 asciiclient automount[4793]: Starting automounter version 5.1.2, master map ldap:ou=auto.master,ou=automount,dc=example,dc=com
Oct  2 15:47:22 asciiclient automount[4793]: using kernel protocol version 5.02
Oct  2 15:47:22 asciiclient automount[4793]: lookup_nss_read_master: reading master ldap ou=auto.master,ou=automount,dc=example,dc=com
Oct  2 15:47:22 asciiclient automount[4793]: parse_server_string: lookup(ldap): Attempting to parse LDAP information from string "ldap:ou=auto.master,ou=automount,dc=example,dc=com".
Oct  2 15:47:22 asciiclient automount[4793]: parse_server_string: lookup(ldap): server "(default)", base dn "ou=auto.master,ou=automount,dc=example,dc=com"
Oct  2 15:47:22 asciiclient automount[4793]: parse_ldap_config: lookup(ldap): ldap authentication configured with the following options:
Oct  2 15:47:22 asciiclient automount[4793]: parse_ldap_config: lookup(ldap): use_tls: 0, tls_required: 1, auth_required: 2, sasl_mech: GSSAPI
Oct  2 15:47:22 asciiclient automount[4793]: parse_ldap_config: lookup(ldap): user: (null), secret: unspecified, client principal: asciiclient$@EXAMPLE.COM credential cache: (null)
Oct  2 15:47:22 asciiclient automount[4793]: do_init: parse(sun): init gathered global options: (null)
Oct  2 15:47:22 asciiclient automount[4793]: spawn_mount: mtab link detected, passing -n to mount
Oct  2 15:47:22 asciiclient automount[4793]: spawn_umount: mtab link detected, passing -n to mount
Oct  2 15:47:22 asciiclient automount[4793]: find_server: trying server uri ldaps://dc1.example.com
Oct  2 15:47:22 asciiclient automount[4793]: do_bind: lookup(ldap): auth_required: 2, sasl_mech GSSAPI
Oct  2 15:47:22 asciiclient automount[4793]: sasl_do_kinit: initializing kerberos ticket: client principal asciiclient$@EXAMPLE.COM
Oct  2 15:47:22 asciiclient automount[4793]: sasl_do_kinit: calling krb5_parse_name on client principal asciiclient$@EXAMPLE.COM
Oct  2 15:47:22 asciiclient automount[4793]: sasl_do_kinit: Using tgs name krbtgt/EXAMPLE.COM@EXAMPLE.COM
Oct  2 15:47:22 asciiclient automount[4793]: sasl_do_kinit: krb5_get_init_creds_keytab failed with error -1765328203
Oct  2 15:47:22 asciiclient automount[4793]: do_bind: lookup(ldap): autofs_sasl_bind returned -1
Oct  2 15:47:22 asciiclient automount[4793]: lookup(ldap): couldn't connect to server ldaps://dc1.example.com
Oct  2 15:47:22 asciiclient automount[4793]: do_reconnect: lookup(ldap): failed to find available server
Oct  2 15:47:22 asciiclient automount[4793]: no mounts in table


Can anyone advise me just where I going wrong ????

This is on Devuan Ascii (aka Debian stretch without systemd)

Linux automount version 5.1.2

Directories:
	config dir:	/etc/default
	maps dir:	/etc
	modules dir:	/usr/lib/x86_64-linux-gnu/autofs

Compile options:
  DISABLE_MOUNT_LOCKING ENABLE_FORCED_SHUTDOWN ENABLE_IGNORE_BUSY_MOUNTS 
  WITH_HESIOD WITH_LDAP WITH_SASL LIBXML2_WORKAROUND 

Samba Version 4.6.8-Debian

Thanks 

Rowland
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
