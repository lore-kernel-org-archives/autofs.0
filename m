From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Failure to Unmount NFS Filesystems causes clients to hang on reboot
Date: Thu, 02 Sep 2004 14:45:09 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <41379465.6030603@physics.ucsd.edu>
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
To: 

Hi,

I am having a problem where my client machines are not able to reboot 
correctly because the NFS mounted file systems are hanging at shutdown 
time and refuse to unmount.

I am running RHEL3 (Rocks Cluster 3.1) nodes with the latest RH RHEL3 
kernel in a cluster environment.  The problem occured with older kernels 
as well.

Relatively little information is actually shared over NFS, and clients 
almost never have to write to the same files. Mostly clients read some 
code and configurations files over NFS and then maybe writing a bit of 
data to isolated locations (no two clients write to the same files).

Even when I shutdown the processes that actually use my nfs file systems 
and confirm via lsof that no files are open on those file systems manual 
unmount commands also hang.  Autofs also fails to stop correctly 
claiming that the file systems are busy.

Most of the clients mount filesystems from 3 or 4 servers via autofs. My 
timeouts are 600 seconds.

The problem is not always consistent. The other day I was able to 
unmount properly and reboot after various strategies of manual unmounts 
and shutting off autofs. Today I could not.

So my questions are, if there are no files open on these mounted file 
systems why would I have such problems? Can you force the NFS file 
systems to unmount anyway? This is a particular problem because a hang 
requires manual intervention to power cycle the machine. I would even be 
happy to have the NFS unmounting be ignored completely and just reboot 
the system after properly unmounting the local filesystems and ensuring 
all programs are shutdown.

I would be interested also in any suggestions of how to find what is 
hanging up my NFS mounts and preventing unmounting...

Thanks for any suggestions,

Terrence Martin
UCSD Physics

A few command outputs


root@compute-2-5 ~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda1              4127076   3454252    463180  89% /
/dev/hda3             71789596  21607120  46535724  32% /state/data
none                   1030816         0   1030816   0% /dev/shm
192.168.20.3:/home/cdfcaf
                     101161396  34167296  66994100  34% /home/cdfcaf
192.168.20.3:/home/cdfcaf
                     101161396  34167296  66994100  34% /home/cdfcaf
192.168.10.5:/falcon/0/users
                     1463382364 618177588 845204776  43% /home/users
frontend-3.local:/export/home/install
                      10080520   5781204   3787248  61% /home/install

root@compute-2-5 ~# mount
/dev/hda1 on / type ext3 (rw)
none on /proc type proc (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
/dev/hda3 on /state/data type ext3 (rw)
none on /dev/shm type tmpfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
automount(pid2592) on /home type autofs 
(rw,fd=5,pgrp=2592,minproto=2,maxproto=3)
192.168.20.3:/home/cdfcaf on /home/cdfcaf type nfs (rw,addr=192.168.20.3)
automount(pid3119) on /home type autofs 
(rw,fd=5,pgrp=3119,minproto=2,maxproto=3)
automount(pid3149) on /netstor type autofs 
(rw,fd=5,pgrp=3149,minproto=2,maxproto=3)
automount(pid3180) on /afs type autofs 
(rw,fd=5,pgrp=3180,minproto=2,maxproto=3)
192.168.20.3:/home/cdfcaf on /home/cdfcaf type nfs (rw,addr=192.168.20.3)
192.168.10.5:/falcon/0/users on /home/users type nfs (rw,addr=192.168.10.5)
frontend-3.local:/export/home/install on /home/install type nfs 
(rw,addr=192.168.21.1)

cat /etc/auto.master
# $411id: /etc/auto.master$
# Retrieved: 02-Sep-2004 21:41
# Master server: 192.168.21.1
# Last modified on master: 04-Aug-2004 04:04
# Encrypted file size: 490 bytes
#
# Owner: 0.0
# Name: etc.auto..master
# Mode: 0100644
/home auto.home --timeout 600
/netstor auto.net --timeout 600
/afs    auto.afs --timeout 600
/groot   auto.grid3      --timeout 600

On one of the servers
cat /etc/exports
/export 192.168.0.0/255.255.0.0(rw,sync)
