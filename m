From: Ian Kent <raven@themaw.net>
Subject: Re: autofs submount question/issue
Date: Thu, 24 Mar 2016 09:00:02 +0800
Message-ID: <1458781202.2976.22.camel@themaw.net>
References: <CA+ctBiAjuPzUK5tYdLSQZB3SHVYYpF3TYELQeJ5Ub4-7yF4PNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Scb/ZLUPuDiESOnVw32FOLl8AJQ=; b=I7KlBO
	7vnIr+QNU90IxmDWV5tT0l4JurTKRWKvJHx0zze+1Z6/WMIPEthQKMhpaEp5T9F8
	zHkrJ4am7GpXuPs6UYT/ZqK6RsXkgT3+HLtTvcwnZlUga3Y1gcEzAoWIaXWfBICK
	zHsCtrMXQE685yKDrm2EkJbyA0nRKoytyMehQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Scb/ZLUPuDiESOn
	Vw32FOLl8AJQ=; b=aeeGwFkLHAt3ThjGdiCIgPOBGtIKfHiThBzvx3ZKO/6ixP/
	eUQPxIHNK1Pd7QP/imaiAygBndzwZBxtD37M8d3CLerfNh/h6es1Cf4QiS2UbaH3
	4d8oGtxgHUOybgf2oXHeIT9UG16Q29R8LM6aPB60n3GwQHop+iT/8FsU7Bns=
In-Reply-To: <CA+ctBiAjuPzUK5tYdLSQZB3SHVYYpF3TYELQeJ5Ub4-7yF4PNQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dana Arnold <davedomainx@gmail.com>, autofs@vger.kernel.org

On Wed, 2016-03-23 at 09:50 +0100, Dana Arnold wrote:
> Hi,
> 
> are there some limitations to how automount can handle submount-maps ?
> 
> I'm using CentOS 6.5 with automount information delivered via SSSD,
> talking to an Active Directory server.  Automount works fine with
> direct + indirect maps.
> 
> But I cannot seem to automount a stanza like so:
> 
> /gnu                -> automounts okay
> /gnu/var/guix/pro   -> does not automount
> 
> I can direct-mount the directories no problems.
> 
> Everything I have read tells me that I should be able to automount the
> above stanza, if they have _direct map_ entries (see below)

You can't do that.

In order for automount to get mount request call backs there needs to be
an autofs file system to trigger it.

What happens with this is when /gnu is mounted, the NFS file system
covers the previously mounted direct mount on /gnu/var/guix/pro.

So when a path walk occurs it follows into the NFS mount on /gnu and
never sees the later path.

> 
> I CAN _indirect_ automount a stanza like below, where each of the
> below directories is handled by a single nisMapEntry in AD:
> 
> /data
> /data/test
> /data/test/here
> 
> nisMapEntry:
> /test 192.168.1.100:/export/test /test/here 192.168.1.100:/export/here

You can write this like (removing the invalid "/" from the indirect map
key test):

test   /            192.168.1.100:/export/test \
       /test/here   192.168.1.100:/export/here

These are different because the autofs offset triggers mounts are
mounted inside the root offset at "/" when it is automounted so they can
trigger mounts within the NFS file system.

> 
> Some obscured config info below.  Any assistance greatly appreciated!
> I'll ask the sssd folks next, but at the moment this feels more of an
> autofs question..
> 
> -------
> 
> cat /etc/auto.master:
> +auto.master                ## lookup SSSD..
> 
> In auto.master:
> dn: CN=/-,CN=auto.master ...
> objectClass: top
> objectClass: nisObject
> nisMapEntry: auto.direct
> nisMapName: auto.master
> 
> In auto.direct:
> # /gnu, auto.direct
> dn: CN=/gnu,CN=auto.direct
> objectClass: top
> objectClass: nisObject
> nisMapEntry: 192.168.1.20:/export/guix_store
> nisMapName: auto.direct
> 
> # /gnu/var/guix/pro, auto.direct
> dn: CN=/gnu/var/guix/pro,CN=auto.direct
> objectClass: top
> objectClass: nisObject
> nisMapEntry: 192.168.1.20:/export/guix_profiles
> nisMapName: auto.direct

The only way you might be able to do this is with something like:

dn: CN=/gnu,CN=auto.direct
objectClass: top
objectClass: nisObject
nisMapEntry: 192.168.1.20:/export/guix_store /var/guix/pro
 192.168.1.20:/export/guix_profiles

That essentially changes it to an offset direct mount entry:

/gnu    /               192.168.1.20:/export/guix_store \
        /var/guix/pro   192.168.1.20:/export/guix_profiles

But having a mount triggered so high up in the direct mount tree hind of
negates the usefulness of direct mounts being able to be mounted into
the file system without covering large portions of the underlying file
systems.

Also, if you have a larger number of paths then such an entry could
easily get unmanageably large.

In this case you would probably be better to change /gnu to an indirect
mount map with some keys possibly having offsets themselves since a
direct mount at /gnu will cover any mounts below it any way.

> 
> -------
> /etc/sssd/sssd.conf:        ## relevant bits only
> autofs_provider = ldap
> ldap_autofs_entry_key = cn
> ldap_autofs_entry_object_class = nisObject
> ldap_autofs_entry_value = nisMapEntry
> ldap_autofs_map_name = nisMapName
> ldap_autofs_map_object_class = nisMap
> ldap_autofs_search_base = XXX
> 
> [sssd]
> services = nss, pam, autofs
> 
> ------
> grep auto /etc/nsswitch.conf    ## relevant bits only
> automount:  files sss
> 
> ------
> 
> sudo rpm -qa |grep sssd
> 
> sssd-client-1.12.4-47.el6_7.7.x86_64
> sssd-ldap-1.12.4-47.el6_7.7.x86_64
> sssd-common-pac-1.12.4-47.el6_7.7.x86_64
> sssd-common-1.12.4-47.el6_7.7.x86_64
> sssd-krb5-1.12.4-47.el6_7.7.x86_64
> sssd-krb5-common-1.12.4-47.el6_7.7.x86_64
> sssd-ad-1.12.4-47.el6_7.7.x86_64
> sssd-1.12.4-47.el6_7.7.x86_64
> python-sssdconfig-1.12.4-47.el6_7.7.noarch
> sssd-ipa-1.12.4-47.el6_7.7.x86_64
> sssd-proxy-1.12.4-47.el6_7.7.x86_64
> 
> sudo rpm -qa |grep autofs
> autofs-5.0.5-113.el6.x86_64
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
