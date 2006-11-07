From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: problem with autofs
Date: Tue, 07 Nov 2006 09:47:18 -0500
Message-ID: <x49ejsfxqix.fsf@segfault.boston.devel.redhat.com>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	<x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
	(Syed Khader's message of "Tue, 7 Nov 2006 19:42:02 +0530")
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
To: Syed Khader <syedk@google.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] problem with autofs; "Syed Khader" <syedk@google.com> adds:

syedk> The ldif for master is like this.
syedk> dn: ou=auto.master,dc=testlab,dc=com
syedk> objectClass:top
syedk> objectClass:automountMap
syedk> ou:auto.master

syedk> dn: cn=/home,ou=auto.master,dc=testlab,dc=com
syedk> objectClass:automount
syedk> cn:/home
syedk> automountInformation: ldap server.testlab.com:ou=auto.home,dc=testlab,dc=com
syedk> --timeout 60

syedk> Auto.Home

syedk> dn: ou=auto.home,dc=testlab,dc=com
syedk> objectClass:top
syedk> objectClass:automountMap
syedk> ou:auto.home

syedk> dn: cn=user1,ou=auto.home,dc=testlab,dc=com
syedk> objectClass: automount
syedk> cn:user1
syedk> automountInformation: -fstype=nfs,hard,intr server.testlab.com:/home/user1

This looks okay to me, at first glance.

syedk> I'm using 4.1.3-155 version of autofs

syedk> My problem is to tell autofs daemon to read the map from LDAP and
syedk> not from files.  My autofs reads from the file /etc/auto.master.  If
syedk> i give the entry

syedk> /home ldap:server.testlab.com:ou=auto.home,dc=testlab,dc=com

syedk> in the /etc/auto.master file and say Service autofs status

syedk> Then i see the mount point as the above.But when i try to login on the
syedk> client side.Still it doesn't mount the user's home directory.

Well, for that problem we may need debug logs, but let's sort out your
issue with reading the master map from LDAP, first.

syedk> I have changed the entry AUTOMOUNT:LDAP in /etc/nsswitch.conf file.

Every time you type this in, you change the case.  Make sure that
nsswitch.conf reads:

automount: ldap

It should all be lower-case, as otherwise the init script will not match
it.  If it is lower-case, then please send along the output from:
  "sh -x /etc/init.d/autofs start"

It may also be useful to see the output from:
   /usr/lib[64]/autofs/autofs-ldap-auto-master

Thanks,

Jeff
