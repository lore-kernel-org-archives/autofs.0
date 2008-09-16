From: Ian Kent <raven@themaw.net>
Subject: Re: Not correctly mount SMB shares ending in $
Date: Tue, 16 Sep 2008 11:22:18 +0800
Message-ID: <1221535338.3084.2.camel@raven.themaw.net>
References: <48C5F518.9010800@edcint.co.nz>
	<1221018586.3030.63.camel@raven.themaw.net>
	<48C8D7FE.9000501@edcint.co.nz>
	<1221142584.28271.15.camel@raven.themaw.net>
	<48CB1F71.50407@edcint.co.nz>
	<1221275360.2965.3.camel@raven.themaw.net>
	<48CBB26A.2040205@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48CBB26A.2040205@edcint.co.nz>
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
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>


Sorry for the delay.

On Sat, 2008-09-13 at 22:30 +1000, Matthew Jurgens wrote:
> Debug Log:
> 
> Sep 16 01:03:11 tempgw automount[17954]: st_expire: state 1 path /misc
> Sep 16 01:03:11 tempgw automount[17954]: expire_proc: exp_proc =
> 3083123600 path /misc
> Sep 16 01:03:11 tempgw automount[17954]: expire_cleanup: got thid
> 3083123600 path /misc stat 0
> Sep 16 01:03:11 tempgw automount[17954]: expire_cleanup: sigchld: exp
> 3083123600 finished, switching from 2 to 1
> Sep 16 01:03:11 tempgw automount[17954]: st_ready: st_ready(): state =
> 2 path /misc
> Sep 16 01:03:12 tempgw automount[17954]: st_expire: state 1 path /misc
> Sep 16 01:03:12 tempgw automount[17954]: expire_proc: exp_proc =
> 3083123600 path /misc
> Sep 16 01:03:12 tempgw automount[17954]: expire_cleanup: got thid
> 3083123600 path /misc stat 0
> Sep 16 01:03:12 tempgw automount[17954]: expire_cleanup: sigchld: exp
> 3083123600 finished, switching from 2 to 1
> Sep 16 01:03:12 tempgw automount[17954]: st_ready: st_ready(): state =
> 2 path /misc
> Sep 16 01:03:12 tempgw automount[17954]: handle_packet: type = 3
> Sep 16 01:03:12 tempgw automount[17954]:
> handle_packet_missing_indirect: token 344, name xp0, request pid 17592
> Sep 16 01:03:12 tempgw automount[17954]: attempting to mount
> entry /smb/xp0
> Sep 16 01:03:12 tempgw automount[17954]: lookup_mount:
> lookup(program): looking up xp0
> Sep 16 01:03:13 tempgw automount[17954]: lookup_mount:
> lookup(program): xp0 -> -fstype=cifs,username=USER,password=PASSWORD
> #011 /C "://xp0/C"  #011 /ADMIN\$ "://xp0/ADMIN\$"  #011 /C\$
> "://xp0/C\$"
> Sep 16 01:03:13 tempgw automount[17954]: parse_mount: parse(sun):
> expanded entry: -fstype=cifs,username=USER,password=PASSWORD  #011 /C
> "://xp0/C"  #011 /ADMIN\$ "://xp0/ADMIN\$"  #011 /C\$ "://xp0/C\$"
> Sep 16 01:03:13 tempgw automount[17954]: parse_mount: parse(sun):
> gathered options: fstype=cifs,username=USER,password=PASSWORD
> Sep 16 01:03:13 tempgw automount[17954]: parse_mount: parse(sun):
> dequote("/C") -> /C
> Sep 16 01:03:13 tempgw automount[17954]: parse_mapent: parse(sun):
> gathered options: fstype=cifs,username=USER,password=PASSWORD
> Sep 16 01:03:13 tempgw automount[17954]: parse_mapent: parse(sun):
> dequote(""://xp0/C"") -> ://xp0/C
> Sep 16 01:03:13 tempgw automount[17954]: add_offset_entry: parse(sun):
> added multi-mount offset /C ->
> -fstype=cifs,username=USER,password=PASSWORD ://xp0/C
> Sep 16 01:03:13 tempgw automount[17954]: parse_mount: parse(sun):
> dequote("/ADMIN\$") -> /ADMIN$
> Sep 16 01:03:13 tempgw automount[17954]: parse_mapent: parse(sun):
> gathered options: fstype=cifs,username=USER,password=PASSWORD
> Sep 16 01:03:13 tempgw automount[17954]: parse_mapent: parse(sun):
> dequote(""://xp0/ADMIN\$"") -> ://xp0/ADMIN\$
> Sep 16 01:03:13 tempgw automount[17954]: add_offset_entry: parse(sun):
> added multi-mount offset /ADMIN$ ->
> -fstype=cifs,username=USER,password=PASSWORD ://xp0/ADMIN\$
> Sep 16 01:03:13 tempgw automount[17954]: parse_mount: parse(sun):
> dequote("/C\$") -> /C$
> Sep 16 01:03:13 tempgw automount[17954]: parse_mapent: parse(sun):
> gathered options: fstype=cifs,username=USER,password=PASSWORD
> Sep 16 01:03:13 tempgw automount[17954]: parse_mapent: parse(sun):
> dequote(""://xp0/C\$"") -> ://xp0/C\$
> Sep 16 01:03:13 tempgw automount[17954]: add_offset_entry: parse(sun):
> added multi-mount offset /C$ ->
> -fstype=cifs,username=USER,password=PASSWORD ://xp0/C\$
> Sep 16 01:03:13 tempgw automount[17954]: mount_multi_triggers: mount
> offset /smb/xp0/ADMIN$
> Sep 16 01:03:13 tempgw automount[17954]: mount_autofs_offset: calling
> mount -t autofs -s  -o fd=18,pgrp=17954,minproto=5,maxproto=5,offset
> automount /smb/xp0/ADMIN$
> Sep 16 01:03:13 tempgw automount[17954]: mount_autofs_offset: mounted
> trigger /smb/xp0/ADMIN$
> Sep 16 01:03:13 tempgw automount[17954]: mount_multi_triggers: mount
> offset /smb/xp0/C
> Sep 16 01:03:13 tempgw automount[17954]: mount_autofs_offset: calling
> mount -t autofs -s  -o fd=18,pgrp=17954,minproto=5,maxproto=5,offset
> automount /smb/xp0/C
> Sep 16 01:03:13 tempgw automount[17954]: mount_autofs_offset: mounted
> trigger /smb/xp0/C
> Sep 16 01:03:13 tempgw automount[17954]: mount_multi_triggers: mount
> offset /smb/xp0/C$
> Sep 16 01:03:13 tempgw automount[17954]: mount_autofs_offset: calling
> mount -t autofs -s  -o fd=18,pgrp=17954,minproto=5,maxproto=5,offset
> automount /smb/xp0/C$
> Sep 16 01:03:13 tempgw automount[17954]: mount_autofs_offset: mounted
> trigger /smb/xp0/C$
> Sep 16 01:03:13 tempgw automount[17954]: send_ready: token = 344
> Sep 16 01:03:13 tempgw automount[17954]: handle_packet: type = 5
> Sep 16 01:03:13 tempgw automount[17954]: handle_packet_missing_direct:
> token 345, name /smb/xp0/C$, request pid 17592
> Sep 16 01:03:13 tempgw automount[17954]: attempting to mount
> entry /smb/xp0/C$
> Sep 16 01:03:13 tempgw automount[17954]: lookup_mount:
> lookup(program): /smb/xp0/C$ ->
> -fstype=cifs,username=USER,password=PASSWORD ://xp0/C\$
> Sep 16 01:03:13 tempgw automount[17954]: parse_mount: parse(sun):
> expanded entry: -fstype=cifs,username=USER,password=PASSWORD ://xp0/C\
> $
> Sep 16 01:03:13 tempgw automount[17954]: parse_mount: parse(sun):
> gathered options: fstype=cifs,username=USER,password=PASSWORD
> Sep 16 01:03:13 tempgw automount[17954]: parse_mount: parse(sun): core
> of entry: options=fstype=cifs,username=USER,password=PASSWORD,
> loc=://xp0/C\$
> Sep 16 01:03:13 tempgw automount[17954]: sun_mount: parse(sun):
> mounting root /smb, mountpoint /smb/xp0/C$, what //xp0/C\$, fstype
> cifs, options username=USER,password=PASSWORD
> Sep 16 01:03:13 tempgw automount[17954]: mounted /smb/xp0
> Sep 16 01:03:13 tempgw automount[17954]: do_mount: //xp0/C\
> $ /smb//smb/xp0/C$ type cifs options username=USER,password=PASSWORD
> using module generic
> Sep 16 01:03:13 tempgw automount[17954]: mount_mount: mount(generic):
> calling mkdir_path /smb/xp0/C$
> Sep 16 01:03:13 tempgw automount[17954]: mount_mount: mount(generic):
> calling mount -t cifs -s -o username=USER,password=PASSWORD //xp0/C\
> $ /smb/xp0/C$

So it appears autofs is doing the right thing.
But it doesn't end up right, odd!

> Sep 16 01:03:13 tempgw automount[17954]: mount(generic):
> mounted //xp0/C\$ type cifs on /smb/xp0/C$
> Sep 16 01:03:13 tempgw automount[17954]: send_ready: token = 345
> Sep 16 01:03:13 tempgw automount[17954]: mounted /smb/xp0/C$

And again it tells us the right thing.

> Sep 16 01:03:13 tempgw automount[17954]: st_expire: state 1 path /misc
> Sep 16 01:03:13 tempgw automount[17954]: expire_proc: exp_proc =
> 3082075024 path /misc
> Sep 16 01:03:13 tempgw automount[17954]: expire_cleanup: got thid
> 3082075024 path /misc stat 0
> Sep 16 01:03:13 tempgw automount[17954]: expire_cleanup: sigchld: exp
> 3082075024 finished, switching from 2 to 1
> Sep 16 01:03:13 tempgw automount[17954]: st_ready: st_ready(): state =
> 2 path /misc
> 
> 
> 
> After cd /smb/xp0/C$
> pwd yields: /smb/xp0/C$
> and mount yields: //xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)
> 
> Thanks
> 
> Ian Kent wrote: 
> > On Sat, 2008-09-13 at 12:03 +1000, Matthew Jurgens wrote:
> >   
> > > Ok, so I updated the script to the RPM version and added the
> > > authentication parts:
> > >     
> > 
> > Right, the reason the script changed was because of the "$" shares.
> > I thought it was working ok but maybe a subsequent change to the daemon
> > has broken it.
> > 
> > I'll try to duplicate the problem here but a debug log would also be
> > useful. See http://people.redhat.com/jmoyer for details.
