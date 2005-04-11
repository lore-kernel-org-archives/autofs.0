From: Martin Ruppert <ruppert@Fh-Worms.de>
Subject: Re: Re: autofs>3.9.99-4.0.0pre10-16 doesn't work any more
	for me
Date: Mon, 11 Apr 2005 21:19:21 +0200
Message-ID: <if7jj9unnq.fsf@mago.wo.de>
References: <E1DD8yC-0005oi-61@mago.wo.de> <20050409120352.GA12001@uio.no>
	<ifbr8o6m1u.fsf@mago.linux-lounge.it.fh-worms.de>
	<20050409151430.GA4432@uio.no>
	<Pine.LNX.4.62.0504101029160.1694@donald.themaw.net>
	<ifvf6uwqd2.fsf@mago.linux-lounge.it.fh-worms.de>
	<Pine.LNX.4.58.0504110909070.9299@wombat.indigo.net.au>
	<ifr7hhzvoy.fsf@mago.linux-lounge.it.fh-worms.de>
	<Pine.LNX.4.58.0504111630150.18235@wombat.indigo.net.au>
	<ifpsx1is4x.fsf@mago.linux-lounge.it.fh-worms.de>
	<Pine.LNX.4.62.0504112239420.3448@donald.themaw.net>
Reply-To: ruppert@Fh-Worms.de
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504112239420.3448@donald.themaw.net>
	(raven@themaw.net's
	message of "Mon, 11 Apr 2005 22:49:15 +0800 (WST)")
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, 300648@bugs.debian.org, ruppert@mago.linux-lounge.it.fh-worms.de

Hello, 

On Mon, 11 Apr 2005 22:49:15 +0800 (WST), raven  wrote:
> On Mon, 11 Apr 2005, Martin Ruppert wrote:
>> Hello,
>>
>> [things already cleared snipped]

> Yes, I think we can get more info.

> The later versions of autofs are quiet.

> There are several reasons for this, for good behaviour, a Debian bug
> report said it was to verbose, but mostly so I can get full debug info
> from people without a recompile.

> You can get debug output by adding --debug to the end of your map
> entry in auto.master. Assuming syslog is logging facility daemon and
> severity at least debug they will be in the log.

>> ... [see above]

> The debug info is really the only way to diagnose these problems.

Here comes it, but because it's a bit longish, i've put it at the end.

First part is a screen log installing autofs_4.1.3-9 and trying to
mount with it and then installing autofs_4.1.3+4.1.4beta2-7 and again
trying to mount with. I didn't have version 4.1.3+4.1.4beta2-7 before
today.

And the good news: version 4.1.3+4.1.4beta2-7 works again, although i
don't know why.

The last 49 Lines of this mail are the part of /var/log/syslog for the
not working autofs_4.1.3-9

Hope that helps, if you need more or other info, please let me know.

> Ian

Thank you very much and best regards
M.Ruppert


mago:~ 0411.20:16:03# dpkg -i /var/cache/apt/archives/autofs_4.1.3-9_i386.deb 
dpkg - warning: downgrading autofs from 4.1.3+4.1.4beta2-7 to 4.1.3-9.
(Reading database ... 48136 files and directories currently installed.)
Preparing to replace autofs 4.1.3+4.1.4beta2-7 (using .../autofs_4.1.3-9_i386.deb) ...
Stopping automounter: done.
Unpacking replacement autofs ...
Setting up autofs (4.1.3-9) ...

[Configuration ... snipped]

Stopping automounter: 
done.
Starting automounter: /mnt/auto /mnt/net.

mago:~ 0411.20:16:46# dir /mnt/auto/hda8
/mnt/auto/hda8: No such file or directory

mago:~ 0411.20:17:20# dpkg -i /var/cache/apt/archives/autofs_4.1.3+4.1.4beta2-7_i386.deb 
(Reading database ... 48134 files and directories currently installed.)
Preparing to replace autofs 4.1.3-9 (using .../autofs_4.1.3+4.1.4beta2-7_i386.deb) ...
Stopping automounter: 

  Stopped 2198
  Stopped 2209
done.
Unpacking replacement autofs ...
Setting up autofs (4.1.3+4.1.4beta2-7) ...

[Configuration ... snipped]

< Here comes an ncurses-menu >
Debian Configuration
Configuring autofs
Upgrade from broken autofs version

You are upgrading from a broken version of the autofs package, which
might hinder proper restarting on upgrade. I'll try stopping autofs
for you before the upgrade (and starting it again afterwards), but
this might fail. If the package installation fails, kill all instances
of automount manually and retry the upgrade.
< /Here comes an ncurses-menu >

Stopping automounter: done.
Starting automounter: done.

mago:~ 0411.20:18:15# mount
/dev/hda9 on / type xfs (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
tmpfs on /tmp type tmpfs (rw)
usb on /proc/bus/usb type usbfs (rw)
/dev/hda5 on /boot type ext3 (rw)
/dev/m/vm-u1 on /usr type xfs (rw)
/dev/m/vm-v1 on /var type xfs (rw)
/dev/m/vm-home on /home type xfs (rw)
/dev/m/vm-pub on /home/ftp/pub type xfs (rw)
automount(pid2414) on /mnt/auto type autofs (rw,fd=5,pgrp=2414,minproto=2,maxproto=4)
automount(pid2467) on /mnt/net type autofs (rw,fd=5,pgrp=2467,minproto=2,maxproto=4)

mago:~ 0411.20:18:18# dir /mnt/auto/hda8
total 111
drwxr-xr-x  19 root root  4096 Apr  9 21:43 .
drwxr-xr-x   3 root root     0 Apr 11 20:18 ..
drwxr-xr-x   2 root root  4096 Feb 12 00:59 bin
dr-xr-xr-x   7 root root  2048 Apr  1 23:24 boot
drwxr-xr-x  20 root root 28672 Apr 11 20:13 dev
drwxr-xr-x  91 root root 12288 Apr 11 20:13 etc
d---------   2 root root     6 Dec  3 16:32 home
drwxr-xr-x   2 root root     6 Dec 30 18:30 initrd
dr-xr-xr-x   2 root root     6 Oct 24 18:27 knoppix
drwxr-xr-x   9 root root  4096 Feb 12 00:59 lib
drwxr-xr-x   2 root root     6 Dec  3 16:42 lost+found
drwxr-xr-x  52 root root  4096 Apr 11 20:13 mnt
d---------   2 root root     6 Feb  8  2002 proc
drwxr-x---  10 root root  4096 Feb  3 06:44 root
drwxr-xr-x   2 root root  8192 Feb 12 00:59 sbin
d---------   2 root root     6 Feb  9  2004 sys
d---------   2 root root     6 Sep 11  2004 tmp
drwxr-xr-x  10 root root   130 Sep  5  2004 usr
drwxr-xr-x  12 root root   136 Dec  8 19:51 var

mago:~ 0411.20:18:28# df
Filesystem1K-blocks      Used Available Use% Mounted on
/dev/hda9    296928     69198    227730  24% /
tmpfs        257288         0    257288   0% /dev/shm
tmpfs        257288         0    257288   0% /tmp
/dev/hda5     58093     32153     22940  59% /boot
/dev/m/vm-u11628160    747372    880788  46% /usr
/dev/m/vm-v1 406528    232762    173766  58% /var
/dev/m/vm-home        19912704  17973938   1938766  91% /home
/dev/m/vm-pub         44018688  35949508   8069180  82% /home/ftp/pub
/dev/hda8    296928     88795    208133  30% /mnt/auto/hda8
/dev/m/vm-v0 406528    153699    252829  38% /mnt/auto/hda8/var
/dev/m/vm-u01628160    753159    875001  47% /mnt/auto/hda8/usr
/dev/hda5     58093     32153     22940  59% /mnt/auto/hda8/boot

mago:~ 0411.20:18:39# dir /mnt/auto/hda9
total 111
drwxr-xr-x  20 root root  4096 Mar 20 01:20 .
drwxr-xr-x   4 root root     0 Apr 11 20:18 ..
drwx------   2 root root     6 Mar 20 01:20 .unison
drwxr-xr-x   2 root root  4096 Apr 11 20:15 bin
dr-xr-xr-x   7 root root  2048 Apr  1 23:24 boot
drwxr-xr-x  18 root root 28672 Apr 11 20:14 dev
drwxr-xr-x  94 root root 12288 Apr 11 20:18 etc
d---------   2 root root     6 Dec  3 17:05 home
drwxr-xr-x   2 root root     6 Dec 30 18:30 initrd
dr-xr-xr-x   2 root root     6 Oct 24 18:27 knoppix
drwxr-xr-x   9 root root  4096 Apr  8 18:42 lib
drwxr-xr-x   2 root root     6 Jan 24 13:11 lost+found
drwxr-xr-x  55 root root  4096 Apr 11 20:18 mnt
d---------   2 root root     6 Feb  8  2002 proc
drwxr-x---  13 root root  4096 Apr 11 20:16 root
drwxr-xr-x   2 root root  8192 Apr 11 20:15 sbin
d---------   2 root root     6 Feb  9  2004 sys
d---------   2 root root     6 Apr  8 18:30 tmp
drwxr-xr-x  10 root root   130 Feb  5 14:32 usr
drwxr-xr-x  12 root root   128 Feb  4 16:06 var

mago:~ 0411.20:18:46# df
Filesystem1K-blocks      Used Available Use% Mounted on
/dev/hda9    296928     69198    227730  24% /
tmpfs        257288         0    257288   0% /dev/shm
tmpfs        257288         0    257288   0% /tmp
/dev/hda5     58093     32153     22940  59% /boot
/dev/m/vm-u11628160    747372    880788  46% /usr
/dev/m/vm-v1 406528    232755    173773  58% /var
/dev/m/vm-home        19912704  17973938   1938766  91% /home
/dev/m/vm-pub         44018688  35949508   8069180  82% /home/ftp/pub
/dev/hda8    296928     88795    208133  30% /mnt/auto/hda8
/dev/m/vm-v0 406528    153699    252829  38% /mnt/auto/hda8/var
/dev/m/vm-u01628160    753159    875001  47% /mnt/auto/hda8/usr
/dev/hda5     58093     32153     22940  59% /mnt/auto/hda8/boot
/dev/hda9    296928     69198    227730  24% /mnt/auto/hda9
/dev/m/vm-v1 406528    232755    173773  58% /mnt/auto/hda9/var
/dev/m/vm-u11628160    747372    880788  46% /mnt/auto/hda9/usr
/dev/hda5     58093     32153     22940  59% /mnt/auto/hda9/boot
mago:~ 0411.20:18:48# 


And here comes the part of the log-file for version 4.1.3-9, i had to
reinstall it again, because i misunderstood "`end of your map entry"',
and so got no log entry, from that comes the difference in the
timestamps.  

Apr 11 20:37:25 mago automount[3520]: starting automounter version 4.1.3, path = /mnt/auto, maptype = program, mapname = /etc/auto.misc
Apr 11 20:37:25 mago automount[3520]: mount(bind): bind_works = 1 
Apr 11 20:37:25 mago automount[3520]: using kernel protocol version 4.05
Apr 11 20:37:25 mago automount[3520]: using timeout 30 seconds; freq 8 secs
Apr 11 20:37:33 mago automount[3520]: sig 14 switching from 1 to 2
Apr 11 20:37:33 mago automount[3520]: get_pkt: state 1, next 2
Apr 11 20:37:33 mago automount[3520]: st_expire(): state = 1 
Apr 11 20:37:33 mago automount[3520]: expire_proc: exp_proc=3554
Apr 11 20:37:33 mago automount[3520]: handle_child: got pid 3554, sig 0 (0), stat 0 
Apr 11 20:37:33 mago automount[3520]: sigchld: exp 3554 finished, switching from 2 to 1
Apr 11 20:37:33 mago automount[3520]: get_pkt: state 2, next 1
Apr 11 20:37:33 mago automount[3520]: st_ready(): state = 2 
Apr 11 20:37:35 mago automount[3520]: handle_packet: type = 0 
Apr 11 20:37:35 mago automount[3520]: handle_packet_missing: token 6, name hda8 
Apr 11 20:37:35 mago automount[3520]: attempting to mount entry /mnt/auto/hda8
Apr 11 20:37:35 mago automount[3557]: lookup(program): looking up hda8
Apr 11 20:37:35 mago automount[3557]: lookup(program): hda8 -> -fstype=auto / /dev/hda8 /boot /dev/hda5 /usr /dev/vm/u0 /var /dev/vm/v0
Apr 11 20:37:35 mago automount[3557]: parse(sun): expanded entry: -fstype=auto / /dev/hda8 /boot /dev/hda5 /usr /dev/vm/u0 /var /dev/vm/v0
Apr 11 20:37:35 mago automount[3557]: parse(sun): dequote("fstype=auto") -> fstype=auto
Apr 11 20:37:35 mago automount[3557]: parse(sun): gathered options: fstype=auto
Apr 11 20:37:35 mago automount[3557]: parse(sun): dequote("/") -> /
Apr 11 20:37:35 mago automount[3557]: parse(sun): dequote("/dev/hda8 /boot /dev/hda5 /usr /dev/vm/u0 /var /dev/vm/v0") -> /dev/hda8 /boot /dev/hda5 /usr /dev/vm/u0 /var /dev/vm/v0
Apr 11 20:37:35 mago automount[3520]: handle_child: got pid 3557, sig 1 (11), stat 0 
Apr 11 20:37:35 mago automount[3520]: sig_child: found pending iop pid 3557: signalled 1 (sig 11), exit status 0
Apr 11 20:37:35 mago automount[3520]: send_fail: token=6 
Apr 11 20:37:41 mago automount[3520]: sig 14 switching from 1 to 2
Apr 11 20:37:41 mago automount[3520]: get_pkt: state 1, next 2
Apr 11 20:37:41 mago automount[3520]: st_expire(): state = 1 
Apr 11 20:37:41 mago automount[3520]: expire_proc: exp_proc=3561
Apr 11 20:37:41 mago automount[3520]: handle_child: got pid 3561, sig 0 (0), stat 0 
Apr 11 20:37:41 mago automount[3520]: sigchld: exp 3561 finished, switching from 2 to 1
Apr 11 20:37:41 mago automount[3520]: get_pkt: state 2, next 1
Apr 11 20:37:41 mago automount[3520]: st_ready(): state = 2 
Apr 11 20:37:49 mago automount[3520]: sig 14 switching from 1 to 2
Apr 11 20:37:49 mago automount[3520]: get_pkt: state 1, next 2
Apr 11 20:37:49 mago automount[3520]: st_expire(): state = 1 
Apr 11 20:37:49 mago automount[3520]: expire_proc: exp_proc=3565
Apr 11 20:37:49 mago automount[3520]: handle_child: got pid 3565, sig 0 (0), stat 0 
Apr 11 20:37:49 mago automount[3520]: sigchld: exp 3565 finished, switching from 2 to 1
Apr 11 20:37:49 mago automount[3520]: get_pkt: state 2, next 1
Apr 11 20:37:49 mago automount[3520]: st_ready(): state = 2 
Apr 11 20:37:57 mago automount[3520]: sig 14 switching from 1 to 2
Apr 11 20:37:57 mago automount[3520]: get_pkt: state 1, next 2
Apr 11 20:37:57 mago automount[3520]: st_expire(): state = 1 
Apr 11 20:37:57 mago automount[3520]: expire_proc: exp_proc=3567
Apr 11 20:37:57 mago automount[3520]: handle_child: got pid 3567, sig 0 (0), stat 0 
Apr 11 20:37:57 mago automount[3520]: sigchld: exp 3567 finished, switching from 2 to 1
Apr 11 20:37:57 mago automount[3520]: get_pkt: state 2, next 1
Apr 11 20:37:57 mago automount[3520]: st_ready(): state = 2 
