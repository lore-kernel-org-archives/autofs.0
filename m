From: Ian Kent <raven@themaw.net>
Subject: Re: Automounting DVD images
Date: Wed, 13 Dec 2006 11:07:58 +0900
Message-ID: <1165975679.3332.7.camel@raven.themaw.net>
References: <457999E0.2040808@kmaclub.com>
	<1165602659.3996.59.camel@raven.themaw.net>
	<4579C7F4.4020506@kmaclub.com>
	<1165808922.3380.1.camel@raven.themaw.net>
	<457EF8EA.9000608@kmaclub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <457EF8EA.9000608@kmaclub.com>
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
To: Michael <michael@kmaclub.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 2006-12-12 at 11:46 -0700, Michael wrote:
> Ian Kent wrote:
> > What happens if you also use this patch:
> >
> > diff --git a/daemon/spawn.c b/daemon/spawn.c
> > index 7f0a6e0..6f59bf2 100644
> > --- a/daemon/spawn.c
> > +++ b/daemon/spawn.c
> > @@ -272,7 +272,7 @@ int spawn_mount(logger *log, ...)
> >  #ifdef ENABLE_MOUNT_LOCKING
> >  	options = SPAWN_OPT_LOCK;
> >  #else
> > -	options = SPAWN_OPT_NONE;
> > +	options = SPAWN_OPT_ACCESS;
> >  #endif
> >  
> >  	va_start(arg, log);
> >
> >   
> 
> That seems to break autofs rather badly.  With that patch I can no 
> longer mount my home directory or the directory where the iso file 
> actually lives.

That's a bit of a surprise, I didn't expect it to break other maps.
I'll check into that before doing anything else.

Does the /home mount also break if you don't use /mythtv map?

> 
> Michael
> 
> 
> 
> plain text document attachment (debug.autofs)
> Dec 12 11:36:30 fcvm automount[2028]: st_expire: state 1 path /mythtv
> Dec 12 11:36:30 fcvm automount[2028]: expire_proc: exp_proc = 3075345296 path /mythtv
> Dec 12 11:36:30 fcvm automount[2028]: expire_cleanup: got thid 3075345296 path /mythtv stat 0
> Dec 12 11:36:30 fcvm automount[2028]: expire_cleanup: sigchld: exp 3075345296 finished, switching from 2 to 1
> Dec 12 11:36:30 fcvm automount[2028]: st_ready: st_ready(): state = 2 path /mythtv
> Dec 12 11:36:32 fcvm automount[2028]: handle_packet: type = 3
> Dec 12 11:36:32 fcvm automount[2028]: handle_packet_missing_indirect: token 1, name iso, request pid 2545
> Dec 12 11:36:32 fcvm automount[2028]: attempting to mount entry /mythtv/iso
> Dec 12 11:36:32 fcvm automount[2028]: lookup_name_file_source_instance: file map not found
> Dec 12 11:36:32 fcvm automount[2028]: lookup_mount: lookup(yp): looking up iso
> Dec 12 11:36:32 fcvm automount[2028]: lookup_mount: lookup(yp): iso -> --timeout=60 -fstype=autofs	auto.mythtv.iso
> Dec 12 11:36:32 fcvm automount[2028]: parse_mount: parse(sun): expanded entry: --timeout=60 -fstype=autofs	auto.mythtv.iso
> Dec 12 11:36:32 fcvm automount[2028]: parse_mount: parse(sun): gathered options: -timeout=60,fstype=autofs
> Dec 12 11:36:32 fcvm automount[2028]: parse_mount: parse(sun): dequote("auto.mythtv.iso") -> auto.mythtv.iso
> Dec 12 11:36:32 fcvm automount[2028]: parse_mount: parse(sun): core of entry: options=-timeout=60,fstype=autofs, loc=auto.mythtv.iso
> Dec 12 11:36:32 fcvm automount[2028]: sun_mount: parse(sun): mounting root /mythtv, mountpoint iso, what auto.mythtv.iso, fstype autofs, options -timeout=60
> Dec 12 11:36:32 fcvm automount[2028]: do_mount: auto.mythtv.iso /mythtv/iso type autofs options -timeout=60 using module autofs
> Dec 12 11:36:32 fcvm automount[2028]: mount_mount: mount(autofs): fullpath=/mythtv/iso what=auto.mythtv.iso options=-timeout=60
> Dec 12 11:36:32 fcvm automount[2028]: lookup_nss_read_map: reading map files auto.mythtv.iso
> Dec 12 11:36:32 fcvm automount[2028]: read_file_source_instance: file map /etc/auto.mythtv.iso not found
> Dec 12 11:36:32 fcvm automount[2028]: lookup_nss_read_map: reading map nis auto.mythtv.iso
> Dec 12 11:36:32 fcvm automount[2028]: lookup_init: lookup(yp): ctxt->mapname=auto.mythtv.iso
> Dec 12 11:36:32 fcvm automount[2028]: parse_init: parse(sun): init gathered global options: timeout=60
> Dec 12 11:36:32 fcvm automount[2028]: mounted indirect mount on /mythtv/iso with timeout 300, freq 75 seconds
> Dec 12 11:36:32 fcvm automount[2028]: ghosting enabled
> Dec 12 11:36:32 fcvm automount[2028]: send_ready: token = 1
> Dec 12 11:36:32 fcvm automount[2028]: mounted /mythtv/iso
> Dec 12 11:36:48 fcvm automount[2028]: st_expire: state 1 path /misc
> Dec 12 11:36:48 fcvm automount[2028]: expire_proc: exp_proc = 3075345296 path /misc
> Dec 12 11:36:48 fcvm automount[2028]: expire_cleanup: got thid 3075345296 path /misc stat 0
> Dec 12 11:36:48 fcvm automount[2028]: expire_cleanup: sigchld: exp 3075345296 finished, switching from 2 to 1
> Dec 12 11:36:48 fcvm automount[2028]: st_ready: st_ready(): state = 2 path /misc
> Dec 12 11:36:49 fcvm automount[2028]: handle_packet: type = 3
> Dec 12 11:36:49 fcvm automount[2028]: handle_packet_missing_indirect: token 2, name MOVIE.iso, request pid 2545
> Dec 12 11:36:49 fcvm automount[2028]: attempting to mount entry /mythtv/iso/MOVIE.iso
> Dec 12 11:36:49 fcvm automount[2028]: lookup_name_file_source_instance: file map not found
> Dec 12 11:36:49 fcvm automount[2028]: lookup_mount: lookup(yp): looking up MOVIE.iso
> Dec 12 11:36:49 fcvm automount[2028]: send_fail: token = 2
> Dec 12 11:36:49 fcvm automount[2028]: handle_packet: type = 3
> Dec 12 11:36:49 fcvm automount[2028]: handle_packet_missing_indirect: token 3, name MOVIE.iso, request pid 2545
> Dec 12 11:36:49 fcvm automount[2028]: failed to mount /mythtv/iso/MOVIE.iso
> Dec 12 11:36:49 fcvm automount[2028]: attempting to mount entry /mythtv/iso/MOVIE.iso
> Dec 12 11:36:49 fcvm automount[2028]: lookup_name_file_source_instance: file map not found
> Dec 12 11:36:49 fcvm automount[2028]: lookup_mount: lookup(yp): looking up MOVIE.iso
> Dec 12 11:36:49 fcvm automount[2028]: send_fail: token = 3
> Dec 12 11:36:49 fcvm automount[2028]: handle_packet: type = 3
> Dec 12 11:36:49 fcvm automount[2028]: handle_packet_missing_indirect: token 4, name MOVIE.iso, request pid 2545
> Dec 12 11:36:49 fcvm automount[2028]: failed to mount /mythtv/iso/MOVIE.iso
> Dec 12 11:36:49 fcvm automount[2028]: attempting to mount entry /mythtv/iso/MOVIE.iso
> Dec 12 11:36:49 fcvm automount[2028]: lookup_name_file_source_instance: file map not found
> Dec 12 11:36:49 fcvm automount[2028]: lookup_mount: lookup(yp): looking up MOVIE.iso
> Dec 12 11:36:49 fcvm automount[2028]: send_fail: token = 4
> Dec 12 11:36:49 fcvm automount[2028]: failed to mount /mythtv/iso/MOVIE.iso
> Dec 12 11:36:51 fcvm automount[2028]: st_expire: state 1 path /net
> Dec 12 11:36:51 fcvm automount[2028]: expire_proc: exp_proc = 3075345296 path /net
> Dec 12 11:36:51 fcvm automount[2028]: expire_cleanup: got thid 3075345296 path /net stat 0
> Dec 12 11:36:51 fcvm automount[2028]: expire_cleanup: sigchld: exp 3075345296 finished, switching from 2 to 1
> Dec 12 11:36:51 fcvm automount[2028]: st_ready: st_ready(): state = 2 path /net
> Dec 12 11:36:52 fcvm automount[2028]: handle_packet: type = 3
> Dec 12 11:36:52 fcvm automount[2028]: handle_packet_missing_indirect: token 5, name mikey, request pid 2545
> Dec 12 11:36:52 fcvm automount[2028]: attempting to mount entry /home/mikey
> Dec 12 11:36:52 fcvm automount[2028]: lookup_name_file_source_instance: file map not found
> Dec 12 11:36:52 fcvm automount[2028]: lookup_mount: lookup(yp): looking up mikey
> Dec 12 11:36:52 fcvm automount[2028]: lookup_mount: lookup(yp): mikey -> -rw             filer:/export/users/&
> Dec 12 11:36:52 fcvm automount[2028]: parse_mount: parse(sun): expanded entry: -rw             filer:/export/users/mikey
> Dec 12 11:36:52 fcvm automount[2028]: parse_mount: parse(sun): gathered options: rw
> Dec 12 11:36:52 fcvm automount[2028]: parse_mount: parse(sun): dequote("filer:/export/users/mikey") -> filer:/export/users/mikey
> Dec 12 11:36:52 fcvm automount[2028]: parse_mount: parse(sun): core of entry: options=rw, loc=filer:/export/users/mikey
> Dec 12 11:36:52 fcvm automount[2028]: sun_mount: parse(sun): mounting root /home, mountpoint mikey, what filer:/export/users/mikey, fstype nfs, options rw
> Dec 12 11:36:52 fcvm automount[2028]: mount_mount: mount(nfs): root=/home name=mikey what=filer:/export/users/mikey, fstype=nfs, options=rw
> Dec 12 11:36:52 fcvm automount[2028]: mount_mount: mount(nfs): nfs options="rw", nosymlink=0, ro=0
> Dec 12 11:36:52 fcvm automount[2028]: mount_mount: mount(nfs): calling mkdir_path /home/mikey
> Dec 12 11:36:52 fcvm automount[2028]: mount_mount: mount(nfs): calling mount -t nfs -s -o rw filer:/export/users/mikey /home/mikey
> Dec 12 11:36:52 fcvm automount[2028]: mount(nfs): nfs: mount failure filer:/export/users/mikey on /home/mikey
> Dec 12 11:36:52 fcvm automount[2028]: send_fail: token = 5
> Dec 12 11:36:52 fcvm automount[2028]: handle_packet: type = 3
> Dec 12 11:36:52 fcvm automount[2028]: handle_packet_missing_indirect: token 6, name mikey, request pid 2545
> Dec 12 11:36:52 fcvm automount[2028]: failed to mount /home/mikey
> Dec 12 11:36:52 fcvm automount[2028]: attempting to mount entry /home/mikey
> Dec 12 11:36:52 fcvm automount[2028]: lookup_name_file_source_instance: file map not found
> Dec 12 11:36:52 fcvm automount[2028]: lookup_mount: lookup(yp): looking up mikey
> Dec 12 11:36:52 fcvm automount[2028]: send_fail: token = 6
> Dec 12 11:36:52 fcvm automount[2028]: handle_packet: type = 3
> Dec 12 11:36:52 fcvm automount[2028]: handle_packet_missing_indirect: token 7, name mikey, request pid 2545
> Dec 12 11:36:52 fcvm automount[2028]: failed to mount /home/mikey
> Dec 12 11:36:52 fcvm automount[2028]: attempting to mount entry /home/mikey
> Dec 12 11:36:52 fcvm automount[2028]: lookup_name_file_source_instance: file map not found
> Dec 12 11:36:52 fcvm automount[2028]: lookup_mount: lookup(yp): looking up mikey
> Dec 12 11:36:52 fcvm automount[2028]: send_fail: token = 7
> Dec 12 11:36:53 fcvm automount[2028]: failed to mount /home/mikey
> Dec 12 11:36:59 fcvm automount[2028]: st_expire: state 1 path /services
> Dec 12 11:36:59 fcvm automount[2028]: expire_proc: exp_proc = 3075345296 path /services
> Dec 12 11:36:59 fcvm automount[2028]: expire_cleanup: got thid 3075345296 path /services stat 0
> Dec 12 11:36:59 fcvm automount[2028]: expire_cleanup: sigchld: exp 3075345296 finished, switching from 2 to 1
> Dec 12 11:36:59 fcvm automount[2028]: st_ready: st_ready(): state = 2 path /services
