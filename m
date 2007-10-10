From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: nested automounts: bind and nfs
Date: Wed, 10 Oct 2007 16:15:57 +0200
Message-ID: <1192025757.27076.31.camel@sangay.TechFak.Uni-Bielefeld.DE>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
	<1191321007.27255.12.camel@localhost>
	<1191332917.26331.171.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1191332917.26331.171.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian, Jeff and list,

> The mount command looks fine to me but mount(8) is failing.
> I'm not sure what's in the kernel your running, checking that would
> probably be a good idea, where can I find the source for it?


> The other thing is that it looks like the bind mount isn't triggering
> the dependent mount which implies that the "--disable-mount-locking"
> isn't being used with configure.

There's an updated package in 
http://packages.techfak.uni-bielefeld.de/pool/techfak-testing/a/autofs5/autofs5_5.0.2-5.diff.gz - the only change being adding --disable-mount-locking and removing --enable-force-shutdown during configure.


Here is what happens:


root@sorpe:~# /etc/init.d/autofs start
Starting automount: done.

root@sorpe:~# ls -la /vol/eclipse/bin/
total 0
dr-xr-xr-x 8 root root 0 2007-10-10 16:06 ..
?--------- ? ?    ?    ?                ? /vol/eclipse/bin/.

okay, something borked here :)

root@sorpe:~# ls -la /vol/eclipse/bin/
total 0
drwxr-xr-x 2 root root 0 2007-10-10 16:06 .
dr-xr-xr-x 8 root root 0 2007-10-10 16:06 ..

hm, now it's empty, but it should look like this:

root@sorpe:~# ls -la /vol/eclipse-3.1/bin/
total 0
drwxrwsr-x 2 root eclipse 96 2007-09-12 14:34 .
dr-xr-xr-x 7 root root     0 2007-10-10 16:06 ..
-rw-r--r-- 1 root eclipse  0 2007-09-12 14:34 foo

below is the syslog.

To me it seems like the following happens:

1. he sees a request for /vol/eclipse/bin and resolves it
2. he sees it's a local mount and tries to bind-mount it
from /vol/eclipse-3.1/bin
3. he sees /vol/eclipse-3.1/bin is not local and calls mount -t
autofs ... on it
4. he bind-mounts /vol/eclipse-3.1/bin to /vol/eclipse/bin
5. and _then_ nfs-mounts /vol/eclipse-3.1/bin from figaro:/..../

I tried to backport util-linux 2.13 for our systems, but this didn't
work out since it needs a new nfs-utils, new initscripts and all that,
so we're stuck with util-linux 2.12r-17ubuntu2 plus patches we could
apply.

-- 
Lukas


Oct 10 16:06:27 sorpe automount[20900]: Starting automounter version 5.0.2, master map /etc/auto.master
Oct 10 16:06:27 sorpe automount[20900]: using kernel protocol version 5.00
Oct 10 16:06:27 sorpe automount[20900]: lookup_nss_read_master: reading master file /etc/auto.master
Oct 10 16:06:27 sorpe automount[20900]: parse_init: parse(sun): init gathered global options: (null)
Oct 10 16:06:27 sorpe automount[20900]: mount_init: mount(bind): bind_works = 1
Oct 10 16:06:27 sorpe automount[20900]: lookup_read_master: lookup(file): read entry +auto_master_direct_linx86
Oct 10 16:06:27 sorpe automount[20900]: lookup_nss_read_master: reading master files auto_master_direct_linx86
Oct 10 16:06:27 sorpe automount[20900]: lookup(file): file map /etc/auto_master_direct_linx86 missing or not readable
Oct 10 16:06:27 sorpe automount[20900]: lookup_nss_read_master: reading master nis auto_master_direct_linx86
Oct 10 16:06:27 sorpe automount[20900]: lookup_init: lookup(yp): ctxt->mapname=auto_master_direct_linx86
Oct 10 16:06:27 sorpe automount[20900]: parse_init: parse(sun): init gathered global options: (null)
Oct 10 16:06:27 sorpe automount[20900]: master_do_mount: mounting /homes
Oct 10 16:06:27 sorpe automount[20900]: lookup_nss_read_map: reading map files auto_homes
Oct 10 16:06:27 sorpe automount[20900]: read_file_source_instance: file map /etc/auto_homes not found
Oct 10 16:06:27 sorpe automount[20900]: lookup_nss_read_map: reading map nis auto_homes
Oct 10 16:06:27 sorpe automount[20900]: lookup_init: lookup(yp): ctxt->mapname=auto_homes
Oct 10 16:06:27 sorpe automount[20900]: parse_init: parse(sun): init gathered global options: nosuid,grpid
Oct 10 16:06:27 sorpe automount[20900]: mount_init: mount(bind): bind_works = 1
Oct 10 16:06:27 sorpe automount[20900]: mounted indirect mount on /homes with timeout 300, freq 75 seconds
Oct 10 16:06:27 sorpe automount[20900]: master_do_mount: mounting /vol
Oct 10 16:06:27 sorpe automount[20900]: lookup_nss_read_map: reading map files auto_vol_linx86
Oct 10 16:06:27 sorpe automount[20900]: parse_init: parse(sun): init gathered global options: (null)
Oct 10 16:06:27 sorpe automount[20900]: lookup_nss_read_map: reading map nis auto_vol_linx86
Oct 10 16:06:27 sorpe automount[20900]: lookup_init: lookup(yp): ctxt->mapname=auto_vol_linx86
Oct 10 16:06:27 sorpe automount[20900]: parse_init: parse(sun): init gathered global options: (null)
Oct 10 16:06:27 sorpe automount[20900]: mounted indirect mount on /vol with timeout 300, freq 75 seconds
Oct 10 16:06:40 sorpe automount[20900]: handle_packet: type = 3
Oct 10 16:06:40 sorpe automount[20900]: handle_packet_missing_indirect: token 78, name eclipse, request pid 20909
Oct 10 16:06:40 sorpe automount[20900]: attempting to mount entry /vol/eclipse
Oct 10 16:06:40 sorpe automount[20900]: lookup_mount: lookup(file): looking up eclipse
Oct 10 16:06:40 sorpe automount[20900]: lookup_mount: lookup(file): eclipse -> /bin          -rw,nosuid,grpid          :/vol/eclipse-3.1/bin   /include      -rw,nosuid,grpid          :/vol/eclipse-3.1/include   /lib          -rw,nosuid,grpid          :/vol/eclipse-3.1/lib   /man          -rw,nosuid,grpid          :/vol/eclipse-3.1/man   /share        -rw,nosuid,grpid          :/vol/eclipse-3.1/share   /src          -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse/src
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): expanded entry: /bin          -rw,nosuid,grpid          :/vol/eclipse-3.1/bin   /include      -rw,nosuid,grpid          :/vol/eclipse-3.1/include   /lib          -rw,nosuid,grpid          :/vol/eclipse-3.1/lib   /man          -rw,nosuid,grpid          :/vol/eclipse-3.1/man   /share        -rw,nosuid,grpid          :/vol/eclipse-3.1/share   /src          -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse/src
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): gathered options: 
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/bin") -> /bin
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote(":/vol/eclipse-3.1/bin") -> :/vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /bin -> -rw,nosuid,grpid :/vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/include") -> /include
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote(":/vol/eclipse-3.1/include") -> :/vol/eclipse-3.1/include
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /include -> -rw,nosuid,grpid :/vol/eclipse-3.1/include
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/lib") -> /lib
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote(":/vol/eclipse-3.1/lib") -> :/vol/eclipse-3.1/lib
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /lib -> -rw,nosuid,grpid :/vol/eclipse-3.1/lib
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/man") -> /man
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote(":/vol/eclipse-3.1/man") -> :/vol/eclipse-3.1/man
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /man -> -rw,nosuid,grpid :/vol/eclipse-3.1/man
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/share") -> /share
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote(":/vol/eclipse-3.1/share") -> :/vol/eclipse-3.1/share
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /share -> -rw,nosuid,grpid :/vol/eclipse-3.1/share
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/src") -> /src
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote("figaro:/volumes/stud03/eclipse/src") -> figaro:/volumes/stud03/eclipse/src
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /src -> -rw,nosuid,grpid figaro:/volumes/stud03/eclipse/src
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse/include
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse/include
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse/include
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse/lib
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse/lib
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse/lib
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse/man
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse/man
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse/man
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse/share
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse/share
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse/share
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse/src
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse/src
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse/src
Oct 10 16:06:40 sorpe automount[20900]: send_ready: token = 78
Oct 10 16:06:40 sorpe automount[20900]: mounted /vol/eclipse
Oct 10 16:06:40 sorpe automount[20900]: handle_packet: type = 5
Oct 10 16:06:40 sorpe automount[20900]: handle_packet_missing_direct: token 79, name /vol/eclipse/bin, request pid 20909
Oct 10 16:06:40 sorpe automount[20900]: attempting to mount entry /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: lookup_mount: lookup(file): looking up /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: lookup_mount: lookup(file): /vol/eclipse/bin -> -rw,nosuid,grpid :/vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): expanded entry: -rw,nosuid,grpid :/vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote(":/vol/eclipse-3.1/bin") -> :/vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): core of entry: options=rw,nosuid,grpid, loc=:/vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: sun_mount: parse(sun): mounting root /vol, mountpoint /vol/eclipse/bin, what :/vol/eclipse-3.1/bin, fstype nfs, options rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(nfs): root=/vol name=/vol/eclipse/bin what=:/vol/eclipse-3.1/bin, fstype=nfs, options=rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(nfs): nfs options="rw,nosuid,grpid", nosymlink=0, ro=0
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(nfs): calling mkdir_path /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(nfs): /vol/eclipse/bin is local, attempt bind mount
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(bind): calling mkdir_path /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(bind): calling mount --bind -s  -o defaults /vol/eclipse-3.1/bin /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: handle_packet: type = 3
Oct 10 16:06:40 sorpe automount[20900]: handle_packet_missing_indirect: token 80, name eclipse-3.1, request pid 20912
Oct 10 16:06:40 sorpe automount[20900]: attempting to mount entry /vol/eclipse-3.1
Oct 10 16:06:40 sorpe automount[20900]: lookup_mount: lookup(file): looking up eclipse-3.1
Oct 10 16:06:40 sorpe automount[20900]: lookup_mount: lookup(file): eclipse-3.1 -> /bin          -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse-3.1/bin.linx86   /include      -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse-3.1/include   /lib          -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse-3.1/lib.linx86   /man          -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse-3.1/man   /share        -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse-3.1/share
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): expanded entry: /bin          -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse-3.1/bin.linx86   /include      -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse-3.1/include   /lib          -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse-3.1/lib.linx86   /man          -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse-3.1/man   /share        -rw,nosuid,grpid          figaro:/volumes/stud03/eclipse-3.1/share
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): gathered options: 
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/bin") -> /bin
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote("figaro:/volumes/stud03/eclipse-3.1/bin.linx86") -> figaro:/volumes/stud03/eclipse-3.1/bin.linx86
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /bin -> -rw,nosuid,grpid figaro:/volumes/stud03/eclipse-3.1/bin.linx86
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/include") -> /include
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote("figaro:/volumes/stud03/eclipse-3.1/include") -> figaro:/volumes/stud03/eclipse-3.1/include
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /include -> -rw,nosuid,grpid figaro:/volumes/stud03/eclipse-3.1/include
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/lib") -> /lib
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote("figaro:/volumes/stud03/eclipse-3.1/lib.linx86") -> figaro:/volumes/stud03/eclipse-3.1/lib.linx86
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /lib -> -rw,nosuid,grpid figaro:/volumes/stud03/eclipse-3.1/lib.linx86
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/man") -> /man
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote("figaro:/volumes/stud03/eclipse-3.1/man") -> figaro:/volumes/stud03/eclipse-3.1/man
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /man -> -rw,nosuid,grpid figaro:/volumes/stud03/eclipse-3.1/man
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("/share") -> /share
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote("figaro:/volumes/stud03/eclipse-3.1/share") -> figaro:/volumes/stud03/eclipse-3.1/share
Oct 10 16:06:40 sorpe automount[20900]: add_offset_entry: parse(sun): added multi-mount offset /share -> -rw,nosuid,grpid figaro:/volumes/stud03/eclipse-3.1/share
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse-3.1/include
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse-3.1/include
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse-3.1/include
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse-3.1/lib
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse-3.1/lib
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse-3.1/lib
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse-3.1/man
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse-3.1/man
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse-3.1/man
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse-3.1/share
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse-3.1/share
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse-3.1/share
Oct 10 16:06:40 sorpe automount[20900]: send_ready: token = 80
Oct 10 16:06:40 sorpe automount[20900]: mounted /vol/eclipse-3.1
Oct 10 16:06:40 sorpe automount[20900]: st_readmap: state 1 path /vol
Oct 10 16:06:40 sorpe automount[20900]: lookup_nss_read_map: reading map files auto_vol_linx86
Oct 10 16:06:40 sorpe automount[20900]: lookup_nss_read_map: reading map nis auto_vol_linx86
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(bind): mounted /vol/eclipse-3.1/bin type bind on /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: send_ready: token = 79
Oct 10 16:06:40 sorpe automount[20900]: mounted /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: handle_packet: type = 5
Oct 10 16:06:40 sorpe automount[20900]: handle_packet_missing_direct: token 81, name /vol/eclipse-3.1/bin, request pid 20909
Oct 10 16:06:40 sorpe automount[20900]: attempting to mount entry /vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: lookup_mount: lookup(file): looking up /vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: lookup_mount: lookup(file): /vol/eclipse-3.1/bin -> -rw,nosuid,grpid figaro:/volumes/stud03/eclipse-3.1/bin.linx86
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): expanded entry: -rw,nosuid,grpid figaro:/volumes/stud03/eclipse-3.1/bin.linx86
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): gathered options: rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): dequote("figaro:/volumes/stud03/eclipse-3.1/bin.linx86") -> figaro:/volumes/stud03/eclipse-3.1/bin.linx86
Oct 10 16:06:40 sorpe automount[20900]: parse_mount: parse(sun): core of entry: options=rw,nosuid,grpid, loc=figaro:/volumes/stud03/eclipse-3.1/bin.linx86
Oct 10 16:06:40 sorpe automount[20900]: sun_mount: parse(sun): mounting root /vol, mountpoint /vol/eclipse-3.1/bin, what figaro:/volumes/stud03/eclipse-3.1/bin.linx86, fstype nfs, options rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(nfs): root=/vol name=/vol/eclipse-3.1/bin what=figaro:/volumes/stud03/eclipse-3.1/bin.linx86, fstype=nfs, options=rw,nosuid,grpid
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(nfs): nfs options="rw,nosuid,grpid", nosymlink=0, ro=0
Oct 10 16:06:40 sorpe automount[20900]: st_ready: st_ready(): state = 4 path /vol
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(nfs): calling mkdir_path /vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(nfs): calling mount -t nfs -s -o rw,nosuid,grpid figaro:/volumes/stud03/eclipse-3.1/bin.linx86 /vol/eclipse-3.1/bin
Oct 10 16:06:41 sorpe automount[20900]: mount(nfs): mounted figaro:/volumes/stud03/eclipse-3.1/bin.linx86 on /vol/eclipse-3.1/bin
Oct 10 16:06:41 sorpe automount[20900]: send_ready: token = 81
Oct 10 16:06:41 sorpe automount[20900]: mounted /vol/eclipse-3.1/bin
Oct 10 16:07:55 sorpe automount[20900]: st_expire: state 1 path /vol
Oct 10 16:07:55 sorpe automount[20900]: expire_proc: exp_proc = 3082599312 path /vol
Oct 10 16:07:55 sorpe automount[20900]: expire_proc_indirect: expire /vol/eclipse-3.1/bin
Oct 10 16:08:00 sorpe automount[20900]: expire_proc_indirect: 1 remaining in /vol
Oct 10 16:08:00 sorpe automount[20900]: mount still busy /vol
Oct 10 16:08:00 sorpe automount[20900]: expire_cleanup: got thid 3082599312 path /vol stat 2
Oct 10 16:08:00 sorpe automount[20900]: expire_cleanup: sigchld: exp 3082599312 finished, switching from 2 to 1
Oct 10 16:08:00 sorpe automount[20900]: st_ready: st_ready(): state = 2 path /vol
Oct 10 16:08:14 sorpe automount[20900]: st_expire: state 1 path /vol
Oct 10 16:08:14 sorpe automount[20900]: expire_proc: exp_proc = 3082599312 path /vol
Oct 10 16:08:14 sorpe automount[20900]: expire_proc_indirect: expire /vol/eclipse-3.1/bin
Oct 10 16:08:19 sorpe automount[20900]: expire_proc_indirect: 1 remaining in /vol
Oct 10 16:08:19 sorpe automount[20900]: mount still busy /vol
Oct 10 16:08:19 sorpe automount[20900]: expire_cleanup: got thid 3082599312 path /vol stat 2
Oct 10 16:08:19 sorpe automount[20900]: expire_cleanup: sigchld: exp 3082599312 finished, switching from 2 to 1
Oct 10 16:08:19 sorpe automount[20900]: st_ready: st_ready(): state = 2 path /vol
Oct 10 16:08:40 sorpe automount[20900]: st_expire: state 1 path /homes
Oct 10 16:08:40 sorpe automount[20900]: expire_proc: exp_proc = 3082599312 path /homes
Oct 10 16:08:40 sorpe automount[20900]: expire_cleanup: got thid 3082599312 path /homes stat 0
Oct 10 16:08:40 sorpe automount[20900]: expire_cleanup: sigchld: exp 3082599312 finished, switching from 2 to 1
Oct 10 16:08:40 sorpe automount[20900]: st_ready: st_ready(): state = 2 path /homes


> Ian
