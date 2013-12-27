From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet committed
Date: Fri, 27 Dec 2013 15:30:55 +0800
Message-ID: <CAF1ZMEdRhy5LcfEwUW3Os5M8nKXT1j2+M4oqOKgqF3sjLPyWpw@mail.gmail.com>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	<CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	<1387875881.7351.12.camel@perseus.fritz.box>
	<CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	<1387881262.7351.15.camel@perseus.fritz.box>
	<CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
	<CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VIt4LUqkP646HhUoEBuJdRThUOb4srShbXprlGCJgPo=;
        b=WL9qpEu8E2qq530BmLOgLbe3Hso0B2MuhnqhhGjPfGZZq5MiYur9l4BPMlnuJO7ybi
         13I73VakkYl8CZLkzgcaM7ZYileQx6+69UChPu1X0ZvIJwgE3LFwM4QmZ0/BIyg+vFXG
         rxAn5PYc0PZpvNaLR2FarlxPpjP3WKOMOPms4o5QflXyRC09ac8VDsx3rNWAuMelKsVl
         n/KigKcWCnw6D1ap+zlXADyShj7KSBW4OCk0vM6puu+7iDwB8kW3+x8Lu5hm32rgMPyp
         DifbDexD6Qw5iZyLCpK0zx2ap8ZToXtnL9tUFaeQZYxjioGL+Z1daI4EUvQxdgMNfGGB
         O4sg==
In-Reply-To: <CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

sorry, I was not accurate about the failure cases.

using commit ec267c2c406256e401540e5bc890b2e0c2ff6c35

snip from file /etc/autofs/auto.misc
mkynfs -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
mkydns -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis

with libtirpc enabled (all other features disabled),[1]
"ls /mnt/misc/mkynfs" lead to automount segfault
"ls /mnt/misc/mkydns" automount fail (no crash), but report "no hosts available"

with libtirpc disabled (all other features disabled)[2]
"ls /mnt/misc/mkynfs" automount fail (no crash), report "no hosts available"
"ls /mnt/misc/mkydns" works fine

[1]
Dec 27 15:08:19 ofire automount[32570]: handle_packet: type = 3
Dec 27 15:08:19 ofire automount[32570]:
handle_packet_missing_indirect: token 106, name mkydns, request pid
32583
Dec 27 15:08:19 ofire automount[32570]: attempting to mount entry
/mnt/misc/mkydns
Dec 27 15:08:19 ofire automount[32570]: lookup_mount: lookup(file):
looking up mkydns
Dec 27 15:08:19 ofire automount[32570]: lookup_mount: lookup(file):
mkydns -> -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
Dec 27 15:08:19 ofire automount[32570]: parse_mount: parse(sun):
expanded entry: -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
Dec 27 15:08:19 ofire automount[32570]: parse_mount: parse(sun):
gathered options: ro,soft,intr,nfsvers=4
Dec 27 15:08:19 ofire automount[32570]: parse_mount: parse(sun):
dequote("mickeycn:/home/dennis") -> mickeycn:/home/dennis
Dec 27 15:08:19 ofire automount[32570]: parse_mount: parse(sun): core
of entry: options=ro,soft,intr,nfsvers=4, loc=mickeycn:/home/dennis
Dec 27 15:08:19 ofire automount[32570]: sun_mount: parse(sun):
mounting root /mnt/misc, mountpoint mkydns, what
mickeycn:/home/dennis, fstype nfs, options ro,soft,intr,nfsvers=4
Dec 27 15:08:19 ofire automount[32570]: mount_mount: mount(nfs):
root=/mnt/misc name=mkydns what=mickeycn:/home/dennis, fstype=nfs,
options=ro,soft,intr,nfsvers=4
Dec 27 15:08:19 ofire automount[32570]: mount_mount: mount(nfs): nfs
options="ro,soft,intr,nfsvers=4", nobind=0, nosymlink=0, ro=1
Dec 27 15:08:19 ofire automount[32570]: get_nfs_info: called with host
mickeycn(192.168.90.12) proto 6 version 0x40
Dec 27 15:08:19 ofire automount[32570]: mount(nfs): no hosts available
Dec 27 15:08:19 ofire automount[32570]: dev_ioctl_send_fail: token = 106
Dec 27 15:08:19 ofire automount[32570]: failed to mount /mnt/misc/mkydns
Dec 27 15:08:19 ofire automount[32570]: handle_packet: type = 3
Dec 27 15:08:19 ofire automount[32570]:
handle_packet_missing_indirect: token 107, name mkydns, request pid
32583
Dec 27 15:08:19 ofire automount[32570]: dev_ioctl_send_fail: token = 107
Dec 27 15:08:26 ofire automount[32570]: st_expire: state 1 path /net
Dec 27 15:08:26 ofire automount[32570]: expire_proc: exp_proc =
140502330578688 path /net
Dec 27 15:08:26 ofire automount[32570]: expire_cleanup: got thid
140502330578688 path /net stat 0
Dec 27 15:08:26 ofire automount[32570]: expire_cleanup: sigchld: exp
140502330578688 finished, switching from 2 to 1
Dec 27 15:08:26 ofire automount[32570]: st_ready: st_ready(): state =
2 path /net
Dec 27 15:08:26 ofire automount[32570]: handle_packet: type = 3
Dec 27 15:08:26 ofire automount[32570]:
handle_packet_missing_indirect: token 108, name mkynfs, request pid
32586
Dec 27 15:08:26 ofire automount[32570]: attempting to mount entry
/mnt/misc/mkynfs
Dec 27 15:08:26 ofire automount[32570]: lookup_mount: lookup(file):
looking up mkynfs
Dec 27 15:08:26 ofire automount[32570]: lookup_mount: lookup(file):
mkynfs -> -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
Dec 27 15:08:26 ofire automount[32570]: parse_mount: parse(sun):
expanded entry: -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
Dec 27 15:08:26 ofire automount[32570]: parse_mount: parse(sun):
gathered options: ro,soft,intr,nfsvers=3
Dec 27 15:08:26 ofire automount[32570]: parse_mount: parse(sun):
dequote("192.168.90.12:/home/dennis") -> 192.168.90.12:/home/dennis
Dec 27 15:08:26 ofire automount[32570]: parse_mount: parse(sun): core
of entry: options=ro,soft,intr,nfsvers=3,
loc=192.168.90.12:/home/dennis
Dec 27 15:08:26 ofire automount[32570]: sun_mount: parse(sun):
mounting root /mnt/misc, mountpoint mkynfs, what
192.168.90.12:/home/dennis, fstype nfs, options ro,soft,intr,nfsvers=3
Dec 27 15:08:26 ofire automount[32570]: mount_mount: mount(nfs):
root=/mnt/misc name=mkynfs what=192.168.90.12:/home/dennis,
fstype=nfs, options=ro,soft,intr,nfsvers=3
Dec 27 15:08:26 ofire automount[32570]: mount_mount: mount(nfs): nfs
options="ro,soft,intr,nfsvers=3", nobind=0, nosymlink=0, ro=1
Dec 27 15:08:26 ofire automount[32570]: get_nfs_info: called with host
192.168.90.12(192.168.90.12) proto 6 version 0x20
Dec 27 15:08:26 ofire automount[32570]: get_nfs_info: called with host
192.168.90.12(192.168.90.12) proto 17 version 0x20
Dec 27 15:08:26 ofire kernel: [20427.317530] automount[32587]:
segfault at 0 ip           (null) sp 00007fc93f808c88 error 14


[2] log
Dec 27 15:16:52 ofire automount[3879]: st_expire: state 1 path /net
Dec 27 15:16:52 ofire automount[3879]: expire_proc: exp_proc =
139809608951552 path /net
Dec 27 15:16:52 ofire automount[3879]: expire_cleanup: got thid
139809608951552 path /net stat 0
Dec 27 15:16:52 ofire automount[3879]: expire_cleanup: sigchld: exp
139809608951552 finished, switching from 2 to 1
Dec 27 15:16:52 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
Dec 27 15:16:53 ofire automount[3879]: handle_packet: type = 3
Dec 27 15:16:53 ofire automount[3879]: handle_packet_missing_indirect:
token 119, name mkydns, request pid 3898
Dec 27 15:16:53 ofire automount[3879]: attempting to mount entry
/mnt/misc/mkydns
Dec 27 15:16:53 ofire automount[3879]: lookup_mount: lookup(file):
looking up mkydns
Dec 27 15:16:53 ofire automount[3879]: lookup_mount: lookup(file):
mkydns -> -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
Dec 27 15:16:53 ofire automount[3879]: parse_mount: parse(sun):
expanded entry: -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
Dec 27 15:16:53 ofire automount[3879]: parse_mount: parse(sun):
gathered options: ro,soft,intr,nfsvers=4
Dec 27 15:16:53 ofire automount[3879]: parse_mount: parse(sun):
dequote("mickeycn:/home/dennis") -> mickeycn:/home/dennis
Dec 27 15:16:53 ofire automount[3879]: parse_mount: parse(sun): core
of entry: options=ro,soft,intr,nfsvers=4, loc=mickeycn:/home/dennis
Dec 27 15:16:53 ofire automount[3879]: sun_mount: parse(sun): mounting
root /mnt/misc, mountpoint mkydns, what mickeycn:/home/dennis, fstype
nfs, options ro,soft,intr,nfsvers=4
Dec 27 15:16:53 ofire automount[3879]: mount_mount: mount(nfs):
root=/mnt/misc name=mkydns what=mickeycn:/home/dennis, fstype=nfs,
options=ro,soft,intr,nfsvers=4
Dec 27 15:16:53 ofire automount[3879]: mount_mount: mount(nfs): nfs
options="ro,soft,intr,nfsvers=4", nobind=0, nosymlink=0, ro=1
Dec 27 15:16:53 ofire automount[3879]: get_nfs_info: called with host
mickeycn(192.168.90.12) proto 6 version 0x40
Dec 27 15:16:53 ofire automount[3879]: get_nfs_info: nfs v4 rpc ping
time: 0.000599
Dec 27 15:16:53 ofire automount[3879]: get_nfs_info: host mickeycn
cost 598 weight 0
Dec 27 15:16:53 ofire automount[3879]: prune_host_list: selected
subset of hosts that support NFS4 over TCP
Dec 27 15:16:53 ofire automount[3879]: mount_mount: mount(nfs):
calling mkdir_path /mnt/misc/mkydns
Dec 27 15:16:53 ofire automount[3879]: mount_mount: mount(nfs):
calling mount -t nfs -s -o ro,soft,intr,nfsvers=4
mickeycn:/home/dennis /mnt/misc/mkydns
Dec 27 15:16:53 ofire automount[3879]: mount_mount: mount(nfs):
mounted mickeycn:/home/dennis on /mnt/misc/mkydns
Dec 27 15:16:53 ofire automount[3879]: dev_ioctl_send_ready: token = 119
Dec 27 15:16:53 ofire automount[3879]: mounted /mnt/misc/mkydns
Dec 27 15:17:00 ofire automount[3879]: st_expire: state 1 path /net
Dec 27 15:17:00 ofire automount[3879]: expire_proc: exp_proc =
139809608951552 path /net
Dec 27 15:17:00 ofire automount[3879]: expire_cleanup: got thid
139809608951552 path /net stat 0
Dec 27 15:17:00 ofire automount[3879]: expire_cleanup: sigchld: exp
139809608951552 finished, switching from 2 to 1
Dec 27 15:17:00 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
Dec 27 15:17:08 ofire automount[3879]: st_expire: state 1 path /net
Dec 27 15:17:08 ofire automount[3879]: expire_proc: exp_proc =
139809608951552 path /net
Dec 27 15:17:08 ofire automount[3879]: expire_cleanup: got thid
139809608951552 path /net stat 0
Dec 27 15:17:08 ofire automount[3879]: expire_cleanup: sigchld: exp
139809608951552 finished, switching from 2 to 1
Dec 27 15:17:08 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
Dec 27 15:17:16 ofire automount[3879]: st_expire: state 1 path /net
Dec 27 15:17:16 ofire automount[3879]: expire_proc: exp_proc =
139809608951552 path /net
Dec 27 15:17:16 ofire automount[3879]: expire_cleanup: got thid
139809608951552 path /net stat 0
Dec 27 15:17:16 ofire automount[3879]: expire_cleanup: sigchld: exp
139809608951552 finished, switching from 2 to 1
Dec 27 15:17:16 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
Dec 27 15:17:17 ofire automount[3879]: handle_packet: type = 3
Dec 27 15:17:17 ofire automount[3879]: handle_packet_missing_indirect:
token 120, name mkynfs, request pid 3918
Dec 27 15:17:17 ofire automount[3879]: attempting to mount entry
/mnt/misc/mkynfs
Dec 27 15:17:17 ofire automount[3879]: lookup_mount: lookup(file):
looking up mkynfs
Dec 27 15:17:17 ofire automount[3879]: lookup_mount: lookup(file):
mkynfs -> -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
Dec 27 15:17:17 ofire automount[3879]: parse_mount: parse(sun):
expanded entry: -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
Dec 27 15:17:17 ofire automount[3879]: parse_mount: parse(sun):
gathered options: ro,soft,intr,nfsvers=3
Dec 27 15:17:17 ofire automount[3879]: parse_mount: parse(sun):
dequote("192.168.90.12:/home/dennis") -> 192.168.90.12:/home/dennis
Dec 27 15:17:17 ofire automount[3879]: parse_mount: parse(sun): core
of entry: options=ro,soft,intr,nfsvers=3,
loc=192.168.90.12:/home/dennis
Dec 27 15:17:17 ofire automount[3879]: sun_mount: parse(sun): mounting
root /mnt/misc, mountpoint mkynfs, what 192.168.90.12:/home/dennis,
fstype nfs, options ro,soft,intr,nfsvers=3
Dec 27 15:17:17 ofire automount[3879]: mount_mount: mount(nfs):
root=/mnt/misc name=mkynfs what=192.168.90.12:/home/dennis,
fstype=nfs, options=ro,soft,intr,nfsvers=3
Dec 27 15:17:17 ofire automount[3879]: mount_mount: mount(nfs): nfs
options="ro,soft,intr,nfsvers=3", nobind=0, nosymlink=0, ro=1
Dec 27 15:17:17 ofire automount[3879]: get_nfs_info: called with host
192.168.90.12(192.168.90.12) proto 6 version 0x20
Dec 27 15:17:17 ofire automount[3879]: get_nfs_info: called with host
192.168.90.12(192.168.90.12) proto 17 version 0x20
Dec 27 15:17:20 ofire automount[3879]: mount(nfs): no hosts available
Dec 27 15:17:20 ofire automount[3879]: dev_ioctl_send_fail: token = 120
Dec 27 15:17:20 ofire automount[3879]: failed to mount /mnt/misc/mkynfs
Dec 27 15:17:20 ofire automount[3879]: handle_packet: type = 3
Dec 27 15:17:20 ofire automount[3879]: handle_packet_missing_indirect:
token 121, name mkynfs, request pid 3918
Dec 27 15:17:20 ofire automount[3879]: dev_ioctl_send_fail: token = 121
Dec 27 15:17:24 ofire automount[3879]: st_expire: state 1 path /net
Dec 27 15:17:24 ofire automount[3879]: expire_proc: exp_proc =
139809608951552 path /net
Dec 27 15:17:24 ofire automount[3879]: expire_cleanup: got thid
139809608951552 path /net stat 0
Dec 27 15:17:24 ofire automount[3879]: expire_cleanup: sigchld: exp
139809608951552 finished, switching from 2 to 1
Dec 27 15:17:24 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
Dec 27 15:17:32 ofire automount[3879]: st_expire: state 1 path /net
Dec 27 15:17:32 ofire automount[3879]: expire_proc: exp_proc =
139809608951552 path /net
Dec 27 15:17:32 ofire automount[3879]: expire_cleanup: got thid
139809608951552 path /net stat 0
Dec 27 15:17:32 ofire automount[3879]: expire_cleanup: sigchld: exp
139809608951552 finished, switching from 2 to 1
Dec 27 15:17:32 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
Dec 27 15:17:40 ofire automount[3879]: st_expire: state 1 path /net
Dec 27 15:17:40 ofire automount[3879]: expire_proc: exp_proc =
139809608951552 path /net
Dec 27 15:17:40 ofire automount[3879]: expire_cleanup: got thid
139809608951552 path /net stat 0
Dec 27 15:17:40 ofire automount[3879]: expire_cleanup: sigchld: exp
139809608951552 finished, switching from 2 to 1
Dec 27 15:17:40 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
