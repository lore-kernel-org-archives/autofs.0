From: Sohnaeo <trysomefun@gmail.com>
Subject: Re: Autmount issue
Date: Tue, 26 May 2015 16:31:24 +1000
Message-ID: <CABJoi6zbw4wVni-kknMD=tVpFoqD32jc2PbbEP+CW2RU3zJ9tQ@mail.gmail.com>
References: <CABJoi6w9OgxBtUSARsaAvxAWt_ViJzh_6BYn_g214KnwmRFMAw@mail.gmail.com>
	<1432190476.4186.8.camel@pluto.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=U/hFHwrCPJ+d/CJWjq93fdcIqfgf9lIEljkLyqPMr5M=;
        b=fqx1C4O89L9DCuT7qrWIJvPciap8VYpQcHt/CcH8Nt8kcnZYjBQH9AXMzJ/HAW/DSX
         nt9ZiTX46dfgtbwXc0h4qp5XrI5PPdjqPSZXw/rT364SYz8ZzN5rmpncswCj/QpyjpPJ
         UQSh59RLsuDKx7RNHtyijD1km+CJ1TeNvAuogBMUsjVfcsVOgEue9r8nWbxq5kWR8/Li
         pO+KZmoQT5p7CEs7VgUpkWniQeIvW121nAz9R+Ja8aANXOrTlIIc5wzmLCvCgLfrrjtI
         Wfg3dT4gjGmYMKGE/UwA37SR36fRa84E9N5Fu6VV+W7F5Zq54Xz2qWV9aa31yrKIxBJ2
         2x5w==
In-Reply-To: <1432190476.4186.8.camel@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello Ian,

Thank you very much for looking into this. Solaris clients didn't have
any issue with the existing master map. In my environment, I do have
99% Solaris clients and I don't want to change master map for few
Linux clients. below is the auto_master map on Sun Directory Server

dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
automountinformation: nfs-cluster:/san/users/cmes/ahmedf
automountkey: ahmedf
objectclass: top
objectclass: automount


I am clueless.

On Thu, May 21, 2015 at 4:41 PM, Ian Kent <raven@themaw.net> wrote:
> On Thu, 2015-05-21 at 12:42 +1000, Sohnaeo wrote:
>> Hello Guys,
>>
>> I am having an issue with the autofs/automount on Cent OS 7, below is the detail
>>
>> LDAP Server
>>
>>
>> Solaris 10
>> Sun Directory Server 6.2
>>
>>
>> LDAP Client
>>
>>
>> CentOS 7
>>
>> OpenLdap
>>
>>
>> I issued the below command to enable LDAP authetication. LDAP users
>> can successfully authenticated now on CentOs
>>
>>  authconfig --enableldap --enableldapauth --ldapserver=x.x.x.x
>> --ldapbasedn=dc=drivess,dc=rtta --disablemkhomedir --update
>>
>> But somehow users home directories can't be mounted through autofs.
>> Below is my autofs.conf file
>>
>>  autofs
>> master_map_name = ldap://xxxxx/automountMapName=auto_master,dc=drivess,dc=rtaa
>> mount_nfs_default_protocol = 3
>> logging = debug
>> ldap_uri = "ldap://x.x.x.x"
>> search_base = "automountMapName=auto_master,dc=drivess,dc=rtaa"
>> map_object_class = automountMap
>> entry_object_class = automount
>> map_attribute = automountMapName
>> entry_attribute = automountKey
>> value_attribute= automountInformation
>> auth_conf_file = /etc/autofs_ldap_auth.conf
>> map_type = ldap
>>
>> When I run the below command , it throws an error
>>
>> automount -m
>> get_query_dn: lookup(ldap): found query dn
>> automountMapName=auto_master,dc=drivess,dc=rtaa
>> lookup_read_master: lookup(ldap): searching for
>> "(objectclass=automount)" under
>> "automountMapName=auto_master,dc=drivess,dc=rtaa"
>> lookup_read_master: lookup(ldap): examining entries
>> syntax error in map near  ahmedf nfs-cluster:
>>
>> Below is ldapsearch command result
>>   ldapsearch -x -b 'automountMapName=auto_master,dc=drivess,dc=rtaa'
>> "(objectClass=automountMap)"
>>
>> dn: automountMapName=auto_master,dc=drivess,dc=rtaa
>> automountMapName: auto_master
>> objectClass: top
>> objectClass: automountMap
>>
>>  ldapsearch -x -b
>> 'automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
>> dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
>> automountInformation: nfs-cluster:/san/users/cmes/ahmedf
>> automountKey: ahmedf
>> objectClass: automount
>> objectClass: top
>>
>> In short, automountInformation is nfs-cluster:/san/users/cmes/ahmedf
>> but somehow autmount is complaining "syntax error in map near [ ahmedf
>> nfs-cluster: ]"
>
> That's telling you that your master map is not right.
>
>>
>>
>> Any ideas?
>
> Have a look at the example in /usr/share/doc/autofs:
> ldap-automount-rfc2307-bis-auto.master
> ldap-automount-rfc2307-bis-auto.indirect
> ldap-automount-rfc2307-bis-auto.direct
>
> For the indirect mount case above you need master map ldap entries that
> contain an entry that specifies the indirect mount mount point and the
> map where the entries for that mount point are stored.
>
> Ian
>
>
>
