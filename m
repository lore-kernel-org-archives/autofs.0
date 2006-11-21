From: "Shawn Starr" <sstarr@platform.com>
Subject: Re: Automount with a local NFS export and a remote NFS
	export using the same mount path name over LDAP
Date: Tue, 21 Nov 2006 16:35:18 -0500
Message-ID: <E2AC825D4FC7764DA86D9C8ECA27A2DEAF7B3C@catoexm05.noam.corp.platform.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org


>Ok, so you basically want included map support.  You are right, I did post
>a patch to implement this, but it is quite a beast, so I wouldn't expect it
>to get released straight away (these things require gobs of testing).

>In the interim, you can use something like the following local master map
>entry:

>/etc/auto.master:
>/home   multi:file /etc/auto.home -- ldap auto.home

>I think that will do what you need.  If not, I'll give it another try.  ;)

>-Jeff

Nov 21 16:31:04 rocksfe1 automount[10044]: nsswitch: couldn't find map auto.home
Nov 21 16:31:04 rocksfe1 automount[10044]: lookup(ldap): query failed for (objectclass=nisObject)
Nov 21 16:31:04 rocksfe1 automount[10044]: lookup(ldap): query failed for (objectclass=automount)

It seems it can't find what the automount is, yet I'm not sure why its not able to find 
the automount maps (ignoring NIS objects which I don't have)

My nsswitch.conf has files only since multi:file would also check a remote ldap for its auto.home LDAP entry.

# ldapsearch -x "(&(objectclass=automount))"
# extended LDIF
#
# LDAPv3
# base <> with scope sub
# filter: (&(objectclass=automount))
# requesting: ALL
#

# /home, auto.master, autofs, platform.com
dn: cn=/home,ou=auto.master,ou=autofs,dc=platform,dc=com
objectClass: top
objectClass: automount
cn: /home
automountInformation: ldap:ou=auto.home,ou=autofs,dc=platform,dc=com

# sstarr, auto.home, autofs, platform.com
dn: cn=sstarr,ou=auto.home,ou=autofs,dc=platform,dc=com
objectClass: top
objectClass: automount
cn: sstarr
automountInformation: -fstype=nfs,hard,intr,nodev,nosuid somehostname.lsf.platform
 .com:/home:&

# search result
search: 2
result: 0 Success

# numResponses: 3
# numEntries: 2

Thanks, 
Shawn.
