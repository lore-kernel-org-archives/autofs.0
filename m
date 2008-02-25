From: "Murata, Dennis" <DENNIS.MURATA@saic.com>
Subject: New autofs behavior in RHEL 4U6
Date: Mon, 25 Feb 2008 15:28:36 -0800
Message-ID: <620E93B2E5CC3B46BD811165E3335B87165B9D@0461-its-exmb02.us.saic.com>
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

Has the multi option changed in RHEL 4U6?  The following mount has been
working with RHEL 3U7:

/etc/auto.master:

/foo  multi:file /etc/auto.too -- yp auto.foo

with auto.too:

*  -fstype=nfs,rsize=32768,intr,rw server:/local/too/&

and auto.foo

*  -rsize=32768,wsize=32768,intr,hard server:/local/foo/&

If a requested directory, 3, is not exported from server:/local/too,
there is a denied request then the mount server:/local/foo is searched
for the requested directory.  If it is found there it is mounted.  The
workstation mount point is /foo/01a regardless if the server directory
is /local/too/01a or /local/foo/01a.

I have been testing a modified RHEL 4U6 workstation:
(bash)-6-$ uname -a 
Linux myhost 2.6.9-67.0.1.ELsmp #1 SMP Fri Nov 30 11:57:43 EST 2007
x86_64 x86_64 x86_64 GNU/Linux
(bash)-3-$ rpm -qa | grep autofs 
autofs-4.1.3-231.x86_64
(bash)-8-$ rpm -qa | grep nfs 
nfs-utils-1.0.6-84.EL4.x86_64 
nfs-utils-lib-1.0.6-8.z1.x86_64 
(bash)-9-$ rpm -qa | grep util-linux 
util-linux-2.12a-17.el4_6.1.x86_64

From the man pages it looks like the multi feature is no longer
supported.  I can get the failover behavior to work if I use a map like
auto.foo:
*  -fstype=nfs,rsize=32768,intr server:/local/too/& server:/local/foo/&

The desired result is to have mounts from /local/too to be rw, those
from /local/foo ro, is this possible?  I have the exports on the server
as ro and rw, but all the mounts on the workstation so far seem to be
ro.

I have debug logs if needed.

Wayne
