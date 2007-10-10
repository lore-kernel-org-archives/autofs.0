From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: nested automounts: bind and nfs
Date: Wed, 10 Oct 2007 17:29:06 +0200
Message-ID: <1192030146.27076.46.camel@sangay.TechFak.Uni-Bielefeld.DE>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
	<1191321007.27255.12.camel@localhost>
	<1191332917.26331.171.camel@raven.themaw.net>
	<1192025757.27076.31.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192029316.3151.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1192029316.3151.11.camel@raven.themaw.net>
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

Hey Ian,

> 
> Certainly is.
> You're NFS is broken.
> 
> I'm not even going to look at the log or consider possible util-linux
> version issues until you update the kernel on this system. This part of
> the problem is very much the responsibility of the distribution kernel
> maintainers. 

I'm not quite so sure about that. nfs is working fine, I can
browse /vol/eclipse-3.1/bin and all other nfs shares without failure.
The bind-mount is what breaks, and the fact that the bind mount takes
place and gets executed _before_ /vol/eclipse-3.1/bin is actually
nfs-mounted, as you can clearly see in the log (only the relevant lines
here, for the full log see the other mail):



Oct 10 16:06:40 sorpe automount[20900]: attempting to mount entry /vol/eclipse
Oct 10 16:06:40 sorpe automount[20900]: parse_mapent: parse(sun): dequote(":/vol/eclipse-3.1/bin") -> :/vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: mounted /vol/eclipse
Oct 10 16:06:40 sorpe automount[20900]: handle_packet: type = 5
Oct 10 16:06:40 sorpe automount[20900]: handle_packet_missing_direct: token 79, name /vol/eclipse/bin, request pid 20909
Oct 10 16:06:40 sorpe automount[20900]: attempting to mount entry /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: lookup_mount: lookup(file): looking up /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: lookup_mount: lookup(file): /vol/eclipse/bin -> -rw,nosuid,grpid :/vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: sun_mount: parse(sun): mounting root /vol, mountpoint /vol/eclipse/bin, what :/vol/eclipse-3.1/bin, fstype nfs, options rw,nosuid,grpid
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
Oct 10 16:06:40 sorpe automount[20900]: mount_multi_triggers: mount offset /vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: calling mount -t autofs -s  -o fd=11,pgrp=20900,minproto=5,maxproto=5,offset automount /vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: mount_autofs_offset: mounted trigger /vol/eclipse-3.1/bin
Oct 10 16:06:40 sorpe automount[20900]: send_ready: token = 80
Oct 10 16:06:40 sorpe automount[20900]: mounted /vol/eclipse-3.1
Oct 10 16:06:40 sorpe automount[20900]: st_readmap: state 1 path /vol
Oct 10 16:06:40 sorpe automount[20900]: lookup_nss_read_map: reading map files auto_vol_linx86
Oct 10 16:06:40 sorpe automount[20900]: lookup_nss_read_map: reading map nis auto_vol_linx86
Oct 10 16:06:40 sorpe automount[20900]: mount_mount: mount(bind): mounted /vol/eclipse-3.1/bin type bind on /vol/eclipse/bin
Oct 10 16:06:40 sorpe automount[20900]: send_ready: token = 79
Oct 10 16:06:40 sorpe automount[20900]: mounted /vol/eclipse/bin

Here, you see that the bind-mount of /vol/eclipse-3.1/bin
to /vol/eclipse/bin is finished even before autofs tried to mount
figaro:/volumes/stud03/eclipse-3.1/bin.linx86 to /vol/eclipse-3.1/bin.
It this is a kernel nfs problem, I'd be happy to let the distribution
maintainers know, alas to me it seems to be an autofs5 problem or might
be a mount locking problem.

What follows is the actual nfs mount:

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


> Ian

-- 
Lukas
