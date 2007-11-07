From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Problem with autofs_home map
Date: Wed, 7 Nov 2007 12:23:20 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F041EE733@permls05.wde.woodside.com.au>
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


Hi all

I'm having a strange problem my autofs_home map. 

RHEL AS4 (32bit)
autofs-4.1.3-199.3
Kernel 2.6.9-55.0.12
nfs-utils 1.0.6-80
 
/etc/auto.master
---
/rhome  autofs.home   --verbose --ghost
nfsvers=3,tcp,rsize=32768,wsize=32768
/-      autofs.global --verbose --ghost
nfsvers=3,tcp,rsize=32768,wsize=32768
---

/etc/nsswitch.conf
---
snip
automount:  ldap files
snip
---

autofs.home (from LDAP)
---
usr4 server:/local/home-usr4
usr3 server:/local/home-usr3
usr2 server:/local/home-usr2
usr1 server:/local/home-usr1
---

I find that there is no '/rhome' directory and '/home' is 0 bytes in
size where what should happen is '/home' is of 'normal' size (4096
bytes) anf '/rhome' exists and is 0 bytes.

Is this a bug or have I configured this box wrong?

CC

NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
