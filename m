From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: mounting problem
Date: Fri, 3 Jun 2005 12:07:11 -0400
Message-ID: <17056.32815.511990.700021@segfault.boston.redhat.com>
References: <42A05E21.4090802@rhythm.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <42A05E21.4090802@rhythm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Greg Bradner <gregb@rhythm.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] mounting problem; Greg Bradner <gregb@rhythm.com> adds:

gregb> This happens with autofs or using mount directly.

gregb> However I mount the disk the first time, the same characteristics are 
gregb> passed to future mounts.

I can't reproduce this.  Can you please post a procedure to trigger this
without automount?  Exact commandlines would be helpful.

Also, if you can trigger this with mount, then I fail to see how this is an
autofs bug.

Thanks,

Jeff


gregb> ## This is a read only mount point and you can see the options in the 
gregb> /proc/mounts file at the bottom

>> cd /nfs/ro3/fs14/a/rla/

>> df -k .
gregb> Filesystem 1K-blocks Used Available Use% Mounted on
gregb> fs14:/a/rla 657148928 545010048 112138880 83% /nfs/ro3/fs14/a/rla

gregb> ## Then when I go to a mount point that shouldn't be read only, it take 
gregb> the options from the previous mount.
>> cd /fs14a/rla/

>> df -k .
gregb> Filesystem 1K-blocks Used Available Use% Mounted on
gregb> fs14:/a/rla 657148928 545010048 112138880 83% /fs14a/rla

>> touch test
gregb> touch: cannot touch `test': Read-only file system

>> tail /proc/mounts
gregb> automount(pid3481) /ntap10 autofs rw 0 0
gregb> automount(pid3599) /morph autofs rw 0 0
gregb> automount(pid3538) /systems autofs rw 0 0
gregb> /dev/hda7 /home/gregb ext3 rw 0 0
gregb> fs14:/a/jobs /nfs/ro3/fs14/a/jobs nfs 
gregb> ro,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0
gregb> fs14:/a/rla /nfs/ro3/fs14/a/rla nfs 
gregb> ro,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0
gregb> fs14:/b/rla /nfs/ro3/fs14/b/rla nfs 
gregb> ro,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0
gregb> fs14:/root0 /nfs/ro3/fs14/root0 nfs 
gregb> ro,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0
gregb> fs14:/root1 /nfs/ro3/fs14/root1 nfs 
gregb> ro,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0
gregb> fs14:/a/rla /fs14a/rla nfs 
gregb> ro,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0


gregb> Has anyone seen this before?  This is stock SuSE 9.2.  Thanks for any help.


gregb> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> rpm -qa | grep autofs
gregb> autofs4-4.0.0-105

>> uname -ar
gregb> Linux lid2 2.6.5-7.112-suse #6 SMP Wed Mar 23 10:16:11 PST 2005 i686 
gregb> athlon i386 GNU/Linux

>> cat /etc/issue
gregb> Welcome to SuSE Linux 9.2 (i586)

>> /usr/sbin/automount -V
gregb> Linux automount version 4.1.3
 
gregb> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gregb> gregb@rhythm.com

gregb> _______________________________________________
gregb> autofs mailing list
gregb> autofs@linux.kernel.org
gregb> http://linux.kernel.org/mailman/listinfo/autofs
