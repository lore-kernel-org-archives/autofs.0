From: Jarl Stefansson <jarl@marimo.is>
Subject: Unmount not working with 2.6.21  & 4.1.3/4.1.4
Date: Sun, 25 Mar 2007 17:38:24 +0000 (GMT)
Message-ID: <5620634.6651174844304991.JavaMail.root@holcus>
References: <4551176.6631174843682082.JavaMail.root@holcus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4551176.6631174843682082.JavaMail.root@holcus>
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


I'm working on a custom Gentoo build and autofs seems to completely ignore all timeout/unmount attempts.

My configuration is 2.6.21-rc3-mm2 with 4.1.3-R7.

The mounting works well but devices never get unmounted, even sending SIGUSR1 or killing does not have any effect.
There is no relevant logging to /var/log/messages even when running with debug enabled.

My Config:

/usr/sbin/automount -dgt 3 /mnt/auto file /etc/autofs/auto.mount

ubadata	-fstype=ext2,ro,async,exec,noatime,nodev	:/dev/uba1

I also included /var/log/messages from starting automount and mounting a device if that can be of any help.

Jarl

######################################### /var/log/messages ####################################################
Mar 26 01:33:43 kidsq daemon.info automount[3608]: starting automounter version 4.1.3, path = /mnt/auto, maptype = file, mapname = /etc/autofs/auto.mount
Mar 26 01:33:43 kidsq daemon.debug automount[3608]: mount(bind): bind_works = 1 
Mar 26 01:33:43 kidsq daemon.info automount[3608]: using kernel protocol version 4.00
Mar 26 01:33:43 kidsq daemon.info automount[3608]: using timeout 3 seconds; freq 1 secs
Mar 26 01:33:43 kidsq daemon.info automount[3608]: ghosting enabled
Mar 26 01:33:44 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:44 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:44 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:44 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3612
Mar 26 01:33:44 kidsq daemon.debug automount[3608]: handle_child: got pid 3612, sig 0 (0), stat 0 
Mar 26 01:33:44 kidsq daemon.debug automount[3608]: sigchld: exp 3612 finished, switching from 2 to 1
Mar 26 01:33:44 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:44 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:45 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:45 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:45 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:45 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3613
Mar 26 01:33:45 kidsq daemon.debug automount[3608]: handle_child: got pid 3613, sig 0 (0), stat 0 
Mar 26 01:33:45 kidsq daemon.debug automount[3608]: sigchld: exp 3613 finished, switching from 2 to 1
Mar 26 01:33:45 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:45 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:46 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:46 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:46 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:46 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3614
Mar 26 01:33:46 kidsq daemon.debug automount[3608]: handle_child: got pid 3614, sig 0 (0), stat 0 
Mar 26 01:33:46 kidsq daemon.debug automount[3608]: sigchld: exp 3614 finished, switching from 2 to 1
Mar 26 01:33:46 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:46 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:47 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:47 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:47 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:47 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3615
Mar 26 01:33:47 kidsq daemon.debug automount[3608]: handle_child: got pid 3615, sig 0 (0), stat 0 
Mar 26 01:33:47 kidsq daemon.debug automount[3608]: sigchld: exp 3615 finished, switching from 2 to 1
Mar 26 01:33:47 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:47 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:48 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:48 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:48 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:48 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3616
Mar 26 01:33:48 kidsq daemon.debug automount[3608]: handle_child: got pid 3616, sig 0 (0), stat 0 
Mar 26 01:33:48 kidsq daemon.debug automount[3608]: sigchld: exp 3616 finished, switching from 2 to 1
Mar 26 01:33:48 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:48 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:49 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:49 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:49 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:49 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3617
Mar 26 01:33:49 kidsq daemon.debug automount[3608]: handle_child: got pid 3617, sig 0 (0), stat 0 
Mar 26 01:33:49 kidsq daemon.debug automount[3608]: sigchld: exp 3617 finished, switching from 2 to 1
Mar 26 01:33:49 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:50 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:51 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:51 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:51 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:51 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3618
Mar 26 01:33:51 kidsq daemon.debug automount[3608]: handle_child: got pid 3618, sig 0 (0), stat 0 
Mar 26 01:33:51 kidsq daemon.debug automount[3608]: sigchld: exp 3618 finished, switching from 2 to 1
Mar 26 01:33:51 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:51 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:52 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:52 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:52 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:52 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3619
Mar 26 01:33:52 kidsq daemon.debug automount[3608]: handle_child: got pid 3619, sig 0 (0), stat 0 
Mar 26 01:33:52 kidsq daemon.debug automount[3608]: sigchld: exp 3619 finished, switching from 2 to 1
Mar 26 01:33:52 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:52 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3620
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: handle_child: got pid 3620, sig 0 (0), stat 0 
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: sigchld: exp 3620 finished, switching from 2 to 1
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: handle_packet: type = 0 
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: handle_packet_missing: token 46, name ubadata 
Mar 26 01:33:53 kidsq daemon.info automount[3608]: attempting to mount entry /mnt/auto/ubadata
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: lookup(file): ubadata -> -fstype=auto,rw,sync,noexec,nodev^I:/dev/uba1
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: parse(sun): expanded entry: -fstype=auto,rw,sync,noexec,nodev^I:/dev/uba1
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: parse(sun): dequote("fstype=auto,rw,sync,noexec,nodev") -> fstype=auto,rw,sync,noexec,nodev
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: parse(sun): gathered options: fstype=auto,rw,sync,noexec,nodev
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: parse(sun): dequote("/dev/uba1") -> /dev/uba1
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: parse(sun): core of entry: options=fstype=auto,rw,sync,noexec,nodev, loc=/dev/uba1
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: parse(sun): mounting root /mnt/auto, mountpoint ubadata, what /dev/uba1, fstype auto, options rw,sync,noexec,nodev 
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: do_mount /dev/uba1 /mnt/auto/ubadata type auto options rw,sync,noexec,nodev using module generic
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: mount(generic): calling mkdir_path /mnt/auto/ubadata
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: mount(generic): calling mount -t auto -o rw,sync,noexec,nodev /dev/uba1 /mnt/auto/ubadata
Mar 26 01:33:53 kidsq user.info kernel: kjournald starting.  Commit interval 5 seconds
Mar 26 01:33:53 kidsq user.info kernel: EXT3 FS on uba1, internal journal
Mar 26 01:33:53 kidsq user.info kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar 26 01:33:53 kidsq daemon.debug automount[3622]: mount(generic): mounted /dev/uba1 type auto on /mnt/auto/ubadata
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: handle_child: got pid 3622, sig 0 (0), stat 0 
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: sig_child: found pending iop pid 3622: signalled 0 (sig 0), exit status 0
Mar 26 01:33:53 kidsq daemon.debug automount[3608]: send_ready: token=46 
Mar 26 01:33:54 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:54 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:54 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:54 kidsq daemon.debug automount[3626]: expire_proc: 1 remaining in /mnt/auto 
Mar 26 01:33:54 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3626
Mar 26 01:33:54 kidsq daemon.debug automount[3608]: handle_child: got pid 3626, sig 0 (0), stat 1 
Mar 26 01:33:54 kidsq daemon.debug automount[3608]: sigchld: exp 3626 finished, switching from 2 to 1
Mar 26 01:33:54 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:54 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:55 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:55 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:55 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:55 kidsq daemon.debug automount[3627]: expire_proc: 1 remaining in /mnt/auto 
Mar 26 01:33:55 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3627
Mar 26 01:33:55 kidsq daemon.debug automount[3608]: handle_child: got pid 3627, sig 0 (0), stat 1 
Mar 26 01:33:55 kidsq daemon.debug automount[3608]: sigchld: exp 3627 finished, switching from 2 to 1
Mar 26 01:33:55 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:55 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:56 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:56 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:56 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:56 kidsq daemon.debug automount[3628]: expire_proc: 1 remaining in /mnt/auto 
Mar 26 01:33:56 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3628
Mar 26 01:33:56 kidsq daemon.debug automount[3608]: handle_child: got pid 3628, sig 0 (0), stat 1 
Mar 26 01:33:56 kidsq daemon.debug automount[3608]: sigchld: exp 3628 finished, switching from 2 to 1
Mar 26 01:33:56 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:56 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:57 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:57 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:57 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:57 kidsq daemon.debug automount[3629]: expire_proc: 1 remaining in /mnt/auto 
Mar 26 01:33:57 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3629
Mar 26 01:33:57 kidsq daemon.debug automount[3608]: handle_child: got pid 3629, sig 0 (0), stat 1 
Mar 26 01:33:57 kidsq daemon.debug automount[3608]: sigchld: exp 3629 finished, switching from 2 to 1
Mar 26 01:33:57 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:57 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:58 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:58 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:58 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:58 kidsq daemon.debug automount[3630]: expire_proc: 1 remaining in /mnt/auto 
Mar 26 01:33:58 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3630
Mar 26 01:33:58 kidsq daemon.debug automount[3608]: handle_child: got pid 3630, sig 0 (0), stat 1 
Mar 26 01:33:58 kidsq daemon.debug automount[3608]: sigchld: exp 3630 finished, switching from 2 to 1
Mar 26 01:33:58 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:58 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:33:59 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:33:59 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:33:59 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:33:59 kidsq daemon.debug automount[3631]: expire_proc: 1 remaining in /mnt/auto 
Mar 26 01:33:59 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3631
Mar 26 01:33:59 kidsq daemon.debug automount[3608]: handle_child: got pid 3631, sig 0 (0), stat 1 
Mar 26 01:33:59 kidsq daemon.debug automount[3608]: sigchld: exp 3631 finished, switching from 2 to 1
Mar 26 01:33:59 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:33:59 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:34:00 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:34:00 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:34:00 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:34:00 kidsq daemon.debug automount[3632]: expire_proc: 1 remaining in /mnt/auto 
Mar 26 01:34:00 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3632
Mar 26 01:34:00 kidsq daemon.debug automount[3608]: handle_child: got pid 3632, sig 0 (0), stat 1 
Mar 26 01:34:00 kidsq daemon.debug automount[3608]: sigchld: exp 3632 finished, switching from 2 to 1
Mar 26 01:34:00 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:34:00 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:34:01 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:34:01 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:34:01 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:34:01 kidsq daemon.debug automount[3633]: expire_proc: 1 remaining in /mnt/auto 
Mar 26 01:34:01 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3633
Mar 26 01:34:01 kidsq daemon.debug automount[3608]: handle_child: got pid 3633, sig 0 (0), stat 1 
Mar 26 01:34:01 kidsq daemon.debug automount[3608]: sigchld: exp 3633 finished, switching from 2 to 1
Mar 26 01:34:01 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:34:01 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
Mar 26 01:34:02 kidsq daemon.debug automount[3608]: sig 14 switching from 1 to 2
Mar 26 01:34:02 kidsq daemon.debug automount[3608]: get_pkt: state 1, next 2
Mar 26 01:34:02 kidsq daemon.debug automount[3608]: st_expire(): state = 1 
Mar 26 01:34:02 kidsq daemon.debug automount[3634]: expire_proc: 1 remaining in /mnt/auto 
Mar 26 01:34:02 kidsq daemon.debug automount[3608]: expire_proc: exp_proc=3634
Mar 26 01:34:02 kidsq daemon.debug automount[3608]: handle_child: got pid 3634, sig 0 (0), stat 1 
Mar 26 01:34:02 kidsq daemon.debug automount[3608]: sigchld: exp 3634 finished, switching from 2 to 1
Mar 26 01:34:02 kidsq daemon.debug automount[3608]: get_pkt: state 2, next 1
Mar 26 01:34:02 kidsq daemon.debug automount[3608]: st_ready(): state = 2 
(this sequence keeps going forever)
