From: pablo.roldan@upc.edu
Subject: newbie autofs problem
Date: Mon, 10 Apr 2006 17:45:04 +0200
Message-ID: <20060410154504.GD1223@pollo.upc.es>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi,

I'm using autofs to automount the home dirs of my users, distributed among
several machines. The config files are:

***** /etc/auto.master: *****
/home /etc/auto_home
***** end /etc/auto.master *****

***** /etc/auto_home: *****
canalias        -rsize=8192,wsize=8192  e04:/homes/&
jmbenita        -rsize=8192,wsize=8192  e05:/homes/&
...
***** end /etc/auto_home *****

Until now, it was all working fine. A few days ago I moved the directory
e04:/homes from / to a (larger) partition, which I now mount as /homes:

***** /etc/fstab: *****
# /etc/fstab: static file system information.
#
#<file sys>          <mount point>     <type>   <options>   <dump>   <pass>
/dev/sda3    /                 ext3    rw,errors=remount-ro  0    1
/dev/sda2    none              swap    rw        0    0
none         /proc             proc    defaults  0    0
none  /proc/bus/usb  usbdevfs  defaults
/dev/fd0  /floppy  auto  users,noauto 0 0
/dev/sda5    /usr                 ext3    defaults  0    2
/dev/sda6    /homes                 ext3    defaults  0    2
***** end /etc/fstab *****

Since that moment, I am having problems accessing anything below /home. For
instance, I can't do

	ls /home

because the shell hangs. It just becomes irresponsive.

There are currently Condor processes running with working directory
/home/canalias.

I've been trying to find out what's going on, with no luck for the moment. Any
hint would be greatly appreciated. I don't even know where to look for logged
errors from the automounter.

I next list the output of command "mount" and "autofs status" for reference:

eixam:~# mount
/dev/sda3 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/sda5 on /usr type ext3 (rw)
/dev/sda6 on /homes type ext3 (rw)
usbfs on /proc/bus/usb type usbfs (rw)
automount(pid1377) on /home type autofs
(rw,fd=4,pgrp=1377,minproto=2,maxproto=4)
/homes/condor on /home/condor type none (rw,bind)
e04:/homes/canalias on /home/canalias type nfs
(rw,rsize=8192,wsize=8192,addr=192.168.1.4)
e05:/homes/jmbenita on /home/jmbenita type nfs
(rw,rsize=8192,wsize=8192,addr=192.168.1.5)

eixam:~# /etc/init.d/autofs status
Configured Mount Points:
------------------------
/usr/sbin/automount --timeout=300 /home file /etc/auto_home

Active Mount Points:
--------------------
/usr/sbin/automount --pid-file=/var/run/autofs/_home.pid --timeout=300 /home
file /etc/auto_home


Thanks a lot,
/P
