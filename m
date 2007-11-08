From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: nested automounts: bind and nfs
Date: Thu, 08 Nov 2007 17:44:39 +0100
Message-ID: <1194540279.27074.10.camel@sangay.TechFak.Uni-Bielefeld.DE>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
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
Cc: Ian Kent <raven@themaw.net>

Hello Ian, Hi List,

I'm sorry I have to bring this thread up again :(

> Given the following mount map:
> 
> eclipse-3.1 \
>   /bin          -rw,nosuid,grpid          fileserver:/volumes/vol1/eclipse-3.1/bin.linx86 \
> 
> eclipse \
>   /bin          -rw,nosuid,grpid          :/vol/eclipse-3.1/bin \
> 
> We can't access /vol/eclipse/bin on the client if /vol/eclipse-3.1/bin
> is not already mounted. The log says:

The above map now works with the kernel patch you send in october, but
we know stumbled over a case that didn't work (found in the map
for /vol): 

jdk-1.5.13 -rw,nosuid,grpid fileserver:/export/stud/vol/jdk-1.5.13/linx86
jdk-1.5    -rw,nosuid,grpid :/vol/jdk-1.5.13

Debug log below. To me, it looks very similar to the problems we had
with the eclipse volume (he bind-mounts /vol/jdk-1.5
from /vol/jdk-1.5.13 that is not yet mounted and only then
mounts /vol/jdk-1.5.13 ...). Could it be that this (not so nested) map
triggers a different code-path than the other so that the kernel patch
in this thread doesn't work?

The diff.gz against autofs5-5.0.2 is at
http://packages.techfak.uni-bielefeld.de/pool/techfak-testing/a/autofs5/autofs5_5.0.2-7techfakfeisty0.diff.gz


-- 
Lukas

Nov  8 17:29:50 lahn automount[27009]: handle_packet_missing_indirect: token 206, name jdk-1.5, request pid 27086
Nov  8 17:29:50 lahn automount[27009]: attempting to mount entry /vol/jdk-1.5
Nov  8 17:29:50 lahn automount[27009]: file map not found
Nov  8 17:29:50 lahn automount[27009]: lookup_mount: lookup(yp): looking up jdk-1.5
Nov  8 17:29:50 lahn automount[27009]: lookup_mount: lookup(yp): jdk-1.5 -> -rw,nosuid,grpid          :/vol/jdk-1.5.13
Nov  8 17:29:50 lahn automount[27009]: parse_mount: parse(sun): expanded entry: -rw,nosuid,grpid          :/vol/jdk-1.5.13
Nov  8 17:29:50 lahn automount[27009]: parse_mount: parse(sun): gathered options: rw,nosuid,grpid
Nov  8 17:29:50 lahn automount[27009]: parse_mount: parse(sun): dequote(":/vol/jdk-1.5.13") -> :/vol/jdk-1.5.13
Nov  8 17:29:50 lahn automount[27009]: parse_mount: parse(sun): core of entry: options=rw,nosuid,grpid, loc=:/vol/jdk-1.5.13
Nov  8 17:29:50 lahn automount[27009]: sun_mount: parse(sun): mounting root /vol, mountpoint jdk-1.5, what :/vol/jdk-1.5.13, fstype nfs, options rw,nosuid,grpid
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(nfs): root=/vol name=jdk-1.5 what=:/vol/jdk-1.5.13, fstype=nfs, options=rw,nosuid,grpid
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(nfs): nfs options="rw,nosuid,grpid", nosymlink=0, ro=0
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(nfs): calling mkdir_path /vol/jdk-1.5
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(nfs): jdk-1.5 is local, attempt bind mount
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(bind): calling mkdir_path /vol/jdk-1.5
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(bind): calling mount --bind -s  -o defaults /vol/jdk-1.5.13 /vol/jdk-1.5
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(bind): mounted /vol/jdk-1.5.13 type bind on /vol/jdk-1.5
Nov  8 17:29:50 lahn automount[27009]: send_ready: token = 206
Nov  8 17:29:50 lahn automount[27009]: handle_packet: type = 3
Nov  8 17:29:50 lahn automount[27009]: handle_packet_missing_indirect: token 207, name jdk-1.5.13, request pid 27086
Nov  8 17:29:50 lahn automount[27009]: attempting to mount entry /vol/jdk-1.5.13
Nov  8 17:29:50 lahn automount[27009]: mounted /vol/jdk-1.5
Nov  8 17:29:50 lahn automount[27009]: file map not found
Nov  8 17:29:50 lahn automount[27009]: lookup_mount: lookup(yp): looking up jdk-1.5.13
Nov  8 17:29:50 lahn automount[27009]: lookup_mount: lookup(yp): jdk-1.5.13 -> -rw,nosuid,grpid          fileserver:/export/stud/vol/jdk-1.5.13/linx86
Nov  8 17:29:50 lahn automount[27009]: parse_mount: parse(sun): expanded entry: -rw,nosuid,grpid          fileserver:/export/stud/vol/jdk-1.5.13/linx86
Nov  8 17:29:50 lahn automount[27009]: parse_mount: parse(sun): gathered options: rw,nosuid,grpid
Nov  8 17:29:50 lahn automount[27009]: parse_mount: parse(sun): dequote("fileserver:/export/stud/vol/jdk-1.5.13/linx86") -> fileserver:/export/stud/vol/jdk-1.5.13/linx86
Nov  8 17:29:50 lahn automount[27009]: parse_mount: parse(sun): core of entry: options=rw,nosuid,grpid, loc=fileserver:/export/stud/vol/jdk-1.5.13/linx86
Nov  8 17:29:50 lahn automount[27009]: sun_mount: parse(sun): mounting root /vol, mountpoint jdk-1.5.13, what fileserver:/export/stud/vol/jdk-1.5.13/linx86, fstype nfs, options rw,nosuid,grpid
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(nfs): root=/vol name=jdk-1.5.13 what=fileserver:/export/stud/vol/jdk-1.5.13/linx86, fstype=nfs, options=rw,nosuid,grpid
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(nfs): nfs options="rw,nosuid,grpid", nosymlink=0, ro=0
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(nfs): calling mkdir_path /vol/jdk-1.5.13
Nov  8 17:29:50 lahn automount[27009]: mount_mount: mount(nfs): calling mount -t nfs -s -o rw,nosuid,grpid fileserver:/export/stud/vol/jdk-1.5.13/linx86 /vol/jdk-1.5.13
Nov  8 17:29:50 lahn automount[27009]: mount(nfs): mounted fileserver:/export/stud/vol/jdk-1.5.13/linx86 on /vol/jdk-1.5.13
Nov  8 17:29:50 lahn automount[27009]: send_ready: token = 207
Nov  8 17:29:50 lahn automount[27009]: mounted /vol/jdk-1.5.13
