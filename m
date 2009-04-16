From: rader@hep.wisc.edu
Subject: allowing ordinary users to umount/eject w/ automount 5.0.1?
Date: Thu, 16 Apr 2009 00:42:33 -0500
Message-ID: <200904160542.n3G5gXdj009779@ginseng.hep.wisc.edu>
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


Is there some magic that'll allow me to eject my ipod that's
automounted via a device file that I *own*?!   I tried both "user"
and "user=rader" (me.)

I can do it after mounting via /etc/fstab with the "user" option.

The system is RHEL5 w/ automount 5.0.1

Details follow.  Please feel free to ask for more.

steve
--

## autofs bad...

bash$ whoami
rader
bash$ sudo automount -V

Linux automount version 5.0.1-0.rc2.43.0.2

Directories:
        config dir:     /etc/sysconfig
        maps dir:       /etc
        modules dir:    /usr/lib/autofs

Compile options:
  DISABLE_MOUNT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS WITH_HESIOD WITH_LDAP 
  WITH_SASL 

bash$ sudo service autofs start
bash$ cat /etc/udev/rules.d/99-usb.rules 
BUS=="usb", KERNEL=="sda2", SYSFS{product}=="iPod", NAME="%k", SYMLINK+="ipod", OWNER="rader"
bash$ ls -l /dev/ipod /dev/sda2
lrwxrwxrwx 1 root  root    4 Apr 16 00:21 /dev/ipod -> sda2
brw-r----- 1 rader disk 8, 2 Apr 16 00:21 /dev/sda2
bash$ cat /etc/auto.master
/mnt    /etc/auto.mnt
bash$ grep ipod /etc/auto.mnt
ipod    -fstype=vfat,sync,user,uid=500,umask=000 :/dev/ipod
bash$ ls -l /mnt/ipod
total 80
drwxrwxrwx 2 rader root 16384 Apr 17  2007 Calendars/
[...]
bash$ umount /dev/ipod
umount: only root can unmount /dev/ipod from /mnt/ipod
bash$ grep ipod /etc/mtab # no user="rader": a clue?
/dev/sda2 /mnt/ipod vfat rw,noexec,nosuid,nodev,sync,uid=500,umask=000 0 0

## /etc/fstab good...

bash$ sudo eject /dev/ipod
bash$ sudo service autofs stop
Stopping automount:                                        [  OK  ]
bash$ grep ipod /etc/fstab
/dev/ipod               /mnt/ipod               vfat    noauto,user     0 0
bash$ mount /mnt/ipod
bash$ ls -l /mnt/ipod
total 80
drwxr-xr-x 2 rader rader 16384 Apr 17  2007 Calendars/
[...]
bash$ grep ipod /etc/mtab # the other half of the clue?
/dev/sda2 /mnt/ipod vfat rw,noexec,nosuid,nodev,user=rader 0 0
bash$ eject /mnt/ipod
bash$  
