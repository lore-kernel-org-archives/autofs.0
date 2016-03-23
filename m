From: Dana Arnold <davedomainx@gmail.com>
Subject: autofs submount question/issue
Date: Wed, 23 Mar 2016 09:50:19 +0100
Message-ID: <CA+ctBiAjuPzUK5tYdLSQZB3SHVYYpF3TYELQeJ5Ub4-7yF4PNQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=L8mJ09vBWiDI+/x9fn3JPy6r9vdc+w+IYNN1+TaNwNc=;
        b=Ac3OOerfrhKecSo3aKVb22Uk2/lLNS9tX8u3vRR4O/5SBIsrhIDsYZv9tOP7We84qE
         aGT/Qab0RTQ6ytRLE6R4BXnOGfhtZtY0HtF686hYG7eAC/sSxDRDuyYc6U9DS5B7axXt
         XpzB5bGMag5Q+VsiRppn5h8p+I5UcyHqgJnH7hD9UFJ55yMwDKgBMEDIGbahLh+MVm5A
         W3Rmh2vSEId6yv/9tApCJPnuHiOApyLpwZU6ZCVIIr1cK6D/PApyIW5AKy2d54MN2JVU
         paN/Eg3Q08DJdO9kHgjvnd4K0wCAkvu+rE7aaLU0+xXVX0jNMGrm1P9GPN72xIMBYl7n
         T4Bg==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hi,

are there some limitations to how automount can handle submount-maps ?

I'm using CentOS 6.5 with automount information delivered via SSSD,
talking to an Active Directory server.  Automount works fine with
direct + indirect maps.

But I cannot seem to automount a stanza like so:

/gnu                -> automounts okay
/gnu/var/guix/pro   -> does not automount

I can direct-mount the directories no problems.

Everything I have read tells me that I should be able to automount the
above stanza, if they have _direct map_ entries (see below)

I CAN _indirect_ automount a stanza like below, where each of the
below directories is handled by a single nisMapEntry in AD:

/data
/data/test
/data/test/here

nisMapEntry:
/test 192.168.1.100:/export/test /test/here 192.168.1.100:/export/here

Some obscured config info below.  Any assistance greatly appreciated!
I'll ask the sssd folks next, but at the moment this feels more of an
autofs question..

-------

cat /etc/auto.master:
+auto.master                ## lookup SSSD..

In auto.master:
dn: CN=/-,CN=auto.master ...
objectClass: top
objectClass: nisObject
nisMapEntry: auto.direct
nisMapName: auto.master

In auto.direct:
# /gnu, auto.direct
dn: CN=/gnu,CN=auto.direct
objectClass: top
objectClass: nisObject
nisMapEntry: 192.168.1.20:/export/guix_store
nisMapName: auto.direct

# /gnu/var/guix/pro, auto.direct
dn: CN=/gnu/var/guix/pro,CN=auto.direct
objectClass: top
objectClass: nisObject
nisMapEntry: 192.168.1.20:/export/guix_profiles
nisMapName: auto.direct

-------
/etc/sssd/sssd.conf:        ## relevant bits only
autofs_provider = ldap
ldap_autofs_entry_key = cn
ldap_autofs_entry_object_class = nisObject
ldap_autofs_entry_value = nisMapEntry
ldap_autofs_map_name = nisMapName
ldap_autofs_map_object_class = nisMap
ldap_autofs_search_base = XXX

[sssd]
services = nss, pam, autofs

------
grep auto /etc/nsswitch.conf    ## relevant bits only
automount:  files sss

------

sudo rpm -qa |grep sssd

sssd-client-1.12.4-47.el6_7.7.x86_64
sssd-ldap-1.12.4-47.el6_7.7.x86_64
sssd-common-pac-1.12.4-47.el6_7.7.x86_64
sssd-common-1.12.4-47.el6_7.7.x86_64
sssd-krb5-1.12.4-47.el6_7.7.x86_64
sssd-krb5-common-1.12.4-47.el6_7.7.x86_64
sssd-ad-1.12.4-47.el6_7.7.x86_64
sssd-1.12.4-47.el6_7.7.x86_64
python-sssdconfig-1.12.4-47.el6_7.7.noarch
sssd-ipa-1.12.4-47.el6_7.7.x86_64
sssd-proxy-1.12.4-47.el6_7.7.x86_64

sudo rpm -qa |grep autofs
autofs-5.0.5-113.el6.x86_64
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
