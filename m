From: Pavel Troller <patrol@sinus.cz>
Subject: Re: automount 4.1.3: unmount timeout not working
Date: Wed, 26 Jan 2005 20:48:24 +0100
Message-ID: <20050126194824.GA3627@tangens.sinus.cz>
References: <20050122215228.GA14303@tangens.sinus.cz>
	<Pine.LNX.4.61.0501262240140.1716@donald.themaw.net>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501262240140.1716@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org, Pavel Troller <patrol@sinus.cz>

> 
> But you leave out the crucial log trace following the mount?
> 
> Can we see more of what follows here please.
> 
> Ian
Hello Ian,
  OK, I'm sending the full system log during the mount/umount... I don't know
which part You are interested in, but I don't see anything special...
  BTW using the UDF packet mode is just an example, umount timeout doesn't
work on vfat floppies or iso9660 cd's as well...
  With regards, Pavel
  
... automount startup log not included, it' identical to the one sent earlier
[ls /mnt/udfcd issued]
Jan 26 20:33:32 arcus automount[1989]: handle_packet: type = 0
Jan 26 20:33:32 arcus automount[1989]: handle_packet_missing: token 3, name udfcd
Jan 26 20:33:32 arcus automount[1989]: attempting to mount entry /mnt/udfcd
Jan 26 20:33:32 arcus automount[3411]: lookup(file): udfcd -> -fstype=udf,rw,noatime,gid=32,umask=002^I:/dev/pktcdvd/0
Jan 26 20:33:32 arcus automount[3411]: parse(sun): expanded entry: -fstype=udf,rw,noatime,gid=32,umask=002^I:/dev/pktcdvd/0
Jan 26 20:33:32 arcus automount[3411]: parse(sun): dequote("fstype=udf,rw,noatime,gid=32,umask=002") -> fstype=udf,rw,noatime,gid=32,umask=002
Jan 26 20:33:32 arcus automount[3411]: parse(sun): gathered options: fstype=udf,rw,noatime,gid=32,umask=002
Jan 26 20:33:32 arcus automount[3411]: parse(sun): dequote("/dev/pktcdvd/0") -> /dev/pktcdvd/0
Jan 26 20:33:32 arcus automount[3411]: parse(sun): core of entry: options=fstype=udf,rw,noatime,gid=32,umask=002, loc=/dev/pktcdvd/0Jan 26 20:33:32 arcus automount[3411]: parse(sun): mounting root /mnt, mountpoint udfcd, what /dev/pktcdvd/0, fstype udf, options rw,noatime,gid=32,umask=002
Jan 26 20:33:32 arcus automount[3411]: do_mount /dev/pktcdvd/0 /mnt/udfcd type udf options rw,noatime,gid=32,umask=002 using module
generic
Jan 26 20:33:32 arcus automount[3411]: mount(generic): calling mkdir_path /mnt/udfcd
Jan 26 20:33:32 arcus automount[3411]: mount(generic): calling mount -t udf -s -o rw,noatime,gid=32,umask=002 /dev/pktcdvd/0 /mnt/udfcd
Jan 26 20:33:32 arcus /sbin/hotplug: no runnable /etc/hotplug/module.agent is installed
Jan 26 20:33:32 arcus /sbin/hotplug: no runnable /etc/hotplug/module.agent is installed
Jan 26 20:33:32 arcus kernel: pktcdvd: inserted media is CD-RW
Jan 26 20:33:33 arcus kernel: pktcdvd: Fixed packets, 32 blocks, Mode-2 disc
Jan 26 20:33:33 arcus kernel: pktcdvd: Max. media speed: 16
Jan 26 20:33:33 arcus kernel: pktcdvd: write speed 16x
Jan 26 20:33:33 arcus kernel: pktcdvd: 590526kB available on disc
Jan 26 20:33:36 arcus kernel: UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 2004/11/15 17:24 (103c)
Jan 26 20:33:36 arcus automount[3411]: mount(generic): mounted /dev/pktcdvd/0 type udf on /mnt/udfcd
Jan 26 20:33:36 arcus automount[1989]: handle_child: got pid 3411, sig 0 (0), stat 0
Jan 26 20:33:36 arcus automount[1989]: sig_child: found pending iop pid 3411: signalled 0 (sig 0), exit status 0
Jan 26 20:33:36 arcus automount[1989]: send_ready: token=3
[Nothing more logged for the mount action]
[umount had to occur 2 seconds later]
Jan 26 20:35:19 arcus login[18647]: ROOT LOGIN on `vc/1'
[root is killing automount with USR1] (also contained in previous mail)
Jan 26 20:35:33 arcus automount[1989]: sig 10 switching from 1 to 3
Jan 26 20:35:33 arcus automount[1989]: get_pkt: state 1, next 3
Jan 26 20:35:33 arcus automount[1989]: st_prune(): state = 1
Jan 26 20:35:33 arcus automount[1989]: expire_proc: exp_proc=3574
Jan 26 20:35:33 arcus automount[1989]: handle_packet: type = 2
Jan 26 20:35:33 arcus automount[1989]: handle_packet_expire_multi: token 4, name udfcd
Jan 26 20:35:33 arcus automount[3575]: expiring path /mnt/udfcd
Jan 26 20:35:33 arcus automount[3575]: umount_multi: path=/mnt/udfcd incl=1
Jan 26 20:35:33 arcus automount[3575]: umount_multi: unmounting dir=/mnt/udfcd
