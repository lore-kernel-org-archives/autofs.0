From: Michael <michael@kmaclub.com>
Subject: Re: Automounting DVD images
Date: Fri, 08 Dec 2006 22:23:57 -0700
Message-ID: <457A486D.9030700@kmaclub.com>
References: <457999E0.2040808@kmaclub.com>	
	<1165602659.3996.59.camel@raven.themaw.net>
	<4579C7F4.4020506@kmaclub.com>
	<1165635742.3980.6.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1165635742.3980.6.camel@raven.themaw.net>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

Ian Kent wrote:
> On Fri, 2006-12-08 at 13:15 -0700, Michael wrote:
>   
> Then you need to provide a debug log.
> You need to ensure that daemon.debug is being set somewhere by syslog.
> Check that because this is not nearly as much logging as would be
> expected.
>
> I'd also add that I don't think the maps are quite right either but I
> don't have any suggestions atm. So give us the debug log first.
>
> Ian
>
>   

Dec  8 22:14:38 fc6 automount[2587]: handle_packet: type = 3
Dec  8 22:14:38 fc6 automount[2587]: handle_packet_missing_indirect: 
token 2, name iso, request pid 3381
Dec  8 22:14:38 fc6 automount[2587]: attempting to mount entry /mythtv/iso
Dec  8 22:14:38 fc6 automount[2587]: lookup_name_file_source_instance: 
file map not found
Dec  8 22:14:38 fc6 automount[2587]: lookup_mount: lookup(yp): looking 
up iso
Dec  8 22:14:38 fc6 automount[2587]: lookup_mount: lookup(yp): iso -> 
--timeout=60 -fstype=autofs  auto.mythtv.iso
Dec  8 22:14:38 fc6 automount[2587]: parse_mount: parse(sun): expanded 
entry: --timeout=60 -fstype=autofs  auto.mythtv.iso
Dec  8 22:14:38 fc6 automount[2587]: parse_mount: parse(sun): gathered 
options: -timeout=60,fstype=autofs
Dec  8 22:14:38 fc6 automount[2587]: parse_mount: parse(sun): 
dequote("auto.mythtv.iso") -> auto.mythtv.iso
Dec  8 22:14:38 fc6 automount[2587]: parse_mount: parse(sun): core of 
entry: options=-timeout=60,fstype=autofs, loc=auto.mythtv.iso
Dec  8 22:14:38 fc6 automount[2587]: sun_mount: parse(sun): mounting 
root /mythtv, mountpoint iso, what auto.mythtv.iso, fstype autofs, 
options -timeout=60
Dec  8 22:14:38 fc6 automount[2587]: do_mount: auto.mythtv.iso 
/mythtv/iso type autofs options -timeout=60 using module autofs
Dec  8 22:14:38 fc6 automount[2587]: mount_mount: mount(autofs): 
fullpath=/mythtv/iso what=auto.mythtv.iso options=-timeout=60
Dec  8 22:14:38 fc6 automount[2587]: lookup_nss_read_map: reading map 
files auto.mythtv.iso
Dec  8 22:14:38 fc6 automount[2587]: read_file_source_instance: file map 
/etc/auto.mythtv.iso not found
Dec  8 22:14:38 fc6 automount[2587]: lookup_nss_read_map: reading map 
nis auto.mythtv.iso
Dec  8 22:14:38 fc6 automount[2587]: lookup_init: lookup(yp): 
ctxt->mapname=auto.mythtv.iso
Dec  8 22:14:38 fc6 automount[2587]: parse_init: parse(sun): init 
gathered global options: timeout=60
Dec  8 22:14:38 fc6 automount[2587]: mounted indirect mount on 
/mythtv/iso with timeout 300, freq 75 seconds
Dec  8 22:14:38 fc6 automount[2587]: ghosting enabled
Dec  8 22:14:38 fc6 automount[2587]: send_ready: token = 2
Dec  8 22:14:38 fc6 automount[2587]: mounted /mythtv/iso
Dec  8 22:14:38 fc6 automount[2587]: handle_packet: type = 3
Dec  8 22:14:38 fc6 automount[2587]: handle_packet_missing_indirect: 
token 3, name MOVIE.iso, request pid 3381
Dec  8 22:14:38 fc6 automount[2587]: attempting to mount entry 
/mythtv/iso/MOVIE.iso
Dec  8 22:14:38 fc6 automount[2587]: lookup_name_file_source_instance: 
file map not found
Dec  8 22:14:38 fc6 automount[2587]: lookup_mount: lookup(yp): looking 
up MOVIE.iso
Dec  8 22:14:38 fc6 automount[2587]: send_fail: token = 3
Dec  8 22:14:38 fc6 automount[2587]: handle_packet: type = 3
Dec  8 22:14:38 fc6 automount[2587]: handle_packet_missing_indirect: 
token 4, name MOVIE.iso, request pid 3381
Dec  8 22:14:38 fc6 automount[2587]: failed to mount /mythtv/iso/MOVIE.iso
Dec  8 22:14:38 fc6 automount[2587]: attempting to mount entry 
/mythtv/iso/MOVIE.iso
Dec  8 22:14:38 fc6 automount[2587]: lookup_name_file_source_instance: 
file map not found
Dec  8 22:14:38 fc6 automount[2587]: lookup_mount: lookup(yp): looking 
up MOVIE.iso
Dec  8 22:14:38 fc6 automount[2587]: send_fail: token = 4
Dec  8 22:14:38 fc6 automount[2587]: handle_packet: type = 3
Dec  8 22:14:38 fc6 automount[2587]: handle_packet_missing_indirect: 
token 5, name MOVIE.iso, request pid 3381
Dec  8 22:14:38 fc6 automount[2587]: failed to mount /mythtv/iso/MOVIE.iso
Dec  8 22:14:38 fc6 automount[2587]: attempting to mount entry 
/mythtv/iso/MOVIE.iso
Dec  8 22:14:38 fc6 automount[2587]: lookup_name_file_source_instance: 
file map not found
Dec  8 22:14:38 fc6 automount[2587]: lookup_mount: lookup(yp): looking 
up MOVIE.iso
Dec  8 22:14:38 fc6 automount[2587]: send_fail: token = 5
Dec  8 22:14:38 fc6 automount[2587]: failed to mount /mythtv/iso/MOVIE.iso
Dec  8 22:14:47 fc6 ntpd[2652]: synchronized to 192.168.101.1, stratum 3
Dec  8 22:14:51 fc6 automount[2587]: st_expire: state 1 path /home
Dec  8 22:14:51 fc6 automount[2587]: expire_proc: exp_proc = 1086486848 
path /home
Dec  8 22:14:51 fc6 automount[2587]: expire_proc_indirect: expire 
/home/mikey
Dec  8 22:14:52 fc6 automount[2587]: expire_proc_indirect: 1 remaining 
in /home
Dec  8 22:14:52 fc6 automount[2587]: mount still busy /home
Dec  8 22:14:52 fc6 automount[2587]: expire_cleanup: got thid 1086486848 
path /home stat 2
Dec  8 22:14:52 fc6 automount[2587]: expire_cleanup: sigchld: exp 
1086486848 finished, switching from 2 to 1
Dec  8 22:14:52 fc6 automount[2587]: st_ready: st_ready(): state = 2 
path /home
Dec  8 22:15:02 fc6 automount[2587]: st_expire: state 1 path /mythtv
Dec  8 22:15:02 fc6 automount[2587]: expire_proc: exp_proc = 1086486848 
path /mythtv
Dec  8 22:15:02 fc6 automount[2587]: st_expire: state 1 path /mythtv/iso
Dec  8 22:15:02 fc6 automount[2587]: expire_proc: exp_proc = 1099077952 
path /mythtv/iso
Dec  8 22:15:02 fc6 automount[2587]: expire_cleanup: got thid 1099077952 
path /mythtv/iso stat 0
Dec  8 22:15:02 fc6 automount[2587]: expire_cleanup: sigchld: exp 
1099077952 finished, switching from 2 to 1
Dec  8 22:15:02 fc6 automount[2587]: st_ready: st_ready(): state = 2 
path /mythtv/iso
Dec  8 22:15:02 fc6 automount[2587]: expire_proc_indirect: 1 submounts 
remaining in /mythtv
Dec  8 22:15:02 fc6 automount[2587]: mount still busy /mythtv
Dec  8 22:15:02 fc6 automount[2587]: expire_cleanup: got thid 1086486848 
path /mythtv stat 1
Dec  8 22:15:02 fc6 automount[2587]: expire_cleanup: sigchld: exp 
1086486848 finished, switching from 2 to 1
Dec  8 22:15:02 fc6 automount[2587]: st_ready: st_ready(): state = 2 
path /mythtv
Dec  8 22:15:19 fc6 automount[2587]: st_expire: state 1 path /misc
Dec  8 22:15:19 fc6 automount[2587]: expire_proc: exp_proc = 1086486848 
path /misc
Dec  8 22:15:19 fc6 automount[2587]: expire_cleanup: got thid 1086486848 
path /misc stat 0
Dec  8 22:15:19 fc6 automount[2587]: expire_cleanup: sigchld: exp 
1086486848 finished, switching from 2 to 1
Dec  8 22:15:19 fc6 automount[2587]: st_ready: st_ready(): state = 2 
path /misc
Dec  8 22:15:23 fc6 automount[2587]: st_expire: state 1 path /net
Dec  8 22:15:23 fc6 automount[2587]: expire_proc: exp_proc = 1086486848 
path /net
Dec  8 22:15:23 fc6 automount[2587]: expire_cleanup: got thid 1086486848 
path /net stat 0
Dec  8 22:15:23 fc6 automount[2587]: expire_cleanup: sigchld: exp 
1086486848 finished, switching from 2 to 1
Dec  8 22:15:23 fc6 automount[2587]: st_ready: st_ready(): state = 2 
path /net


Michael
