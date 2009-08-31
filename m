From: "Jason T. Masker" <jason.fmic@masker.net>
Subject: Re: More CIFS $ Share Woes
Date: Mon, 31 Aug 2009 08:22:36 -0400
Message-ID: <85c7eb2d0908310522u18907b17pd1399a1cf79ad1e5@mail.gmail.com>
References: <85c7eb2d0908280709u35cd5cfci7f50413da61539e7@mail.gmail.com>
	<4A9B5274.4040800@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A9B5274.4040800@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian,

Unfortunately, without the double escape, the $ doesn't survive
parse_mount.  Here is a debug with the gsub line removed:

Starting automounter version 5.0.4-36, master map auto.master
using kernel protocol version 5.01
lookup_nss_read_master: reading master files auto.master
parse_init: parse(sun): init gathered global options: (null)
lookup_read_master: lookup(file): read entry /misc
lookup_read_master: lookup(file): read entry /net
lookup_read_master: lookup(file): read entry /cifs
lookup_read_master: lookup(file): read entry +auto.master
lookup_nss_read_master: reading master files auto.master
parse_init: parse(sun): init gathered global options: (null)
lookup_nss_read_master: reading master nisplus auto.master
parse_init: parse(sun): init gathered global options: (null)
lookup_read_master: lookup(nisplus): couldn't locate nis+ table auto.master
lookup(file): failed to read included master map auto.master
master_do_mount: mounting /misc
automount_path_to_fifo: fifo name /var/run/autofs.fifo-misc
lookup_nss_read_map: reading map file /etc/auto.misc
parse_init: parse(sun): init gathered global options: (null)
remount_active_mount: trying to re-connect to mount /misc
mounted indirect on /misc with timeout 300, freq 75 seconds
remount_active_mount: re-connected to mount /misc
st_ready: st_ready(): state = 0 path /misc
master_do_mount: mounting /net
automount_path_to_fifo: fifo name /var/run/autofs.fifo-net
lookup_nss_read_map: reading map hosts (null)
parse_init: parse(sun): init gathered global options: (null)
remount_active_mount: trying to re-connect to mount /net
mounted indirect on /net with timeout 300, freq 75 seconds
remount_active_mount: re-connected to mount /net
st_ready: st_ready(): state = 0 path /net
master_do_mount: mounting /cifs
automount_path_to_fifo: fifo name /var/run/autofs.fifo-cifs
lookup_nss_read_map: reading map file /etc/auto.cifs
parse_init: parse(sun): init gathered global options: (null)
remount_active_mount: trying to re-connect to mount /cifs
mounted indirect on /cifs with timeout 60, freq 15 seconds
remount_active_mount: re-connected to mount /cifs
st_ready: st_ready(): state = 0 path /cifs
handle_packet: type = 3
handle_packet_missing_indirect: token 16, name VMW1013, request pid 14020
attempting to mount entry /cifs/VMW1013
lookup_mount: lookup(program): looking up VMW1013
lookup_mount: lookup(program): VMW1013 ->
-fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
     "/My Documents" "://VMW1013/My Documents"      "/ADMIN$"
"://VMW1013/ADMIN$"    "/C$" "://VMW1013/C$"           "/Shared"
"://VMW1013/Shared"
parse_mount: parse(sun): expanded entry:
-fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
      "/My Documents" "://VMW1013/My Documents"      "/ADMIN$"
"://VMW1013/ADMIN$"    "/C$" "://VMW1013/C$"           "/Shared"
"://VMW1013/Shared"
parse_mount: parse(sun): gathered options:
fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
parse_mount: parse(sun): dequote(""/My Documents"") -> /My Documents
parse_mapent: parse(sun): gathered options:
fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
parse_mapent: parse(sun): dequote(""://VMW1013/My Documents"") ->
://VMW1013/My Documents
add_offset_entry: parse(sun): added multi-mount offset /My Documents
-> -fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
://VMW1013/My Documents
parse_mount: parse(sun): dequote(""/ADMIN$"") -> /ADMIN$
parse_mapent: parse(sun): gathered options:
fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
parse_mapent: parse(sun): dequote(""://VMW1013/ADMIN$"") ->
://VMW1013/ADMIN$
add_offset_entry: parse(sun): added multi-mount offset /ADMIN$ ->
-fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
://VMW1013/ADMIN$
parse_mount: parse(sun): dequote(""/C$"") -> /C$
parse_mapent: parse(sun): gathered options:
fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
parse_mapent: parse(sun): dequote(""://VMW1013/C$"") -> ://VMW1013/C$
add_offset_entry: parse(sun): added multi-mount offset /C$ ->
-fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
://VMW1013/C$
parse_mount: parse(sun): dequote(""/Shared"") -> /Shared
parse_mapent: parse(sun): gathered options:
fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
parse_mapent: parse(sun): dequote(""://VMW1013/Shared"") ->
://VMW1013/Shared
add_offset_entry: parse(sun): added multi-mount offset /Shared ->
-fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
://VMW1013/Shared
mount_multi_triggers: mount offset /cifs/VMW1013/ADMIN$ at
/cifs/VMW1013
mount_autofs_offset: calling mount -t autofs -s  -o
fd=19,pgrp=14313,minproto=5,maxproto=5,offset automount
/cifs/VMW1013/ADMIN$
mounted offset on /cifs/VMW1013/ADMIN$ with timeout 60, freq 15
seconds
mount_autofs_offset: mounted trigger /cifs/VMW1013/ADMIN$ at
/cifs/VMW1013/ADMIN$
mount_multi_triggers: mount offset /cifs/VMW1013/C$ at /cifs/VMW1013
mount_autofs_offset: calling mount -t autofs -s  -o
fd=19,pgrp=14313,minproto=5,maxproto=5,offset automount
/cifs/VMW1013/C$
mounted offset on /cifs/VMW1013/C$ with timeout 60, freq 15 seconds
mount_autofs_offset: mounted trigger /cifs/VMW1013/C$ at
/cifs/VMW1013/C$
mount_multi_triggers: mount offset /cifs/VMW1013/My Documents at
/cifs/VMW1013
mount_autofs_offset: calling mount -t autofs -s  -o
fd=19,pgrp=14313,minproto=5,maxproto=5,offset automount
/cifs/VMW1013/My Documents
mounted offset on /cifs/VMW1013/My Documents with timeout 60, freq 15
seconds
mount_autofs_offset: mounted trigger /cifs/VMW1013/My Documents at
/cifs/VMW1013/My Documents
mount_multi_triggers: mount offset /cifs/VMW1013/Shared at
/cifs/VMW1013
mount_autofs_offset: calling mount -t autofs -s  -o
fd=19,pgrp=14313,minproto=5,maxproto=5,offset automount
/cifs/VMW1013/Shared
mounted offset on /cifs/VMW1013/Shared with timeout 60, freq 15
seconds
mount_autofs_offset: mounted trigger /cifs/VMW1013/Shared at
/cifs/VMW1013/Shared
dev_ioctl_send_ready: token = 16
handle_packet: type = 5
handle_packet_missing_direct: token 17, name /cifs/VMW1013/C$, request
pid 14020
mounted /cifs/VMW1013
attempting to mount entry /cifs/VMW1013/C$
lookup_mount: lookup(program): /cifs/VMW1013/C$ ->
-fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
://VMW1013/C$
parse_mount: parse(sun): expanded entry:
-fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
://VMW1013/C
parse_mount: parse(sun): gathered options:
fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
parse_mount: parse(sun): core of entry:
options=fstype=cifs,file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker,
loc=://VMW1013/C
sun_mount: parse(sun): mounting root /tmp/autokYGbOn, mountpoint
/cifs/VMW1013/C$, what //VMW1013/C, fstype cifs, options
file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
do_mount: //VMW1013/C /cifs/VMW1013/C$ type cifs options
file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
using module generic
mount_mount: mount(generic): calling mkdir_path /tmp/autokYGbOn
mount_mount: mount(generic): calling mount -t cifs -s -o
file_mode=0644,dir_mode=0755,uid=jmasker,gid=users,credentials=/etc/auto.smb.jmasker
//VMW1013/C /tmp/autokYGbOn
>> retrying with upper case share name
>> mount error(6): No such device or address
>> Refer to the mount.cifs(8) manual page (e.g.man mount.cifs)
mount(generic): failed to mount //VMW1013/C (type cifs) on
/tmp/autokYGbOn
dev_ioctl_send_fail: token = 17
failed to mount /cifs/VMW1013/C$
handle_packet: type = 5
handle_packet_missing_direct: token 18, name /cifs/VMW1013/C$, request
pid 14020
attempting to mount entry /cifs/VMW1013/C$
dev_ioctl_send_fail: token = 18
failed to mount /cifs/VMW1013/C$
^Cdo_notify_state: signal 2
master_notify_state_change: sig 2 switching /misc from 1 to 5
st_prepare_shutdown: state 1 path /misc
expire_proc: exp_proc = 3049257840 path /misc
master_notify_state_change: sig 2 switching /net from 1 to 5
expire_cleanup: got thid 3049257840 path /misc stat 0
expire_cleanup: sigchld: exp 3049257840 finished, switching from 5 to 7
st_shutdown: state 5 path /misc
master_notify_state_change: sig 2 switching /cifs from 1 to 5
st_prepare_shutdown: state 1 path /cifs
expire_proc: exp_proc = 3048205168 path /cifs
handle_packet: type = 4
handle_packet_expire_indirect: token 19, name VMW1013
st_prepare_shutdown: state 1 path /net
expire_proc: exp_proc = 3047152496 path /net
expire_cleanup: got thid 3047152496 path /net stat 0
expire_cleanup: sigchld: exp 3047152496 finished, switching from 5 to 7
st_shutdown: state 5 path /net
expiring path /cifs/VMW1013
umount_multi: path /cifs/VMW1013 incl 1
umount_multi_triggers: umount offset /cifs/VMW1013/ADMIN$
umounted offset mount /cifs/VMW1013/ADMIN$
umount_multi_triggers: umount offset /cifs/VMW1013/C$
umounted offset mount /cifs/VMW1013/C$
umount_multi_triggers: umount offset /cifs/VMW1013/My Documents
umounted offset mount /cifs/VMW1013/My Documents
umount_multi_triggers: umount offset /cifs/VMW1013/Shared
umounted offset mount /cifs/VMW1013/Shared
cache_delete_offset_list: deleting offset key /cifs/VMW1013/ADMIN$
cache_delete_offset_list: deleting offset key /cifs/VMW1013/C$
cache_delete_offset_list: deleting offset key /cifs/VMW1013/My Documents
cache_delete_offset_list: deleting offset key /cifs/VMW1013/Shared
rm_unwanted_fn: removing directory /cifs/VMW1013
expired /cifs/VMW1013
dev_ioctl_send_ready: token = 19
expire_cleanup: got thid 3048205168 path /cifs stat 0
expire_cleanup: sigchld: exp 3048205168 finished, switching from 5 to 7
st_shutdown: state 5 path /cifs
umount_multi: path /misc incl 0
umounted indirect mount /misc
automount_path_to_fifo: fifo name /var/run/autofs.fifo-misc
shut down path /misc
umount_multi: path /net incl 0
umounted indirect mount /net
automount_path_to_fifo: fifo name /var/run/autofs.fifo-net
shut down path /net
umount_multi: path /cifs incl 0
umounted indirect mount /cifs
automount_path_to_fifo: fifo name /var/run/autofs.fifo-cifs
shut down path /cifs
autofs stopped
