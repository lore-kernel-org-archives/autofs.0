From: Tom Georgoulias <tom.georgoulias@freescale.com>
Subject: mount fails because entry in multi-mount doesn't work
Date: Thu, 13 May 2004 09:26:13 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40A38585.4050103@freescale.com>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs mailing list <autofs@linux.kernel.org>

Yesterday I ran into an issue where a mount point wasn't working and 
tracked it down to one of the submounts.  From what I can tell, if one 
of the submounts in a multi-mount doesn't work, the entire mount point 
won't work.  If that is the case, can this behavior be changed?

System:
Sun V20Z running RHEL3 WS AMD64, 2.4.21-15ELsmp (with 
kernel-smp-unsupported-2.4.21-15.EL RPM to get autofs4 module) and 
autofs-4.1.2-6 from Jeff Moyer.


[root@winston root]# cd /proj/tec/layout/copperhead
-bash: cd: /proj/tec/layout/copperhead: No such file or directory

Checked the messages:

[root@winston root]# tail /var/log/messages
May 12 17:22:47 winston automount[8314]: rm_unwanted: 
/proj/tec/layout/maskprep1
May 12 17:22:47 winston automount[8314]: rm_unwanted: 
/proj/tec/layout/copperhead
May 12 17:22:47 winston automount[8314]: rm_unwanted: /proj/tec/layout
May 12 17:22:47 winston automount[6941]: attempting to mount entry 
/proj/tec/layout
May 12 17:22:47 winston automount[8318]: >> mount: 
macduff:/fsys/fs04/maskprep1 failed, reason given by server: Permission 
denied
May 12 17:22:47 winston automount[8318]: mount(nfs): nfs: mount failure 
macduff:/fsys/fs04/maskprep1 on /proj/tec/layout/maskprep1
May 12 17:22:47 winston automount[8318]: failed to mount /proj/tec/layout
May 12 17:22:47 winston automount[8318]: rm_unwanted: 
/proj/tec/layout/maskprep1
May 12 17:22:47 winston automount[8318]: rm_unwanted: 
/proj/tec/layout/copperhead
May 12 17:22:47 winston automount[8318]: rm_unwanted: /proj/tec/layout

Noticed how mount failed for /proj/tec/layout/maskprep1, then the whole 
/proj/tec/layout mount fails.  The mount point it was failing on is 
intentionally unshared at the moment, so I'm not surprise it couldn't 
make it. Took the entry out of the automount map

layout \
/copperhead eclipse0:/export/layout/copperhead \
/maskprep1 macduff:/fsys/fs04/maskprep1 \
<snip>

refreshed the automount daemon's cache.  Mount works now.

[root@winston root]# pkill -HUP -f auto.proj
[root@winston root]# cd /proj/tec/layout/copperhead
[root@winston copperhead]# ls
mpc5554.0l00x  mpc5554.0l87p  restore
[root@winston copperhead]#

Tom
-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Freescale Semiconductor Internal Use
[] Freescale Semiconductor Confidential Proprietary
