From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: "Too many levels of symbolic links"
Date: Sun, 02 Mar 2014 01:52:21 +0100
Message-ID: <531280C5.1050906@molgen.mpg.de>
References: <1391145206.2486.25.camel@perseus.fritz.box> <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de> <530484B7.6030305@molgen.mpg.de> <1392896501.2508.16.camel@perseus.fritz.box> <1392898704.2508.26.camel@perseus.fritz.box> <530625D0.7020808@molgen.mpg.de> <1392946952.2495.3.camel@perseus.fritz.box> <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de> <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com> <5310F30D.9040407@molgen.mpg.de> <53125771.4030000@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms000603010209060406060808"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <53125771.4030000@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Alexander Viro <aviro@redhat.com>
Cc: Ian Kent <raven@themaw.net>, autofs <autofs@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms000603010209060406060808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Okay, same bug hit again.

New info this time: There _is_ a "struct mount" for the failing dentry , =

but neither "cat /proc/mounts" nor "mount" or the crash utility  show it.=


Demo follows:

The Problem:


> root:kasslerbraten:/home/buczek/autofs/# uname -a
> Linux kasslerbraten.molgen.mpg.de 3.13.1.mx64.1 #1 SMP Fri Feb 21=20
> 15:54:38 CET 2014 x86_64 GNU/Linux
> root:kasslerbraten:/home/buczek/autofs/# ls /project/mariux32/
> ls: cannot access /project/mariux32/: Too many levels of symbolic links=


Logfile:

> root:kasslerbraten:/home/buczek/autofs/# fgrep mariux32=20
> /var/log/messages|tail
> 2014-03-02T01:33:02.051118+01:00 kasslerbraten kernel: [146256.094196] =

> pid 23244: autofs4_d_automount: dentry=3Dffff88007c86da10 mariux32
> 2014-03-02T01:33:02.051119+01:00 kasslerbraten kernel: [146256.094197] =

> pid 23244: autofs4_d_automount: dentry=3Dffff88007c86da10 mariux32
> 2014-03-02T01:33:02.051132+01:00 kasslerbraten kernel: [146256.094199] =

> pid 23244: autofs4_d_automount: dentry=3Dffff88007c86da10 mariux32
> 2014-03-02T01:33:02.051133+01:00 kasslerbraten kernel: [146256.094200] =

> pid 23244: autofs4_d_automount: dentry=3Dffff88007c86da10 mariux32
> 2014-03-02T01:33:02.051134+01:00 kasslerbraten kernel: [146256.094201] =

> pid 23244: autofs4_d_automount: dentry=3Dffff88007c86da10 mariux32
> 2014-03-02T01:33:02.051135+01:00 kasslerbraten kernel: [146256.094202] =

> pid 23244: autofs4_d_automount: dentry=3Dffff88007c86da10 mariux32
> 2014-03-02T01:33:02.051136+01:00 kasslerbraten kernel: [146256.094203] =

> pid 23244: autofs4_d_automount: dentry=3Dffff88007c86da10 mariux32
> 2014-03-02T01:33:02.051137+01:00 kasslerbraten kernel: [146256.094204] =

> pid 23244: autofs4_d_automount: dentry=3Dffff88007c86da10 mariux32
> 2014-03-02T01:33:02.051138+01:00 kasslerbraten kernel: [146256.094205] =

> pid 23244: autofs4_d_automount: dentry=3Dffff88007c86da10 mariux32
> 2014-03-02T01:33:02.051139+01:00 kasslerbraten kernel: [146256.094206] =

> pid 23244: autofs4_d_automount: dentry=3Dffff88007c86da10 mariux32

Mount on  /project/mariux32  not visible in /proc/mounts:

> root:kasslerbraten:/home/buczek/autofs/# cat /proc/mounts
> rootfs / rootfs rw 0 0
> /dev/root / reiserfs rw,relatime 0 0
> devtmpfs /dev devtmpfs=20
> rw,relatime,size=3D2001060k,nr_inodes=3D500265,mode=3D755 0 0
> proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
> sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
> tmpfs /dev/shm tmpfs rw,nosuid,nodev,relatime 0 0
> devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=3D5,mode=3D620 0 0=

> tmpfs /run tmpfs rw,nosuid,nodev,noexec,relatime,mode=3D755 0 0
> tmpfs /sys/fs/cgroup tmpfs rw,nosuid,nodev,noexec,relatime,mode=3D755 0=
 0
> cgroup /sys/fs/cgroup/systemd cgroup=20
> rw,nosuid,nodev,noexec,relatime,release_agent=3D/lib/systemd/systemd-cg=
roups-agent,name=3Dsystemd=20
> 0 0
> cgroup /sys/fs/cgroup/cpuset cgroup=20
> rw,nosuid,nodev,noexec,relatime,cpuset 0 0
> cgroup /sys/fs/cgroup/debug cgroup=20
> rw,nosuid,nodev,noexec,relatime,debug 0 0
> cgroup /sys/fs/cgroup/cpu cgroup rw,nosuid,nodev,noexec,relatime,cpu 0 =
0
> cgroup /sys/fs/cgroup/cpuacct cgroup=20
> rw,nosuid,nodev,noexec,relatime,cpuacct 0 0
> cgroup /sys/fs/cgroup/devices cgroup=20
> rw,nosuid,nodev,noexec,relatime,devices 0 0
> cgroup /sys/fs/cgroup/freezer cgroup=20
> rw,nosuid,nodev,noexec,relatime,freezer 0 0
> cgroup /sys/fs/cgroup/blkio cgroup=20
> rw,nosuid,nodev,noexec,relatime,blkio 0 0
> systemd-1 /dev/hugepages autofs=20
> rw,relatime,fd=3D26,pgrp=3D1,timeout=3D300,minproto=3D5,maxproto=3D5,di=
rect 0 0
> systemd-1 /proc/sys/fs/binfmt_misc autofs=20
> rw,relatime,fd=3D27,pgrp=3D1,timeout=3D300,minproto=3D5,maxproto=3D5,di=
rect 0 0
> systemd-1 /sys/kernel/debug autofs=20
> rw,relatime,fd=3D28,pgrp=3D1,timeout=3D300,minproto=3D5,maxproto=3D5,di=
rect 0 0
> systemd-1 /dev/mqueue autofs=20
> rw,relatime,fd=3D29,pgrp=3D1,timeout=3D300,minproto=3D5,maxproto=3D5,di=
rect 0 0
> systemd-1 /sys/kernel/security autofs=20
> rw,relatime,fd=3D30,pgrp=3D1,timeout=3D300,minproto=3D5,maxproto=3D5,di=
rect 0 0
> tmpfs /var/run tmpfs rw,nosuid,nodev,noexec,relatime,mode=3D755 0 0
> rpc_pipefs /var/lib/nfs/rpc_pipefs rpc_pipefs rw,relatime 0 0
> tmpfs /media tmpfs rw,nosuid,nodev,noexec,relatime,mode=3D755 0 0
> nfsd /proc/fs/nfsd nfsd rw,relatime 0 0
> fusectl /sys/fs/fuse/connections fusectl rw,relatime 0 0
> /dev/sda2 /amd/kasslerbraten/0 reiserfs rw,relatime 0 0
> /etc/automount/auto.home /home autofs=20
> rw,relatime,fd=3D7,pgrp=3D542,timeout=3D300,minproto=3D5,maxproto=3D5,i=
ndirect 0 0
> /etc/automount/auto.jbod /jbod autofs=20
> rw,relatime,fd=3D13,pgrp=3D542,timeout=3D300,minproto=3D5,maxproto=3D5,=
indirect 0 0
> /etc/automount/auto.confidential /confidential autofs=20
> rw,relatime,fd=3D19,pgrp=3D542,timeout=3D300,minproto=3D5,maxproto=3D5,=
indirect 0 0
> /etc/automount/auto.project /project autofs=20
> rw,relatime,fd=3D25,pgrp=3D542,timeout=3D300,minproto=3D5,maxproto=3D5,=
indirect 0 0
> /etc/automount/auto.package /package autofs=20
> rw,relatime,fd=3D31,pgrp=3D542,timeout=3D300,minproto=3D5,maxproto=3D5,=
indirect 0 0
> /etc/automount/auto.scratch /scratch autofs=20
> rw,relatime,fd=3D37,pgrp=3D542,timeout=3D300,minproto=3D5,maxproto=3D5,=
indirect 0 0
> /etc/automount/auto.src /src autofs=20
> rw,relatime,fd=3D43,pgrp=3D542,timeout=3D300,minproto=3D5,maxproto=3D5,=
indirect 0 0
> pummelfee:/amd/pummelfee/X/X3009/home/abt_srv/klages /home/klages nfs4 =

> rw,nosuid,relatime,vers=3D4.0,rsize=3D1048576,wsize=3D1048576,namlen=3D=
255,hard,proto=3Dtcp,port=3D0,timeo=3D600,retrans=3D2,sec=3Dsys,clientadd=
r=3D141.14.19.40,local_lock=3Dnone,addr=3D141.14.16.18=20
> 0 0
> palle:/amd/palle/1/home/abt_srv/buczek /home/buczek nfs=20
> rw,nosuid,relatime,vers=3D3,rsize=3D524288,wsize=3D524288,namlen=3D255,=
hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D141.14.28.=
251,mountvers=3D3,mountport=3D58602,mountproto=3Dudp,local_lock=3Dnone,ad=
dr=3D141.14.28.251=20
> 0 0
> binfmt_misc /proc/sys/fs/binfmt_misc binfmt_misc rw,relatime 0 0
> erdnuckel:/amd/erdnuckel/X/X0008/package/sequencer /package/sequencer=20
> nfs=20
> rw,nosuid,relatime,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D25=
5,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D141.14.2=
8.246,mountvers=3D3,mountport=3D53128,mountproto=3Dudp,local_lock=3Dnone,=
addr=3D141.14.28.246=20
> 0 0
> root:kasslerbraten:/home/buczek/autofs/#

But visible to my little perl program (=20
http://owww.molgen.mpg.de/~buczek/autofs-demo/peekmounts ) which walks=20
the mountpoint hashtable and the mount_hashtable ) :

> root:kasslerbraten:/home/buczek/autofs/# ./peekmounts
>  mountpoint 0xffff8801280ffc20 : count=3D   2 denty=3D0xffff8800c899689=
0 (src)
>  mountpoint 0xffff8801285b6c20 : count=3D   2 denty=3D0xffff8800ca457c9=
0=20
> (systemd)
>  mountpoint 0xffff8801285b6a60 : count=3D   2 denty=3D0xffff8800ca457d5=
0=20
> (cpuset)
>  mountpoint 0xffff8801285e9d00 : count=3D   2 denty=3D0xffff8800ca4cf71=
0=20
> (hugepages)
>  mountpoint 0xffff8801285b6c60 : count=3D   2 denty=3D0xffff8800ca457ed=
0=20
> (cgroup)
>  mountpoint 0xffff8801285e9da0 : count=3D   2 denty=3D0xffff8800ca4a3c5=
0=20
> (blkio)
>  mountpoint 0xffff8800a39282a0 : count=3D   1 denty=3D0xffff880094483e9=
0=20
> (buczek)
>  mountpoint 0xffff8801280ffc80 : count=3D   2 denty=3D0xffff8800c8996dd=
0=20
> (scratch)
>  mountpoint 0xffff8800c8ed8480 : count=3D   2 denty=3D0xffff8800c88284d=
0=20
> (connections)
>  mountpoint 0xffff8801285e99e0 : count=3D   2 denty=3D0xffff8800bd87411=
0=20
> (klages)
>  mountpoint 0xffff8801285e9c80 : count=3D   2 denty=3D0xffff8800ca4cfdd=
0=20
> (binfmt_misc)
>  mountpoint 0xffff8801285e9e40 : count=3D   2 denty=3D0xffff8800ca4a051=
0=20
> (freezer)
>  mountpoint 0xffff8800aa2d6880 : count=3D   1 denty=3D0xffff8800ca4cc39=
0 (/)
>  mountpoint 0xffff8801285e9c20 : count=3D   2 denty=3D0xffff8800ca4cc5d=
0=20
> (debug)
>  mountpoint 0xffff8801285e9f60 : count=3D   2 denty=3D0xffff8800ca49c95=
0=20
> (cpuacct)
>  mountpoint 0xffff8800c1d06920 : count=3D   2 denty=3D0xffff880129187dd=
0=20
> (confidential)
>  mountpoint 0xffff8800ca1736c0 : count=3D   2 denty=3D0xffff8800ca4c4a5=
0=20
> (rpc_pipefs)
>  mountpoint 0xffff8800c1d068a0 : count=3D   2 denty=3D0xffff8800c8b2e45=
0=20
> (project)
>  mountpoint 0xffff8801285e9ec0 : count=3D   2 denty=3D0xffff8800ca4a0ed=
0=20
> (devices)
>  mountpoint 0xffff8801285e9ac0 : count=3D   2 denty=3D0xffff8800ca4c8dd=
0=20
> (security)
>  mountpoint 0xffff8801285e9fe0 : count=3D   2 denty=3D0xffff8800ca4992d=
0 (cpu)
>  mountpoint 0xffff8800a3efeba0 : count=3D   1 denty=3D0xffff8800c890ce1=
0 (tmp)
>  mountpoint 0xffff880125e44480 : count=3D   1 denty=3D0xffff88007c86da1=
0=20
> (mariux32)
>  mountpoint 0xffff8800c1d06940 : count=3D   2 denty=3D0xffff8800c89b069=
0=20
> (home)
>  mountpoint 0xffff8800c2841820 : count=3D   2 denty=3D0xffff8800c8adf45=
0 (0)
>  mountpoint 0xffff8800c2841400 : count=3D   2 denty=3D0xffff8800c89dc8d=
0=20
> (jbod)
>  mountpoint 0xffff8801285b6ce0 : count=3D   2 denty=3D0xffff8800ca4521d=
0 (run)
>  mountpoint 0xffff8801285b6d40 : count=3D   2 denty=3D0xffff8800ca45229=
0 (pts)
>  mountpoint 0xffff8801285b69e0 : count=3D   2 denty=3D0xffff8800ca499ed=
0=20
> (debug)
>  mountpoint 0xffff8801285b6d80 : count=3D   2 denty=3D0xffff8800ca4524d=
0 (shm)
>  mountpoint 0xffff880128fef2e0 : count=3D   3 denty=3D0xffff880129002ad=
0 (/)
>  mountpoint 0xffff8801285b6e00 : count=3D   2 denty=3D0xffff8800ca45271=
0 (sys)
>  mountpoint 0xffff880125d17800 : count=3D   1 denty=3D0xffff8800944ae1d=
0=20
> (roche454)
>  mountpoint 0xffff8801280ffce0 : count=3D   2 denty=3D0xffff8800c897959=
0=20
> (package)
>  mountpoint 0xffff8801285b6e80 : count=3D   2 denty=3D0xffff8800ca452a1=
0=20
> (proc)
>  mountpoint 0xffff8801285e9600 : count=3D   2 denty=3D0xffff8800ca4e21d=
0=20
> (media)
>  mountpoint 0xffff8801285e9740 : count=3D   2 denty=3D0xffff88012900f05=
0 (dev)
>  mountpoint 0xffff8800ca173fc0 : count=3D   2 denty=3D0xffff88012904745=
0=20
> (nfsd)
>  mountpoint 0xffff8800b9493d00 : count=3D   1 denty=3D0xffff8800b59ade1=
0=20
> (local)
>  mountpoint 0xffff8800ca1439c0 : count=3D   2 denty=3D0xffff8800ca4e2d1=
0 (run)
>  mountpoint 0xffff8800aa146b60 : count=3D   1 denty=3D0xffff880038b8c45=
0 (web)
>  mountpoint 0xffff8801285e9b40 : count=3D   2 denty=3D0xffff8801290478d=
0=20
> (mqueue)
>  struct mount 0xffff880128fd2e00 : mountpoint dentry=20
> 0xffff880129002ad0 (/) mountpoint struct 0xffff880128fef2e0
>  struct mount 0xffff8800c9e5e0c0 : mountpoint dentry=20
> 0xffff880129187dd0 (confidential) mountpoint struct 0xffff8800c1d06920
>  struct mount 0xffff880128fd2cc0 : mountpoint dentry=20
> 0xffff8800ca4c4a50 (rpc_pipefs) mountpoint struct 0xffff8800ca1736c0
>  struct mount 0xffff8800c9e5e200 : mountpoint dentry=20
> 0xffff8800c8b2e450 (project) mountpoint struct 0xffff8800c1d068a0
>  struct mount 0xffff8800c9dda300 : mountpoint dentry=20
> 0xffff8800ca4cf710 (hugepages) mountpoint struct 0xffff8801285e9d00
>  struct mount 0xffff8800aa103840 : mountpoint dentry=20
> 0xffff880129047450 (nfsd) mountpoint struct 0xffff8800ca173fc0
>  struct mount 0xffff8800a3a9a300 : mountpoint dentry=20
> 0xffff8800b59ade10 (local) mountpoint struct 0xffff8800b9493d00
>  struct mount 0xffff8800aa103480 : mountpoint dentry=20
> 0xffff8800ca457c90 (systemd) mountpoint struct 0xffff8801285b6c20
>  struct mount 0xffff8800aa103340 : mountpoint dentry=20
> 0xffff8800ca457d50 (cpuset) mountpoint struct 0xffff8801285b6a60
>  struct mount 0xffff8800aa13ebc0 : mountpoint dentry=20
> 0xffff880038b8c450 (web) mountpoint struct 0xffff8800aa146b60
>  struct mount 0xffff8800aa1035c0 : mountpoint dentry=20
> 0xffff8800ca457ed0 (cgroup) mountpoint struct 0xffff8801285b6c60
>  struct mount 0xffff8800b5e40a40 : mountpoint dentry=20
> 0xffff8800ca4a3c50 (blkio) mountpoint struct 0xffff8801285e9da0
>  struct mount 0xffff8800c9e5e840 : mountpoint dentry=20
> 0xffff8800c89b0690 (home) mountpoint struct 0xffff8800c1d06940
>  struct mount 0xffff8800a3a9aa80 : mountpoint dentry=20
> 0xffff880129187dd0 (confidential) mountpoint struct 0xffff8800c1d06920
>  struct mount 0xffff8800cac2b840 : mountpoint dentry=20
> 0xffff8800c8adf450 (0) mountpoint struct 0xffff8800c2841820
>  struct mount 0xffff8800b5e402c0 : mountpoint dentry=20
> 0xffff8800ca4c4a50 (rpc_pipefs) mountpoint struct 0xffff8800ca1736c0
>  struct mount 0xffff8800c9ddad00 : mountpoint dentry=20
> 0xffff8800ca457c90 (systemd) mountpoint struct 0xffff8801285b6c20
>  struct mount 0xffff8800a3a9a940 : mountpoint dentry=20
> 0xffff8800c8b2e450 (project) mountpoint struct 0xffff8800c1d068a0
>  struct mount 0xffff8800b5e40680 : mountpoint dentry=20
> 0xffff8800c88284d0 (connections) mountpoint struct 0xffff8800c8ed8480
>  struct mount 0xffff8800c9ddabc0 : mountpoint dentry=20
> 0xffff8800ca457d50 (cpuset) mountpoint struct 0xffff8801285b6a60
>  struct mount 0xffff8800c1d97b80 : mountpoint dentry=20
> 0xffff8800ca4cc390 (/) mountpoint struct 0xffff8800aa2d6880
>  struct mount 0xffff880128fd2a40 : mountpoint dentry=20
> 0xffff8800c89dc8d0 (jbod) mountpoint struct 0xffff8800c2841400
>  struct mount 0xffff880128fee580 : mountpoint dentry=20
> 0xffff8800ca4521d0 (run) mountpoint struct 0xffff8801285b6ce0
>  struct mount 0xffff8800c9dda440 : mountpoint dentry=20
> 0xffff8800ca4a3c50 (blkio) mountpoint struct 0xffff8801285e9da0
>  struct mount 0xffff8800b5e40b80 : mountpoint dentry=20
> 0xffff8800ca4a0510 (freezer) mountpoint struct 0xffff8801285e9e40
>  struct mount 0xffff8800c9e5e340 : mountpoint dentry=20
> 0xffff880094483e90 (buczek) mountpoint struct 0xffff8800a39282a0
>  struct mount 0xffff8800aa103980 : mountpoint dentry=20
> 0xffff8800ca4cfdd0 (binfmt_misc) mountpoint struct 0xffff8801285e9c80
>  struct mount 0xffff8800a3a9a080 : mountpoint dentry=20
> 0xffff8800c890ce10 (tmp) mountpoint struct 0xffff8800a3efeba0
>  struct mount 0xffff8800c1d97180 : mountpoint dentry=20
> 0xffff8800bd874110 (klages) mountpoint struct 0xffff8801285e99e0
>  struct mount 0xffff880128fee1c0 : mountpoint dentry=20
> 0xffff8800ca452710 (sys) mountpoint struct 0xffff8801285b6e00
>  struct mount 0xffff880128feed00 : mountpoint dentry=20
> 0xffff880129002ad0 (/) mountpoint struct 0xffff880128fef2e0
>  struct mount 0xffff8800c9e5ec00 : mountpoint dentry=20
> 0xffff880129047450 (nfsd) mountpoint struct 0xffff8800ca173fc0
>  struct mount 0xffff8800c9e5eac0 : mountpoint dentry=20
> 0xffff8800c8979590 (package) mountpoint struct 0xffff8801280ffce0
>  struct mount 0xffff8800a3a9ae40 : mountpoint dentry=20
> 0xffff8800c89b0690 (home) mountpoint struct 0xffff8800c1d06940
>  struct mount 0xffff8800b5e40e00 : mountpoint dentry=20
> 0xffff8800ca49c950 (cpuacct) mountpoint struct 0xffff8801285e9f60
>  struct mount 0xffff8800b5e40040 : mountpoint dentry=20
> 0xffff8800c8adf450 (0) mountpoint struct 0xffff8800c2841820
>  struct mount 0xffff8800b5e40900 : mountpoint dentry=20
> 0xffff8800ca4cc5d0 (debug) mountpoint struct 0xffff8801285e9c20
>  struct mount 0xffff880128fee080 : mountpoint dentry=20
> 0xffff8800ca452a10 (proc) mountpoint struct 0xffff8801285b6e80
>  struct mount 0xffff8800c9dda580 : mountpoint dentry=20
> 0xffff8800ca4a0510 (freezer) mountpoint struct 0xffff8801285e9e40
>  struct mount 0xffff8800cac2bac0 : mountpoint dentry=20
> 0xffff8800ca4e21d0 (media) mountpoint struct 0xffff8801285e9600
>  struct mount 0xffff8800cac2bc00 : mountpoint dentry=20
> 0xffff88012900f050 (dev) mountpoint struct 0xffff8801285e9740
>  struct mount 0xffff8800aa103e80 : mountpoint dentry=20
> 0xffff8800ca452290 (pts) mountpoint struct 0xffff8801285b6d40
>  struct mount 0xffff8800a3a9abc0 : mountpoint dentry=20
> 0xffff8800c89dc8d0 (jbod) mountpoint struct 0xffff8800c2841400
>  struct mount 0xffff8800b5e40540 : mountpoint dentry=20
> 0xffff8800ca4521d0 (run) mountpoint struct 0xffff8801285b6ce0
>  struct mount 0xffff8800c9dda800 : mountpoint dentry=20
> 0xffff8800ca49c950 (cpuacct) mountpoint struct 0xffff8801285e9f60
>  struct mount 0xffff8800b5e40cc0 : mountpoint dentry=20
> 0xffff8800ca4a0ed0 (devices) mountpoint struct 0xffff8801285e9ec0
>  struct mount 0xffff8800aa13e080 : mountpoint dentry=20
> 0xffff8800ca4524d0 (shm) mountpoint struct 0xffff8801285b6d80
>  struct mount 0xffff8800a3a9ad00 : mountpoint dentry=20
> 0xffff8800bd874110 (klages) mountpoint struct 0xffff8801285e99e0
>  struct mount 0xffff8800b5e407c0 : mountpoint dentry=20
> 0xffff8800ca4c8dd0 (security) mountpoint struct 0xffff8801285e9ac0
>  struct mount 0xffff8800aa1030c0 : mountpoint dentry=20
> 0xffff8800ca4992d0 (cpu) mountpoint struct 0xffff8801285e9fe0
>  struct mount 0xffff8800aa103700 : mountpoint dentry=20
> 0xffff8800ca452710 (sys) mountpoint struct 0xffff8801285b6e00
>  struct mount 0xffff8800a3a9a580 : mountpoint dentry=20
> 0xffff8800c8979590 (package) mountpoint struct 0xffff8801280ffce0
>  struct mount 0xffff8800c9dda6c0 : mountpoint dentry=20
> 0xffff8800ca4a0ed0 (devices) mountpoint struct 0xffff8801285e9ec0
>  struct mount 0xffff8800c9ddae40 : mountpoint dentry=20
> 0xffff8800ca457ed0 (cgroup) mountpoint struct 0xffff8801285b6c60
>  struct mount 0xffff8800aa103ac0 : mountpoint dentry=20
> 0xffff8800ca452a10 (proc) mountpoint struct 0xffff8801285b6e80
>  struct mount 0xffff880128fee440 : mountpoint dentry=20
> 0xffff8800ca452290 (pts) mountpoint struct 0xffff8801285b6d40
>  struct mount 0xffff880128feebc0 : mountpoint dentry=20
> 0xffff8800ca4e2d10 (run) mountpoint struct 0xffff8800ca1439c0
>  struct mount 0xffff8800b5e40180 : mountpoint dentry=20
> 0xffff8800ca4e21d0 (media) mountpoint struct 0xffff8801285e9600
>  struct mount 0xffff8800cac2b980 : mountpoint dentry=20
> 0xffff8800c88284d0 (connections) mountpoint struct 0xffff8800c8ed8480
>  struct mount 0xffff8800aa13e1c0 : mountpoint dentry=20
> 0xffff88012900f050 (dev) mountpoint struct 0xffff8801285e9740
>  struct mount 0xffff8800c9dda940 : mountpoint dentry=20
> 0xffff8800ca4992d0 (cpu) mountpoint struct 0xffff8801285e9fe0
>  struct mount 0xffff880128fee300 : mountpoint dentry=20
> 0xffff8800ca4524d0 (shm) mountpoint struct 0xffff8801285b6d80
>  struct mount 0xffff8800c9dda1c0 : mountpoint dentry=20
> 0xffff8800ca4cfdd0 (binfmt_misc) mountpoint struct 0xffff8801285e9c80
>  struct mount 0xffff8800c1d97e00 : mountpoint dentry=20
> 0xffff8800c8996890 (src) mountpoint struct 0xffff8801280ffc20
>  struct mount 0xffff8800aa103200 : mountpoint dentry=20
> 0xffff8800ca499ed0 (debug) mountpoint struct 0xffff8801285b69e0
>  struct mount 0xffff8800b5e40400 : mountpoint dentry=20
> 0xffff8800ca4e2d10 (run) mountpoint struct 0xffff8800ca1439c0
>  struct mount 0xffff8800c9e5e980 : mountpoint dentry=20
> 0xffff8800c8996dd0 (scratch) mountpoint struct 0xffff8801280ffc80
>  struct mount 0xffff8800aa103c00 : mountpoint dentry=20
> 0xffff8801290478d0 (mqueue) mountpoint struct 0xffff8801285e9b40
>  struct mount 0xffff8800c9dda080 : mountpoint dentry=20
> 0xffff8800ca4cc5d0 (debug) mountpoint struct 0xffff8801285e9c20
>  struct mount 0xffff8800a3a9a6c0 : mountpoint dentry=20
> 0xffff88007c86da10 (mariux32) mountpoint struct 0xffff880125e44480
>  struct mount 0xffff8800c9ddaa80 : mountpoint dentry=20
> 0xffff8800ca499ed0 (debug) mountpoint struct 0xffff8801285b69e0
>  struct mount 0xffff8800aa13e300 : mountpoint dentry=20
> 0xffff880129002ad0 (/) mountpoint struct 0xffff880128fef2e0
>  struct mount 0xffff8800a3a9a1c0 : mountpoint dentry=20
> 0xffff8800c8996890 (src) mountpoint struct 0xffff8801280ffc20
>  struct mount 0xffff8800aa103d40 : mountpoint dentry=20
> 0xffff8800ca4cf710 (hugepages) mountpoint struct 0xffff8801285e9d00
>  struct mount 0xffff8800c9e5ed40 : mountpoint dentry=20
> 0xffff8800ca4c8dd0 (security) mountpoint struct 0xffff8801285e9ac0
>  struct mount 0xffff8800c9e5ee80 : mountpoint dentry=20
> 0xffff8801290478d0 (mqueue) mountpoint struct 0xffff8801285e9b40
>  struct mount 0xffff8800a3a9a440 : mountpoint dentry=20
> 0xffff8800c8996dd0 (scratch) mountpoint struct 0xffff8801280ffc80
>  struct mount 0xffff8800a3a9a800 : mountpoint dentry=20
> 0xffff8800944ae1d0 (roche454) mountpoint struct 0xffff880125d17800

This is the struct mount of "mariux32" :

> (gdb) print *(struct mount *)0xffff8800a3a9a6c0
> $2 =3D {mnt_hash =3D {next =3D 0xffff880128e87cf0, prev =3D=20
> 0xffff880128e87cf0}, mnt_parent =3D 0xffff8800a3a9a940, mnt_mountpoint =
=3D=20
> 0xffff88007c86da10, mnt =3D {mnt_root =3D 0xffff88007c8ed590,
>     mnt_sb =3D 0xffff880125fef800, mnt_flags =3D 33}, mnt_rcu =3D {next=
 =3D=20
> 0x0, func =3D 0}, mnt_pcp =3D 0x60fed2000ab4, mnt_mounts =3D {next =3D =

> 0xffff8800a3a9a710, prev =3D 0xffff8800a3a9a710},
>   mnt_child =3D {next =3D 0xffff8800a3a9a990, prev =3D 0xffff8800a3a9a8=
60},=20
> mnt_instance =3D {next =3D 0xffff880125fef8b0, prev =3D 0xffff880125fef=
8b0},
>   mnt_devname =3D 0xffff880120c69c80=20
> "pille:/amd/pille/1/project/mariux32", mnt_list =3D {next =3D=20
> 0xffff8800a3a9a608, prev =3D 0xffff8800a3a9a888}, mnt_expire =3D {next =
=3D=20
> 0xffff8800a3a9a758,
>     prev =3D 0xffff8800a3a9a758}, mnt_share =3D {next =3D=20
> 0xffff8800a3a9a768, prev =3D 0xffff8800a3a9a768}, mnt_slave_list =3D {n=
ext=20
> =3D 0xffff8800a3a9a778, prev =3D 0xffff8800a3a9a778},
>   mnt_slave =3D {next =3D 0xffff8800a3a9a788, prev =3D 0xffff8800a3a9a7=
88},=20
> mnt_master =3D 0x0, mnt_ns =3D 0xffff8801271f9300, mnt_mp =3D=20
> 0xffff880125e44480, mnt_fsnotify_marks =3D {first =3D 0x0},
>   mnt_fsnotify_mask =3D 0, mnt_id =3D 126, mnt_group_id =3D 0,=20
> mnt_expiry_mark =3D 0, mnt_pinned =3D 0, mnt_ex_mountpoint =3D {mnt =3D=
 0x0,=20
> dentry =3D 0x0}}
>

This is the struct mount of the parent ( "/project") :

> (gdb) print *((struct mount *)0xffff8800a3a9a6c0)->mnt_parent
> $3 =3D {mnt_hash =3D {next =3D 0xffff880128e87380, prev =3D=20
> 0xffff880128e87380}, mnt_parent =3D 0xffff8800aa13e300, mnt_mountpoint =
=3D=20
> 0xffff8800c8b2e450, mnt =3D {mnt_root =3D 0xffff8800c8b2e810,
>     mnt_sb =3D 0xffff8800c8f44000, mnt_flags =3D 32}, mnt_rcu =3D {next=
 =3D=20
> 0x0, func =3D 0}, mnt_pcp =3D 0x60fed2000aa4, mnt_mounts =3D {next =3D =

> 0xffff8800a3a9a860, prev =3D 0xffff8800a3a9a720},
>   mnt_child =3D {next =3D 0xffff8800a3a9a5e0, prev =3D 0xffff8800a3a9aa=
e0},=20
> mnt_instance =3D {next =3D 0xffff8800c8f440b0, prev =3D 0xffff8800c9e5e=
270},
>   mnt_devname =3D 0xffff8800a3efe1e0 "/etc/automount/auto.project",=20
> mnt_list =3D {next =3D 0xffff8800a3a9a888, prev =3D 0xffff8800a3a9ab08}=
,=20
> mnt_expire =3D {next =3D 0xffff8800a3a9a9d8,
>     prev =3D 0xffff8800a3a9a9d8}, mnt_share =3D {next =3D=20
> 0xffff8800a3a9a9e8, prev =3D 0xffff8800a3a9a9e8}, mnt_slave_list =3D {n=
ext=20
> =3D 0xffff8800a3a9a9f8, prev =3D 0xffff8800a3a9a9f8},
>   mnt_slave =3D {next =3D 0xffff8800a3a9aa08, prev =3D 0xffff8800a3a9aa=
08},=20
> mnt_master =3D 0x0, mnt_ns =3D 0xffff8801271f9300, mnt_mp =3D=20
> 0xffff8800c1d068a0, mnt_fsnotify_marks =3D {first =3D 0x0},
>   mnt_fsnotify_mask =3D 0, mnt_id =3D 124, mnt_group_id =3D 0,=20
> mnt_expiry_mark =3D 0, mnt_pinned =3D 0, mnt_ex_mountpoint =3D {mnt =3D=
 0x0,=20
> dentry =3D 0x0}}


Regards
   Donald

--=20
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433



--------------ms000603010209060406060808
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOKjCC
BCEwggMJoAMCAQICAgDHMA0GCSqGSIb3DQEBBQUAMHExCzAJBgNVBAYTAkRFMRwwGgYDVQQK
ExNEZXV0c2NoZSBUZWxla29tIEFHMR8wHQYDVQQLExZULVRlbGVTZWMgVHJ1c3QgQ2VudGVy
MSMwIQYDVQQDExpEZXV0c2NoZSBUZWxla29tIFJvb3QgQ0EgMjAeFw0wNjEyMTkxMDI5MDBa
Fw0xOTA2MzAyMzU5MDBaMFoxCzAJBgNVBAYTAkRFMRMwEQYDVQQKEwpERk4tVmVyZWluMRAw
DgYDVQQLEwdERk4tUEtJMSQwIgYDVQQDExtERk4tVmVyZWluIFBDQSBHbG9iYWwgLSBHMDEw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDpm8NnhfkNrvWNVMOWUDU9YuluTO2U
1wBblSJ01CDrNI/W7MAxBAuZgeKmFNJSoCgjhIt0iQReW+DieMF4yxbLKDU5ey2QRdDtoAB6
fL9KDhsAw4bpXCsxEXsM84IkQ4wcOItqaACa7txPeKvSxhObdq3u3ibo7wGvdA/BCaL2a869
080UME/15eOkyGKbghoDJzANAmVgTe3RCSMqljVYJ9N2xnG2kB3E7f81hn1vM7PbD8URwoqD
oZRdQWvY0hD1TP3KUazZve+Sg7va64sWVlZDz+HVEz2mHycwzUlU28kTNJpxdcVs6qcLmPkh
nSevPqM5OUhqjK3JmfvDEvK9AgMBAAGjgdkwgdYwcAYDVR0fBGkwZzBloGOgYYZfaHR0cDov
L3BraS50ZWxlc2VjLmRlL2NnaS1iaW4vc2VydmljZS9hZl9Eb3dubG9hZEFSTC5jcmw/LWNy
bF9mb3JtYXQ9WF81MDkmLWlzc3Vlcj1EVF9ST09UX0NBXzIwHQYDVR0OBBYEFEm3xs/oPR9/
6kR7Eyn38QpwPt5kMB8GA1UdIwQYMBaAFDHDeRu69VPXF+CJei0XbAqzK50zMA4GA1UdDwEB
/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgECMA0GCSqGSIb3DQEBBQUAA4IBAQA74Vp3wEgX
3KkY7IGvWonwvSiSpspZGBJw7Cjy565/lizn8l0ZMfYTK3S9vYCyufdnyTmieTvhERHua3iR
M347XyYndVNljjNj7s9zw7CSI0khUHUjoR8Y4pSFPT8z6XcgjaK95qGFKUD2P3MyWA0Ja6ba
hWzAP7uNZmRWJE6uDT8yNQFb6YyC2XJZT7GGhfF0hVblw/hc843uR7NTBXDn5U2KaYMo4RMJ
hp5eyOpYHgwf+aTUWgRo/Sg+iwK2WLX2oSw3VwBnqyNojWOl75lrXP1LVvarQIc01BGSbOyH
xQoLBzNytG8MHVQs2FHHzL8w00Ny8TK/jM5JY6gA9/IcMIIE5zCCA8+gAwIBAgIECs6x2DAN
BgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZOLVZlcmVpbjEQMA4G
A1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xvYmFsIC0gRzAxMB4X
DTA3MDczMTEzMDgyNVoXDTE5MDYzMDAwMDAwMFowXjELMAkGA1UEBhMCREUxIDAeBgNVBAoT
F01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MQ8wDQYDVQQDEwZNUEcgQ0ExHDAaBgkqhkiG9w0B
CQEWDW1wZy1jYUBtcGcuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDYUXKe
oNTLgkGwbani4rlua5jzlzISfHnaj/5qS+mojQqA/eYa0bGucylV5hyQuyJz7d4gRckdhMDV
8DZIxERUIsFlXFj6HGHjaZjlhIHbo4S12GjLhTH5YZ37O7MHVw0L/JhhzUIxESM1ZfRT/xLq
hz2idJYjT98W9OFvzPgT0yrdieMzkLUz5X/fpY8MuyYBgxnddBJRw6ZtlhdCml4F8Q35pSb8
J2qANiwuJVu3WCTgL/ydo3eA8vDieMMZ7O+L1wAnCzBbHAjJ5H6xU1B7mlwmu7V3pToKPgcW
mlO0HcTpa68McNTGGiY8pO0/Rn1fXkqDYf8z0lPdWUWxbM1RAgMBAAGjggGvMIIBqzASBgNV
HRMBAf8ECDAGAQH/AgEBMAsGA1UdDwQEAwIBBjAdBgNVHQ4EFgQUAtYebgmrv1hlpwo8SDNh
0c59w1swHwYDVR0jBBgwFoAUSbfGz+g9H3/qRHsTKffxCnA+3mQwGAYDVR0RBBEwD4ENbXBn
LWNhQG1wZy5kZTCBiAYDVR0fBIGAMH4wPaA7oDmGN2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUv
Z2xvYmFsLXJvb3QtY2EvcHViL2NybC9jYWNybC5jcmwwPaA7oDmGN2h0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvZ2xvYmFsLXJvb3QtY2EvcHViL2NybC9jYWNybC5jcmwwgaIGCCsGAQUFBwEB
BIGVMIGSMEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290
LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBHBggrBgEFBQcwAoY7aHR0cDovL2NkcDIucGNh
LmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcN
AQEFBQADggEBABtJz5i/SGqQOficdRUN6myFVmVelCYgkGT+zX7frnBRJFoVVafXolstZdVB
7ZpH9FAcqj8O6FTZyhAANwh3+Y1D6xYBWTB7mQGy0lUoUL+j0msZjaMvyj/2LCQp7cKB5vA4
h6Ntq5BN5MPcaRhunzjJey/i+J/3jMdG7KpufV47Gl0E8ky9lDegaM7SToG4IOQKwv1wsnuH
oxoGLRewxO7FmYd9uq9f4L2mHtqgq+vibT1DeehT0HGPnrjjd8NK6g2TvZwirwjydbGs7szB
5oxDm/pfWoJxYzO68HKTiVBlmaWMLpGw4/UsLE+5xJHpvNXfkYCQ3T+k99KBUZuIpKwwggUW
MIID/qADAgECAgcTo68+b/5oMA0GCSqGSIb3DQEBBQUAMF4xCzAJBgNVBAYTAkRFMSAwHgYD
VQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEPMA0GA1UEAxMGTVBHIENBMRwwGgYJKoZI
hvcNAQkBFg1tcGctY2FAbXBnLmRlMB4XDTEyMDQxMDEzMTIxNFoXDTE1MDQxMDEzMTIxNFow
gYoxCzAJBgNVBAYTAkRFMSAwHgYDVQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDE0MDIG
A1UECxMrTWF4LVBsYW5jay1JbnN0aXR1dCBmdWVyIG1vbGVrdWxhcmUgR2VuZXRpazELMAkG
A1UECxMCSVQxFjAUBgNVBAMTDURvbmFsZCBCdWN6ZWswggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC8AkX5++7fOB5qItwhRS7gQ6VJthfPItK8AMTlGeyuqHztDM4us3VKll9t
Z7HybeXypqTt38JNrU56RnIqRwk+ajvNngk0Z+72eLUXH+TydvemBJ4fvnkIYtOgO7PZfKTy
iDSCo2tt/PuqnMlacXhCOWrgljhYhZgaPeecoDC+7EA3S3IKVJNBPxT1VtwRb3M691Igu2Th
yar3F7BkeyimbJ8UKHLpeHX1UvUwfdO0Geem7tkC5JPHlhwMb0Lpr6VImyl6a1CW88yGP5s2
sp1Bnr31ZLISjwq3VCRggzjPcjZPo1bMXzg2yAsh3BUp3ljYYTxJHe2u/LGzsJoVB1crAgMB
AAGjggGqMIIBpjAJBgNVHRMEAjAAMAsGA1UdDwQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFEUP5hp3anavBSte9vwsqlJ/LpMSMB8GA1UdIwQYMBaA
FALWHm4Jq79YZacKPEgzYdHOfcNbMB8GA1UdEQQYMBaBFGJ1Y3pla0Btb2xnZW4ubXBnLmRl
MHcGA1UdHwRwMG4wNaAzoDGGL2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWNhL3B1Yi9j
cmwvY2FjcmwuY3JsMDWgM6Axhi9odHRwOi8vY2RwMi5wY2EuZGZuLmRlL21wZy1jYS9wdWIv
Y3JsL2NhY3JsLmNybDCBkgYIKwYBBQUHAQEEgYUwgYIwPwYIKwYBBQUHMAKGM2h0dHA6Ly9j
ZHAxLnBjYS5kZm4uZGUvbXBnLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDA/BggrBgEFBQcw
AoYzaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBBQUAA4IBAQAn66b/WvVhpEsNXTGaZhxnUbN4+unYyQ930uxLwYrvGVxz
oEb/DoB/HJnxwly4ZVPhJ+Md8JabjkUPU7uUV/DBKjpatREOzLESa1wE++lP1QytuhEU9eIn
LDQLzpXrB2JPR9eMhh/8Qez6ikCYgIP0vNPdX2wTc1FwLvrN2YIyGqmLgGBdbUEwqY1dFn8I
9LOZR0tZT+ynNfPoQv4W7ec4BtqAbvC6bEbJ9bu2ZNEOoeX4FzpCgvtKdwQQJVDbZ9U8F3BY
5rTzZnfc73PkcSN+oDTYUQi6tVhbIqEp+DIRwx3VynbXYzJUbyKB5I2TEi2896KnWEdkdiYD
SE8yrLDmMYIDVTCCA1ECAQEwaTBeMQswCQYDVQQGEwJERTEgMB4GA1UEChMXTWF4LVBsYW5j
ay1HZXNlbGxzY2hhZnQxDzANBgNVBAMTBk1QRyBDQTEcMBoGCSqGSIb3DQEJARYNbXBnLWNh
QG1wZy5kZQIHE6OvPm/+aDAJBgUrDgMCGgUAoIIBwTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0xNDAzMDIwMDUyMjFaMCMGCSqGSIb3DQEJBDEWBBR8u6Ze
9vaeid0/LyDlx0acCfvdUTBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwXjELMAkGA1UEBhMCREUxIDAe
BgNVBAoTF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MQ8wDQYDVQQDEwZNUEcgQ0ExHDAaBgkq
hkiG9w0BCQEWDW1wZy1jYUBtcGcuZGUCBxOjrz5v/mgwegYLKoZIhvcNAQkQAgsxa6BpMF4x
CzAJBgNVBAYTAkRFMSAwHgYDVQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEPMA0GA1UE
AxMGTVBHIENBMRwwGgYJKoZIhvcNAQkBFg1tcGctY2FAbXBnLmRlAgcTo68+b/5oMA0GCSqG
SIb3DQEBAQUABIIBAEeKHWa2Ikcf6srgV9ZNgAic8r4Cg8vE4UBmyEj67QlkgpSylmqTh/Ym
XV6lP3tlwHJ7qNstKSAI0sN8MQxawyene6wFZCxruIze5TVKxC67/CBWXSxthIhyptIGxR6E
SPcsGhofbwjWm0tB3uG4d8BJRIm8q/X3+qYIJQcpdGAQlZhANRRHsGJ5NWYCPy31QSscJom0
BL90sgq97VmRobJ+FqJEbB8HCT/gl4Ravs5aIvE8xB1UId1BlAwIY3gFALhBW98Kc6jW1FgD
nh556oGvk+tykxftcoaePM+RzQBXWnewnWGV54ynBSM4/+bIKrqxsX8JOOvXPewMI5pI834A
AAAAAAA=
--------------ms000603010209060406060808--
