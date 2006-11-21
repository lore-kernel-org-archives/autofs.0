From: "Shawn Starr" <sstarr@platform.com>
Subject: Re: Automount with a local NFS export and a remote NFS
	export using the same mount path name over LDAP
Date: Tue, 21 Nov 2006 15:12:46 -0500
Message-ID: <E2AC825D4FC7764DA86D9C8ECA27A2DE065AFA@catoexm05.noam.corp.platform.com>
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

==> Regarding RE: [autofs] Automount with a local NFS export and a remote NFS export using the same mount path name over LDAP; "Shawn Starr" 
>I re-read your original problem statement, and I am officially confused.
>What, exactly, are you trying to accomplish?

>Do you want to merge the contents of two master maps?  If so, set
>ONE_AUTO_MASTER=0.

>Do you want to merge the contents of two indirect maps?  If so, try reading
>up on multi-maps.  This allows one to merge the contents of two or more
>maps, potentially from different sources.

>If neither of these is what you are trying to do, then please provide a
>better explanation of the problem.  Post your maps, and give concrete
>examples with machine names, exports, and intended use.

>-Jeff

Hi Jeff, Here's what I'm trying to do:

On a local machine (10.1.1.75) I have the following configuration:

/etc/exports:
=========
/export 10.0.0.0/255.0.0.0(rw,async)


/etc/auto.home:
===========

install         10.1.1.75:/export/home/&
+auto.home

/etc/auto.master:
============
/home  /etc/auto.home --ghost

On the local machine, /home is NFS exported so: /home/install is visible when using automount.


On a remote machine (somehostname.platform.com) I have the following configuration:

/etc/exports:
=========
/home   *(rw,async)


auto.master: LDAP map
===============

dn: ou=autofs,dc=platform,dc=com
objectClass: top
objectClass: organizationalUnit
ou: autofs

dn: ou=auto.master,ou=autofs,dc=platform,dc=com
objectClass: top
objectCLass: automountMap
ou: auto.master

dn: cn=/home,ou=auto.master,ou=autofs,dc=platform,dc=com
objectClass: top
objectClass: automount
cn: /home
automountInformation: ldap:ou=auto.home,ou=autofs,dc=platform,dc=com

auto.home:  LDAP map
===============

dn: ou=auto.home,ou=autofs,dc=platform,dc=com
objectClass: top
objectClass: automountMap
ou: auto.home

dn: cn=sstarr,ou=auto.home,ou=autofs,dc=platform,dc=com
objectClass: top
objectClass: automount
cn: sstarr
automountInformation: -fstype=nfs,hard,intr,nodev,nosuid somehostname.platform.com:/home:&


The goal is to be able to share /home from *both* NFS exports and combine them like NIS does (with +auto.home).

So on the local machine: if I do cd /home/install or cd /home/sstarr I can see both as if they were one mounted point.

I can do this if I add the following to my LDAP maps:

dn: cn=install,ou=auto.home,ou=autofs,dc=platform,dc=com
objectClass: top
objectClass: automount
cn: install
automountInformation: 10.1.1.75:/export/home/install

Which basically does what I'm trying to do, but its a hack since I have to use an LDAP entry instead of using the local 10.1.1.75 /etc/auto.home mapping

On the 10.1.1.75 local machine I have the /etc/nsswitch.conf as:  automount: files ldap

If it finds valid automounts in the 10.1.1.75's local /etc/auto.master it ignores the LDAP maps so I only get one automount set up. This isn't the behavour I'm looking for. I need a way to tell automount that even though it found valid maps in /etc/auto.master, look for additional maps from LDAP also.

I hope this clears things up :-)

Thanks,
Shawn.
