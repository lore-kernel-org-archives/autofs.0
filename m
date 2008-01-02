From: "Jerzy Jalocha N" <jjalocha@gmail.com>
Subject: basic SOHO NFS/autofs setup for noob help
Date: Wed, 2 Jan 2008 12:42:14 -0600
Message-ID: <9b72f9a90801021042m65d350ak5467b4c500d94933@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

Hi, I am trying to set-up the following (simple?) configuration:
 * one server which has a mounted partition (/shared) exported with
NFS. This holds some files (office, etc) which will be shared by all
users.
 * a few (4) clients which should autofs this partition as '/shared'.

I am able to manually mount the partition on the clients:
 $ sudo mount 192.168.1.20:/shared /shared
And I am able to mount with fstab. (That's how it's running now.)

But I am unable to automount. Whatever the combinations of options I
try ('ls /shared/', or 'ls /shared/subdir', or 'cd /shared : ls'), it
shows nothing.

I guess, It has to do with the combination of
mounting/exporting/autofs options, but I don't really know how to
debug this part.

This is how I've set it up right now:

 * server:/etc/fstab
 /dev/sdb1 /shared ext3 rw,sync,suid,nodev,exec,auto,nouser 0 3

 * server:/etc/exports
 /shared 192.168.1.0/24(rw,sync,no_root_squash,no_subtree_check)

 * client:/etc/auto.master
 shared 192.168.1.20:/shared --ghost --timeout=60

 * client:/etc/auto.shared
 shared  fstype=nfs,rw,sync,soft,intr,rsize=8192,wsize=8192 192.168.1.20:/shared

Everytime I change some configuration file, I restart the necessary
services. (/etc/init.d/xxx restart). When testing autofs, I remove the
entry from fstab.


The only debugging information I know of:

 $ sudo /etc/init.d/autofs status
 Configured Mount Points:
 ------------------------
 /usr/sbin/automount --timeout=300 /net program /etc/auto.net

 Active Mount Points:
 --------------------
 /usr/sbin/automount --pid-file=/var/run/autofs/_shared.pid
--timeout=60 --ghost /shared file /etc/auto.shared


And '/proc/mounts' while autofs is running:
 automount(pid8181) /shared autofs
rw,fd=4,pgrp=8181,timeout=60,minproto=2,maxproto=4,indirect 0 0


I've tried all possible combinations of options, and I've been working
on this for several weeks now, without success. I'm really a noob, but
I've read everything I could find, including the manual pages of
mount, exports, nfs, fstab, the excellent Redhat reference guide, and
forums. I've also asked for help on two forums without success so far:
 * from post 19 onwards:
http://www.linuxquestions.org/questions/linux-networking-3/small-linux-only-network-607346/page2.html
 * http://ubuntuforums.org/showthread.php?t=646572

I am trying really hard to understand what I'm doing, and to learn as
much as possible, but I'm really stuck here. Could anyone with more
experience please guide me with this?

Thanks!
-Jerzy
