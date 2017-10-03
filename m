From: Rowland Penny <rpenny@samba.org>
Subject: Re: Using autofs with Active directory
Date: Tue, 3 Oct 2017 15:55:57 +0100
Message-ID: <20171003155557.39eb1396@devstation.samdom.example.com>
References: <20171002192855.554d1e3a@devstation.samdom.example.com>
        <49527a45-8ba3-f9d1-30b9-8906dc8c19c4@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42627210; h=Message-ID:To:From:Date:CC;
        bh=H0Y0lAJZ/7wBmdb7oTCMzcwIYstrrkUVTDpsRoZ9Bik=; b=foM1v2Ovtb+XboqC86Bn/I4YXY
        wCYrpCUWqkUSxQTEWa62oQ/aqNaXOOuTJaBC4zd45yjhIOC+ELtIENiz5euzpD5xBauyKUvrEFBik
        mbmQsmQHoYWxMpvXREuFef4zieHZC+7e8B/hzv0MTOLGXdmvtRNdHQ98Y1Bv+HmZUYno=;
In-Reply-To: <49527a45-8ba3-f9d1-30b9-8906dc8c19c4@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org

On Tue, 3 Oct 2017 14:13:02 +0800
Ian Kent <raven@themaw.net> wrote:

> On 03/10/17 02:28, Rowland Penny wrote:
> > 
> > Hi, I hope this is the right place to send this to, but if not, can
> > you advise just where I should send it to ;-)
> > 
> > 
> > I am trying to get Automount to work with a Samba AD DC and I am
> > struggling. I think I might have read just about everything there
> > is on the internet, but there isn't much for using Autofs with ldap
> > and even less about AD.
> 
> Yes, that is true but to change that would we would need input from
> people using this functionality.

If I can get this to work, I will put something on the Samba wiki.


> 
> Looks ok although I'm not sure about using CN, a case insensitive
> attribute.

Everything is case insensitive on windows ;-)

> 
> > 
> > 
> > Set /etc/default/autofs to this:
> > 
> > USE_MISC_DEVICE="yes"
> > #OPTIONS=""
> > MASTER_MAP_NAME="ldap:ou=auto.master,ou=automount,dc=example,dc=com"
> > #MASTER_MAP_NAME="ou=auto.master,ou=automount,dc=example,dc=com"
> > LDAP_URI="ldaps://dc1.example.com" # AD server name
> > SEARCH_BASE="ou=automount,dc=example,dc=com"
> > #LOGGING="verbose"
> > LOGGING="debug"
> > #LDAP_URI="ldap://dc1.example.com" # AD server name
> > #LDAP_URI="ldap:///dc=example,dc=com" # AD server name
> > MAP_OBJECT_CLASS="automountMap"
> > ENTRY_OBJECT_CLASS="automount"
> > MAP_ATTRIBUTE="automountMapName"
> > ENTRY_ATTRIBUTE="automountKey"
> > VALUE_ATTRIBUTE="automountInformation"
> > AUTH_CONF_FILE="/etc/autofs_ldap_auth.conf"
> 
> Well, old style configuration but that should still work regardless
> of autofs version.

I take it from that, there is a new style configuration, is this
documented anywhere ?

> 
> > 
> > Set /etc/autofs_ldap_auth.conf to this:
> > 
> > <?xml version="1.0" ?>
> > <!--
> > This files contains a single entry with multiple attributes tied to
> > it. See autofs_ldap_auth.conf(5) for more information.
> > -->
> > 
> > <autofs_ldap_sasl_conf
> >         usetls="no"
> >         tlsrequired="yes"
> >         authrequired="yes"
> >         authtype="GSSAPI"
> >         clientprinc="asciiclient$@EXAMPLE.COM"
> > />
> > 
> > 
> > Set /etc/ldap/ldap.conf to this:
> > 
> > BASE    dc=example,dc=com
> > URI     ldaps://dc1.example.com
> > HOST dc1.example.com
> > TLS_CACERT /etc/ssl/certs/dc1cert.pem
> > TLS_REQCERT never
> 
> LDAP + Kerberos is not my favorite, anyway here are some things to
> think about.

Sort of goes with an AD domain ;-)

> 
> Is EXAMPLE.COM is a valid Kerberos realm?

Definitely.

> 
> Has it got a principle asciiclient$@EXAMPLE.COM that doesn't require
> a password?

Oh dear, no it hasn't, but there is ASCIICLIENT$@EXAMPLE.COM
Feel a bit of a fool now, I should have known better.

OK, fixing that got me a bit further, but I now cannot login to
asciiclient, the home dirs get overwritten, so I am now trying to
setup an indirect mount.

The automount objects now look like this:

 dn: OU=automount,DC=example,DC=com
objectClass: top
objectClass: organizationalUnit
ou: automount
name: automount

dn: OU=auto.master,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automountMap
objectClass: organizationalUnit
ou: auto.master
name: auto.master
automountMapName: auto.master

dn: CN=*,OU=auto.master,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automount
objectClass: container
cn: *
name: *
automountKey: *
automountInformation: -fstype=nfs4,rw,sec=krb5 dc1//:/home/users/&

dn: OU=auto.home,OU=automount,DC=example,DC=com
objectClass: top
objectClass: automountMap
objectClass: organizationalUnit
ou: auto.home
name: auto.home
automountMapName: auto.home

Which leads to this:

Oct  3 15:20:26 asciiclient automount[1587]: connected to uri ldaps://dc1.example.com
Oct  3 15:20:26 asciiclient automount[1587]: lookup_read_master: lookup(ldap): searching for "(objectclass=automount)" under "OU=auto.master,OU=automount,DC=example,DC=com"
Oct  3 15:20:26 asciiclient automount[1587]: lookup_read_master: lookup(ldap): examining entries
Oct  3 15:20:26 asciiclient automount[1587]: syntax error in map near [ * -fstype=nfs4,rw,sec=krb5 dc1 ]
Oct  3 15:20:26 asciiclient automount[1587]: no mounts in table

I have tried various permutations of the automountInformation line, but
just keep getting the syntax error. Okay where have I gone wrong now ?

Rowland
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
