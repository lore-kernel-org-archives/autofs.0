From: Ian Kent <raven@themaw.net>
Subject: Re: Automounter stops after reload signal.
Date: Sun, 12 Apr 2009 22:08:35 +0800
Message-ID: <1239545315.23791.0.camel@zeus.themaw.net>
References: <49DCCD73.5050307@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49DCCD73.5050307@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

On Wed, 2009-04-08 at 18:14 +0200, Stef Bon wrote:
> Hello,
> 
> I've been working on a construction which adds an autofs managed 
> mountpoint to the homedirectory, when:
> a. an usb device or more than one is detected when logging in
> b. an usb device is plugged in during a session

What version of autofs did you say you are using?

> 
> This looks like:
> 
> /home/sbon/Connections
> 
> is the base directory for all kinds of connections (network, all kind of 
> hardware)
> Earlier I've been working on a construction to create a browseable 
> network map here, also with autofs.
> Network resources like SMB shares, FTP servers and SSH access is 
> possible. (SMB via cifs, FTP via curlftpfs/FUSE, SSH via sshfs/FUSE). 
> Access to Novell networks should also be possible.
> 
> Now about devices. When I add a device during my session, the (virtual) 
> directory Devices is added, and therein my USB stick:
> 
> /home/sbon/Connections/Devices/USB_DISK_Pro
> 
> Other devices should also appear in this directory.
> I do not have published this yet anywhere, but it is simular to the one 
> you can find here:
> 
> http://www.gentoo-wiki.info/Autofs#UDEV_with_autofs
> 
> The big difference with my construction is that the mountpoint is *in* 
> the users homedirectory, not in /media: direct accessible for users from 
> their homedirectory, where going to a "foreign" place like /media is not 
> that userfriendly.
> 
> Now I've got the following situation:
> 
> my mastermap looks like:
> 
> /mnt/sd /etc/autofs/auto.sd --timeout=50
> 
> +/var/run/autofs/auto.master
> 
> 
> and /var/run/autofs/auto.master:
> 
> /home/sbon/Connections/Network     
> /var/run/autofs/session/auto.network.map.sbon --ghost
> /home/sbon/Connections/Devices /var/run/autofs/session/auto.usb.map.sbon 
> --ghost
> 
> the automaps are dynamically created maps:
> /var/run/autofs/session/auto.usb.map.sbon:
> 
> USB_DISK_Pro -fstype=auto :/dev/disk/by-uuid/6891-3786
> 
> and /var/run/autofs/session/auto.network.map.sbon:
> 
> "FTP" -fstype=ftpfs \
>       /192.168.0.1 ://192.168.0.1 \
>       /ftp-stud.fht-esslingen.de ://ftp-stud.fht-esslingen.de
> "Windows Network" 
> -fstype=cifs,credentials="/var/run/safe/sbon/latest/mount.smb.cred" \
>       "/BONONLINE/ROUTER/sbon" -rw,ip=192.168.0.1 "://ROUTER/sbon" \
>       "/BONONLINE/ROUTER/bononline" -rw,ip=192.168.0.1 
> "://ROUTER/bononline" \
>       "/BONONLINE/ROUTER/mvanklink" -rw,ip=192.168.0.1 
> "://ROUTER/mvanklink" \
>       "/BONONLINE/ROUTER/ftp" -rw,ip=192.168.0.1 "://ROUTER/ftp" \
>       "/BONONLINE/ROUTER/public" -rw,ip=192.168.0.1 "://ROUTER/public" \
>       "/BONONLINE/ROUTER/cwdocumenten" -rw,ip=192.168.0.1 
> "://ROUTER/cwdocumenten" \
>       "/BONONLINE/LFS20060812/sbon" -rw,ip=192.168.0.2 
> "://LFS20060812/sbon" \
>       "/BONONLINE/LFS20060812/bononline" -rw,ip=192.168.0.2 
> "://LFS20060812/bononline" \
>       "/BONONLINE/LFS20060812/video" -rw,ip=192.168.0.2 
> "://LFS20060812/video" \
>       "/BONONLINE/LFS20060812/test" -rw,ip=192.168.0.2 
> "://LFS20060812/test" \
>       "/BONONLINE/LFS20060812/public" -rw,ip=192.168.0.2 
> "://LFS20060812/public"
> "SSH access" -fstype=sshfs \
>       "/192.168.0.1" "://sbon@192.168.0.1:/" \
>       "/192.168.0.2" "://sbon@192.168.0.2:/"
> 
> These maps are created dynamically, by udev (when plugging in a device) 
> and at login (coldpluggin and the networkmap)
> There is a script which is run by udev when a device is removed.
> 
> After removal of the usbstick, my maps look like:
> 
> /var/run/autofs/auto.master
> 
> /home/sbon/Connections/Network     
> /var/run/autofs/session/auto.network.map.sbon --ghost
> 
> The networkmap is unchanged.
> 
> After a reload the automounter has stopped. Attached is the relevant 
> output of the logfile.
> 
> This behaviour I get also in siumlar situations. For example, logging in 
> as sbon, adding a device, then logging in as root in a terminal(konsole 
> and then su), everything is still ok (the maps above are changed: 
> mountpoints and maps are added. But when logging out as root, and the 
> maps are changed again, the automounter stops also.
> 
> It looks like the automounter cannot handle the removal of mountpoints 
> correctly. It will stop.
> 
> 
> Stef Bon
> 
> 
> 
> 
> 
> plain text document attachment (automount.stop.log)
> 2009-04-08T13:08:40.686693+02:00 lfs20080510 kernel:<6>usb 6-1.3: USB disconnect, address 4
> 2009-04-08T13:08:40.714507+02:00 lfs20080510 : The configuration file /etc/autofs.usersession.conf found.
> 2009-04-08T13:08:40.716559+02:00 lfs20080510 : Parameter DEVICES_NAME not set. Using default.
> 2009-04-08T13:08:40.770432+02:00 lfs20080510 automount[5948]: re-reading master map /etc/autofs/auto.master
> 2009-04-08T13:08:40.770586+02:00 lfs20080510 automount[5948]: lookup_nss_read_master: reading master file /etc/autofs/auto.master
> 2009-04-08T13:08:40.770645+02:00 lfs20080510 automount[5948]: parse_init: parse(sun): init gathered global options: (null)
> 2009-04-08T13:08:40.770723+02:00 lfs20080510 automount[5948]: lookup_read_master: lookup(file): read entry /mnt/sd
> 2009-04-08T13:08:40.770791+02:00 lfs20080510 automount[5948]: lookup_read_master: lookup(file): read entry +/var/run/autofs/auto.master
> 2009-04-08T13:08:40.770826+02:00 lfs20080510 automount[5948]: lookup_nss_read_master: reading master file /var/run/autofs/auto.master
> 2009-04-08T13:08:40.770868+02:00 lfs20080510 automount[5948]: parse_init: parse(sun): init gathered global options: (null)
> 2009-04-08T13:08:40.770915+02:00 lfs20080510 automount[5948]: lookup_read_master: lookup(file): read entry /home/sbon/Connections/Network
> 2009-04-08T13:08:40.772530+02:00 lfs20080510 automount[5948]: st_readmap: state 1 path /mnt/sd
> 2009-04-08T13:08:40.772572+02:00 lfs20080510 automount[5948]: re-reading map for /mnt/sd
> 2009-04-08T13:08:40.772612+02:00 lfs20080510 automount[5948]: st_readmap: state 1 path /home/sbon/Connections/Network
> 2009-04-08T13:08:40.772655+02:00 lfs20080510 automount[5948]: re-reading map for /home/sbon/Connections/Network
> 2009-04-08T13:08:40.772948+02:00 lfs20080510 automount[5948]: lookup_nss_read_map: reading map file /etc/autofs/auto.sd
> 2009-04-08T13:08:40.772975+02:00 lfs20080510 automount[5948]: parse_init: parse(sun): init gathered global options: (null)
> 2009-04-08T13:08:40.772998+02:00 lfs20080510 automount[5948]: st_ready: st_ready(): state = 4 path /mnt/sd
> 2009-04-08T13:08:40.773021+02:00 lfs20080510 automount[5948]: lookup_nss_read_map: reading map file /var/run/autofs/session/auto.network.map.sbon
> 2009-04-08T13:08:40.773044+02:00 lfs20080510 automount[5948]: parse_init: parse(sun): init gathered global options: (null)
> 2009-04-08T13:08:40.773067+02:00 lfs20080510 automount[5948]: st_ready: st_ready(): state = 4 path /home/sbon/Connections/Network
> 2009-04-08T13:08:40.773103+02:00 lfs20080510 automount[5948]: st_prepare_shutdown: state 1 path /home/sbon/Connections/Devices
> 2009-04-08T13:08:40.773141+02:00 lfs20080510 automount[5948]: expire_proc: exp_proc = 3051350928 path /home/sbon/Connections/Devices
> 2009-04-08T13:08:40.773323+02:00 lfs20080510 automount[5948]: expire_cleanup: got thid 3051350928 path /home/sbon/Connections/Devices stat 0
> 2009-04-08T13:08:40.773360+02:00 lfs20080510 automount[5948]: expire_cleanup: sigchld: exp 3051350928 finished, switching from 5 to 7
> 2009-04-08T13:08:40.773394+02:00 lfs20080510 automount[5948]: st_shutdown: state 5 path /home/sbon/Connections/Devices
> 2009-04-08T13:08:40.973483+02:00 lfs20080510 automount[5948]: umount_multi: path /home/sbon/Connections/Devices incl 0
> 2009-04-08T13:08:40.973568+02:00 lfs20080510 automount[5948]: rm_unwanted_fn: removing directory /home/sbon/Connections/Devices/USB_DISK_Pro
> 2009-04-08T13:08:40.973847+02:00 lfs20080510 automount[5948]: umounted indirect mount /home/sbon/Connections/Devices
> 2009-04-08T13:08:40.973864+02:00 lfs20080510 automount[5948]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-home-sbon-Connections-Devices
> 2009-04-08T13:08:40.973916+02:00 lfs20080510 automount[5948]: shut down path /home/sbon/Connections/Devices
> 2009-04-08T13:08:40.973978+02:00 lfs20080510 automount[5948]: do_notify_state: signal 15
> 2009-04-08T13:08:40.973989+02:00 lfs20080510 automount[5948]: master_notify_state_change: sig 15 switching /mnt/sd from 1 to 5
> 2009-04-08T13:08:40.973997+02:00 lfs20080510 automount[5948]: master_notify_state_change: sig 15 switching /home/sbon/Connections/Network from 1 to 5
> 2009-04-08T13:08:40.974012+02:00 lfs20080510 automount[5948]: st_prepare_shutdown: state 1 path /home/sbon/Connections/Network
> 2009-04-08T13:08:40.974031+02:00 lfs20080510 automount[5948]: expire_proc: exp_proc = 3051350928 path /home/sbon/Connections/Network
> 2009-04-08T13:08:40.974127+02:00 lfs20080510 automount[5948]: expire_proc_indirect: expire /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/public
> 2009-04-08T13:08:40.974150+02:00 lfs20080510 automount[5948]: st_prepare_shutdown: state 1 path /mnt/sd
> 2009-04-08T13:08:40.974159+02:00 lfs20080510 automount[5948]: handle_packet: type = 6
> 2009-04-08T13:08:40.974169+02:00 lfs20080510 automount[5948]: handle_packet_expire_direct: token 273, name /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/public
> 2009-04-08T13:08:40.974183+02:00 lfs20080510 automount[5948]: expire_proc: exp_proc = 3066383248 path /mnt/sd
> 2009-04-08T13:08:40.974967+02:00 lfs20080510 automount[5948]: expiring path /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/public
> 2009-04-08T13:08:40.974974+02:00 lfs20080510 automount[5948]: umount_multi: path /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/public incl 1
> 2009-04-08T13:08:40.974978+02:00 lfs20080510 automount[5948]: unmounting dir = /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/public
> 2009-04-08T13:08:40.975015+02:00 lfs20080510 automount[5948]: expire_cleanup: got thid 3066383248 path /mnt/sd stat 0
> 2009-04-08T13:08:40.975023+02:00 lfs20080510 automount[5948]: expire_cleanup: sigchld: exp 3066383248 finished, switching from 5 to 7
> 2009-04-08T13:08:40.975027+02:00 lfs20080510 automount[5948]: st_shutdown: state 5 path /mnt/sd
> 2009-04-08T13:08:40.976955+02:00 lfs20080510 automount[5948]: expired /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/public
> 2009-04-08T13:08:40.976973+02:00 lfs20080510 automount[5948]: dev_ioctl_send_ready: token = 273
> 2009-04-08T13:08:41.077208+02:00 lfs20080510 automount[5948]: handle_packet: type = 4
> 2009-04-08T13:08:41.077228+02:00 lfs20080510 automount[5948]: handle_packet_expire_indirect: token 274, name Windows Network
> 2009-04-08T13:08:41.077263+02:00 lfs20080510 automount[5948]: expiring path /home/sbon/Connections/Network/Windows Network
> 2009-04-08T13:08:41.077277+02:00 lfs20080510 automount[5948]: umount_multi: path /home/sbon/Connections/Network/Windows Network incl 1
> 2009-04-08T13:08:41.077312+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/bononline
> 2009-04-08T13:08:41.077547+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/bononline
> 2009-04-08T13:08:41.077569+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/public
> 2009-04-08T13:08:41.077693+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/public
> 2009-04-08T13:08:41.077713+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/sbon
> 2009-04-08T13:08:41.077829+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/sbon
> 2009-04-08T13:08:41.077849+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/test
> 2009-04-08T13:08:41.077962+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/test
> 2009-04-08T13:08:41.077982+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/video
> 2009-04-08T13:08:41.078091+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/video
> 2009-04-08T13:08:41.078110+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/bononline
> 2009-04-08T13:08:41.078215+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/bononline
> 2009-04-08T13:08:41.078234+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/cwdocumenten
> 2009-04-08T13:08:41.078336+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/cwdocumenten
> 2009-04-08T13:08:41.078355+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/ftp
> 2009-04-08T13:08:41.078454+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/ftp
> 2009-04-08T13:08:41.078473+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/mvanklink
> 2009-04-08T13:08:41.078568+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/mvanklink
> 2009-04-08T13:08:41.078587+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/public
> 2009-04-08T13:08:41.078681+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/public
> 2009-04-08T13:08:41.078700+02:00 lfs20080510 automount[5948]: umount_multi_triggers: umount offset /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/sbon
> 2009-04-08T13:08:41.078789+02:00 lfs20080510 automount[5948]: umounted offset mount /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/sbon
> 2009-04-08T13:08:41.078809+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/bononline
> 2009-04-08T13:08:41.078826+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/public
> 2009-04-08T13:08:41.078841+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/sbon
> 2009-04-08T13:08:41.078856+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/test
> 2009-04-08T13:08:41.078870+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812/video
> 2009-04-08T13:08:41.078885+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/bononline
> 2009-04-08T13:08:41.078900+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/cwdocumenten
> 2009-04-08T13:08:41.078914+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/ftp
> 2009-04-08T13:08:41.078929+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/mvanklink
> 2009-04-08T13:08:41.078943+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/public
> 2009-04-08T13:08:41.078958+02:00 lfs20080510 automount[5948]: cache_delete_offset_list: deleting offset key /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER/sbon
> 2009-04-08T13:08:41.078998+02:00 lfs20080510 automount[5948]: rm_unwanted_fn: removing directory /home/sbon/Connections/Network/Windows Network/BONONLINE/ROUTER
> 2009-04-08T13:08:41.079025+02:00 lfs20080510 automount[5948]: rm_unwanted_fn: removing directory /home/sbon/Connections/Network/Windows Network/BONONLINE/LFS20060812
> 2009-04-08T13:08:41.079045+02:00 lfs20080510 automount[5948]: rm_unwanted_fn: removing directory /home/sbon/Connections/Network/Windows Network/BONONLINE
> 2009-04-08T13:08:41.079063+02:00 lfs20080510 automount[5948]: rm_unwanted_fn: removing directory /home/sbon/Connections/Network/Windows Network
> 2009-04-08T13:08:41.079078+02:00 lfs20080510 automount[5948]: expired /home/sbon/Connections/Network/Windows Network
> 2009-04-08T13:08:41.079091+02:00 lfs20080510 automount[5948]: dev_ioctl_send_ready: token = 274
> 2009-04-08T13:08:41.079117+02:00 lfs20080510 automount[5948]: handle_packet: type = 3
> 2009-04-08T13:08:41.175131+02:00 lfs20080510 automount[5948]: umount_multi: path /mnt/sd incl 0
> 2009-04-08T13:08:41.175324+02:00 lfs20080510 automount[5948]: umounted indirect mount /mnt/sd
> 2009-04-08T13:08:41.175342+02:00 lfs20080510 automount[5948]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-mnt-sd
> 2009-04-08T13:08:41.175376+02:00 lfs20080510 automount[5948]: handle_packet_missing_indirect: token 275, name Windows Network, request pid 4115
> 2009-04-08T13:08:41.175401+02:00 lfs20080510 automount[5948]: shut down path /mnt/sd
> 2009-04-08T13:08:41.175431+02:00 lfs20080510 automount[5948]: dev_ioctl_send_fail: token = 275
> 2009-04-08T13:08:41.175494+02:00 lfs20080510 automount[5948]: handle_packet: type = 3
> 2009-04-08T13:08:41.175539+02:00 lfs20080510 automount[5948]: handle_packet_missing_indirect: token 276, name Windows Network, request pid 4115
> 2009-04-08T13:08:41.175564+02:00 lfs20080510 automount[5948]: do_notify_state: signal 15
> 2009-04-08T13:08:41.175574+02:00 lfs20080510 automount[5948]: dev_ioctl_send_fail: token = 276
> 2009-04-08T13:08:41.179184+02:00 lfs20080510 automount[5948]: expire_cleanup: got thid 3051350928 path /home/sbon/Connections/Network stat 0
> 2009-04-08T13:08:41.179211+02:00 lfs20080510 automount[5948]: expire_cleanup: sigchld: exp 3051350928 finished, switching from 5 to 7
> 2009-04-08T13:08:41.179236+02:00 lfs20080510 automount[5948]: st_shutdown: state 5 path /home/sbon/Connections/Network
> 2009-04-08T13:08:41.379363+02:00 lfs20080510 automount[5948]: umount_multi: path /home/sbon/Connections/Network incl 0
> 2009-04-08T13:08:41.379435+02:00 lfs20080510 automount[5948]: rm_unwanted_fn: removing directory /home/sbon/Connections/Network/SSH access
> 2009-04-08T13:08:41.379465+02:00 lfs20080510 automount[5948]: rm_unwanted_fn: removing directory /home/sbon/Connections/Network/FTP
> 2009-04-08T13:08:41.379645+02:00 lfs20080510 automount[5948]: umounted indirect mount /home/sbon/Connections/Network
> 2009-04-08T13:08:41.379662+02:00 lfs20080510 automount[5948]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-home-sbon-Connections-Network
> 2009-04-08T13:08:41.379690+02:00 lfs20080510 automount[5948]: shut down path /home/sbon/Connections/Network
> 2009-04-08T13:08:41.379791+02:00 lfs20080510 automount[5948]: autofs stopped
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
