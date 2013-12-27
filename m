From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet
 committed
Date: Fri, 27 Dec 2013 16:56:53 +0800
Message-ID: <1388134613.2623.7.camel@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	 <CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	 <1387875881.7351.12.camel@perseus.fritz.box>
	 <CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	 <1387881262.7351.15.camel@perseus.fritz.box>
	 <CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
	 <CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
	 <CAF1ZMEdRhy5LcfEwUW3Os5M8nKXT1j2+M4oqOKgqF3sjLPyWpw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=zFC+TRfJL6czZK8hiYUQH4L236M=; b=HU9Y/O6Rn/oMLVGjrm4VqkxfcoNs
	NFVanrpgLWMH1G00E3oJPE6jWY/2KkhV8DbBpjzYF0nrS0vj34u53etrtNIomHkH
	tk6nMWT8WJfbI9pRSbEAI7rpkeOqJyrPHDFXIPaaIEebG723QD+ITr5uQQl/+Zmz
	5IqbSU8I/YXV1Y0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=zFC+TRfJL6czZK8hiYUQH4
	L236M=; b=p7Z+J63Jpn7d/GZB3CrIF4cFh1NZTQxjfDZH4gHMlpps6vLi9T/82s
	6dr3/XlO/AI7TCBEQj/yz4Cjijfzg7Yg8Dco4nvVr/jLWR2Pw5+KE5RNFdnQQGFA
	YRejK7byUquOuWAo4SYq7NZF2ZC6Q3GOP4xFBCWooh7K8yVtt9T3I=
In-Reply-To: <CAF1ZMEdRhy5LcfEwUW3Os5M8nKXT1j2+M4oqOKgqF3sjLPyWpw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Fri, 2013-12-27 at 15:30 +0800, Dennis Lan (dlan) wrote:
> sorry, I was not accurate about the failure cases.
> 
> using commit ec267c2c406256e401540e5bc890b2e0c2ff6c35
> 
> snip from file /etc/autofs/auto.misc
> mkynfs -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
> mkydns -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
> 
> with libtirpc enabled (all other features disabled),[1]
> "ls /mnt/misc/mkynfs" lead to automount segfault
> "ls /mnt/misc/mkydns" automount fail (no crash), but report "no hosts available"

Right, I think I've worked out the issue with this second case.
I'll push my recent changes to autofs-5.0.public once I've had a look at
the segfault issue.

> 
> with libtirpc disabled (all other features disabled)[2]
> "ls /mnt/misc/mkynfs" automount fail (no crash), report "no hosts available"
> "ls /mnt/misc/mkydns" works fine

Mmmm .. I'll need to duplicate this and have a look.
The libtirpc disabled case shouldn't really have changed ....

Let me work through these logs and see if I can spot anything obvious.

> 
> [1]
> Dec 27 15:08:19 ofire automount[32570]: handle_packet: type = 3
> Dec 27 15:08:19 ofire automount[32570]:
> handle_packet_missing_indirect: token 106, name mkydns, request pid
> 32583
> Dec 27 15:08:19 ofire automount[32570]: attempting to mount entry
> /mnt/misc/mkydns
> Dec 27 15:08:19 ofire automount[32570]: lookup_mount: lookup(file):
> looking up mkydns
> Dec 27 15:08:19 ofire automount[32570]: lookup_mount: lookup(file):
> mkydns -> -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
> Dec 27 15:08:19 ofire automount[32570]: parse_mount: parse(sun):
> expanded entry: -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
> Dec 27 15:08:19 ofire automount[32570]: parse_mount: parse(sun):
> gathered options: ro,soft,intr,nfsvers=4
> Dec 27 15:08:19 ofire automount[32570]: parse_mount: parse(sun):
> dequote("mickeycn:/home/dennis") -> mickeycn:/home/dennis
> Dec 27 15:08:19 ofire automount[32570]: parse_mount: parse(sun): core
> of entry: options=ro,soft,intr,nfsvers=4, loc=mickeycn:/home/dennis
> Dec 27 15:08:19 ofire automount[32570]: sun_mount: parse(sun):
> mounting root /mnt/misc, mountpoint mkydns, what
> mickeycn:/home/dennis, fstype nfs, options ro,soft,intr,nfsvers=4
> Dec 27 15:08:19 ofire automount[32570]: mount_mount: mount(nfs):
> root=/mnt/misc name=mkydns what=mickeycn:/home/dennis, fstype=nfs,
> options=ro,soft,intr,nfsvers=4
> Dec 27 15:08:19 ofire automount[32570]: mount_mount: mount(nfs): nfs
> options="ro,soft,intr,nfsvers=4", nobind=0, nosymlink=0, ro=1
> Dec 27 15:08:19 ofire automount[32570]: get_nfs_info: called with host
> mickeycn(192.168.90.12) proto 6 version 0x40
> Dec 27 15:08:19 ofire automount[32570]: mount(nfs): no hosts available
> Dec 27 15:08:19 ofire automount[32570]: dev_ioctl_send_fail: token = 106
> Dec 27 15:08:19 ofire automount[32570]: failed to mount /mnt/misc/mkydns
> Dec 27 15:08:19 ofire automount[32570]: handle_packet: type = 3
> Dec 27 15:08:19 ofire automount[32570]:
> handle_packet_missing_indirect: token 107, name mkydns, request pid
> 32583
> Dec 27 15:08:19 ofire automount[32570]: dev_ioctl_send_fail: token = 107
> Dec 27 15:08:26 ofire automount[32570]: st_expire: state 1 path /net
> Dec 27 15:08:26 ofire automount[32570]: expire_proc: exp_proc =
> 140502330578688 path /net
> Dec 27 15:08:26 ofire automount[32570]: expire_cleanup: got thid
> 140502330578688 path /net stat 0
> Dec 27 15:08:26 ofire automount[32570]: expire_cleanup: sigchld: exp
> 140502330578688 finished, switching from 2 to 1
> Dec 27 15:08:26 ofire automount[32570]: st_ready: st_ready(): state =
> 2 path /net
> Dec 27 15:08:26 ofire automount[32570]: handle_packet: type = 3
> Dec 27 15:08:26 ofire automount[32570]:
> handle_packet_missing_indirect: token 108, name mkynfs, request pid
> 32586
> Dec 27 15:08:26 ofire automount[32570]: attempting to mount entry
> /mnt/misc/mkynfs
> Dec 27 15:08:26 ofire automount[32570]: lookup_mount: lookup(file):
> looking up mkynfs
> Dec 27 15:08:26 ofire automount[32570]: lookup_mount: lookup(file):
> mkynfs -> -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
> Dec 27 15:08:26 ofire automount[32570]: parse_mount: parse(sun):
> expanded entry: -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
> Dec 27 15:08:26 ofire automount[32570]: parse_mount: parse(sun):
> gathered options: ro,soft,intr,nfsvers=3
> Dec 27 15:08:26 ofire automount[32570]: parse_mount: parse(sun):
> dequote("192.168.90.12:/home/dennis") -> 192.168.90.12:/home/dennis
> Dec 27 15:08:26 ofire automount[32570]: parse_mount: parse(sun): core
> of entry: options=ro,soft,intr,nfsvers=3,
> loc=192.168.90.12:/home/dennis
> Dec 27 15:08:26 ofire automount[32570]: sun_mount: parse(sun):
> mounting root /mnt/misc, mountpoint mkynfs, what
> 192.168.90.12:/home/dennis, fstype nfs, options ro,soft,intr,nfsvers=3
> Dec 27 15:08:26 ofire automount[32570]: mount_mount: mount(nfs):
> root=/mnt/misc name=mkynfs what=192.168.90.12:/home/dennis,
> fstype=nfs, options=ro,soft,intr,nfsvers=3
> Dec 27 15:08:26 ofire automount[32570]: mount_mount: mount(nfs): nfs
> options="ro,soft,intr,nfsvers=3", nobind=0, nosymlink=0, ro=1
> Dec 27 15:08:26 ofire automount[32570]: get_nfs_info: called with host
> 192.168.90.12(192.168.90.12) proto 6 version 0x20
> Dec 27 15:08:26 ofire automount[32570]: get_nfs_info: called with host
> 192.168.90.12(192.168.90.12) proto 17 version 0x20
> Dec 27 15:08:26 ofire kernel: [20427.317530] automount[32587]:
> segfault at 0 ip           (null) sp 00007fc93f808c88 error 14
> 
> 
> [2] log
> Dec 27 15:16:52 ofire automount[3879]: st_expire: state 1 path /net
> Dec 27 15:16:52 ofire automount[3879]: expire_proc: exp_proc =
> 139809608951552 path /net
> Dec 27 15:16:52 ofire automount[3879]: expire_cleanup: got thid
> 139809608951552 path /net stat 0
> Dec 27 15:16:52 ofire automount[3879]: expire_cleanup: sigchld: exp
> 139809608951552 finished, switching from 2 to 1
> Dec 27 15:16:52 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
> Dec 27 15:16:53 ofire automount[3879]: handle_packet: type = 3
> Dec 27 15:16:53 ofire automount[3879]: handle_packet_missing_indirect:
> token 119, name mkydns, request pid 3898
> Dec 27 15:16:53 ofire automount[3879]: attempting to mount entry
> /mnt/misc/mkydns
> Dec 27 15:16:53 ofire automount[3879]: lookup_mount: lookup(file):
> looking up mkydns
> Dec 27 15:16:53 ofire automount[3879]: lookup_mount: lookup(file):
> mkydns -> -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
> Dec 27 15:16:53 ofire automount[3879]: parse_mount: parse(sun):
> expanded entry: -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
> Dec 27 15:16:53 ofire automount[3879]: parse_mount: parse(sun):
> gathered options: ro,soft,intr,nfsvers=4
> Dec 27 15:16:53 ofire automount[3879]: parse_mount: parse(sun):
> dequote("mickeycn:/home/dennis") -> mickeycn:/home/dennis
> Dec 27 15:16:53 ofire automount[3879]: parse_mount: parse(sun): core
> of entry: options=ro,soft,intr,nfsvers=4, loc=mickeycn:/home/dennis
> Dec 27 15:16:53 ofire automount[3879]: sun_mount: parse(sun): mounting
> root /mnt/misc, mountpoint mkydns, what mickeycn:/home/dennis, fstype
> nfs, options ro,soft,intr,nfsvers=4
> Dec 27 15:16:53 ofire automount[3879]: mount_mount: mount(nfs):
> root=/mnt/misc name=mkydns what=mickeycn:/home/dennis, fstype=nfs,
> options=ro,soft,intr,nfsvers=4
> Dec 27 15:16:53 ofire automount[3879]: mount_mount: mount(nfs): nfs
> options="ro,soft,intr,nfsvers=4", nobind=0, nosymlink=0, ro=1
> Dec 27 15:16:53 ofire automount[3879]: get_nfs_info: called with host
> mickeycn(192.168.90.12) proto 6 version 0x40
> Dec 27 15:16:53 ofire automount[3879]: get_nfs_info: nfs v4 rpc ping
> time: 0.000599
> Dec 27 15:16:53 ofire automount[3879]: get_nfs_info: host mickeycn
> cost 598 weight 0
> Dec 27 15:16:53 ofire automount[3879]: prune_host_list: selected
> subset of hosts that support NFS4 over TCP
> Dec 27 15:16:53 ofire automount[3879]: mount_mount: mount(nfs):
> calling mkdir_path /mnt/misc/mkydns
> Dec 27 15:16:53 ofire automount[3879]: mount_mount: mount(nfs):
> calling mount -t nfs -s -o ro,soft,intr,nfsvers=4
> mickeycn:/home/dennis /mnt/misc/mkydns
> Dec 27 15:16:53 ofire automount[3879]: mount_mount: mount(nfs):
> mounted mickeycn:/home/dennis on /mnt/misc/mkydns
> Dec 27 15:16:53 ofire automount[3879]: dev_ioctl_send_ready: token = 119
> Dec 27 15:16:53 ofire automount[3879]: mounted /mnt/misc/mkydns
> Dec 27 15:17:00 ofire automount[3879]: st_expire: state 1 path /net
> Dec 27 15:17:00 ofire automount[3879]: expire_proc: exp_proc =
> 139809608951552 path /net
> Dec 27 15:17:00 ofire automount[3879]: expire_cleanup: got thid
> 139809608951552 path /net stat 0
> Dec 27 15:17:00 ofire automount[3879]: expire_cleanup: sigchld: exp
> 139809608951552 finished, switching from 2 to 1
> Dec 27 15:17:00 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
> Dec 27 15:17:08 ofire automount[3879]: st_expire: state 1 path /net
> Dec 27 15:17:08 ofire automount[3879]: expire_proc: exp_proc =
> 139809608951552 path /net
> Dec 27 15:17:08 ofire automount[3879]: expire_cleanup: got thid
> 139809608951552 path /net stat 0
> Dec 27 15:17:08 ofire automount[3879]: expire_cleanup: sigchld: exp
> 139809608951552 finished, switching from 2 to 1
> Dec 27 15:17:08 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
> Dec 27 15:17:16 ofire automount[3879]: st_expire: state 1 path /net
> Dec 27 15:17:16 ofire automount[3879]: expire_proc: exp_proc =
> 139809608951552 path /net
> Dec 27 15:17:16 ofire automount[3879]: expire_cleanup: got thid
> 139809608951552 path /net stat 0
> Dec 27 15:17:16 ofire automount[3879]: expire_cleanup: sigchld: exp
> 139809608951552 finished, switching from 2 to 1
> Dec 27 15:17:16 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
> Dec 27 15:17:17 ofire automount[3879]: handle_packet: type = 3
> Dec 27 15:17:17 ofire automount[3879]: handle_packet_missing_indirect:
> token 120, name mkynfs, request pid 3918
> Dec 27 15:17:17 ofire automount[3879]: attempting to mount entry
> /mnt/misc/mkynfs
> Dec 27 15:17:17 ofire automount[3879]: lookup_mount: lookup(file):
> looking up mkynfs
> Dec 27 15:17:17 ofire automount[3879]: lookup_mount: lookup(file):
> mkynfs -> -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
> Dec 27 15:17:17 ofire automount[3879]: parse_mount: parse(sun):
> expanded entry: -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
> Dec 27 15:17:17 ofire automount[3879]: parse_mount: parse(sun):
> gathered options: ro,soft,intr,nfsvers=3
> Dec 27 15:17:17 ofire automount[3879]: parse_mount: parse(sun):
> dequote("192.168.90.12:/home/dennis") -> 192.168.90.12:/home/dennis
> Dec 27 15:17:17 ofire automount[3879]: parse_mount: parse(sun): core
> of entry: options=ro,soft,intr,nfsvers=3,
> loc=192.168.90.12:/home/dennis
> Dec 27 15:17:17 ofire automount[3879]: sun_mount: parse(sun): mounting
> root /mnt/misc, mountpoint mkynfs, what 192.168.90.12:/home/dennis,
> fstype nfs, options ro,soft,intr,nfsvers=3
> Dec 27 15:17:17 ofire automount[3879]: mount_mount: mount(nfs):
> root=/mnt/misc name=mkynfs what=192.168.90.12:/home/dennis,
> fstype=nfs, options=ro,soft,intr,nfsvers=3
> Dec 27 15:17:17 ofire automount[3879]: mount_mount: mount(nfs): nfs
> options="ro,soft,intr,nfsvers=3", nobind=0, nosymlink=0, ro=1
> Dec 27 15:17:17 ofire automount[3879]: get_nfs_info: called with host
> 192.168.90.12(192.168.90.12) proto 6 version 0x20
> Dec 27 15:17:17 ofire automount[3879]: get_nfs_info: called with host
> 192.168.90.12(192.168.90.12) proto 17 version 0x20
> Dec 27 15:17:20 ofire automount[3879]: mount(nfs): no hosts available
> Dec 27 15:17:20 ofire automount[3879]: dev_ioctl_send_fail: token = 120
> Dec 27 15:17:20 ofire automount[3879]: failed to mount /mnt/misc/mkynfs
> Dec 27 15:17:20 ofire automount[3879]: handle_packet: type = 3
> Dec 27 15:17:20 ofire automount[3879]: handle_packet_missing_indirect:
> token 121, name mkynfs, request pid 3918
> Dec 27 15:17:20 ofire automount[3879]: dev_ioctl_send_fail: token = 121
> Dec 27 15:17:24 ofire automount[3879]: st_expire: state 1 path /net
> Dec 27 15:17:24 ofire automount[3879]: expire_proc: exp_proc =
> 139809608951552 path /net
> Dec 27 15:17:24 ofire automount[3879]: expire_cleanup: got thid
> 139809608951552 path /net stat 0
> Dec 27 15:17:24 ofire automount[3879]: expire_cleanup: sigchld: exp
> 139809608951552 finished, switching from 2 to 1
> Dec 27 15:17:24 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
> Dec 27 15:17:32 ofire automount[3879]: st_expire: state 1 path /net
> Dec 27 15:17:32 ofire automount[3879]: expire_proc: exp_proc =
> 139809608951552 path /net
> Dec 27 15:17:32 ofire automount[3879]: expire_cleanup: got thid
> 139809608951552 path /net stat 0
> Dec 27 15:17:32 ofire automount[3879]: expire_cleanup: sigchld: exp
> 139809608951552 finished, switching from 2 to 1
> Dec 27 15:17:32 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net
> Dec 27 15:17:40 ofire automount[3879]: st_expire: state 1 path /net
> Dec 27 15:17:40 ofire automount[3879]: expire_proc: exp_proc =
> 139809608951552 path /net
> Dec 27 15:17:40 ofire automount[3879]: expire_cleanup: got thid
> 139809608951552 path /net stat 0
> Dec 27 15:17:40 ofire automount[3879]: expire_cleanup: sigchld: exp
> 139809608951552 finished, switching from 2 to 1
> Dec 27 15:17:40 ofire automount[3879]: st_ready: st_ready(): state = 2 path /net


