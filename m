From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Sun, 02 Mar 2014 10:17:12 +0800
Message-ID: <1393726632.9725.3.camel@perseus.fritz.box>
References: <1391145206.2486.25.camel@perseus.fritz.box>
	 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
	 <530484B7.6030305@molgen.mpg.de>
	 <1392896501.2508.16.camel@perseus.fritz.box>
	 <1392898704.2508.26.camel@perseus.fritz.box>
	 <530625D0.7020808@molgen.mpg.de>
	 <1392946952.2495.3.camel@perseus.fritz.box>
	 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>
	 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
	 <5310F30D.9040407@molgen.mpg.de> <53125771.4030000@molgen.mpg.de>
	 <531280C5.1050906@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=y0Hlv8a3Peu+SGOW8tYR0EJvygE=; b=oR45FnQEOgYBT6W5myKmdMFTg6YP
	BZJTnWbyInwa0lSfk/L8qag2HtFoEDDkoD1QrYcz6Bqpcc+s8O/Hh15k/ekdP7rX
	Hk2odS4vhwXybqcGW4lawyFR1yLwpPZ99DHTOz5vFihc1N5QC1ZHDdMZvLxe8zC9
	OQlIi+L951qitpE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=y0Hlv8a3Peu+SGOW8tYR0E
	JvygE=; b=fwkra8wDVLoi7wpQ3Su3cF3L4xNph2sF0DocqB1BY+2kPwPfjUAJAH
	4oSVvpXMhiSMkvl4wnVxPgxmZKKsmJdPUTL0V28/wxC+9Y6BLrRCzySqj3mMbFC2
	3U/pRvWPP9Rg5fawFy3b/dAnf7Hl3A3QlVaZ16Shczo/TQiVaHjTE=
In-Reply-To: <531280C5.1050906@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: Alexander Viro <aviro@redhat.com>, autofs <autofs@vger.kernel.org>

On Sun, 2014-03-02 at 01:52 +0100, Donald Buczek wrote:
> Okay, same bug hit again.
> 
> New info this time: There _is_ a "struct mount" for the failing dentry , 
> but neither "cat /proc/mounts" nor "mount" or the crash utility  show it.
> 
> Demo follows:
> 
> The Problem:
> 
> 
> > root:kasslerbraten:/home/buczek/autofs/# uname -a
> > Linux kasslerbraten.molgen.mpg.de 3.13.1.mx64.1 #1 SMP Fri Feb 21 
> > 15:54:38 CET 2014 x86_64 GNU/Linux
> > root:kasslerbraten:/home/buczek/autofs/# ls /project/mariux32/
> > ls: cannot access /project/mariux32/: Too many levels of symbolic links
> 
> Logfile:
> 
> > root:kasslerbraten:/home/buczek/autofs/# fgrep mariux32 
> > /var/log/messages|tail
> > 2014-03-02T01:33:02.051118+01:00 kasslerbraten kernel: [146256.094196] 
> > pid 23244: autofs4_d_automount: dentry=ffff88007c86da10 mariux32
> > 2014-03-02T01:33:02.051119+01:00 kasslerbraten kernel: [146256.094197] 
> > pid 23244: autofs4_d_automount: dentry=ffff88007c86da10 mariux32
> > 2014-03-02T01:33:02.051132+01:00 kasslerbraten kernel: [146256.094199] 
> > pid 23244: autofs4_d_automount: dentry=ffff88007c86da10 mariux32
> > 2014-03-02T01:33:02.051133+01:00 kasslerbraten kernel: [146256.094200] 
> > pid 23244: autofs4_d_automount: dentry=ffff88007c86da10 mariux32
> > 2014-03-02T01:33:02.051134+01:00 kasslerbraten kernel: [146256.094201] 
> > pid 23244: autofs4_d_automount: dentry=ffff88007c86da10 mariux32
> > 2014-03-02T01:33:02.051135+01:00 kasslerbraten kernel: [146256.094202] 
> > pid 23244: autofs4_d_automount: dentry=ffff88007c86da10 mariux32
> > 2014-03-02T01:33:02.051136+01:00 kasslerbraten kernel: [146256.094203] 
> > pid 23244: autofs4_d_automount: dentry=ffff88007c86da10 mariux32
> > 2014-03-02T01:33:02.051137+01:00 kasslerbraten kernel: [146256.094204] 
> > pid 23244: autofs4_d_automount: dentry=ffff88007c86da10 mariux32
> > 2014-03-02T01:33:02.051138+01:00 kasslerbraten kernel: [146256.094205] 
> > pid 23244: autofs4_d_automount: dentry=ffff88007c86da10 mariux32
> > 2014-03-02T01:33:02.051139+01:00 kasslerbraten kernel: [146256.094206] 
> > pid 23244: autofs4_d_automount: dentry=ffff88007c86da10 mariux32
> 
> Mount on  /project/mariux32  not visible in /proc/mounts:
> 
> > root:kasslerbraten:/home/buczek/autofs/# cat /proc/mounts
> > rootfs / rootfs rw 0 0
> > /dev/root / reiserfs rw,relatime 0 0
> > devtmpfs /dev devtmpfs 
> > rw,relatime,size=2001060k,nr_inodes=500265,mode=755 0 0
> > proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
> > sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
> > tmpfs /dev/shm tmpfs rw,nosuid,nodev,relatime 0 0
> > devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=5,mode=620 0 0
> > tmpfs /run tmpfs rw,nosuid,nodev,noexec,relatime,mode=755 0 0
> > tmpfs /sys/fs/cgroup tmpfs rw,nosuid,nodev,noexec,relatime,mode=755 0 0
> > cgroup /sys/fs/cgroup/systemd cgroup 
> > rw,nosuid,nodev,noexec,relatime,release_agent=/lib/systemd/systemd-cgroups-agent,name=systemd 
> > 0 0
> > cgroup /sys/fs/cgroup/cpuset cgroup 
> > rw,nosuid,nodev,noexec,relatime,cpuset 0 0
> > cgroup /sys/fs/cgroup/debug cgroup 
> > rw,nosuid,nodev,noexec,relatime,debug 0 0
> > cgroup /sys/fs/cgroup/cpu cgroup rw,nosuid,nodev,noexec,relatime,cpu 0 0
> > cgroup /sys/fs/cgroup/cpuacct cgroup 
> > rw,nosuid,nodev,noexec,relatime,cpuacct 0 0
> > cgroup /sys/fs/cgroup/devices cgroup 
> > rw,nosuid,nodev,noexec,relatime,devices 0 0
> > cgroup /sys/fs/cgroup/freezer cgroup 
> > rw,nosuid,nodev,noexec,relatime,freezer 0 0
> > cgroup /sys/fs/cgroup/blkio cgroup 
> > rw,nosuid,nodev,noexec,relatime,blkio 0 0
> > systemd-1 /dev/hugepages autofs 
> > rw,relatime,fd=26,pgrp=1,timeout=300,minproto=5,maxproto=5,direct 0 0
> > systemd-1 /proc/sys/fs/binfmt_misc autofs 
> > rw,relatime,fd=27,pgrp=1,timeout=300,minproto=5,maxproto=5,direct 0 0
> > systemd-1 /sys/kernel/debug autofs 
> > rw,relatime,fd=28,pgrp=1,timeout=300,minproto=5,maxproto=5,direct 0 0
> > systemd-1 /dev/mqueue autofs 
> > rw,relatime,fd=29,pgrp=1,timeout=300,minproto=5,maxproto=5,direct 0 0
> > systemd-1 /sys/kernel/security autofs 
> > rw,relatime,fd=30,pgrp=1,timeout=300,minproto=5,maxproto=5,direct 0 0
> > tmpfs /var/run tmpfs rw,nosuid,nodev,noexec,relatime,mode=755 0 0
> > rpc_pipefs /var/lib/nfs/rpc_pipefs rpc_pipefs rw,relatime 0 0
> > tmpfs /media tmpfs rw,nosuid,nodev,noexec,relatime,mode=755 0 0
> > nfsd /proc/fs/nfsd nfsd rw,relatime 0 0
> > fusectl /sys/fs/fuse/connections fusectl rw,relatime 0 0
> > /dev/sda2 /amd/kasslerbraten/0 reiserfs rw,relatime 0 0
> > /etc/automount/auto.home /home autofs 
> > rw,relatime,fd=7,pgrp=542,timeout=300,minproto=5,maxproto=5,indirect 0 0
> > /etc/automount/auto.jbod /jbod autofs 
> > rw,relatime,fd=13,pgrp=542,timeout=300,minproto=5,maxproto=5,indirect 0 0
> > /etc/automount/auto.confidential /confidential autofs 
> > rw,relatime,fd=19,pgrp=542,timeout=300,minproto=5,maxproto=5,indirect 0 0
> > /etc/automount/auto.project /project autofs 
> > rw,relatime,fd=25,pgrp=542,timeout=300,minproto=5,maxproto=5,indirect 0 0
> > /etc/automount/auto.package /package autofs 
> > rw,relatime,fd=31,pgrp=542,timeout=300,minproto=5,maxproto=5,indirect 0 0
> > /etc/automount/auto.scratch /scratch autofs 
> > rw,relatime,fd=37,pgrp=542,timeout=300,minproto=5,maxproto=5,indirect 0 0
> > /etc/automount/auto.src /src autofs 
> > rw,relatime,fd=43,pgrp=542,timeout=300,minproto=5,maxproto=5,indirect 0 0
> > pummelfee:/amd/pummelfee/X/X3009/home/abt_srv/klages /home/klages nfs4 
> > rw,nosuid,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=141.14.19.40,local_lock=none,addr=141.14.16.18 
> > 0 0
> > palle:/amd/palle/1/home/abt_srv/buczek /home/buczek nfs 
> > rw,nosuid,relatime,vers=3,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=141.14.28.251,mountvers=3,mountport=58602,mountproto=udp,local_lock=none,addr=141.14.28.251 
> > 0 0
> > binfmt_misc /proc/sys/fs/binfmt_misc binfmt_misc rw,relatime 0 0
> > erdnuckel:/amd/erdnuckel/X/X0008/package/sequencer /package/sequencer 
> > nfs 
> > rw,nosuid,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=141.14.28.246,mountvers=3,mountport=53128,mountproto=udp,local_lock=none,addr=141.14.28.246 
> > 0 0
> > root:kasslerbraten:/home/buczek/autofs/#
> 
> But visible to my little perl program ( 
> http://owww.molgen.mpg.de/~buczek/autofs-demo/peekmounts ) which walks 
> the mountpoint hashtable and the mount_hashtable ) :
> 
> > root:kasslerbraten:/home/buczek/autofs/# ./peekmounts
> >  mountpoint 0xffff8801280ffc20 : count=   2 denty=0xffff8800c8996890 (src)
> >  mountpoint 0xffff8801285b6c20 : count=   2 denty=0xffff8800ca457c90 
> > (systemd)
> >  mountpoint 0xffff8801285b6a60 : count=   2 denty=0xffff8800ca457d50 
> > (cpuset)
> >  mountpoint 0xffff8801285e9d00 : count=   2 denty=0xffff8800ca4cf710 
> > (hugepages)
> >  mountpoint 0xffff8801285b6c60 : count=   2 denty=0xffff8800ca457ed0 
> > (cgroup)
> >  mountpoint 0xffff8801285e9da0 : count=   2 denty=0xffff8800ca4a3c50 
> > (blkio)
> >  mountpoint 0xffff8800a39282a0 : count=   1 denty=0xffff880094483e90 
> > (buczek)
> >  mountpoint 0xffff8801280ffc80 : count=   2 denty=0xffff8800c8996dd0 
> > (scratch)
> >  mountpoint 0xffff8800c8ed8480 : count=   2 denty=0xffff8800c88284d0 
> > (connections)
> >  mountpoint 0xffff8801285e99e0 : count=   2 denty=0xffff8800bd874110 
> > (klages)
> >  mountpoint 0xffff8801285e9c80 : count=   2 denty=0xffff8800ca4cfdd0 
> > (binfmt_misc)
> >  mountpoint 0xffff8801285e9e40 : count=   2 denty=0xffff8800ca4a0510 
> > (freezer)
> >  mountpoint 0xffff8800aa2d6880 : count=   1 denty=0xffff8800ca4cc390 (/)
> >  mountpoint 0xffff8801285e9c20 : count=   2 denty=0xffff8800ca4cc5d0 
> > (debug)
> >  mountpoint 0xffff8801285e9f60 : count=   2 denty=0xffff8800ca49c950 
> > (cpuacct)
> >  mountpoint 0xffff8800c1d06920 : count=   2 denty=0xffff880129187dd0 
> > (confidential)
> >  mountpoint 0xffff8800ca1736c0 : count=   2 denty=0xffff8800ca4c4a50 
> > (rpc_pipefs)
> >  mountpoint 0xffff8800c1d068a0 : count=   2 denty=0xffff8800c8b2e450 
> > (project)
> >  mountpoint 0xffff8801285e9ec0 : count=   2 denty=0xffff8800ca4a0ed0 
> > (devices)
> >  mountpoint 0xffff8801285e9ac0 : count=   2 denty=0xffff8800ca4c8dd0 
> > (security)
> >  mountpoint 0xffff8801285e9fe0 : count=   2 denty=0xffff8800ca4992d0 (cpu)
> >  mountpoint 0xffff8800a3efeba0 : count=   1 denty=0xffff8800c890ce10 (tmp)
> >  mountpoint 0xffff880125e44480 : count=   1 denty=0xffff88007c86da10 
> > (mariux32)
> >  mountpoint 0xffff8800c1d06940 : count=   2 denty=0xffff8800c89b0690 
> > (home)
> >  mountpoint 0xffff8800c2841820 : count=   2 denty=0xffff8800c8adf450 (0)
> >  mountpoint 0xffff8800c2841400 : count=   2 denty=0xffff8800c89dc8d0 
> > (jbod)
> >  mountpoint 0xffff8801285b6ce0 : count=   2 denty=0xffff8800ca4521d0 (run)
> >  mountpoint 0xffff8801285b6d40 : count=   2 denty=0xffff8800ca452290 (pts)
> >  mountpoint 0xffff8801285b69e0 : count=   2 denty=0xffff8800ca499ed0 
> > (debug)
> >  mountpoint 0xffff8801285b6d80 : count=   2 denty=0xffff8800ca4524d0 (shm)
> >  mountpoint 0xffff880128fef2e0 : count=   3 denty=0xffff880129002ad0 (/)
> >  mountpoint 0xffff8801285b6e00 : count=   2 denty=0xffff8800ca452710 (sys)
> >  mountpoint 0xffff880125d17800 : count=   1 denty=0xffff8800944ae1d0 
> > (roche454)
> >  mountpoint 0xffff8801280ffce0 : count=   2 denty=0xffff8800c8979590 
> > (package)
> >  mountpoint 0xffff8801285b6e80 : count=   2 denty=0xffff8800ca452a10 
> > (proc)
> >  mountpoint 0xffff8801285e9600 : count=   2 denty=0xffff8800ca4e21d0 
> > (media)
> >  mountpoint 0xffff8801285e9740 : count=   2 denty=0xffff88012900f050 (dev)
> >  mountpoint 0xffff8800ca173fc0 : count=   2 denty=0xffff880129047450 
> > (nfsd)
> >  mountpoint 0xffff8800b9493d00 : count=   1 denty=0xffff8800b59ade10 
> > (local)
> >  mountpoint 0xffff8800ca1439c0 : count=   2 denty=0xffff8800ca4e2d10 (run)
> >  mountpoint 0xffff8800aa146b60 : count=   1 denty=0xffff880038b8c450 (web)
> >  mountpoint 0xffff8801285e9b40 : count=   2 denty=0xffff8801290478d0 
> > (mqueue)
> >  struct mount 0xffff880128fd2e00 : mountpoint dentry 
> > 0xffff880129002ad0 (/) mountpoint struct 0xffff880128fef2e0
> >  struct mount 0xffff8800c9e5e0c0 : mountpoint dentry 
> > 0xffff880129187dd0 (confidential) mountpoint struct 0xffff8800c1d06920
> >  struct mount 0xffff880128fd2cc0 : mountpoint dentry 
> > 0xffff8800ca4c4a50 (rpc_pipefs) mountpoint struct 0xffff8800ca1736c0
> >  struct mount 0xffff8800c9e5e200 : mountpoint dentry 
> > 0xffff8800c8b2e450 (project) mountpoint struct 0xffff8800c1d068a0
> >  struct mount 0xffff8800c9dda300 : mountpoint dentry 
> > 0xffff8800ca4cf710 (hugepages) mountpoint struct 0xffff8801285e9d00
> >  struct mount 0xffff8800aa103840 : mountpoint dentry 
> > 0xffff880129047450 (nfsd) mountpoint struct 0xffff8800ca173fc0
> >  struct mount 0xffff8800a3a9a300 : mountpoint dentry 
> > 0xffff8800b59ade10 (local) mountpoint struct 0xffff8800b9493d00
> >  struct mount 0xffff8800aa103480 : mountpoint dentry 
> > 0xffff8800ca457c90 (systemd) mountpoint struct 0xffff8801285b6c20
> >  struct mount 0xffff8800aa103340 : mountpoint dentry 
> > 0xffff8800ca457d50 (cpuset) mountpoint struct 0xffff8801285b6a60
> >  struct mount 0xffff8800aa13ebc0 : mountpoint dentry 
> > 0xffff880038b8c450 (web) mountpoint struct 0xffff8800aa146b60
> >  struct mount 0xffff8800aa1035c0 : mountpoint dentry 
> > 0xffff8800ca457ed0 (cgroup) mountpoint struct 0xffff8801285b6c60
> >  struct mount 0xffff8800b5e40a40 : mountpoint dentry 
> > 0xffff8800ca4a3c50 (blkio) mountpoint struct 0xffff8801285e9da0
> >  struct mount 0xffff8800c9e5e840 : mountpoint dentry 
> > 0xffff8800c89b0690 (home) mountpoint struct 0xffff8800c1d06940
> >  struct mount 0xffff8800a3a9aa80 : mountpoint dentry 
> > 0xffff880129187dd0 (confidential) mountpoint struct 0xffff8800c1d06920
> >  struct mount 0xffff8800cac2b840 : mountpoint dentry 
> > 0xffff8800c8adf450 (0) mountpoint struct 0xffff8800c2841820
> >  struct mount 0xffff8800b5e402c0 : mountpoint dentry 
> > 0xffff8800ca4c4a50 (rpc_pipefs) mountpoint struct 0xffff8800ca1736c0
> >  struct mount 0xffff8800c9ddad00 : mountpoint dentry 
> > 0xffff8800ca457c90 (systemd) mountpoint struct 0xffff8801285b6c20
> >  struct mount 0xffff8800a3a9a940 : mountpoint dentry 
> > 0xffff8800c8b2e450 (project) mountpoint struct 0xffff8800c1d068a0
> >  struct mount 0xffff8800b5e40680 : mountpoint dentry 
> > 0xffff8800c88284d0 (connections) mountpoint struct 0xffff8800c8ed8480
> >  struct mount 0xffff8800c9ddabc0 : mountpoint dentry 
> > 0xffff8800ca457d50 (cpuset) mountpoint struct 0xffff8801285b6a60
> >  struct mount 0xffff8800c1d97b80 : mountpoint dentry 
> > 0xffff8800ca4cc390 (/) mountpoint struct 0xffff8800aa2d6880
> >  struct mount 0xffff880128fd2a40 : mountpoint dentry 
> > 0xffff8800c89dc8d0 (jbod) mountpoint struct 0xffff8800c2841400
> >  struct mount 0xffff880128fee580 : mountpoint dentry 
> > 0xffff8800ca4521d0 (run) mountpoint struct 0xffff8801285b6ce0
> >  struct mount 0xffff8800c9dda440 : mountpoint dentry 
> > 0xffff8800ca4a3c50 (blkio) mountpoint struct 0xffff8801285e9da0
> >  struct mount 0xffff8800b5e40b80 : mountpoint dentry 
> > 0xffff8800ca4a0510 (freezer) mountpoint struct 0xffff8801285e9e40
> >  struct mount 0xffff8800c9e5e340 : mountpoint dentry 
> > 0xffff880094483e90 (buczek) mountpoint struct 0xffff8800a39282a0
> >  struct mount 0xffff8800aa103980 : mountpoint dentry 
> > 0xffff8800ca4cfdd0 (binfmt_misc) mountpoint struct 0xffff8801285e9c80
> >  struct mount 0xffff8800a3a9a080 : mountpoint dentry 
> > 0xffff8800c890ce10 (tmp) mountpoint struct 0xffff8800a3efeba0
> >  struct mount 0xffff8800c1d97180 : mountpoint dentry 
> > 0xffff8800bd874110 (klages) mountpoint struct 0xffff8801285e99e0
> >  struct mount 0xffff880128fee1c0 : mountpoint dentry 
> > 0xffff8800ca452710 (sys) mountpoint struct 0xffff8801285b6e00
> >  struct mount 0xffff880128feed00 : mountpoint dentry 
> > 0xffff880129002ad0 (/) mountpoint struct 0xffff880128fef2e0
> >  struct mount 0xffff8800c9e5ec00 : mountpoint dentry 
> > 0xffff880129047450 (nfsd) mountpoint struct 0xffff8800ca173fc0
> >  struct mount 0xffff8800c9e5eac0 : mountpoint dentry 
> > 0xffff8800c8979590 (package) mountpoint struct 0xffff8801280ffce0
> >  struct mount 0xffff8800a3a9ae40 : mountpoint dentry 
> > 0xffff8800c89b0690 (home) mountpoint struct 0xffff8800c1d06940
> >  struct mount 0xffff8800b5e40e00 : mountpoint dentry 
> > 0xffff8800ca49c950 (cpuacct) mountpoint struct 0xffff8801285e9f60
> >  struct mount 0xffff8800b5e40040 : mountpoint dentry 
> > 0xffff8800c8adf450 (0) mountpoint struct 0xffff8800c2841820
> >  struct mount 0xffff8800b5e40900 : mountpoint dentry 
> > 0xffff8800ca4cc5d0 (debug) mountpoint struct 0xffff8801285e9c20
> >  struct mount 0xffff880128fee080 : mountpoint dentry 
> > 0xffff8800ca452a10 (proc) mountpoint struct 0xffff8801285b6e80
> >  struct mount 0xffff8800c9dda580 : mountpoint dentry 
> > 0xffff8800ca4a0510 (freezer) mountpoint struct 0xffff8801285e9e40
> >  struct mount 0xffff8800cac2bac0 : mountpoint dentry 
> > 0xffff8800ca4e21d0 (media) mountpoint struct 0xffff8801285e9600
> >  struct mount 0xffff8800cac2bc00 : mountpoint dentry 
> > 0xffff88012900f050 (dev) mountpoint struct 0xffff8801285e9740
> >  struct mount 0xffff8800aa103e80 : mountpoint dentry 
> > 0xffff8800ca452290 (pts) mountpoint struct 0xffff8801285b6d40
> >  struct mount 0xffff8800a3a9abc0 : mountpoint dentry 
> > 0xffff8800c89dc8d0 (jbod) mountpoint struct 0xffff8800c2841400
> >  struct mount 0xffff8800b5e40540 : mountpoint dentry 
> > 0xffff8800ca4521d0 (run) mountpoint struct 0xffff8801285b6ce0
> >  struct mount 0xffff8800c9dda800 : mountpoint dentry 
> > 0xffff8800ca49c950 (cpuacct) mountpoint struct 0xffff8801285e9f60
> >  struct mount 0xffff8800b5e40cc0 : mountpoint dentry 
> > 0xffff8800ca4a0ed0 (devices) mountpoint struct 0xffff8801285e9ec0
> >  struct mount 0xffff8800aa13e080 : mountpoint dentry 
> > 0xffff8800ca4524d0 (shm) mountpoint struct 0xffff8801285b6d80
> >  struct mount 0xffff8800a3a9ad00 : mountpoint dentry 
> > 0xffff8800bd874110 (klages) mountpoint struct 0xffff8801285e99e0
> >  struct mount 0xffff8800b5e407c0 : mountpoint dentry 
> > 0xffff8800ca4c8dd0 (security) mountpoint struct 0xffff8801285e9ac0
> >  struct mount 0xffff8800aa1030c0 : mountpoint dentry 
> > 0xffff8800ca4992d0 (cpu) mountpoint struct 0xffff8801285e9fe0
> >  struct mount 0xffff8800aa103700 : mountpoint dentry 
> > 0xffff8800ca452710 (sys) mountpoint struct 0xffff8801285b6e00
> >  struct mount 0xffff8800a3a9a580 : mountpoint dentry 
> > 0xffff8800c8979590 (package) mountpoint struct 0xffff8801280ffce0
> >  struct mount 0xffff8800c9dda6c0 : mountpoint dentry 
> > 0xffff8800ca4a0ed0 (devices) mountpoint struct 0xffff8801285e9ec0
> >  struct mount 0xffff8800c9ddae40 : mountpoint dentry 
> > 0xffff8800ca457ed0 (cgroup) mountpoint struct 0xffff8801285b6c60
> >  struct mount 0xffff8800aa103ac0 : mountpoint dentry 
> > 0xffff8800ca452a10 (proc) mountpoint struct 0xffff8801285b6e80
> >  struct mount 0xffff880128fee440 : mountpoint dentry 
> > 0xffff8800ca452290 (pts) mountpoint struct 0xffff8801285b6d40
> >  struct mount 0xffff880128feebc0 : mountpoint dentry 
> > 0xffff8800ca4e2d10 (run) mountpoint struct 0xffff8800ca1439c0
> >  struct mount 0xffff8800b5e40180 : mountpoint dentry 
> > 0xffff8800ca4e21d0 (media) mountpoint struct 0xffff8801285e9600
> >  struct mount 0xffff8800cac2b980 : mountpoint dentry 
> > 0xffff8800c88284d0 (connections) mountpoint struct 0xffff8800c8ed8480
> >  struct mount 0xffff8800aa13e1c0 : mountpoint dentry 
> > 0xffff88012900f050 (dev) mountpoint struct 0xffff8801285e9740
> >  struct mount 0xffff8800c9dda940 : mountpoint dentry 
> > 0xffff8800ca4992d0 (cpu) mountpoint struct 0xffff8801285e9fe0
> >  struct mount 0xffff880128fee300 : mountpoint dentry 
> > 0xffff8800ca4524d0 (shm) mountpoint struct 0xffff8801285b6d80
> >  struct mount 0xffff8800c9dda1c0 : mountpoint dentry 
> > 0xffff8800ca4cfdd0 (binfmt_misc) mountpoint struct 0xffff8801285e9c80
> >  struct mount 0xffff8800c1d97e00 : mountpoint dentry 
> > 0xffff8800c8996890 (src) mountpoint struct 0xffff8801280ffc20
> >  struct mount 0xffff8800aa103200 : mountpoint dentry 
> > 0xffff8800ca499ed0 (debug) mountpoint struct 0xffff8801285b69e0
> >  struct mount 0xffff8800b5e40400 : mountpoint dentry 
> > 0xffff8800ca4e2d10 (run) mountpoint struct 0xffff8800ca1439c0
> >  struct mount 0xffff8800c9e5e980 : mountpoint dentry 
> > 0xffff8800c8996dd0 (scratch) mountpoint struct 0xffff8801280ffc80
> >  struct mount 0xffff8800aa103c00 : mountpoint dentry 
> > 0xffff8801290478d0 (mqueue) mountpoint struct 0xffff8801285e9b40
> >  struct mount 0xffff8800c9dda080 : mountpoint dentry 
> > 0xffff8800ca4cc5d0 (debug) mountpoint struct 0xffff8801285e9c20
> >  struct mount 0xffff8800a3a9a6c0 : mountpoint dentry 
> > 0xffff88007c86da10 (mariux32) mountpoint struct 0xffff880125e44480
> >  struct mount 0xffff8800c9ddaa80 : mountpoint dentry 
> > 0xffff8800ca499ed0 (debug) mountpoint struct 0xffff8801285b69e0
> >  struct mount 0xffff8800aa13e300 : mountpoint dentry 
> > 0xffff880129002ad0 (/) mountpoint struct 0xffff880128fef2e0
> >  struct mount 0xffff8800a3a9a1c0 : mountpoint dentry 
> > 0xffff8800c8996890 (src) mountpoint struct 0xffff8801280ffc20
> >  struct mount 0xffff8800aa103d40 : mountpoint dentry 
> > 0xffff8800ca4cf710 (hugepages) mountpoint struct 0xffff8801285e9d00
> >  struct mount 0xffff8800c9e5ed40 : mountpoint dentry 
> > 0xffff8800ca4c8dd0 (security) mountpoint struct 0xffff8801285e9ac0
> >  struct mount 0xffff8800c9e5ee80 : mountpoint dentry 
> > 0xffff8801290478d0 (mqueue) mountpoint struct 0xffff8801285e9b40
> >  struct mount 0xffff8800a3a9a440 : mountpoint dentry 
> > 0xffff8800c8996dd0 (scratch) mountpoint struct 0xffff8801280ffc80
> >  struct mount 0xffff8800a3a9a800 : mountpoint dentry 
> > 0xffff8800944ae1d0 (roche454) mountpoint struct 0xffff880125d17800
> 
> This is the struct mount of "mariux32" :
> 
> > (gdb) print *(struct mount *)0xffff8800a3a9a6c0
> > $2 = {mnt_hash = {next = 0xffff880128e87cf0, prev = 
> > 0xffff880128e87cf0}, mnt_parent = 0xffff8800a3a9a940, mnt_mountpoint = 
> > 0xffff88007c86da10, mnt = {mnt_root = 0xffff88007c8ed590,
> >     mnt_sb = 0xffff880125fef800, mnt_flags = 33}, mnt_rcu = {next = 
> > 0x0, func = 0}, mnt_pcp = 0x60fed2000ab4, mnt_mounts = {next = 
> > 0xffff8800a3a9a710, prev = 0xffff8800a3a9a710},
> >   mnt_child = {next = 0xffff8800a3a9a990, prev = 0xffff8800a3a9a860}, 
> > mnt_instance = {next = 0xffff880125fef8b0, prev = 0xffff880125fef8b0},
> >   mnt_devname = 0xffff880120c69c80 
> > "pille:/amd/pille/1/project/mariux32", mnt_list = {next = 
> > 0xffff8800a3a9a608, prev = 0xffff8800a3a9a888}, mnt_expire = {next = 
> > 0xffff8800a3a9a758,
> >     prev = 0xffff8800a3a9a758}, mnt_share = {next = 
> > 0xffff8800a3a9a768, prev = 0xffff8800a3a9a768}, mnt_slave_list = {next 
> > = 0xffff8800a3a9a778, prev = 0xffff8800a3a9a778},
> >   mnt_slave = {next = 0xffff8800a3a9a788, prev = 0xffff8800a3a9a788}, 
> > mnt_master = 0x0, mnt_ns = 0xffff8801271f9300, mnt_mp = 
> > 0xffff880125e44480, mnt_fsnotify_marks = {first = 0x0},
> >   mnt_fsnotify_mask = 0, mnt_id = 126, mnt_group_id = 0, 
> > mnt_expiry_mark = 0, mnt_pinned = 0, mnt_ex_mountpoint = {mnt = 0x0, 
> > dentry = 0x0}}
> >
> 
> This is the struct mount of the parent ( "/project") :
> 
> > (gdb) print *((struct mount *)0xffff8800a3a9a6c0)->mnt_parent
> > $3 = {mnt_hash = {next = 0xffff880128e87380, prev = 
> > 0xffff880128e87380}, mnt_parent = 0xffff8800aa13e300, mnt_mountpoint = 

mnt_hash->next == mnt_hash->prev, mount has been unlinked from the mount
tree so is not "visible". As far as we are concerned this mount has
gone.

> > 0xffff8800c8b2e450, mnt = {mnt_root = 0xffff8800c8b2e810,
> >     mnt_sb = 0xffff8800c8f44000, mnt_flags = 32}, mnt_rcu = {next = 
> > 0x0, func = 0}, mnt_pcp = 0x60fed2000aa4, mnt_mounts = {next = 
> > 0xffff8800a3a9a860, prev = 0xffff8800a3a9a720},
> >   mnt_child = {next = 0xffff8800a3a9a5e0, prev = 0xffff8800a3a9aae0}, 
> > mnt_instance = {next = 0xffff8800c8f440b0, prev = 0xffff8800c9e5e270},
> >   mnt_devname = 0xffff8800a3efe1e0 "/etc/automount/auto.project", 
> > mnt_list = {next = 0xffff8800a3a9a888, prev = 0xffff8800a3a9ab08}, 
> > mnt_expire = {next = 0xffff8800a3a9a9d8,
> >     prev = 0xffff8800a3a9a9d8}, mnt_share = {next = 
> > 0xffff8800a3a9a9e8, prev = 0xffff8800a3a9a9e8}, mnt_slave_list = {next 
> > = 0xffff8800a3a9a9f8, prev = 0xffff8800a3a9a9f8},
> >   mnt_slave = {next = 0xffff8800a3a9aa08, prev = 0xffff8800a3a9aa08}, 
> > mnt_master = 0x0, mnt_ns = 0xffff8801271f9300, mnt_mp = 
> > 0xffff8800c1d068a0, mnt_fsnotify_marks = {first = 0x0},
> >   mnt_fsnotify_mask = 0, mnt_id = 124, mnt_group_id = 0, 
> > mnt_expiry_mark = 0, mnt_pinned = 0, mnt_ex_mountpoint = {mnt = 0x0, 
> > dentry = 0x0}}
> 
> 
> Regards
>    Donald
> 


