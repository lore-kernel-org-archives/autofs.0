From: Simon Gao <gao@schrodinger.com>
Subject: Autofs 5 failed unmounting Solaris 10 NFS share
Date: Thu, 26 Jul 2007 10:57:54 -0700
Message-ID: <46A8E0A2.3050103@schrodinger.com>
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

Hi,

I am seeing autofs 5 on RHEL/CentOS 5 failed auto umounting NFS shares 
served by Solaris 10 11/06 server. However, other NFS shares got 
unmounted just fine after expired.  All automount maps are pulled from 
LDAP servers. All NFS shares are auto mounted under /nfs.

Here are some information:

1. autofs version:      autofs-5.0.1-0.rc2.43.0.2

2. kernel version:      2.6.18-8.1.8.el5xen

3. auto.master:
===============================================================================
/misc   /etc/auto.misc
/net    -hosts

# Include central master map if it can be found using
# nsswitch sources.
+auto.ldap
===============================================================================

4. auto.ldap (automount map in LDAP server):
===============================================================================
dn: ou=auto.master,ou=ldap,ou=autofs,ou=services,dc=example,dc=com
objectClass: top
objectClass: automountMap
ou: auto.master

dn: cn=/nfs,ou=auto.master,ou=ldap,ou=autofs,ou=services,dc=example,dc=com
automountInformation: 
ldap:ou=auto.nfs,ou=ldap,ou=autofs,ou=services,dc=example
,dc=com
objectClass: top
objectClass: automount
cn: /nfs

# share1
dn: cn=share1,ou=auto.nfs,ou=ldap,ou=autofs,ou=services,dc=example,dc=com
objectClass: top
objectClass: automount
automountInformation: -fstype=nfs,rw,hard,intr,nosuid,nfsvers=3,udp 
server1:/export/zfs/nshare1
cn: share1

===============================================================================

5. /etc/sysconfig/autofs
===============================================================================
DEFAULT_MASTER_MAP_NAME="auto.master"
DEFAULT_TIMEOUT=300
DEFAULT_BROWSE_MODE="no"
DEFAULT_LOGGING="debug"

# Define the default LDAP schema to use for lookups
DEFAULT_MAP_OBJECT_CLASS="automountMap"
DEFAULT_ENTRY_OBJECT_CLASS="automount"
DEFAULT_MAP_ATTRIBUTE="ou"
DEFAULT_ENTRY_ATTRIBUTE="cn"
DEFAULT_VALUE_ATTRIBUTE="automountInformation"

DEFAULT_AUTH_CONF_FILE="/etc/autofs_ldap_auth.conf"

# General global options
OPTIONS=""
===============================================================================

6. /var/log/messages:
===============================================================================

....
Jul 26 10:26:26 client1 automount[21073]: expiring path /home/joe
Jul 26 10:26:26 client1 automount[21073]: unmounting dir = /home/joe
Jul 26 10:26:26 client1 automount[21073]: expired /home/joe
Jul 26 10:26:39 client1 automount[21073]: expiring path /nfs/share1
Jul 26 10:26:39 client1 automount[21073]: umount_multi: could not stat 
fs of /nfs/share1
Jul 26 10:26:39 client1 automount[21073]: do_expire: couldn't complete 
expire of /nfs/share1
....
===============================================================================

7: /var/log/debug:
===============================================================================
.....

Jul 26 10:26:26 client1 automount[21073]: st_expire: state 1 path /home
Jul 26 10:26:26 client1 automount[21073]: expire_proc: exp_proc = 
3076074384 path /home
Jul 26 10:26:26 client1 automount[21073]: expire_proc_indirect: expire 
/home/joe
Jul 26 10:26:26 client1 automount[21073]: handle_packet: type = 4
Jul 26 10:26:26 client1 automount[21073]: handle_packet_expire_indirect: 
token 1900, name joe
Jul 26 10:26:26 client1 automount[21073]: expiring path /home/joe
Jul 26 10:26:26 client1 automount[21073]: umount_multi: path /home/joe 
incl 1
Jul 26 10:26:26 client1 automount[21073]: unmounting dir = /home/joe
Jul 26 10:26:26 client1 automount[21073]: rm_unwanted_fn: removing 
directory /home/joe
Jul 26 10:26:26 client1 automount[21073]: expired /home/joe
Jul 26 10:26:26 client1 automount[21073]: send_ready: token = 1900
Jul 26 10:26:26 client1 automount[21073]: expire_cleanup: got thid 
3076074384 path /home stat 0
Jul 26 10:26:26 client1 automount[21073]: expire_cleanup: sigchld: exp 
3076074384 finished, switching from 2 to 1
Jul 26 10:26:26 client1 automount[21073]: st_ready: st_ready(): state = 
2 path /home
Jul 26 10:26:39 client1 automount[21073]: st_expire: state 1 path /nfs
Jul 26 10:26:39 client1 automount[21073]: expire_proc: exp_proc = 
3076074384 path /nfs
Jul 26 10:26:39 client1 automount[21073]: expire_proc_indirect: expire 
/nfs/share1
Jul 26 10:26:39 client1 automount[21073]: handle_packet: type = 4
Jul 26 10:26:39 client1 automount[21073]: handle_packet_expire_indirect: 
token 1901, name share1
Jul 26 10:26:39 client1 automount[21073]: expiring path /nfs/share1
Jul 26 10:26:39 client1 automount[21073]: umount_multi: path /nfs/share1 
incl 1
Jul 26 10:26:39 client1 automount[21073]: umount_multi: could not stat 
fs of /nfs/share1
Jul 26 10:26:39 client1 automount[21073]: do_expire: couldn't complete 
expire of /nfs/share1
Jul 26 10:26:39 client1 automount[21073]: send_fail: token = 1901
Jul 26 10:26:39 client1 automount[21073]: expire_proc_indirect: 1 
remaining in /nfs
Jul 26 10:26:39 client1 automount[21073]: mount still busy /nfs
Jul 26 10:26:39 client1 automount[21073]: expire_cleanup: got thid 
3076074384 path /nfs stat 2
Jul 26 10:26:39 client1 automount[21073]: expire_cleanup: sigchld: exp 
3076074384 finished, switching from 2 to 1
Jul 26 10:26:39 client1 automount[21073]: st_ready: st_ready(): state = 
2 path /nfs
===============================================================================

Anyone sees similar problem?

Simon
