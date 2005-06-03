From: Greg Bradner <gregb@rhythm.com>
Subject: mounting problem
Date: Fri, 03 Jun 2005 06:41:53 -0700
Message-ID: <42A05E21.4090802@rhythm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org


This happens with autofs or using mount directly.

However I mount the disk the first time, the same characteristics are 
passed to future mounts.

## This is a read only mount point and you can see the options in the 
/proc/mounts file at the bottom

 > cd /nfs/ro3/fs14/a/rla/

 > df -k .
Filesystem 1K-blocks Used Available Use% Mounted on
fs14:/a/rla 657148928 545010048 112138880 83% /nfs/ro3/fs14/a/rla

## Then when I go to a mount point that shouldn't be read only, it take 
the options from the previous mount.
 > cd /fs14a/rla/

 > df -k .
Filesystem 1K-blocks Used Available Use% Mounted on
fs14:/a/rla 657148928 545010048 112138880 83% /fs14a/rla

 > touch test
touch: cannot touch `test': Read-only file system

 > tail /proc/mounts
automount(pid3481) /ntap10 autofs rw 0 0
automount(pid3599) /morph autofs rw 0 0
automount(pid3538) /systems autofs rw 0 0
/dev/hda7 /home/gregb ext3 rw 0 0
fs14:/a/jobs /nfs/ro3/fs14/a/jobs nfs 
ro,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0
fs14:/a/rla /nfs/ro3/fs14/a/rla nfs 
ro,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0
fs14:/b/rla /nfs/ro3/fs14/b/rla nfs 
ro,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0
fs14:/root0 /nfs/ro3/fs14/root0 nfs 
ro,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0
fs14:/root1 /nfs/ro3/fs14/root1 nfs 
ro,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0
fs14:/a/rla /fs14a/rla nfs 
ro,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=fs14 0 0


Has anyone seen this before?  This is stock SuSE 9.2.  Thanks for any help.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 > rpm -qa | grep autofs
autofs4-4.0.0-105

 > uname -ar
Linux lid2 2.6.5-7.112-suse #6 SMP Wed Mar 23 10:16:11 PST 2005 i686 
athlon i386 GNU/Linux

 > cat /etc/issue
Welcome to SuSE Linux 9.2 (i586)

 > /usr/sbin/automount -V
Linux automount version 4.1.3
 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gregb@rhythm.com
