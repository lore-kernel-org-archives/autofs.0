From: Ian Kent <raven@themaw.net>
Subject: Re: Autmount issue
Date: Thu, 28 May 2015 09:46:22 +0800
Message-ID: <1432777582.3090.56.camel@pluto.fritz.box>
References: <CABJoi6w9OgxBtUSARsaAvxAWt_ViJzh_6BYn_g214KnwmRFMAw@mail.gmail.com>
	 <1432190476.4186.8.camel@pluto.fritz.box>
	 <CABJoi6zbw4wVni-kknMD=tVpFoqD32jc2PbbEP+CW2RU3zJ9tQ@mail.gmail.com>
	 <1432692464.2736.12.camel@pluto.fritz.box>
	 <1432698919.2736.13.camel@pluto.fritz.box>
	 <CABJoi6yDsfcUdd3-zRHKe-PcWLmF=RR59AXFBn5DBfN4CsEEbA@mail.gmail.com>
	 <1432725003.2736.33.camel@pluto.fritz.box>
	 <CABJoi6yUnnBcixd7J6e6ZRgN28PqXYKwPA69vSdMeh1C_Y39tw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=YRIeNev+PS2QZ99fmHMiSHPCRhc=; b=vi9Te+
	+ZHjoBbsLRFctywMKD5n2bK/XWxdvL+x1/wbM/SZlqypR2frAzv4GmQ0NZmxG4FF
	6gj6rRITlTJbCDCGyiYR3ok2Or3l5DOlCAvBoHp80Vm4469JCTqWzPj1nOCwytPU
	ik0NY4C6T5SPG9H8YGqFPbBTLWuuUTPpyZ6Zs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=YRIeNev+PS2QZ99
	fmHMiSHPCRhc=; b=a2A9q+iUP7KpOFRkMrVSuZypfcc39OS2zEVRMv8aSPBTOzx
	HK6j4c/nleVqYKNGJy3BcZQ5PGhiQyUTHr6GW6hBjVtGRPWph3m/yDGa2Ldcq33D
	MO5J+5ndzIiLRSWx4p512LSwZZCaWqgaCSAIuczxKSYD1ZeNdFIMon9SInrU=
In-Reply-To: <CABJoi6yUnnBcixd7J6e6ZRgN28PqXYKwPA69vSdMeh1C_Y39tw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sohnaeo <trysomefun@gmail.com>
Cc: autofs@vger.kernel.org

On Thu, 2015-05-28 at 10:00 +1000, Sohnaeo wrote:
> Hi Ian,
> 
> Thanks heaps looking further into this. We do have only one master map
> which is auto_home. You are right about auto_master, in fact in my
> LDAP server there was only auto_home but somehow Linux ldap client
> always looking for auto_master so I had to create auto_master and
> create a entry in it but then I hit syntax error. But anyways I
> reverted back to auto_home and fix things in autofs.conf and it looks
> much better now but still having syntax error. I try again to provide
> you as much as information as I can.

I don't think you understand the difference between the master map and
the maps that it refers to.

You need to look at the example maps I mentioned in the beginning.

The master map defines autofs managed mount points and specifies the map
they use.

There are other cases but I'm only going to describe a simple master map
with one entry that refers to an indirect map with three entries.

For example:

Create an ldap object to contain master map entries (one ldap container
entry is needed for each distinct map, a master map in this case):

dn: automountMapName=auto_master,dc=themaw,dc=net
objectClass: top
objectClass: automountMap
automountMapName: auto_master

Create ldap objects for each master map entry (only one entry in this
example):

dn: description=/ldap, automountMapName=auto_master,dc=themaw,dc=net
objectClass: top
objectClass: automount
automountKey: /ldap
automountInformation: auto_indirect
description: /ldap

These entries are equivalent to this in a file based master map (such
as /etc/auto_master):

/ldap               auto_indirect

Note: the first field, the key, is always an absolute path in the master
map (except for direct map entries, but I digress).

Then create an ldap object to contain the map entries for each map
referred to in the master map (only one in this example,
auto_indirect): 

dn: automountMapName=auto_indirect,dc=themaw,dc=net
objectClass: top
objectClass: automountMap
automountMapName: auto_indirect

Create ldap objects for each entry in the given map (auto_indirect with
three map entries in this case):

dn: automountKey=bin,automountMapName=auto_indirect,dc=themaw,dc=net
objectClass: top
objectClass: automount
automountKey: bin
automountInformation:   budgie:/usr/local/bin

dn: automountKey=etc,automountMapName=auto_indirect,dc=themaw,dc=net
objectClass: top
objectClass: automount
automountKey: etc
automountInformation:   budgie:/usr/local/etc

dn: automountKey=lib,automountMapName=auto_indirect,dc=themaw,dc=net
objectClass: top
objectClass: automount
automountKey: lib
automountInformation:   budgie:/usr/local/lib

These entries are equivalent to this in a file based indirect
map, /etc/auto_indirect:

bin           budgie:/usr/local/bin
etc           budgie:/usr/local/etc
lib           budgie:/usr/local/lib

Note that the first field is a single path component only without any
path component separators (again different for direct maps, but we
aren't talking about them here).

> 
> 
> LDAP Server:
> -----------------
> 
> dn: automountMapName=auto_home,dc=drivess,dc=rtaa
> aci: (target = ldap:///automountMapName=auto_home,dc=drivess,dc=rtaa)
> (targetscope = subtree) (targetattr="*") (version 3.0; acl "Adding
> automount"; allow (all, import, export, proxy) (userdn = "ldap:///all"
> or userdn = "ldap:///self" or userdn =
> "ldap:///cn=proxyagent,ou=profile,dc=drivess,dc=rtaa") ;)
> automountmapname: auto_home
> objectclass: top
> bjectclass: automountMap

Assuming "bjectclass" is a typo.

Given the above description this is not a master map, it's a container
for the map auto_home.

> 
> 
> dn: automountkey=ahmedf,automountMapName=auto_home,dc=drivess,dc=rtaa
> automountinformation: nfs-cluster:/san/users/cmes/ahmedf
> automountkey: ahmedf
> objectclass: top
> objectclass: automount

And this is a map entry belonging to auto_home.

You've not provided any master map ldap objects so I have no idea how
the above entries can be used but see below as it might become clear ...

> 
> 
> Linux client
> ----------------

Judging by the Solaris configuration below (and assuming it also has
"automount: files ldap" in /etc/nsswitch.conf you might have more
success with ...

> 
> autofs.conf
> 
> [ autofs ]
> master_map_name = "ldap://x.x.x.x/automountMapName=auto_home,dc=drivess,dc=rtaa"

Set this to auto_master and ensure /etc/auto_master exists so that the
"files" nsswitch source is used for the master map.

> ldap_uri = "ldap://x.x.x.x"
> search_base = "automountMapName=auto_home,dc=drivess,dc=rtaa

It's usually better to put the server address and ldap base
in /etc/openldap/ldap.conf.

In this case it should be:
BASE   dc=drivess,dc=rtaa
URI   ldap://x.x.x.x

> map_object_class = automountMap
> entry_object_class = automount
> map_attribute = automountMapName
> entry_attribute = automountKey
> value_attribute= automountInformation

If you create the ldap entries as described Linux should be able to work
this out automatically and I believe Solaris should still function.

> auth_conf_file = /etc/autofs_ldap_auth.conf


> normalize_slashes = "yes"
> ldap_base = "dc=drivess,dc=rtaa"
> ldap_base = "ldap://x.x.x.x/automountMapName=auto_home,dc=drivess,dc=rtaa"

There's no such configuration options as normalize_slashes or ldap_base
in the [ autofs ] section of the configuration (ie. Sun format maps).
They are only valid in the [ amd ] section (ie. for amd format maps).

> [ amd ]
> 
>  map_type = ldap

AFAICT you aren't using amd format maps so this is not used.

Now create /etc/auto_master as:
+auto_master
/net            -hosts          -nosuid,nobrowse,hard,intr
/home           auto_home       -nobrowse,hard,intr

or as:

/net            -hosts          -nosuid,nobrowse,hard,intr
/home           auto_home       -nobrowse,hard,intr
+auto_master

depending on whether you want to be able to override the file based
master map entries for /net or /home, in the former case, or override
master map ldap entries (if they exist) for the later case.

Ensure that /etc/auto_home does not exist so that the nsswitch.conf
entry "automount: files ldap" will not find a local auto_home and will
then look to ldap and should find the ldap auto_home map entries.

This approach is I think common on Solaris installs since it fits easily
with the default install.

Note that IIUC there's no ldap auto_master in your case so the plus map
inclusion of the master map ("+auto_master") will not find anything as
the "files" nsswitch source is skipped because plus map inclusion is
only allowed in file based maps.

> 
> 
> [root@splunk-tst ~]# automount -m
> lookup_nss_read_master: reading master ldap
> //x.x.x.x/automountMapName=auto_home,dc=drivess,dc=rtaa
> parse_server_string: lookup(ldap): Attempting to parse LDAP
> information from string
> "ldap://x.x.x.x/automountMapName=auto_home,dc=drivess,dc=rtaa".
> parse_server_string: lookup(ldap): server "ldap://x.x.x.x/", base dn
> "automountMapName=auto_home,dc=drivess,dc=rtaa"
> parse_ldap_config: lookup(ldap): ldap authentication configured with
> the following options:
> parse_ldap_config: lookup(ldap): use_tls: 0, tls_required: 0,
> auth_required: 1, sasl_mech: (null)
> parse_ldap_config: lookup(ldap): user: (null), secret: unspecified,
> client principal: (null) credential cache: (null)
> parse_init: parse(sun): init gathered global options: (null)
> spawn_mount: mtab link detected, passing -n to mount
> spawn_umount: mtab link detected, passing -n to mount
> do_bind: lookup(ldap): auth_required: 1, sasl_mech (null)
> do_bind: lookup(ldap): ldap simple bind returned 0
> get_query_dn: lookup(ldap): found query dn
> automountMapName=auto_home,dc=drivess,dc=rtaa
> lookup_read_master: lookup(ldap): searching for
> "(objectclass=automount)" under
> "automountMapName=auto_home,dc=drivess,dc=rtaa"
> lookup_read_master: lookup(ldap): examining entries
> syntax error in map near [ adels nfs-cluster: ]
> syntax error in map near [ san ]
> syntax error in map near [ users ]
> syntax error in map near [ ad ]
> syntax error in map near [ soma ]
> 
> 
> 
> [root@splunk-tst ~]# more /etc/nsswitch.conf|grep autom
> automount:  files ldap
> 
> 
> 
> Working through auto.home on Linux clients
> ===============================
> 
> [root@splunk-tst ~]# more /etc/autofs.conf |grep auto.master
> 
> master_map_name = auto.master
> 
> 
> I can make it work through auto.master like below but I wanted to
> mount the users home directory via LDAP automount
> 
> [root@splunk-tst ~]# more /etc/auto.master
> /home /etc/auto.home
> /net  -hosts
> +auto.master
> 
> [root@splunk-tst ~]# more /etc/auto.home
> * -fstype=nfs,rw nfs-cluster:/san/users/cmes/& \
>                  nfs-cluster:/san/users/techdev/& \
>                  nfs-cluster:/san/users/ad/& \
>                  nfs-cluster:/san/users/systest/&
> 
> 
> [root@splunk-tst ~]# cat /etc/mtab |grep autofs
> systemd-1 /proc/sys/fs/binfmt_misc autofs
> rw,relatime,fd=34,pgrp=1,timeout=300,minproto=5,maxproto=5,direct 0 0
> /etc/auto.home /home autofs
> rw,relatime,fd=7,pgrp=10163,timeout=300,minproto=5,maxproto=5,indirect
> 0 0
> -hosts /net autofs
> rw,relatime,fd=13,pgrp=10163,timeout=300,minproto=5,maxproto=5,indirect
> 0 0
> 
> 
> 
> Solaris Client
> --------
> 
> I can login as LDAP user and my home directory mounted in right way
> through automount
> 
> asqcsat:/ # more /etc/auto_master
> 
> +auto_master
> /net            -hosts          -nosuid,nobrowse,hard,intr
> /home           auto_home       -nobrowse,hard,intr
> 
> asqcsat:/ # more /etc/auto_home
> 
> +auto_home
> 
> On Wed, May 27, 2015 at 9:10 PM, Ian Kent <raven@themaw.net> wrote:
> > On Wed, 2015-05-27 at 17:38 +1000, Sohnaeo wrote:
> >> Hi Ian,
> >>
> >> Here is the mnttab of Solaris client
> >>
> >> asqcsat:/ # cat /etc/mnttab |grep autofs
> >
> > So there is no auto_master references here so why does your ldap entry
> > say it belongs to auto_master?
> >
> > Perhaps you load the master map from a file, what's in /etc/auto_master?
> >
> >>
> >> -hosts  /net    autofs
> >> nosuid,indirect,ignore,nobrowse,zone=asqcsat,dev=5340047
> >> 1430995592
> >> auto_home       /home   autofs
> >> nodevices,indirect,ignore,nobrowse,zone=asqcsat,dev=5340048
> >> 1430995592
> >
> > I'd think the ldap entry you mentioned would belong to this indirect
> > mount map, auto_home and not auto_master.
> >
> >> -hosts  /net/nfs-cluster/san    autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340061    1430995660
> >> -hosts  /net/nfs-cluster/san/sys        autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340062    1430995660
> >> -hosts  /net/nfs-cluster/san/www        autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340063    1430995660
> >> -hosts  /net/nfs-cluster/san/appl       autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340064    1430995660
> >> -hosts  /net/nfs-cluster/san/gen85      autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340065    1430995660
> >> -hosts  /net/nfs-cluster/san/nottn      autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340066    1430995660
> >> -hosts  /net/nfs-cluster/san/model      autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340067    1430995660
> >> -hosts  /net/nfs-cluster/san/users      autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340068    1430995660
> >> -hosts  /net/nfs-cluster/san/project    autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=5340069    1430995660
> >> -hosts  /net/nfs-cluster/san/workdmp    autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=534006a    1430995660
> >> -hosts  /net/nfs-cluster/san/repository autofs
> >> nosuid,ignore,nest,nobrowse,zone=asqcsat,dev=534006b    1430995660
> >
> > Right, a few host map entries have been accessed by the look of it.
> >
> >>
> >> Users home directories are on NFS, path is nfs-cluster:/san/users/
> >
> > Yes but the ldap entry below doesn't quite match that either.
> >
> >>dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
> >
> > So the automountMapName possibly should be auto_home but ...
> >
> >>automountinformation: nfs-cluster:/san/users/cmes/ahmedf
> >
> > the key should be cmes and not ahmedf or perhaps the
> > automountInformation should be nfs-cluster:/san/users/ahmedf
> > but I don't know what your trying to achieve and I don't know what else
> > you have in ldap.
> >
> >>automountkey: ahmedf
> >>objectclass: top
> >>objectclass: automount
> >
> > What do you have in /etc/nsswitch.conf?
> > Presumably it's "automount: files ldap" or "automount: ldap", I can't
> > tell from this.
> >
> > In any case Linux autofs is not tolerant of configurations that aren't
> > quite right and won't just ignore them as Solaris seems to do in some
> > cases. Perhaps this is the source of the problem.
> >
> > Really, putting map entries in what should be the master map is the
> > wrong thing to do and will lead to even more confusion later. For
> > example, what if you have two distinct indirect maps that have some keys
> > of the same name but point to different mount locations, how will the
> > key lookup work out which key belongs to what map?
> >
> > Even if putting them in the master map ldap object works I recommend
> > separating them to be under specific map object holders as is seen in
> > the example I originally pointed you at. It will be much easier to
> > maintain, especially if your maps grow over time (as most do).
> >
> >>
> >> Regards,
> >>
> >> Farhan
> >>
> >>
> >> On Wed, May 27, 2015 at 1:55 PM, Ian Kent <raven@themaw.net> wrote:
> >> > On Wed, 2015-05-27 at 10:07 +0800, Ian Kent wrote:
> >> >> On Tue, 2015-05-26 at 16:31 +1000, Sohnaeo wrote:
> >> >> > Hello Ian,
> >> >> >
> >> >> > Thank you very much for looking into this. Solaris clients didn't have
> >> >> > any issue with the existing master map. In my environment, I do have
> >> >> > 99% Solaris clients and I don't want to change master map for few
> >> >> > Linux clients. below is the auto_master map on Sun Directory Server
> >> >> >
> >> >> > dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
> >> >> > automountinformation: nfs-cluster:/san/users/cmes/ahmedf
> >> >> > automountkey: ahmedf
> >> >> > objectclass: top
> >> >> > objectclass: automount
> >> >>
> >> >> I don't see how that could work, it's not a master map entry, it's a map
> >> >> entry.
> >> >>
> >> >> The problem with this entry is it doesn't provide the information about
> >> >> what indirect mount this key belongs to?
> >> >>
> >> >> You'll need to give me more info about what's in ldap and what the
> >> >> mounts look like after automount is started on Solaris.
> >> >>
> >> >> Start autofs on an idle system, do nothing else, and post the contents
> >> >> of /etc/mnttab (assuming that hasn't changed over the years since I
> >> >> worked on Solaris systems). If there are obvious things you don't want
> >> >> people to see in it then delete those lines but don't delete autofs
> >> >> related lines.
> >> >
> >> > And what path do you use to cause this entry to mount?
> >> >
> >> >>
> >> >> If you want you could log a bug at bugzilla.redhat.com and have it made
> >> >> private to so the information isn't available to people not included on
> >> >> the cc list or allowed groups.
> >> >>
> >> >> >
> >> >> >
> >> >> > I am clueless.
> >> >> >
> >> >> > On Thu, May 21, 2015 at 4:41 PM, Ian Kent <raven@themaw.net> wrote:
> >> >> > > On Thu, 2015-05-21 at 12:42 +1000, Sohnaeo wrote:
> >> >> > >> Hello Guys,
> >> >> > >>
> >> >> > >> I am having an issue with the autofs/automount on Cent OS 7, below is the detail
> >> >> > >>
> >> >> > >> LDAP Server
> >> >> > >>
> >> >> > >>
> >> >> > >> Solaris 10
> >> >> > >> Sun Directory Server 6.2
> >> >> > >>
> >> >> > >>
> >> >> > >> LDAP Client
> >> >> > >>
> >> >> > >>
> >> >> > >> CentOS 7
> >> >> > >>
> >> >> > >> OpenLdap
> >> >> > >>
> >> >> > >>
> >> >> > >> I issued the below command to enable LDAP authetication. LDAP users
> >> >> > >> can successfully authenticated now on CentOs
> >> >> > >>
> >> >> > >>  authconfig --enableldap --enableldapauth --ldapserver=x.x.x.x
> >> >> > >> --ldapbasedn=dc=drivess,dc=rtta --disablemkhomedir --update
> >> >> > >>
> >> >> > >> But somehow users home directories can't be mounted through autofs.
> >> >> > >> Below is my autofs.conf file
> >> >> > >>
> >> >> > >>  autofs
> >> >> > >> master_map_name = ldap://xxxxx/automountMapName=auto_master,dc=drivess,dc=rtaa
> >> >> > >> mount_nfs_default_protocol = 3
> >> >> > >> logging = debug
> >> >> > >> ldap_uri = "ldap://x.x.x.x"
> >> >> > >> search_base = "automountMapName=auto_master,dc=drivess,dc=rtaa"
> >> >> > >> map_object_class = automountMap
> >> >> > >> entry_object_class = automount
> >> >> > >> map_attribute = automountMapName
> >> >> > >> entry_attribute = automountKey
> >> >> > >> value_attribute= automountInformation
> >> >> > >> auth_conf_file = /etc/autofs_ldap_auth.conf
> >> >> > >> map_type = ldap
> >> >> > >>
> >> >> > >> When I run the below command , it throws an error
> >> >> > >>
> >> >> > >> automount -m
> >> >> > >> get_query_dn: lookup(ldap): found query dn
> >> >> > >> automountMapName=auto_master,dc=drivess,dc=rtaa
> >> >> > >> lookup_read_master: lookup(ldap): searching for
> >> >> > >> "(objectclass=automount)" under
> >> >> > >> "automountMapName=auto_master,dc=drivess,dc=rtaa"
> >> >> > >> lookup_read_master: lookup(ldap): examining entries
> >> >> > >> syntax error in map near  ahmedf nfs-cluster:
> >> >> > >>
> >> >> > >> Below is ldapsearch command result
> >> >> > >>   ldapsearch -x -b 'automountMapName=auto_master,dc=drivess,dc=rtaa'
> >> >> > >> "(objectClass=automountMap)"
> >> >> > >>
> >> >> > >> dn: automountMapName=auto_master,dc=drivess,dc=rtaa
> >> >> > >> automountMapName: auto_master
> >> >> > >> objectClass: top
> >> >> > >> objectClass: automountMap
> >> >> > >>
> >> >> > >>  ldapsearch -x -b
> >> >> > >> 'automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
> >> >> > >> dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
> >> >> > >> automountInformation: nfs-cluster:/san/users/cmes/ahmedf
> >> >> > >> automountKey: ahmedf
> >> >> > >> objectClass: automount
> >> >> > >> objectClass: top
> >> >> > >>
> >> >> > >> In short, automountInformation is nfs-cluster:/san/users/cmes/ahmedf
> >> >> > >> but somehow autmount is complaining "syntax error in map near [ ahmedf
> >> >> > >> nfs-cluster: ]"
> >> >> > >
> >> >> > > That's telling you that your master map is not right.
> >> >> > >
> >> >> > >>
> >> >> > >>
> >> >> > >> Any ideas?
> >> >> > >
> >> >> > > Have a look at the example in /usr/share/doc/autofs:
> >> >> > > ldap-automount-rfc2307-bis-auto.master
> >> >> > > ldap-automount-rfc2307-bis-auto.indirect
> >> >> > > ldap-automount-rfc2307-bis-auto.direct
> >> >> > >
> >> >> > > For the indirect mount case above you need master map ldap entries that
> >> >> > > contain an entry that specifies the indirect mount mount point and the
> >> >> > > map where the entries for that mount point are stored.
> >> >> > >
> >> >> > > Ian
> >> >> > >
> >> >> > >
> >> >> > >
> >> >>
> >> >>
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe autofs" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >
> >> >
> >
> >


