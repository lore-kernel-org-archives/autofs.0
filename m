From: Rich West <Rich.West@wesmo.com>
Subject: autofs5 + ldap + ldap replication
Date: Sat, 14 Jul 2007 22:26:39 -0400
Message-ID: <469985DF.9010607@wesmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

We have an LDAP infrastructure where all of the automount maps 
(auto.master and auto.home) are pulled out of LDAP.  In this instance, 
we have two LDAP servers, one primary, and the other is a replica.  The 
clients are all Fedora/Redhat systems.  Most of them are running 
autofs4, and a few newer ones are running autofs5.

/etc/openldap/ldap.conf has both the primary and replica hosts in the URI.

The problem we are having is with the client hosts running autofs5.  For 
some reason, if we have the replica host first in the URI line, autofs5 
is unable to get any automount data. All of the other LDAP related stuff 
works just fine with both entries (in /etc/ldap.conf and in 
/etc/openldap/ldap.conf).  I was able to narrow things down to the 
replica host itself.  If I just had the replica address in the URI, 
autofs5 doesn't seem to like it.
Jul 14 22:18:09 myhost automount[12143]: Starting automounter version 
5.0.1-0.rc3.31, master map auto.master
Jul 14 22:18:09 myhost automount[12143]: using kernel protocol version 5.00
Jul 14 22:18:09 myhost automount[12143]: mounted indirect mount on /misc 
with timeout 60, freq 15 seconds
Jul 14 22:18:09 myhost automount[12143]: mounted indirect mount on /net 
with timeout 60, freq 15 seconds
Jul 14 22:18:09 myhost automount[12143]: read_file_source_instance: file 
map /etc/ldap not found
Jul 14 22:18:09 myhost automount[12143]: lookup_init: lookup(ldap): 
failed to get query dn
Jul 14 22:18:09 myhost automount[12143]: mount_autofs_indirect: failed 
to read map for /home
Jul 14 22:18:09 myhost automount[12143]: handle_mounts: mount of /home 
failed!
Jul 14 22:18:09 myhost automount[12143]: master_do_mount: failed to 
startup mount

The exact same configuration works fine on the older systems running 
autofs4.

I've confirmed that everything is ok with both the primary and the 
replica (this works for all of the autofs4 based hosts).  phpMyAdmin 
happily browses to the replica's contents.  I can perform ldapsearch's 
with no problems from all of the hosts.  When running automount with the 
"-d" and "-v" flags on the autofs5 hosts, I get the above message in 
/var/log/messages and I see the following ldap query:
Jul 14 22:18:09 myhost slapd[5410]: conn=315 fd=9 ACCEPT from 
IP=192.168.0.100:35494 (IP=0.0.0.0:389)
Jul 14 22:18:09 myhost slapd[5410]: conn=315 op=0 BIND dn="" method=128
Jul 14 22:18:09 myhost slapd[5410]: conn=315 op=0 RESULT tag=97 err=0 text=
Jul 14 22:18:09 myhost slapd[5410]: conn=315 op=1 SRCH 
base="dc=mydomain,dc=com" scope=2 deref=0 
filter="(&(objectClass=automountMap)(ou=auto.master))"
Jul 14 22:18:09 myhost slapd[5410]: conn=315 op=1 SRCH attr=1.1
Jul 14 22:18:09 myhost slapd[5410]: conn=315 op=1 SEARCH RESULT tag=101 
err=0 nentries=1 text=
Jul 14 22:18:09 myhost slapd[5410]: conn=315 op=2 UNBIND
Jul 14 22:18:09 myhost slapd[5410]: conn=315 fd=9 closed
Jul 14 22:18:09 myhost slapd[5410]: conn=316 fd=9 ACCEPT from 
IP=192.168.0.100:35495 (IP=0.0.0.0:389)
Jul 14 22:18:09 myhost slapd[5410]: conn=316 op=0 BIND dn="" method=128
Jul 14 22:18:09 myhost slapd[5410]: conn=316 op=0 RESULT tag=97 err=0 text=
Jul 14 22:18:09 myhost slapd[5410]: conn=316 op=1 SRCH 
base="ou=auto.master,dc=mydomain,dc=com" scope=2 deref=0 
filter="(objectClass=automount)"
Jul 14 22:18:09 myhost slapd[5410]: conn=316 op=1 SRCH attr=cn 
automountInformation
Jul 14 22:18:09 myhost slapd[5410]: conn=316 op=1 SEARCH RESULT tag=101 
err=0 nentries=1 text=
Jul 14 22:18:09 myhost slapd[5410]: conn=316 op=2 UNBIND
Jul 14 22:18:09 myhost slapd[5410]: conn=316 fd=9 closed
Jul 14 22:18:09 myhost slapd[5410]: conn=317 fd=9 ACCEPT from 
IP=192.168.0.100:35496 (IP=0.0.0.0:389)
Jul 14 22:18:09 myhost slapd[5410]: conn=317 op=0 BIND dn="" method=128
Jul 14 22:18:09 myhost slapd[5410]: conn=317 op=0 RESULT tag=97 err=0 text=
Jul 14 22:18:09 myhost slapd[5410]: conn=317 op=1 SRCH 
base="dc=mydomain,dc=com" scope=2 deref=0 
filter="(&(objectClass=automountMap)(ou=ldap))"
Jul 14 22:18:09 myhost slapd[5410]: conn=317 op=1 SRCH attr=1.1
Jul 14 22:18:09 myhost slapd[5410]: conn=317 op=1 SEARCH RESULT tag=101 
err=0 nentries=0 text=
Jul 14 22:18:09 myhost slapd[5410]: conn=317 op=2 UNBIND
Jul 14 22:18:09 myhost slapd[5410]: conn=317 fd=9 closed

I'm at a loss.  I'm just trying to get the LDAP redundancy in place, but 
autofs5 just doesn't seem to want to play nice.  Any pointers in the 
right direction would be happily appreciated!

-Rich
