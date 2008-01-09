From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Autofs leaking map entries
Date: Wed, 9 Jan 2008 13:55:24 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F051929CD@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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


Hi All

I saw on this list some time ago that someone was having problems with
autofs working fine for a while and then starting to 'forget' map
entries but I can't find those threads now.  Anyway, we are now seeing
this problem on RHEL5.

This machine was working fine until today.  (It's been up for only 4
days).

Once again, I haven't included the auto_global or auto_home maps.

Autofs version
autofs-5.0.1-0.rc2.55.el5.2

Kernel version
2.6.18-53.1.4.el5

Autofs global map
same as previous post

Autofs home map
same as previous post

Contents of /etc/nsswitch.conf
#
# /etc/nsswitch.conf
#
passwd:     files ldap
shadow:     files ldap
group:      files ldap

# Warning: "getent hosts | grep hostname" probably won't do what you
want
# Do a "getent hosts hostname" instead
hosts:      files dns

bootparams: files ldap
ethers:     files ldap

netmasks:   files ldap
networks:   files ldap

protocols:  files ldap
rpc:        files ldap
publickey:  files ldap
services:   files ldap

netgroup:   files ldap
automount:  ldap files
aliases:    files ldap

Contents of /etc/sysconfig/autofs
LOCALOPTIONS=""
DAEMONOPTIONS="--timeout=60"
UNDERSCORETODOT=0
DISABLE_DIRECT=0

DEFAULT_MAP_OBJECT_CLASS="automountMap"
DEFAULT_ENTRY_OBJECT_CLASS="automount"
DEFAULT_MAP_ATTRIBUTE="automountMapName"
DEFAULT_ENTRY_ATTRIBUTE="automountKey"
DEFAULT_VALUE_ATTRIBUTE="automountInformation"


Contents of /etc/auto.master
# This is a managed by RedHat satellite server, do not edit

/home   autofs.home   --verbose --ghost
nfsvers=3,tcp,rsize=32768,wsize=32768
/-      autofs.global --verbose --ghost
nfsvers=3,tcp,rsize=32768,wsize=32768

Thanks

CC

NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
