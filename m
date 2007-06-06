From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 + ldap
Date: Wed, 06 Jun 2007 21:46:17 +0800
Message-ID: <1181137577.3699.49.camel@raven.themaw.net>
References: <370788.91736.qm@web90501.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <370788.91736.qm@web90501.mail.mud.yahoo.com>
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
To: Phy Prabab <phyprabab@yahoo.com>
Cc: autofs@linux.kernel.org

On Sat, 2007-05-12 at 22:35 -0700, Phy Prabab wrote:
> Hello!
> 
> I am having some issues with autofs5 + ldap configuration, I just can
> not seem to get autofs to read the auto_master map out of ldap.  I
> have tried unsuccessfully using the "samples" and my previous
> configuration (autofs414 which does work with ldap).  I tried to use
> the /etc/sysconfig/autofs config file paralleling the sample but using
> my ldap settings as well as using /etc/auto.master again using my ldap
> settings, both to no avail.  I know the ldap settings are correct, I
> can search the ldap server without any issues and I am using it to
> authenticate (i.e. passwords).
> 
> If anyone could lend me a suggestion, I would be most grateful.
> TIA,
> Phy
> 
> 
> [root@b~]# cat /etc/auto.master
> dn:
> automountMapName=auto_master,ou=automount,ou=defaults,ou=sanjose,ou=services,o=cadence.com
> objectClass: top
> objectClass: automountMap
> automountMapName: auto_master
> #+auto.master

Master map entries don't look like this.

In the samples directory look for auto.master.ldap for an example of an
a file based ldap master map.

If you want the master map itself to be stored in LDAP look at the
samples ldap-automount-* and ldap-nis-* for examples of what to store in
LDAP for the various schema that you can use.

To be honest, if you just want to use only LDAP, it's much easier not to
put any LDAP specific information in the map entries and ensure
that /etc/nsswitch.conf has

automount: ldap 

and use LDAP entries like the ones below. autofs will find the LDAP
server and locate the entries for you as long as the ldap client
configuration has which server to contact setup which is verified by
using ldapsearch, as you have done.

The autofs default master map name is auto.master so be sure to use that
at least until you have a working configuration.

This example (produced in LDIF format) assumes you have enabled the
schema below in the autofs configuration by changing:

#MAP_OBJECT_CLASS="automountMap"
#ENTRY_OBJECT_CLASS="automount"
#MAP_ATTRIBUTE="ou"
#ENTRY_ATTRIBUTE="cn"
#VALUE_ATTRIBUTE="automountInformation"

to

MAP_OBJECT_CLASS="automountMap"
ENTRY_OBJECT_CLASS="automount"
MAP_ATTRIBUTE="ou"
ENTRY_ATTRIBUTE="cn"
VALUE_ATTRIBUTE="automountInformation"

Otherwise the internal system default schema is the old NIS schema.

For the master map, first the container object (this is used to work out
the base dn for searches for map entries in this map):

dn: ou=auto.master,dc=bogus
objectClass: top
objectClass: automountMap
ou: auto.master

Then the master map entries themselves (in this case just one):

dn: cn=/ldap,ou=auto.master,dc=bogus
objectClass: automount
cn: /ldap
automountInformation: auto.indirect

Then the container for the corresponding master map entry above (again,
this is used to work out the base dn for searches for map entries in
this map):

dn: ou=auto.indirect,dc=bogus
objectClass: top
objectClass: automountMap
ou: auto.indirect

and the entries for the auto.indirect map itself:

dn: cn=bin,ou=auto.indirect,dc=bogus
objectClass: automount
cn: bin
automountInformation:   budgie:/usr/local/bin

dn: cn=etc,ou=auto.indirect,dc=bogus
objectClass: automount
cn: etc
automountInformation:   budgie:/usr/local/etc

dn: cn=lib,ou=auto.indirect,dc=bogus
objectClass: automount
cn: lib
automountInformation:   budgie:/usr/local/lib

dn: cn=/,ou=auto.indirect,dc=bogus
objectClass: automount
cn: /
automountInformation:   budgie:/usr/local/&


> [root@b ~]# 
> 
> [root@b ~]# /usr/sbin/automount --version
> 
> Linux automount version 5.0.1
> 
> Directories:
>         config dir:     /etc/sysconfig
>         maps dir:       /etc
>         modules dir:    /usr/local/autofs501p1/lib/autofs
> 
> Compile options:
>   ENABLE_IGNORE_BUSY_MOUNTS WITH_LDAP 
> 
> [root@b ~]# ldapsearch -x -b 'ou=default,ou=region,o=test.com'
> automountMapName=auto_master
> version: 2
> 
> #
> # filter: automountMapName=auto_master
> # requesting: ALL
> #
> 
> # auto_master, automount, Default, region, test.com
> dn:
> automountMapName=auto_master,ou=automount,ou=Default,ou=region,ou=test.com
> objectClass: top
> objectClass: automountMap
> objectClass: nisMap
> automountMapName: auto_master
> nisMapName: auto_master
> 
> # search result
> search: 2
> result: 0 Success
> 
> # numResponses: 2
> # numEntries: 1
> [root@b ~]# uname -a
> Linux host1.test.com 2.6.21.1 #1 SMP Wed May 9 08:54:29 PDT 2007 i686
> athlon i386 GNU/Linux
> [root@b ~]#
> 
> 
> 
> 
> ______________________________________________________________________
> Luggage? GPS? Comic books? 
> Check out fitting gifts for grads at Yahoo! Search.
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
