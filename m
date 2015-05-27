From: Ian Kent <raven@themaw.net>
Subject: Re: Autmount issue
Date: Wed, 27 May 2015 11:55:19 +0800
Message-ID: <1432698919.2736.13.camel@pluto.fritz.box>
References: <CABJoi6w9OgxBtUSARsaAvxAWt_ViJzh_6BYn_g214KnwmRFMAw@mail.gmail.com>
	 <1432190476.4186.8.camel@pluto.fritz.box>
	 <CABJoi6zbw4wVni-kknMD=tVpFoqD32jc2PbbEP+CW2RU3zJ9tQ@mail.gmail.com>
	 <1432692464.2736.12.camel@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=wG9p7IcSR2gTW2OjV4thfk5WxoM=; b=THsA3s
	I/jLUFixZQu37+ROORN1HIGItrOPm6gCb1RzFQ4FndT0zDS54teoYf65Ts2Bjgut
	tGq1ov3ZlKPV4+D4kI58oTUAh1Jw+wncyqCaiaD50oDYmrr3xulQQGD7lYybBDIy
	THl3278ouYBXdLWZQ03SEhtn8IkfMo3pIIkGQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=wG9p7IcSR2gTW2O
	jV4thfk5WxoM=; b=no7GTZGGOnNbTs9McaSLA18IjLD66SOcDceMgq1lKXMrlKf
	5PJpCnnXDX4H7J1N0t1B7kOIFGm1TlXAAaQWBvA11q3ijjLypb8rIlnsC/3Ega9L
	rRnWND4tatkUClExQ0BuheVK2R53R8fRq24z7eKlZlla7t8pDIlbSskkx57Q=
In-Reply-To: <1432692464.2736.12.camel@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sohnaeo <trysomefun@gmail.com>
Cc: autofs@vger.kernel.org

On Wed, 2015-05-27 at 10:07 +0800, Ian Kent wrote:
> On Tue, 2015-05-26 at 16:31 +1000, Sohnaeo wrote:
> > Hello Ian,
> > 
> > Thank you very much for looking into this. Solaris clients didn't have
> > any issue with the existing master map. In my environment, I do have
> > 99% Solaris clients and I don't want to change master map for few
> > Linux clients. below is the auto_master map on Sun Directory Server
> > 
> > dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
> > automountinformation: nfs-cluster:/san/users/cmes/ahmedf
> > automountkey: ahmedf
> > objectclass: top
> > objectclass: automount
> 
> I don't see how that could work, it's not a master map entry, it's a map
> entry.
> 
> The problem with this entry is it doesn't provide the information about
> what indirect mount this key belongs to?
> 
> You'll need to give me more info about what's in ldap and what the
> mounts look like after automount is started on Solaris.
> 
> Start autofs on an idle system, do nothing else, and post the contents
> of /etc/mnttab (assuming that hasn't changed over the years since I
> worked on Solaris systems). If there are obvious things you don't want
> people to see in it then delete those lines but don't delete autofs
> related lines.

And what path do you use to cause this entry to mount?

> 
> If you want you could log a bug at bugzilla.redhat.com and have it made
> private to so the information isn't available to people not included on
> the cc list or allowed groups.
> 
> > 
> > 
> > I am clueless.
> > 
> > On Thu, May 21, 2015 at 4:41 PM, Ian Kent <raven@themaw.net> wrote:
> > > On Thu, 2015-05-21 at 12:42 +1000, Sohnaeo wrote:
> > >> Hello Guys,
> > >>
> > >> I am having an issue with the autofs/automount on Cent OS 7, below is the detail
> > >>
> > >> LDAP Server
> > >>
> > >>
> > >> Solaris 10
> > >> Sun Directory Server 6.2
> > >>
> > >>
> > >> LDAP Client
> > >>
> > >>
> > >> CentOS 7
> > >>
> > >> OpenLdap
> > >>
> > >>
> > >> I issued the below command to enable LDAP authetication. LDAP users
> > >> can successfully authenticated now on CentOs
> > >>
> > >>  authconfig --enableldap --enableldapauth --ldapserver=x.x.x.x
> > >> --ldapbasedn=dc=drivess,dc=rtta --disablemkhomedir --update
> > >>
> > >> But somehow users home directories can't be mounted through autofs.
> > >> Below is my autofs.conf file
> > >>
> > >>  autofs
> > >> master_map_name = ldap://xxxxx/automountMapName=auto_master,dc=drivess,dc=rtaa
> > >> mount_nfs_default_protocol = 3
> > >> logging = debug
> > >> ldap_uri = "ldap://x.x.x.x"
> > >> search_base = "automountMapName=auto_master,dc=drivess,dc=rtaa"
> > >> map_object_class = automountMap
> > >> entry_object_class = automount
> > >> map_attribute = automountMapName
> > >> entry_attribute = automountKey
> > >> value_attribute= automountInformation
> > >> auth_conf_file = /etc/autofs_ldap_auth.conf
> > >> map_type = ldap
> > >>
> > >> When I run the below command , it throws an error
> > >>
> > >> automount -m
> > >> get_query_dn: lookup(ldap): found query dn
> > >> automountMapName=auto_master,dc=drivess,dc=rtaa
> > >> lookup_read_master: lookup(ldap): searching for
> > >> "(objectclass=automount)" under
> > >> "automountMapName=auto_master,dc=drivess,dc=rtaa"
> > >> lookup_read_master: lookup(ldap): examining entries
> > >> syntax error in map near  ahmedf nfs-cluster:
> > >>
> > >> Below is ldapsearch command result
> > >>   ldapsearch -x -b 'automountMapName=auto_master,dc=drivess,dc=rtaa'
> > >> "(objectClass=automountMap)"
> > >>
> > >> dn: automountMapName=auto_master,dc=drivess,dc=rtaa
> > >> automountMapName: auto_master
> > >> objectClass: top
> > >> objectClass: automountMap
> > >>
> > >>  ldapsearch -x -b
> > >> 'automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
> > >> dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
> > >> automountInformation: nfs-cluster:/san/users/cmes/ahmedf
> > >> automountKey: ahmedf
> > >> objectClass: automount
> > >> objectClass: top
> > >>
> > >> In short, automountInformation is nfs-cluster:/san/users/cmes/ahmedf
> > >> but somehow autmount is complaining "syntax error in map near [ ahmedf
> > >> nfs-cluster: ]"
> > >
> > > That's telling you that your master map is not right.
> > >
> > >>
> > >>
> > >> Any ideas?
> > >
> > > Have a look at the example in /usr/share/doc/autofs:
> > > ldap-automount-rfc2307-bis-auto.master
> > > ldap-automount-rfc2307-bis-auto.indirect
> > > ldap-automount-rfc2307-bis-auto.direct
> > >
> > > For the indirect mount case above you need master map ldap entries that
> > > contain an entry that specifies the indirect mount mount point and the
> > > map where the entries for that mount point are stored.
> > >
> > > Ian
> > >
> > >
> > >
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


