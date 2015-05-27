From: Sohnaeo <trysomefun@gmail.com>
Subject: Re: Autmount issue
Date: Wed, 27 May 2015 17:38:29 +1000
Message-ID: <CABJoi6yDsfcUdd3-zRHKe-PcWLmF=RR59AXFBn5DBfN4CsEEbA@mail.gmail.com>
References: <CABJoi6w9OgxBtUSARsaAvxAWt_ViJzh_6BYn_g214KnwmRFMAw@mail.gmail.com>
	<1432190476.4186.8.camel@pluto.fritz.box>
	<CABJoi6zbw4wVni-kknMD=tVpFoqD32jc2PbbEP+CW2RU3zJ9tQ@mail.gmail.com>
	<1432692464.2736.12.camel@pluto.fritz.box>
	<1432698919.2736.13.camel@pluto.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4+ss+ps0sHUC+Hji/SHuZMGNnMz9K6AfF9gPKdP42Bk=;
        b=EPhLR8iKt9iMp02fccjOygzrrfmlkTn6ip9tGHPp7JqOnj2/M++TayWL9ZVdbVfm+i
         Sr+autd1LpSif3cMrkOAtia9CJ86m9rKLuQsiyq5bb6f0NQ+cKdXEb/qX/p8+ejvxeTv
         79CrO6XdOV9lD4V7Te0V+KzsFAgIZfkAlrSwzejfKEDq/uEo3GwxWVe8uBO3ql8BFp/c
         BsFZsUOYNClDaYqsVQOOwYZx8j6pa2CupkU7r3ZPM/P5KtPAA0PvO33cdsrc7g7sjOVX
         FAP60Vdgln0Lxo7jiYFKk0O+iY1plDJyZZw+rawmx1raOryEJvqyeuCuSVbtcAnUWoi5
         7fHg==
In-Reply-To: <1432698919.2736.13.camel@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hi Ian,

Here is the mnttab of Solaris client

asqcsat:/ # cat /etc/mnttab |grep autofs

-hosts  /net    autofs
nosuid,indirect,ignore,nobrowse,zone=asqcsat,dev=5340047
1430995592
auto_home       /home   autofs
nodevices,indirect,ignore,nobrowse,zone=asqcsat,dev=5340048
1430995592
-hosts  /net/nfs-cluster/san    autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340061    1430995660
-hosts  /net/nfs-cluster/san/sys        autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340062    1430995660
-hosts  /net/nfs-cluster/san/www        autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340063    1430995660
-hosts  /net/nfs-cluster/san/appl       autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340064    1430995660
-hosts  /net/nfs-cluster/san/gen85      autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340065    1430995660
-hosts  /net/nfs-cluster/san/nottn      autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340066    1430995660
-hosts  /net/nfs-cluster/san/model      autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340067    1430995660
-hosts  /net/nfs-cluster/san/users      autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340068    1430995660
-hosts  /net/nfs-cluster/san/project    autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340069    1430995660
-hosts  /net/nfs-cluster/san/workdmp    autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=534006a    1430995660
-hosts  /net/nfs-cluster/san/repository autofs
nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=534006b    1430995660

Users home directories are on NFS, path is nfs-cluster:/san/users/

Regards,

Farhan


On Wed, May 27, 2015 at 1:55 PM, Ian Kent <raven@themaw.net> wrote:
> On Wed, 2015-05-27 at 10:07 +0800, Ian Kent wrote:
>> On Tue, 2015-05-26 at 16:31 +1000, Sohnaeo wrote:
>> > Hello Ian,
>> >
>> > Thank you very much for looking into this. Solaris clients didn't have
>> > any issue with the existing master map. In my environment, I do have
>> > 99% Solaris clients and I don't want to change master map for few
>> > Linux clients. below is the auto_master map on Sun Directory Server
>> >
>> > dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
>> > automountinformation: nfs-cluster:/san/users/cmes/ahmedf
>> > automountkey: ahmedf
>> > objectclass: top
>> > objectclass: automount
>>
>> I don't see how that could work, it's not a master map entry, it's a map
>> entry.
>>
>> The problem with this entry is it doesn't provide the information about
>> what indirect mount this key belongs to?
>>
>> You'll need to give me more info about what's in ldap and what the
>> mounts look like after automount is started on Solaris.
>>
>> Start autofs on an idle system, do nothing else, and post the contents
>> of /etc/mnttab (assuming that hasn't changed over the years since I
>> worked on Solaris systems). If there are obvious things you don't want
>> people to see in it then delete those lines but don't delete autofs
>> related lines.
>
> And what path do you use to cause this entry to mount?
>
>>
>> If you want you could log a bug at bugzilla.redhat.com and have it made
>> private to so the information isn't available to people not included on
>> the cc list or allowed groups.
>>
>> >
>> >
>> > I am clueless.
>> >
>> > On Thu, May 21, 2015 at 4:41 PM, Ian Kent <raven@themaw.net> wrote:
>> > > On Thu, 2015-05-21 at 12:42 +1000, Sohnaeo wrote:
>> > >> Hello Guys,
>> > >>
>> > >> I am having an issue with the autofs/automount on Cent OS 7, below is the detail
>> > >>
>> > >> LDAP Server
>> > >>
>> > >>
>> > >> Solaris 10
>> > >> Sun Directory Server 6.2
>> > >>
>> > >>
>> > >> LDAP Client
>> > >>
>> > >>
>> > >> CentOS 7
>> > >>
>> > >> OpenLdap
>> > >>
>> > >>
>> > >> I issued the below command to enable LDAP authetication. LDAP users
>> > >> can successfully authenticated now on CentOs
>> > >>
>> > >>  authconfig --enableldap --enableldapauth --ldapserver=x.x.x.x
>> > >> --ldapbasedn=dc=drivess,dc=rtta --disablemkhomedir --update
>> > >>
>> > >> But somehow users home directories can't be mounted through autofs.
>> > >> Below is my autofs.conf file
>> > >>
>> > >>  autofs
>> > >> master_map_name = ldap://xxxxx/automountMapName=auto_master,dc=drivess,dc=rtaa
>> > >> mount_nfs_default_protocol = 3
>> > >> logging = debug
>> > >> ldap_uri = "ldap://x.x.x.x"
>> > >> search_base = "automountMapName=auto_master,dc=drivess,dc=rtaa"
>> > >> map_object_class = automountMap
>> > >> entry_object_class = automount
>> > >> map_attribute = automountMapName
>> > >> entry_attribute = automountKey
>> > >> value_attribute= automountInformation
>> > >> auth_conf_file = /etc/autofs_ldap_auth.conf
>> > >> map_type = ldap
>> > >>
>> > >> When I run the below command , it throws an error
>> > >>
>> > >> automount -m
>> > >> get_query_dn: lookup(ldap): found query dn
>> > >> automountMapName=auto_master,dc=drivess,dc=rtaa
>> > >> lookup_read_master: lookup(ldap): searching for
>> > >> "(objectclass=automount)" under
>> > >> "automountMapName=auto_master,dc=drivess,dc=rtaa"
>> > >> lookup_read_master: lookup(ldap): examining entries
>> > >> syntax error in map near  ahmedf nfs-cluster:
>> > >>
>> > >> Below is ldapsearch command result
>> > >>   ldapsearch -x -b 'automountMapName=auto_master,dc=drivess,dc=rtaa'
>> > >> "(objectClass=automountMap)"
>> > >>
>> > >> dn: automountMapName=auto_master,dc=drivess,dc=rtaa
>> > >> automountMapName: auto_master
>> > >> objectClass: top
>> > >> objectClass: automountMap
>> > >>
>> > >>  ldapsearch -x -b
>> > >> 'automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
>> > >> dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
>> > >> automountInformation: nfs-cluster:/san/users/cmes/ahmedf
>> > >> automountKey: ahmedf
>> > >> objectClass: automount
>> > >> objectClass: top
>> > >>
>> > >> In short, automountInformation is nfs-cluster:/san/users/cmes/ahmedf
>> > >> but somehow autmount is complaining "syntax error in map near [ ahmedf
>> > >> nfs-cluster: ]"
>> > >
>> > > That's telling you that your master map is not right.
>> > >
>> > >>
>> > >>
>> > >> Any ideas?
>> > >
>> > > Have a look at the example in /usr/share/doc/autofs:
>> > > ldap-automount-rfc2307-bis-auto.master
>> > > ldap-automount-rfc2307-bis-auto.indirect
>> > > ldap-automount-rfc2307-bis-auto.direct
>> > >
>> > > For the indirect mount case above you need master map ldap entries that
>> > > contain an entry that specifies the indirect mount mount point and the
>> > > map where the entries for that mount point are stored.
>> > >
>> > > Ian
>> > >
>> > >
>> > >
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe autofs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
