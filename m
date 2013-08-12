From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs mount fails if it relies on another autofs managed
 resource on Ubuntu
Date: Mon, 12 Aug 2013 16:26:28 +0800
Message-ID: <1376295988.8864.15.camel@perseus.fritz.box>
References: <520795C7.8030408@aol.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=R1gXp6tH4nGHNe3OL3ZzDD3q9MA=; b=bwnIxTrMxRUPKAzFNQEYf5gQ7+wz
	+kPBKi4/2rIcJEp7jbqNLOKVT2Q5dRyhCoyKWaIm61ASjDBkOIG6IW+c1+gCjx1b
	C9xrsdSe9s9Zkpy9nK4/Mqbw5+Lmb5YZJDpjZpO3now2w6JrdFbB0B9PLJv6+rZO
	nzBt5dpZWiNCLf8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=R1gXp6tH4nGHNe3OL3ZzDD
	3q9MA=; b=uEu7V8cbrLd0V/X5ds/hEeVPkyesyu9IFmP4yVozR5TT+Ojdw7j4Pm
	7eHW4tWyemCgZOuyLPHIIFlfVENpNmIDif0oo3doSPIRyMn+U/AVFfhy8QE+TRwu
	7/y8EF9OVqiWKaNpQSnUGDzKtXHYLQahl/Qnb792js1OJfTK9Tbdo=
In-Reply-To: <520795C7.8030408@aol.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: jj <nimjj@aol.com>
Cc: autofs@vger.kernel.org

On Sun, 2013-08-11 at 15:46 +0200, jj wrote:
> Hi,
> 
> can anybody help with a nested automount issue.
> I am trying to open a truecrypt container that is located on a samba fileshare.
> Both are registered with autofs and both are initially not mounted.
> When I try to access the truecrypt container it fails. The autofs log says "no such file" for the cifs container and does not
> try to mount the cifs resource automatically.
> If I manually mount the cifs fileshare (or try to accesss this prior to the truecrypt) it works.
> 
> If anybody knows this issue or a solution I would be glad for a hint.

The log looks like everything is umounted between tries but you should
make sure that the actual autofs mounts are in fact umounted not just
the mounts that have been automounted within them. In fact that's more
important when testing than umounting the mounts since to umount the
autofs mounts, mounts within them must have already been umounted. That
could make a difference if, for some unknown reason they appeared busy
and were left mounted, then reconnected to at startup.

> 
> Best wishes,
>   Joe
> 
> I am running ubuntu 13.04 with truecrypt 7.1a, cifs-utils 2:5.5-1ubuntu2 and autofs 5.0.7-3ubuntu1

As we discussed, this can't possibly work unless autofs configure option
--disable-mount-locking is used.

I installed Fedora package dpkg-dev, downloaded the Ubuntu source
package files, unpacked them using "dpkg-source -x
autofs_5.0.7-3ubuntu1.dsc" and I see this in debian/rules:

        dh_auto_configure -- \
                --enable-forced-shutdown \
                --enable-ignore-busy \
                --mandir=/usr/share/man \
                --with-confdir=/etc/default \
                --with-mapdir=/etc \
                --with-fifodir=/var/run --with-flagdir=/var/run \
                --with-hesiod \
                --with-openldap \
                --with-sasl

so the option isn't used.

Seems that's about all I can do on Fedora though.
But then I've forgotten most of how to do things with the debian package
management system.

Perhaps others here can help with that?
 
> Autofs has the following configuration:
> 
> auto.master
> /mnt/cifs /etc/auto.cifs
> /mnt/tc /etc/auto.truecrypt
> 
> auto.cifs
> NETHUN
> -fstype=cifs,rw,noperm,credentials=/etc/auto.smb.NETHUN ://FRITZ.BOX/FNAS
> 
> auto.truecypt
> jj      -loop,gid=users,uid=jj,fstype=truecrypt,password=pw
>     :/mnt/cifs/NETHUN/Kingston/container.tc
> 
> To demonstrate the error, I wrote the following testscript:
> testtc.cmd
> 
> echo ">> Start " $(date +"at: %H:%M:%S %N")
> cd
> echo ">> Unmount any mounted truecrypt containers " $(date +"at: %H:%M:%S %N")
> sudo truecrypt -d -v
> echo ">> Restarting autofs " $(date +"at: %H:%M:%S %N")
> sudo service autofs restart
> sleep 1
> echo ">> show mount " $(date +"at: %H:%M:%S %N")
> mount
> echo ">> try to cd/mnt/tc/jj " $(date +"at: %H:%M:%S %N")
> cd /mnt/tc/jj
> echo ">> show mount " $(date +"at: %H:%M:%S %N")
> mount
> echo ">> cd to /mnt/cifs/NETHUN " $(date +"at: %H:%M:%S %N")
> cd /mnt/cifs/NETHUN
> echo ">> show mount " $(date +"at: %H:%M:%S %N")
> mount
> echo ">> try to cd/mnt/tc/jj " $(date +"at: %H:%M:%S %N")
> cd /mnt/tc/jj
> cd
> echo ">> Restarting autofs " $(date +"at: %H:%M:%S %N")
> sudo service autofs restart
> sleep 1
> echo ">> show mount " $(date +"at: %H:%M:%S %N")
> mount
> echo ">> cd to /mnt/cifs/NETHUN " $(date +"at: %H:%M:%S %N")
> cd /mnt/cifs/NETHUN
> echo ">> show mount " $(date +"at: %H:%M:%S %N")
> mount
> echo ">> try to cd/mnt/tc/jj " $(date +"at: %H:%M:%S %N")
> cd /mnt/tc/jj
> echo ">> show mount " $(date +"at: %H:%M:%S %N")
> mount
> echo ">> Finished " $(date +"at: %H:%M:%S %N")
> 
> This gives the following stdout output:
>  >> Start  at: 15:10:03 109484298
>  >> Unmount any mounted truecrypt containers  at: 15:10:03 112498122
>  >> Restarting autofs  at: 15:10:03 203693405
> autofs stop/waiting
> autofs start/running, process 2581
>  >> show mount  at: 15:10:06 314603458
> /dev/mapper/ubuntu-root on / type ext4 (rw,noatime,nodiratime,discard,errors=remount-ro)
> proc on /proc type proc (rw,noexec,nosuid,nodev)
> sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
> none on /sys/fs/cgroup type tmpfs (rw)
> none on /sys/fs/fuse/connections type fusectl (rw)
> none on /sys/kernel/debug type debugfs (rw)
> none on /sys/kernel/security type securityfs (rw)
> udev on /dev type devtmpfs (rw,mode=0755)
> devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
> tmpfs on /tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
> none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
> none on /run/shm type tmpfs (rw,nosuid,nodev)
> none on /run/user type tmpfs (rw,noexec,nosuid,nodev,size=104857600,mode=0755)
> tmpfs on /var/tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> /dev/sda1 on /boot type ext2 (rw)
> binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,noexec,nosuid,nodev)
> rpc_pipefs on /run/rpc_pipefs type rpc_pipefs (rw)
> gvfsd-fuse on /run/user/jj/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,user=jj)
>  >> try to cd/mnt/tc/jj  at: 15:10:06 320506631
> ./testtc.cmd: line 16: cd: /mnt/tc/jj: No such file or directory
>  >> show mount  at: 15:10:06 382228009
> /dev/mapper/ubuntu-root on / type ext4 (rw,noatime,nodiratime,discard,errors=remount-ro)
> proc on /proc type proc (rw,noexec,nosuid,nodev)
> sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
> none on /sys/fs/cgroup type tmpfs (rw)
> none on /sys/fs/fuse/connections type fusectl (rw)
> none on /sys/kernel/debug type debugfs (rw)
> none on /sys/kernel/security type securityfs (rw)
> udev on /dev type devtmpfs (rw,mode=0755)
> devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
> tmpfs on /tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
> none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
> none on /run/shm type tmpfs (rw,nosuid,nodev)
> none on /run/user type tmpfs (rw,noexec,nosuid,nodev,size=104857600,mode=0755)
> tmpfs on /var/tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> /dev/sda1 on /boot type ext2 (rw)
> binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,noexec,nosuid,nodev)
> rpc_pipefs on /run/rpc_pipefs type rpc_pipefs (rw)
> gvfsd-fuse on /run/user/jj/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,user=jj)
>  >> cd to /mnt/cifs/NETHUN  at: 15:10:06 384996370
>  >> show mount  at: 15:10:06 700739562
> /dev/mapper/ubuntu-root on / type ext4 (rw,noatime,nodiratime,discard,errors=remount-ro)
> proc on /proc type proc (rw,noexec,nosuid,nodev)
> sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
> none on /sys/fs/cgroup type tmpfs (rw)
> none on /sys/fs/fuse/connections type fusectl (rw)
> none on /sys/kernel/debug type debugfs (rw)
> none on /sys/kernel/security type securityfs (rw)
> udev on /dev type devtmpfs (rw,mode=0755)
> devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
> tmpfs on /tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
> none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
> none on /run/shm type tmpfs (rw,nosuid,nodev)
> none on /run/user type tmpfs (rw,noexec,nosuid,nodev,size=104857600,mode=0755)
> tmpfs on /var/tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> /dev/sda1 on /boot type ext2 (rw)
> binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,noexec,nosuid,nodev)
> rpc_pipefs on /run/rpc_pipefs type rpc_pipefs (rw)
> gvfsd-fuse on /run/user/jj/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,user=jj)
> //FRITZ.BOX/FNAS on /mnt/cifs/NETHUN type cifs (rw)
>  >> try to cd/mnt/tc/jj  at: 15:10:06 706983994
> ./testtc.cmd: line 24: cd: /mnt/tc/jj: No such file or directory
>  >> Restarting autofs  at: 15:10:06 710504253
> autofs stop/waiting
> autofs start/running, process 2629
>  >> show mount  at: 15:10:08 375056291
> /dev/mapper/ubuntu-root on / type ext4 (rw,noatime,nodiratime,discard,errors=remount-ro)
> proc on /proc type proc (rw,noexec,nosuid,nodev)
> sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
> none on /sys/fs/cgroup type tmpfs (rw)
> none on /sys/fs/fuse/connections type fusectl (rw)
> none on /sys/kernel/debug type debugfs (rw)
> none on /sys/kernel/security type securityfs (rw)
> udev on /dev type devtmpfs (rw,mode=0755)
> devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
> tmpfs on /tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
> none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
> none on /run/shm type tmpfs (rw,nosuid,nodev)
> none on /run/user type tmpfs (rw,noexec,nosuid,nodev,size=104857600,mode=0755)
> tmpfs on /var/tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> /dev/sda1 on /boot type ext2 (rw)
> binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,noexec,nosuid,nodev)
> rpc_pipefs on /run/rpc_pipefs type rpc_pipefs (rw)
> gvfsd-fuse on /run/user/jj/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,user=jj)
>  >> cd to /mnt/cifs/NETHUN  at: 15:10:08 381028989
>  >> show mount  at: 15:10:08 699377723
> /dev/mapper/ubuntu-root on / type ext4 (rw,noatime,nodiratime,discard,errors=remount-ro)
> proc on /proc type proc (rw,noexec,nosuid,nodev)
> sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
> none on /sys/fs/cgroup type tmpfs (rw)
> none on /sys/fs/fuse/connections type fusectl (rw)
> none on /sys/kernel/debug type debugfs (rw)
> none on /sys/kernel/security type securityfs (rw)
> udev on /dev type devtmpfs (rw,mode=0755)
> devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
> tmpfs on /tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
> none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
> none on /run/shm type tmpfs (rw,nosuid,nodev)
> none on /run/user type tmpfs (rw,noexec,nosuid,nodev,size=104857600,mode=0755)
> tmpfs on /var/tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> /dev/sda1 on /boot type ext2 (rw)
> binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,noexec,nosuid,nodev)
> rpc_pipefs on /run/rpc_pipefs type rpc_pipefs (rw)
> gvfsd-fuse on /run/user/jj/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,user=jj)
> //FRITZ.BOX/FNAS on /mnt/cifs/NETHUN type cifs (rw)
>  >> try to cd/mnt/tc/jj  at: 15:10:08 702421291
>  >> show mount  at: 15:10:09 392452122
> /dev/mapper/ubuntu-root on / type ext4 (rw,noatime,nodiratime,discard,errors=remount-ro)
> proc on /proc type proc (rw,noexec,nosuid,nodev)
> sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
> none on /sys/fs/cgroup type tmpfs (rw)
> none on /sys/fs/fuse/connections type fusectl (rw)
> none on /sys/kernel/debug type debugfs (rw)
> none on /sys/kernel/security type securityfs (rw)
> udev on /dev type devtmpfs (rw,mode=0755)
> devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
> tmpfs on /tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
> none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
> none on /run/shm type tmpfs (rw,nosuid,nodev)
> none on /run/user type tmpfs (rw,noexec,nosuid,nodev,size=104857600,mode=0755)
> tmpfs on /var/tmp type tmpfs (rw,noatime,nodiratime,mode=1777)
> /dev/sda1 on /boot type ext2 (rw)
> binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,noexec,nosuid,nodev)
> rpc_pipefs on /run/rpc_pipefs type rpc_pipefs (rw)
> gvfsd-fuse on /run/user/jj/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,user=jj)
> //FRITZ.BOX/FNAS on /mnt/cifs/NETHUN type cifs (rw)
> truecrypt on /tmp/.truecrypt_aux_mnt1 type fuse.truecrypt (rw,nosuid,nodev,allow_other)
> /dev/mapper/truecrypt1 on /mnt/tc/jj type vfat (rw,uid=0,gid=0,umask=077,gid=100,uid=1000)
>  >> Finished  at: 15:10:09 397882895
> 
> The daemon.log is here:
> Aug 11 15:10:04 A5300 automount[1110]: do_notify_state: signal 15
> Aug 11 15:10:04 A5300 automount[1110]: master_notify_state_change: sig 15 switching /mnt/webdav from 1 to 5
> Aug 11 15:10:04 A5300 automount[1110]: st_prepare_shutdown: state 1 path /mnt/webdav
> Aug 11 15:10:04 A5300 automount[1110]: expire_proc: exp_proc = 140347856316160 path /mnt/webdav
> Aug 11 15:10:04 A5300 automount[1110]: master_notify_state_change: sig 15 switching /mnt/cifs from 1 to 5
> Aug 11 15:10:04 A5300 automount[1110]: master_notify_state_change: sig 15 switching /mnt/tc from 1 to 5
> Aug 11 15:10:04 A5300 automount[1110]: st_prepare_shutdown: state 1 path /mnt/tc
> Aug 11 15:10:04 A5300 automount[1110]: expire_proc: exp_proc = 140347886319360 path /mnt/tc
> Aug 11 15:10:04 A5300 automount[1110]: st_prepare_shutdown: state 1 path /mnt/cifs
> Aug 11 15:10:04 A5300 automount[1110]: expire_proc: exp_proc = 140347752904448 path /mnt/cifs
> Aug 11 15:10:04 A5300 automount[1110]: expire_cleanup: got thid 140347856316160 path /mnt/webdav stat 0
> Aug 11 15:10:04 A5300 automount[1110]: expire_cleanup: sigchld: exp 140347856316160 finished, switching from 5 to 7
> Aug 11 15:10:04 A5300 automount[1110]: st_shutdown: state 5 path /mnt/webdav
> Aug 11 15:10:04 A5300 automount[1110]: expire_cleanup: got thid 140347886319360 path /mnt/tc stat 0
> Aug 11 15:10:04 A5300 automount[1110]: expire_cleanup: sigchld: exp 140347886319360 finished, switching from 5 to 7
> Aug 11 15:10:04 A5300 automount[1110]: st_shutdown: state 5 path /mnt/tc
> Aug 11 15:10:04 A5300 automount[1110]: expire_proc_indirect: expire /mnt/cifs/NETHUN
> Aug 11 15:10:04 A5300 automount[1110]: handle_packet: type = 4
> Aug 11 15:10:04 A5300 automount[1110]: handle_packet_expire_indirect: token 6, name NETHUN
> Aug 11 15:10:04 A5300 automount[1110]: expiring path /mnt/cifs/NETHUN
> Aug 11 15:10:04 A5300 automount[1110]: umount_multi: path /mnt/cifs/NETHUN incl 1
> Aug 11 15:10:04 A5300 automount[1110]: umount_subtree_mounts: unmounting dir = /mnt/cifs/NETHUN
> Aug 11 15:10:04 A5300 automount[1110]: rm_unwanted_fn: removing directory /mnt/cifs/NETHUN
> Aug 11 15:10:04 A5300 automount[1110]: expired /mnt/cifs/NETHUN
> Aug 11 15:10:04 A5300 automount[1110]: dev_ioctl_send_ready: token = 6
> Aug 11 15:10:04 A5300 automount[1110]: expire_cleanup: got thid 140347752904448 path /mnt/cifs stat 0
> Aug 11 15:10:04 A5300 automount[1110]: expire_cleanup: sigchld: exp 140347752904448 finished, switching from 5 to 7
> Aug 11 15:10:04 A5300 automount[1110]: st_shutdown: state 5 path /mnt/cifs
> Aug 11 15:10:04 A5300 automount[1110]: umount_multi: path /mnt/webdav incl 0
> Aug 11 15:10:04 A5300 automount[1110]: umounted indirect mount /mnt/webdav
> Aug 11 15:10:04 A5300 automount[1110]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-webdav
> Aug 11 15:10:04 A5300 automount[1110]: shut down path /mnt/webdav
> Aug 11 15:10:05 A5300 automount[1110]: umount_multi: path /mnt/tc incl 0
> Aug 11 15:10:05 A5300 automount[1110]: umounted indirect mount /mnt/tc
> Aug 11 15:10:05 A5300 automount[1110]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-tc
> Aug 11 15:10:05 A5300 automount[1110]: shut down path /mnt/tc
> Aug 11 15:10:05 A5300 automount[1110]: umount_multi: path /mnt/cifs incl 0
> Aug 11 15:10:05 A5300 automount[1110]: umounted indirect mount /mnt/cifs
> Aug 11 15:10:05 A5300 automount[1110]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-cifs
> Aug 11 15:10:05 A5300 automount[1110]: shut down path /mnt/cifs
> Aug 11 15:10:05 A5300 automount[1110]: autofs stopped
> Aug 11 15:10:05 A5300 automount[2581]: Starting automounter version 5.0.7, master map /etc/auto.master
> Aug 11 15:10:05 A5300 automount[2581]: using kernel protocol version 5.02
> Aug 11 15:10:05 A5300 automount[2581]: lookup_nss_read_master: reading master file /etc/auto.master
> Aug 11 15:10:05 A5300 automount[2581]: lookup_nss_read_master: reading master dir /etc/auto.master.d
> Aug 11 15:10:05 A5300 automount[2581]: lookup_nss_read_master: reading master files auto.master
> Aug 11 15:10:05 A5300 automount[2581]: master_do_mount: mounting /mnt/webdav
> Aug 11 15:10:05 A5300 automount[2581]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-webdav
> Aug 11 15:10:05 A5300 automount[2581]: lookup_nss_read_map: reading map file /etc/auto.webdav
> Aug 11 15:10:05 A5300 automount[2581]: mounted indirect on /mnt/webdav with timeout 300, freq 75 seconds
> Aug 11 15:10:05 A5300 automount[2581]: st_ready: st_ready(): state = 0 path /mnt/webdav
> Aug 11 15:10:05 A5300 automount[2581]: master_do_mount: mounting /mnt/cifs
> Aug 11 15:10:05 A5300 automount[2581]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-cifs
> Aug 11 15:10:05 A5300 automount[2581]: lookup_nss_read_map: reading map file /etc/auto.cifs
> Aug 11 15:10:05 A5300 automount[2581]: mounted indirect on /mnt/cifs with timeout 300, freq 75 seconds
> Aug 11 15:10:05 A5300 automount[2581]: st_ready: st_ready(): state = 0 path /mnt/cifs
> Aug 11 15:10:05 A5300 automount[2581]: master_do_mount: mounting /mnt/tc
> Aug 11 15:10:05 A5300 automount[2581]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-tc
> Aug 11 15:10:05 A5300 automount[2581]: lookup_nss_read_map: reading map file /etc/auto.truecrypt
> Aug 11 15:10:05 A5300 automount[2581]: mounted indirect on /mnt/tc with timeout 300, freq 75 seconds
> Aug 11 15:10:05 A5300 automount[2581]: st_ready: st_ready(): state = 0 path /mnt/tc
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet: type = 3
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet_missing_indirect: token 7, name jj, request pid 2557
> Aug 11 15:10:06 A5300 automount[2581]: attempting to mount entry /mnt/tc/jj
> Aug 11 15:10:06 A5300 automount[2581]: do_mount: /mnt/cifs/NETHUN/Kingston/container.tc /mnt/tc/jj type truecrypt options gid=users,uid=jj,password=pw using module generic
> Aug 11 15:10:06 A5300 automount[2581]: >> Error: No such file or directory:
> Aug 11 15:10:06 A5300 automount[2581]: >> /mnt/cifs/NETHUN/Kingston/container.tc
> Aug 11 15:10:06 A5300 automount[2581]: dev_ioctl_send_fail: token = 7
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet: type = 3
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet_missing_indirect: token 8, name jj, request pid 2557
> Aug 11 15:10:06 A5300 automount[2581]: dev_ioctl_send_fail: token = 8
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet: type = 3
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet_missing_indirect: token 9, name jj, request pid 2557
> Aug 11 15:10:06 A5300 automount[2581]: dev_ioctl_send_fail: token = 9
> Aug 11 15:10:06 A5300 automount[2581]: failed to mount /mnt/tc/jj
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet: type = 3
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet_missing_indirect: token 10, name NETHUN, request pid 2557
> Aug 11 15:10:06 A5300 automount[2581]: attempting to mount entry /mnt/cifs/NETHUN
> Aug 11 15:10:06 A5300 automount[2581]: do_mount: //FRITZ.BOX/FNAS /mnt/cifs/NETHUN type cifs options rw,noperm,credentials=/etc/auto.smb.NETHUN using module generic
> Aug 11 15:10:06 A5300 automount[2581]: dev_ioctl_send_ready: token = 10
> Aug 11 15:10:06 A5300 automount[2581]: mounted /mnt/cifs/NETHUN
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet: type = 3
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet_missing_indirect: token 11, name jj, request pid 2557
> Aug 11 15:10:06 A5300 automount[2581]: dev_ioctl_send_fail: token = 11
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet: type = 3
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet_missing_indirect: token 12, name jj, request pid 2557
> Aug 11 15:10:06 A5300 automount[2581]: dev_ioctl_send_fail: token = 12
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet: type = 3
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet_missing_indirect: token 13, name jj, request pid 2557
> Aug 11 15:10:06 A5300 automount[2581]: dev_ioctl_send_fail: token = 13
> Aug 11 15:10:06 A5300 automount[2581]: do_notify_state: signal 15
> Aug 11 15:10:06 A5300 automount[2581]: master_notify_state_change: sig 15 switching /mnt/webdav from 1 to 5
> Aug 11 15:10:06 A5300 automount[2581]: st_prepare_shutdown: state 1 path /mnt/webdav
> Aug 11 15:10:06 A5300 automount[2581]: expire_proc: exp_proc = 140269975959296 path /mnt/webdav
> Aug 11 15:10:06 A5300 automount[2581]: master_notify_state_change: sig 15 switching /mnt/cifs from 1 to 5
> Aug 11 15:10:06 A5300 automount[2581]: st_prepare_shutdown: state 1 path /mnt/cifs
> Aug 11 15:10:06 A5300 automount[2581]: expire_proc: exp_proc = 140269974906624 path /mnt/cifs
> Aug 11 15:10:06 A5300 automount[2581]: master_notify_state_change: sig 15 switching /mnt/tc from 1 to 5
> Aug 11 15:10:06 A5300 automount[2581]: st_prepare_shutdown: state 1 path /mnt/tc
> Aug 11 15:10:06 A5300 automount[2581]: expire_proc: exp_proc = 140269973853952 path /mnt/tc
> Aug 11 15:10:06 A5300 automount[2581]: expire_proc_indirect: expire /mnt/cifs/NETHUN
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet: type = 4
> Aug 11 15:10:06 A5300 automount[2581]: expire_cleanup: got thid 140269975959296 path /mnt/webdav stat 0
> Aug 11 15:10:06 A5300 automount[2581]: handle_packet_expire_indirect: token 14, name NETHUN
> Aug 11 15:10:06 A5300 automount[2581]: expire_cleanup: sigchld: exp 140269975959296 finished, switching from 5 to 7
> Aug 11 15:10:06 A5300 automount[2581]: st_shutdown: state 5 path /mnt/webdav
> Aug 11 15:10:06 A5300 automount[2581]: expiring path /mnt/cifs/NETHUN
> Aug 11 15:10:06 A5300 automount[2581]: umount_multi: path /mnt/cifs/NETHUN incl 1
> Aug 11 15:10:06 A5300 automount[2581]: expire_cleanup: got thid 140269973853952 path /mnt/tc stat 0
> Aug 11 15:10:06 A5300 automount[2581]: expire_cleanup: sigchld: exp 140269973853952 finished, switching from 5 to 7
> Aug 11 15:10:06 A5300 automount[2581]: umount_subtree_mounts: unmounting dir = /mnt/cifs/NETHUN
> Aug 11 15:10:06 A5300 automount[2581]: st_shutdown: state 5 path /mnt/tc
> Aug 11 15:10:06 A5300 automount[2581]: rm_unwanted_fn: removing directory /mnt/cifs/NETHUN
> Aug 11 15:10:06 A5300 automount[2581]: expired /mnt/cifs/NETHUN
> Aug 11 15:10:06 A5300 automount[2581]: dev_ioctl_send_ready: token = 14
> Aug 11 15:10:06 A5300 automount[2581]: expire_cleanup: got thid 140269974906624 path /mnt/cifs stat 0
> Aug 11 15:10:06 A5300 automount[2581]: expire_cleanup: sigchld: exp 140269974906624 finished, switching from 5 to 7
> Aug 11 15:10:06 A5300 automount[2581]: st_shutdown: state 5 path /mnt/cifs
> Aug 11 15:10:06 A5300 automount[2581]: umount_multi: path /mnt/webdav incl 0
> Aug 11 15:10:06 A5300 automount[2581]: umounted indirect mount /mnt/webdav
> Aug 11 15:10:06 A5300 automount[2581]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-webdav
> Aug 11 15:10:06 A5300 automount[2581]: shut down path /mnt/webdav
> Aug 11 15:10:07 A5300 automount[2581]: umount_multi: path /mnt/tc incl 0
> Aug 11 15:10:07 A5300 automount[2581]: umounted indirect mount /mnt/tc
> Aug 11 15:10:07 A5300 automount[2581]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-tc
> Aug 11 15:10:07 A5300 automount[2581]: shut down path /mnt/tc
> Aug 11 15:10:07 A5300 automount[2581]: umount_multi: path /mnt/cifs incl 0
> Aug 11 15:10:07 A5300 automount[2581]: umounted indirect mount /mnt/cifs
> Aug 11 15:10:07 A5300 automount[2581]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-cifs
> Aug 11 15:10:07 A5300 automount[2581]: shut down path /mnt/cifs
> Aug 11 15:10:07 A5300 automount[2581]: autofs stopped
> Aug 11 15:10:07 A5300 automount[2629]: Starting automounter version 5.0.7, master map /etc/auto.master
> Aug 11 15:10:07 A5300 automount[2629]: using kernel protocol version 5.02
> Aug 11 15:10:07 A5300 automount[2629]: lookup_nss_read_master: reading master file /etc/auto.master
> Aug 11 15:10:07 A5300 automount[2629]: lookup_nss_read_master: reading master dir /etc/auto.master.d
> Aug 11 15:10:07 A5300 automount[2629]: lookup_nss_read_master: reading master files auto.master
> Aug 11 15:10:07 A5300 automount[2629]: master_do_mount: mounting /mnt/webdav
> Aug 11 15:10:07 A5300 automount[2629]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-webdav
> Aug 11 15:10:07 A5300 automount[2629]: lookup_nss_read_map: reading map file /etc/auto.webdav
> Aug 11 15:10:07 A5300 automount[2629]: mounted indirect on /mnt/webdav with timeout 300, freq 75 seconds
> Aug 11 15:10:07 A5300 automount[2629]: st_ready: st_ready(): state = 0 path /mnt/webdav
> Aug 11 15:10:07 A5300 automount[2629]: master_do_mount: mounting /mnt/cifs
> Aug 11 15:10:07 A5300 automount[2629]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-cifs
> Aug 11 15:10:07 A5300 automount[2629]: lookup_nss_read_map: reading map file /etc/auto.cifs
> Aug 11 15:10:07 A5300 automount[2629]: mounted indirect on /mnt/cifs with timeout 300, freq 75 seconds
> Aug 11 15:10:07 A5300 automount[2629]: st_ready: st_ready(): state = 0 path /mnt/cifs
> Aug 11 15:10:07 A5300 automount[2629]: master_do_mount: mounting /mnt/tc
> Aug 11 15:10:07 A5300 automount[2629]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-tc
> Aug 11 15:10:07 A5300 automount[2629]: lookup_nss_read_map: reading map file /etc/auto.truecrypt
> Aug 11 15:10:07 A5300 automount[2629]: mounted indirect on /mnt/tc with timeout 300, freq 75 seconds
> Aug 11 15:10:07 A5300 automount[2629]: st_ready: st_ready(): state = 0 path /mnt/tc
> Aug 11 15:10:08 A5300 automount[2629]: handle_packet: type = 3
> Aug 11 15:10:08 A5300 automount[2629]: handle_packet_missing_indirect: token 15, name NETHUN, request pid 2557
> Aug 11 15:10:08 A5300 automount[2629]: attempting to mount entry /mnt/cifs/NETHUN
> Aug 11 15:10:08 A5300 automount[2629]: do_mount: //FRITZ.BOX/FNAS /mnt/cifs/NETHUN type cifs options rw,noperm,credentials=/etc/auto.smb.NETHUN using module generic
> Aug 11 15:10:08 A5300 automount[2629]: dev_ioctl_send_ready: token = 15
> Aug 11 15:10:08 A5300 automount[2629]: mounted /mnt/cifs/NETHUN
> Aug 11 15:10:08 A5300 automount[2629]: handle_packet: type = 3
> Aug 11 15:10:08 A5300 automount[2629]: handle_packet_missing_indirect: token 16, name jj, request pid 2557
> Aug 11 15:10:08 A5300 automount[2629]: attempting to mount entry /mnt/tc/jj
> Aug 11 15:10:08 A5300 automount[2629]: do_mount: /mnt/cifs/NETHUN/Kingston/container.tc /mnt/tc/jj type truecrypt options gid=users,uid=jj,password=pw using module generic
> Aug 11 15:10:09 A5300 automount[2629]: >> Volume "/mnt/cifs/NETHUN/Kingston/container.tc" has been mounted.
> Aug 11 15:10:09 A5300 automount[2629]: dev_ioctl_send_ready: token = 16
> Aug 11 15:10:09 A5300 automount[2629]: mounted /mnt/tc/jj
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


