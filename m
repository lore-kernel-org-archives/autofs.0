From: Ian Kent <raven@themaw.net>
Subject: Re: Autmount issue
Date: Thu, 21 May 2015 14:41:16 +0800
Message-ID: <1432190476.4186.8.camel@pluto.fritz.box>
References: <CABJoi6w9OgxBtUSARsaAvxAWt_ViJzh_6BYn_g214KnwmRFMAw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=LigivICUEUmJkOTfr8dpT1phJDU=; b=UELnFE
	9cCL90WZry67d7m9sbEMBRKymhHZcF0FzPSayJ9PU3u1CZfVZYr3duBaZMTT5ejR
	NHji/rjt2qjH71TRgEjh05Kh5lMhWrBroOz+wEYubHTKWCTGgtRLE49/R2LxYfSX
	CcQCRIRZsD2Bf5DiwLWCSZ0Wjnmlr4duyerLc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=LigivICUEUmJkOT
	fr8dpT1phJDU=; b=smgW/5U69tVeV4Brkkl+GcHCRC5jBRqdmLGgjXnylX3QI4W
	NhgIgqJx42DLLBHVxbI1hrgdCanGvVcAFIUevxU4eKflivddqydQBtrTqaW3SzYx
	vcBfUPj/ztqDPu+nGRZQ1fwSPgZZOI0jK78kZq65GZAebzVeFRQ6tcsLME2E=
In-Reply-To: <CABJoi6w9OgxBtUSARsaAvxAWt_ViJzh_6BYn_g214KnwmRFMAw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sohnaeo <trysomefun@gmail.com>
Cc: autofs@vger.kernel.org

On Thu, 2015-05-21 at 12:42 +1000, Sohnaeo wrote:
> Hello Guys,
> 
> I am having an issue with the autofs/automount on Cent OS 7, below is the detail
> 
> LDAP Server
> 
> 
> Solaris 10
> Sun Directory Server 6.2
> 
> 
> LDAP Client
> 
> 
> CentOS 7
> 
> OpenLdap
> 
> 
> I issued the below command to enable LDAP authetication. LDAP users
> can successfully authenticated now on CentOs
> 
>  authconfig --enableldap --enableldapauth --ldapserver=x.x.x.x
> --ldapbasedn=dc=drivess,dc=rtta --disablemkhomedir --update
> 
> But somehow users home directories can't be mounted through autofs.
> Below is my autofs.conf file
> 
>  autofs
> master_map_name = ldap://xxxxx/automountMapName=auto_master,dc=drivess,dc=rtaa
> mount_nfs_default_protocol = 3
> logging = debug
> ldap_uri = "ldap://x.x.x.x"
> search_base = "automountMapName=auto_master,dc=drivess,dc=rtaa"
> map_object_class = automountMap
> entry_object_class = automount
> map_attribute = automountMapName
> entry_attribute = automountKey
> value_attribute= automountInformation
> auth_conf_file = /etc/autofs_ldap_auth.conf
> map_type = ldap
> 
> When I run the below command , it throws an error
> 
> automount -m
> get_query_dn: lookup(ldap): found query dn
> automountMapName=auto_master,dc=drivess,dc=rtaa
> lookup_read_master: lookup(ldap): searching for
> "(objectclass=automount)" under
> "automountMapName=auto_master,dc=drivess,dc=rtaa"
> lookup_read_master: lookup(ldap): examining entries
> syntax error in map near  ahmedf nfs-cluster:
> 
> Below is ldapsearch command result
>   ldapsearch -x -b 'automountMapName=auto_master,dc=drivess,dc=rtaa'
> "(objectClass=automountMap)"
> 
> dn: automountMapName=auto_master,dc=drivess,dc=rtaa
> automountMapName: auto_master
> objectClass: top
> objectClass: automountMap
> 
>  ldapsearch -x -b
> 'automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
> dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
> automountInformation: nfs-cluster:/san/users/cmes/ahmedf
> automountKey: ahmedf
> objectClass: automount
> objectClass: top
> 
> In short, automountInformation is nfs-cluster:/san/users/cmes/ahmedf
> but somehow autmount is complaining "syntax error in map near [ ahmedf
> nfs-cluster: ]"

That's telling you that your master map is not right.

> 
> 
> Any ideas?

Have a look at the example in /usr/share/doc/autofs:
ldap-automount-rfc2307-bis-auto.master
ldap-automount-rfc2307-bis-auto.indirect
ldap-automount-rfc2307-bis-auto.direct

For the indirect mount case above you need master map ldap entries that
contain an entry that specifies the indirect mount mount point and the
map where the entries for that mount point are stored.

Ian



