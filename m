From: Ian Kent <raven@themaw.net>
Subject: Re: Using autofs with Active directory
Date: Tue, 3 Oct 2017 14:13:02 +0800
Message-ID: <49527a45-8ba3-f9d1-30b9-8906dc8c19c4@themaw.net>
References: <20171002192855.554d1e3a@devstation.samdom.example.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=exHlFyX1JmLdpIkOla
        8R2sviEq7c588xeiPs9k2R1nY=; b=IGdalDJyijqvoltOWUO1p6bjdLSIosNUGc
        99WS61yhjqCiKd8umUD7bjSY9bZWiwB21Pa2tW20dIolg+/gpNmZB1HaQx0Tjjvn
        iJB3NSSN6wq9UfBI0Oy0vDajtB+Mqhl3qyQEY3jaxZ9VuQa7H+7p6rojCgiH/ya+
        9a10aByFtsN36j11Q+j2cscfOzil1Pb5O/Su8IwvkvrgrR1RekWLfnCUN/EQhhGc
        cj/8lc0UbGVFcVgSNT1/8EESC9p9L6A3dBtLo6VeKBQR4goUFwPll8UYgL7S2nGj
        LhF1OQ0zrWyG3ZZwABSmU1CCk7cXdCiag2+brxPeX5QH4N4QWnzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=exHlFyX1JmLdpIkOla8R2sviEq7c588xeiPs9k2R1nY=; b=czrsfG4/
        K5ulgKyOa9a83UIbI1PcKKDwa7940QpYs5cRqVCnFTgVTZsa6UQd4fEvSY9d2xYj
        fKz5ThhFBbOZBO5rnae+LEtsBsRkXH5rLVNg9/KN8oQGgYiqjOvmGkPGWK+VdhTK
        IGF5bb/4zbr/dmapBsxxG8BAsiY7uG4IqGOopQadN8XwEVbjAx9qSbkhtEXyssUy
        WB66C8eJ9xopGDh5s1+/CVlYP6uyDRp0MIXUHLu39vXmTDJ2C3zbJDdzJMdONKvj
        zwgSnPVMRSZfJLpTeIxDb307E/4XcnAdtItu1nGAUNH7RoaHrxhXXOa7dE/7xF1X
        AU1MPsWeVV54YA==
In-Reply-To: <20171002192855.554d1e3a@devstation.samdom.example.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Rowland Penny <rpenny@samba.org>, autofs@vger.kernel.org

On 03/10/17 02:28, Rowland Penny wrote:
> 
> Hi, I hope this is the right place to send this to, but if not, can you
> advise just where I should send it to ;-)
> 
> 
> I am trying to get Automount to work with a Samba AD DC and I am struggling. 
> I think I might have read just about everything there is on the internet, but there isn't much for using Autofs with ldap and even less about AD.

Yes, that is true but to change that would we would need input from
people using this functionality.

> 
> I have extended the AD schema and added these objects:
> 
> dn: OU=automount,DC=example,DC=com
> objectClass: top
> objectClass: organizationalUnit
> ou: automount
> name: automount
> distinguishedName: OU=automount,DC=example,DC=com
> 
> dn: OU=auto.master,OU=automount,DC=example,DC=com
> objectClass: top
> objectClass: automountMap
> objectClass: organizationalUnit
> ou: auto.master
> name: auto.master
> automountMapName: auto.master
> 
> dn: OU=auto.home,OU=automount,DC=example,DC=com
> objectClass: top
> objectClass: automountMap
> objectClass: organizationalUnit
> ou: auto.home
> name: auto.home
> automountMapName: auto.home
> 
> dn: CN=user,OU=auto.home,OU=automount,DC=example,DC=com
> objectClass: top
> objectClass: automount
> objectClass: container
> cn: user
> name: user
> automountKey: user
> automountInformation: -fstype=nfs4,rw,sec=krb5 dc1.example.com:/home/user/&
> 
> dn: CN=/home,OU=auto.master,OU=automount,DC=example,DC=com
> objectClass: top
> objectClass: automount
> objectClass: container
> cn: /home
> name: /home
> automountKey: /home
> automountInformation: ldap:ou=auto.home,ou=Automount,dc=example,dc=com rsize=8192,wsize=8192

Looks ok although I'm not sure about using CN, a case insensitive attribute.

> 
> 
> Set /etc/default/autofs to this:
> 
> USE_MISC_DEVICE="yes"
> #OPTIONS=""
> MASTER_MAP_NAME="ldap:ou=auto.master,ou=automount,dc=example,dc=com"
> #MASTER_MAP_NAME="ou=auto.master,ou=automount,dc=example,dc=com"
> LDAP_URI="ldaps://dc1.example.com" # AD server name
> SEARCH_BASE="ou=automount,dc=example,dc=com"
> #LOGGING="verbose"
> LOGGING="debug"
> #LDAP_URI="ldap://dc1.example.com" # AD server name
> #LDAP_URI="ldap:///dc=example,dc=com" # AD server name
> MAP_OBJECT_CLASS="automountMap"
> ENTRY_OBJECT_CLASS="automount"
> MAP_ATTRIBUTE="automountMapName"
> ENTRY_ATTRIBUTE="automountKey"
> VALUE_ATTRIBUTE="automountInformation"
> AUTH_CONF_FILE="/etc/autofs_ldap_auth.conf"

Well, old style configuration but that should still work regardless
of autofs version.

> 
> Set /etc/autofs_ldap_auth.conf to this:
> 
> <?xml version="1.0" ?>
> <!--
> This files contains a single entry with multiple attributes tied to it.
> See autofs_ldap_auth.conf(5) for more information.
> -->
> 
> <autofs_ldap_sasl_conf
>         usetls="no"
>         tlsrequired="yes"
>         authrequired="yes"
>         authtype="GSSAPI"
>         clientprinc="asciiclient$@EXAMPLE.COM"
> />
> 
> 
> Set /etc/ldap/ldap.conf to this:
> 
> BASE    dc=example,dc=com
> URI     ldaps://dc1.example.com
> HOST dc1.example.com
> TLS_CACERT /etc/ssl/certs/dc1cert.pem
> TLS_REQCERT never

LDAP + Kerberos is not my favorite, anyway here are some things to
think about.

Is EXAMPLE.COM is a valid Kerberos realm?

Has it got a principle asciiclient$@EXAMPLE.COM that doesn't require
a password?

Can you do ldapsearch against dc1.example.com and get a list of your
ldap entries?

Is SASL setup on the client so you can successfully use:
"-Y GSSAPI -b dc=example,dc=com -H ldap://<server address>" with ldapsearch
and get a list of your entries?

> 
> It doesn't work, I get this in /var/log/syslog:
> 
> Oct  2 15:47:22 asciiclient automount[4793]: Starting automounter version 5.1.2, master map ldap:ou=auto.master,ou=automount,dc=example,dc=com
> Oct  2 15:47:22 asciiclient automount[4793]: using kernel protocol version 5.02
> Oct  2 15:47:22 asciiclient automount[4793]: lookup_nss_read_master: reading master ldap ou=auto.master,ou=automount,dc=example,dc=com
> Oct  2 15:47:22 asciiclient automount[4793]: parse_server_string: lookup(ldap): Attempting to parse LDAP information from string "ldap:ou=auto.master,ou=automount,dc=example,dc=com".
> Oct  2 15:47:22 asciiclient automount[4793]: parse_server_string: lookup(ldap): server "(default)", base dn "ou=auto.master,ou=automount,dc=example,dc=com"
> Oct  2 15:47:22 asciiclient automount[4793]: parse_ldap_config: lookup(ldap): ldap authentication configured with the following options:
> Oct  2 15:47:22 asciiclient automount[4793]: parse_ldap_config: lookup(ldap): use_tls: 0, tls_required: 1, auth_required: 2, sasl_mech: GSSAPI
> Oct  2 15:47:22 asciiclient automount[4793]: parse_ldap_config: lookup(ldap): user: (null), secret: unspecified, client principal: asciiclient$@EXAMPLE.COM credential cache: (null)
> Oct  2 15:47:22 asciiclient automount[4793]: do_init: parse(sun): init gathered global options: (null)
> Oct  2 15:47:22 asciiclient automount[4793]: spawn_mount: mtab link detected, passing -n to mount
> Oct  2 15:47:22 asciiclient automount[4793]: spawn_umount: mtab link detected, passing -n to mount
> Oct  2 15:47:22 asciiclient automount[4793]: find_server: trying server uri ldaps://dc1.example.com
> Oct  2 15:47:22 asciiclient automount[4793]: do_bind: lookup(ldap): auth_required: 2, sasl_mech GSSAPI
> Oct  2 15:47:22 asciiclient automount[4793]: sasl_do_kinit: initializing kerberos ticket: client principal asciiclient$@EXAMPLE.COM
> Oct  2 15:47:22 asciiclient automount[4793]: sasl_do_kinit: calling krb5_parse_name on client principal asciiclient$@EXAMPLE.COM
> Oct  2 15:47:22 asciiclient automount[4793]: sasl_do_kinit: Using tgs name krbtgt/EXAMPLE.COM@EXAMPLE.COM
> Oct  2 15:47:22 asciiclient automount[4793]: sasl_do_kinit: krb5_get_init_creds_keytab failed with error -1765328203
> Oct  2 15:47:22 asciiclient automount[4793]: do_bind: lookup(ldap): autofs_sasl_bind returned -1
> Oct  2 15:47:22 asciiclient automount[4793]: lookup(ldap): couldn't connect to server ldaps://dc1.example.com
> Oct  2 15:47:22 asciiclient automount[4793]: do_reconnect: lookup(ldap): failed to find available server
> Oct  2 15:47:22 asciiclient automount[4793]: no mounts in table
> 
> 
> Can anyone advise me just where I going wrong ????
> 
> This is on Devuan Ascii (aka Debian stretch without systemd)
> 
> Linux automount version 5.1.2
> 
> Directories:
> 	config dir:	/etc/default
> 	maps dir:	/etc
> 	modules dir:	/usr/lib/x86_64-linux-gnu/autofs
> 
> Compile options:
>   DISABLE_MOUNT_LOCKING ENABLE_FORCED_SHUTDOWN ENABLE_IGNORE_BUSY_MOUNTS 
>   WITH_HESIOD WITH_LDAP WITH_SASL LIBXML2_WORKAROUND 
> 
> Samba Version 4.6.8-Debian
> 
> Thanks 
> 
> Rowland
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
