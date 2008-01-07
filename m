From: "Knops, Manfred" <Manfred.KNOPS@3ds.com>
Subject: Re: master_notify: syntax error in map near [ bogus	option
 ]
Date: Mon, 07 Jan 2008 08:06:45 +0100
Message-ID: <4781CF85.4010800@3ds.com>
References: <477CD7B8.1070002@3ds.com> <477CFF21.20309@3ds.com>
	<1199411144.3288.15.camel@raven.themaw.net>
Reply-To: Manfred.KNOPS@3ds.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1199411144.3288.15.camel@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> (...)
> Not really a mistake. Version 5 is more strict about this but don't be
> surprised if it starts to work again in later revisions because lot of
> people do seem to use this even though it's not specified as valid.
> 
> The valid formats are ldap:[server:]dn or, more recently,
> ldap:[//server/]dn, although the man page seems a little unclear now I
> look at it. There are further restrictions on the dn in that it needs to
> be either a map name alone or a full dn string including the base.
Ok, thank you for this information. I checked the documenation on 
opensuse 10.3. They use version 5.0.2. And they wrote:

dn: cn=/mounts,nisMapName=auto.master,ou=AUTOFS,dc=example,dc=org
objectClass: nisObject
nisMapName: auto.master
cn: /mounts
nisMapEntry: ldap 
ldapserver.example.org:nisMapName=auto.mounts,ou=AUTOFS,dc=example,dc=org

So I will try to use ldap://server/dn on opensuse to make ldap 
replication possible.

> (...)
> Does this same connection information work OK for ldapsearch?
Yes, it works.
[userB@hostB ~]# ldapsearch -v "(objectClass=automountMap)"
ldap_initialize( <DEFAULT> )
SASL/DIGEST-MD5 authentication started
Please enter your password:
SASL username: ldap
SASL SSF: 128
SASL installing layers
filter: (objectClass=automountMap)
requesting: All userApplication attributes
# extended LDIF
#
# LDAPv3[root@kerberos ~]# ldapwhoami -U ldap -X u:ldap
SASL/DIGEST-MD5 authentication started
Please enter your password:
SASL username: u:ldap
SASL SSF: 128
SASL installing layers
dn:uid=ldap,ou=users,dc=abaqus,dc=de
Result: Success (0)

# base <> with scope subtree
# filter: (objectClass=automountMap)
# requesting: ALL
#

# auto.home, automount, abaqus.de
dn: automountMapName=auto.home,ou=automount,dc=abaqus,dc=de
objectClass: top
objectClass: automountMap
automountMapName: auto.home
description: This chapter is analog to /etc/auto.home

# auto.master, automount, abaqus.de
dn: automountMapName=auto.master,ou=automount,dc=abaqus,dc=de
objectClass: top
objectClass: automountMap
automountMapName: auto.master
description: This chapter is analog to the file /etc/auto.master

# search result
search: 3
result: 0 Success

# numResponses: 3
# numEntries: 2



testsaslauthd also works fine:
[userB@hostB ~]# testsaslauthd -u ldap -p ldap
0: OK "Success."



ldapwhoami also works fine:
[userB@hostB ~]# ldapwhoami -U ldap -X u:ldap
SASL/DIGEST-MD5 authentication started
Please enter your password:
SASL username: u:ldap
SASL SSF: 128
SASL installing layers
dn:uid=ldap,ou=users,dc=abaqus,dc=de
Result: Success (0)


It also work for automount. Because /net mount with /etc/auto.net works:
Jan  4 09:35:19 kerberos automount[18890]: mounted indirect mount on 
/net with timeout 60, freq 15 seconds

He got this information from ldap:
[userB@hostB ~]# ldapsearch 
"(&(objectClass=automount)(automountKey=/net))" -LLL
SASL/DIGEST-MD5 authentication started
Please enter your password:
SASL username: ldap
SASL SSF: 128
SASL installing layers
dn: 
automountKey=/net,automountMapName=auto.master,ou=automount,dc=abaqus,dc=de
objectClass: top
objectClass: automount
automountKey: /net
automountInformation: /etc/auto.net --timeout=60

He also notice that /home are a mount point. He found this information 
in ldap. So he got a connection. But he doesn't read the mount options:
Jan  4 09:35:19 kerberos automount[18890]: mount_autofs_indirect: failed 
to read map for /home

And I don't know why.
Manfred
