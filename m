From: jmoyer@redhat.com
Subject: Re: Automount with a local NFS export and a remote NFS
	export using the same mount path name over LDAP
Date: Tue, 21 Nov 2006 15:37:14 -0500
Message-ID: <m37ixoy1s5.fsf@redhat.com>
References: <E2AC825D4FC7764DA86D9C8ECA27A2DE065AFA@catoexm05.noam.corp.platform.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E2AC825D4FC7764DA86D9C8ECA27A2DE065AFA@catoexm05.noam.corp.platform.com>
	(Shawn Starr's message of "Tue, 21 Nov 2006 15:12:46 -0500")
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
To: Shawn Starr <sstarr@platform.com>
Cc: autofs@linux.kernel.org

==> Regarding RE: [autofs] Automount with a local NFS export and a remote NFS export using the same mount path name over LDAP; "Shawn Starr" <sstarr@platform.com> adds:

==> Regarding RE: [autofs] Automount with a local NFS export and a remote NFS export using the same mount path name over LDAP; "Shawn Starr" 
>> I re-read your original problem statement, and I am officially confused.
>> What, exactly, are you trying to accomplish?

>> Do you want to merge the contents of two master maps?  If so, set
>> ONE_AUTO_MASTER=0.

>> Do you want to merge the contents of two indirect maps?  If so, try reading
>> up on multi-maps.  This allows one to merge the contents of two or more
>> maps, potentially from different sources.

>> If neither of these is what you are trying to do, then please provide a
>> better explanation of the problem.  Post your maps, and give concrete
>> examples with machine names, exports, and intended use.

>> -Jeff

sstarr> Hi Jeff, Here's what I'm trying to do:

sstarr> On a local machine (10.1.1.75) I have the following configuration:

sstarr> /etc/exports:
sstarr> =========
sstarr> /export 10.0.0.0/255.0.0.0(rw,async)


sstarr> /etc/auto.home:
sstarr> ===========

sstarr> install         10.1.1.75:/export/home/&
sstarr> +auto.home

sstarr> /etc/auto.master:
sstarr> ============
sstarr> /home  /etc/auto.home --ghost

sstarr> On the local machine, /home is NFS exported so: /home/install is
sstarr> visible when using automount.


sstarr> On a remote machine (somehostname.platform.com) I have the
sstarr> following configuration:

sstarr> /etc/exports:
sstarr> =========
sstarr> /home   *(rw,async)


sstarr> auto.master: LDAP map
sstarr> ===============

sstarr> dn: ou=autofs,dc=platform,dc=com
sstarr> objectClass: top
sstarr> objectClass: organizationalUnit
sstarr> ou: autofs

sstarr> dn: ou=auto.master,ou=autofs,dc=platform,dc=com
sstarr> objectClass: top
sstarr> objectCLass: automountMap
sstarr> ou: auto.master

sstarr> dn: cn=/home,ou=auto.master,ou=autofs,dc=platform,dc=com
sstarr> objectClass: top
sstarr> objectClass: automount
sstarr> cn: /home
sstarr> automountInformation: ldap:ou=auto.home,ou=autofs,dc=platform,dc=com

sstarr> auto.home:  LDAP map
sstarr> ===============

sstarr> dn: ou=auto.home,ou=autofs,dc=platform,dc=com
sstarr> objectClass: top
sstarr> objectClass: automountMap
sstarr> ou: auto.home

sstarr> dn: cn=sstarr,ou=auto.home,ou=autofs,dc=platform,dc=com
sstarr> objectClass: top
sstarr> objectClass: automount
sstarr> cn: sstarr
sstarr> automountInformation: -fstype=nfs,hard,intr,nodev,nosuid somehostname.platform.com:/home:&

is this supposed to be /home/& ?

sstarr> The goal is to be able to share /home from *both* NFS exports and
sstarr> combine them like NIS does (with +auto.home).

sstarr> So on the local machine: if I do cd /home/install or cd
sstarr> /home/sstarr I can see both as if they were one mounted point.

sstarr> I can do this if I add the following to my LDAP maps:

sstarr> dn: cn=install,ou=auto.home,ou=autofs,dc=platform,dc=com
sstarr> objectClass: top
sstarr> objectClass: automount
sstarr> cn: install
sstarr> automountInformation: 10.1.1.75:/export/home/install

sstarr> Which basically does what I'm trying to do, but its a hack since I
sstarr> have to use an LDAP entry instead of using the local 10.1.1.75
sstarr> /etc/auto.home mapping

sstarr> On the 10.1.1.75 local machine I have the /etc/nsswitch.conf as:
sstarr> automount: files ldap

sstarr> If it finds valid automounts in the 10.1.1.75's local
sstarr> /etc/auto.master it ignores the LDAP maps so I only get one
sstarr> automount set up. This isn't the behavour I'm looking for. I need a
sstarr> way to tell automount that even though it found valid maps in
sstarr> /etc/auto.master, look for additional maps from LDAP also.

sstarr> I hope this clears things up :-)

Ok, so you basically want included map support.  You are right, I did post
a patch to implement this, but it is quite a beast, so I wouldn't expect it
to get released straight away (these things require gobs of testing).

In the interim, you can use something like the following local master map
entry:

/etc/auto.master:
/home   multi:file /etc/auto.home -- ldap auto.home

I think that will do what you need.  If not, I'll give it another try.  ;)

-Jeff
