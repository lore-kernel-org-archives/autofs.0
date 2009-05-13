From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Wed, 13 May 2009 13:05:43 +0800
Message-ID: <4A0A5527.2060207@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A0A533A.3060203@edcint.co.nz>
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
Cc: autofs@linux.kernel.org

Matthew Jurgens wrote:
> Ian Kent wrote:
>> Matthew Jurgens wrote:
>>  
>>> I've had this same problem from time to time and since upgrading to
>>> Fedora 10 it has come back:
>>> Fedora 10 - kernel 2.6.27.21-170.2.56.fc10.i686.PAE
>>> autofs-5.0.3-41.i386
>>>
>>> The correctly mounted manual entry:
>>> //xp0/C$ on /mnt type cifs (rw,mand)
>>>
>>> The autofs entry:
>>> //xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)
>>>
>>> If you need anymore debug info let me know
>>>     
>>
>> I have no idea what you are trying to say.
>> The above, //xp0/C/$, doesn't correspond to what autofs-5.0.3-41 passes
>> to mount(8) and I have no idea what has happened since you haven't
>> provided any log information
> Sorry, here is more information:
> 
> Windows machine called xp0.
> cd /smb/xp0/C$ yields the following debug:
> 
> May 13 14:43:28 gw automount[15573]: handle_packet: type = 3
> May 13 14:43:28 gw automount[15573]: handle_packet_missing_indirect:
> token 57, name xp0, request pid 15215
> May 13 14:43:28 gw automount[15573]: attempting to mount entry /smb/xp0
> May 13 14:43:28 gw automount[15573]: lookup_mount: lookup(program):
> looking up xp0
> May 13 14:43:28 gw automount[15573]: lookup_mount: lookup(program): xp0
> -> -fstype=cifs,username=USERNAME,password=PASSWORD  #011 /C "://xp0/C" 
> #011 /ADMIN\$ "://xp0/ADMIN\$"  #011 /C\$ "://xp0/C\$"
> May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): expanded
> entry: -fstype=cifs,username=USERNAME,password=PASSWORD  #011 /C
> "://xp0/C"  #011 /ADMIN\$ "://xp0/ADMIN\$"  #011 /C\$ "://xp0/C\$"
> May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): gathered
> options: fstype=cifs,username=USERNAME,password=PASSWORD
> May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun):
> dequote("/C") -> /C
> May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): gathered
> options: fstype=cifs,username=USERNAME,password=PASSWORD
> May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun):
> dequote(""://xp0/C"") -> ://xp0/C
> May 13 14:43:28 gw automount[15573]: add_offset_entry: parse(sun): added
> multi-mount offset /C ->
> -fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C
> May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun):
> dequote("/ADMIN\$") -> /ADMIN$
> May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): gathered
> options: fstype=cifs,username=USERNAME,password=PASSWORD
> May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun):
> dequote(""://xp0/ADMIN\$"") -> ://xp0/ADMIN\$
> May 13 14:43:28 gw automount[15573]: add_offset_entry: parse(sun): added
> multi-mount offset /ADMIN$ ->
> -fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/ADMIN\$
> May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun):
> dequote("/C\$") -> /C$
> May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): gathered
> options: fstype=cifs,username=USERNAME,password=PASSWORD
> May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun):
> dequote(""://xp0/C\$"") -> ://xp0/C\$
> May 13 14:43:28 gw automount[15573]: add_offset_entry: parse(sun): added
> multi-mount offset /C$ ->
> -fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C\$
> May 13 14:43:28 gw automount[15573]: mount_multi_triggers: mount offset
> /smb/xp0/ADMIN$ at /smb/xp0
> May 13 14:43:28 gw automount[15573]: mount_autofs_offset: calling mount
> -t autofs -s  -o fd=18,pgrp=15573,minproto=5,maxproto=5,offset automount
> /smb/xp0/ADMIN$
> May 13 14:43:28 gw automount[15573]: mount_autofs_offset: mounted
> trigger /smb/xp0/ADMIN$ at /smb/xp0/ADMIN$
> May 13 14:43:28 gw automount[15573]: mount_multi_triggers: mount offset
> /smb/xp0/C at /smb/xp0
> May 13 14:43:28 gw automount[15573]: mount_autofs_offset: calling mount
> -t autofs -s  -o fd=18,pgrp=15573,minproto=5,maxproto=5,offset automount
> /smb/xp0/C
> May 13 14:43:28 gw automount[15573]: mount_autofs_offset: mounted
> trigger /smb/xp0/C at /smb/xp0/C
> May 13 14:43:28 gw automount[15573]: mount_multi_triggers: mount offset
> /smb/xp0/C$ at /smb/xp0
> May 13 14:43:28 gw automount[15573]: mount_autofs_offset: calling mount
> -t autofs -s  -o fd=18,pgrp=15573,minproto=5,maxproto=5,offset automount
> /smb/xp0/C$
> May 13 14:43:28 gw automount[15573]: mount_autofs_offset: mounted
> trigger /smb/xp0/C$ at /smb/xp0/C$
> May 13 14:43:28 gw automount[15573]: send_ready: token = 57
> May 13 14:43:28 gw automount[15573]: mounted /smb/xp0
> May 13 14:43:28 gw automount[15573]: handle_packet: type = 5
> May 13 14:43:28 gw automount[15573]: handle_packet_missing_direct: token
> 58, name /smb/xp0/C$, request pid 15215
> May 13 14:43:28 gw automount[15573]: attempting to mount entry /smb/xp0/C$
> May 13 14:43:28 gw automount[15573]: lookup_mount: lookup(program):
> /smb/xp0/C$ -> -fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C\$
> May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): expanded
> entry: -fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C\$
> May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): gathered
> options: fstype=cifs,username=USERNAME,password=PASSWORD
> May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): core of
> entry: options=fstype=cifs,username=USERNAME,password=PASSWORD,
> loc=://xp0/C\$
> May 13 14:43:28 gw automount[15573]: sun_mount: parse(sun): mounting
> root /tmp/auto6t8L4W, mountpoint /smb/xp0/C$, what //xp0/C\$, fstype
> cifs, options username=USERNAME,password=PASSWORD
> May 13 14:43:28 gw automount[15573]: do_mount: //xp0/C\$
> /tmp/auto6t8L4W//smb/xp0/C$ type cifs options
> username=USERNAME,password=PASSWORD using module generic
> May 13 14:43:28 gw automount[15573]: mount_mount: mount(generic):
> calling mkdir_path /tmp/auto6t8L4W
> May 13 14:43:28 gw automount[15573]: mount_mount: mount(generic):
> calling mount -t cifs -s -o username=USERNAME,password=PASSWORD
> //xp0/C\$ /tmp/auto6t8L4W
> May 13 14:43:28 gw automount[15573]: mount(generic): mounted //xp0/C\$
> type cifs on /tmp/auto6t8L4W
> May 13 14:43:28 gw automount[15573]: move_mount: moved mount tree from
> /tmp/auto6t8L4W to /smb/xp0/C$
> May 13 14:43:28 gw automount[15573]: send_ready: token = 58
> May 13 14:43:28 gw automount[15573]: mounted /smb/xp0/C$
> 
> The output of a mount command is:
> //xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)
> 
> The incorrect target of //xp0/C/$ does not appear to be reflected in the
> debug output
> 
> The correct output of the mount command should be:
> //xp0/C$ on /smb/xp0/C$ type cifs (rw,mand)

Clearly it isn't an autofs problem.
It's a mount.cifs (or mount(8)) problem.

Ian
