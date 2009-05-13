From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: unable to automount windows C$
Date: Thu, 14 May 2009 09:55:25 +1000
Message-ID: <4A0B5DED.1090900@edcint.co.nz>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A0A7ECB.2060604@themaw.net>
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


> I bet that:
> mount -t cifs -o username=USER,password=PASS \
> 	'//xp0/C\$' /mnt/C\$
> fails.
>
>   
Good bet.
It certainly does fail. The output of mount for that is now:

//xp0/C/$ on /mnt/C$ type cifs (rw,mand)

Reading ahead in the thread Jeff says "'\' is a valid character in posix 
path components" which does explain this behaviour

Do you really need the \ in front of the $ when it is already quoted?

Reading ahead again I comment out the gsub in /etc/auto.smb which 
changes the output from
-fstype=cifs,username=USER,password=PASS \
         /C "://xp0/C" \
         /ADMIN\$ "://xp0/ADMIN\$" \
         /C\$ "://xp0/C\$"

to

-fstype=cifs,username=USER,password=PASS \
         /C "://xp0/C" \
         /ADMIN$ "://xp0/ADMIN$" \
         /C$ "://xp0/C$"

So the
/C$ "://xp0/C$"
does look at little friendlier but does not actually work (does some 
autofs code need to change as well?).

When I
cd /smb/xp0/C$
I get
cd: no such file or directory: /smb/xp0/C$

I get the same result even trying to
cd /smb/xp0

The debug output from this is:

May 14 09:49:52 gw automount[9171]: handle_packet: type = 3
May 14 09:49:52 gw automount[9171]: handle_packet_missing_indirect: 
token 71, name xp0, request pid 15215
May 14 09:49:52 gw automount[9171]: attempting to mount entry /smb/xp0
May 14 09:49:52 gw automount[9171]: lookup_mount: lookup(program): 
looking up xp0
May 14 09:49:52 gw automount[9171]: lookup_mount: lookup(program): xp0 
-> -fstype=cifs,username=USER,password=PASS  #011 /C "://xp0/C"  #011 
/ADMIN$ "://xp0/ADMIN$"  #011 /C$ "://xp0/C$"
May 14 09:49:52 gw automount[9171]: parse_mount: parse(sun): expanded 
entry: -fstype=cifs,username=USER,password=PASS  #011 /C "://xp0/C"  
#011 /ADMIN "://xp0/ADMIN$"  #011 /C "://xp0/C$"
May 14 09:49:52 gw automount[9171]: parse_mount: parse(sun): gathered 
options: fstype=cifs,username=USER,password=PASS
May 14 09:49:52 gw automount[9171]: parse_mount: parse(sun): 
dequote("/C") -> /C
May 14 09:49:52 gw automount[9171]: parse_mapent: parse(sun): gathered 
options: fstype=cifs,username=USER,password=PASS
May 14 09:49:52 gw automount[9171]: parse_mapent: parse(sun): 
dequote(""://xp0/C"") -> ://xp0/C
May 14 09:49:52 gw automount[9171]: add_offset_entry: parse(sun): added 
multi-mount offset /C -> -fstype=cifs,username=USER,password=PASS ://xp0/C
May 14 09:49:52 gw automount[9171]: parse_mount: parse(sun): 
dequote("/ADMIN") -> /ADMIN
May 14 09:49:52 gw automount[9171]: parse_mapent: parse(sun): gathered 
options: fstype=cifs,username=USER,password=PASS
May 14 09:49:52 gw automount[9171]: parse_mapent: parse(sun): 
dequote(""://xp0/ADMIN$"") -> ://xp0/ADMIN$
May 14 09:49:52 gw automount[9171]: add_offset_entry: parse(sun): added 
multi-mount offset /ADMIN -> -fstype=cifs,username=USER,password=PASS 
://xp0/ADMIN$
May 14 09:49:52 gw automount[9171]: parse_mount: parse(sun): 
dequote("/C") -> /C
May 14 09:49:52 gw automount[9171]: parse_mapent: parse(sun): gathered 
options: fstype=cifs,username=USER,password=PASS
May 14 09:49:52 gw automount[9171]: parse_mapent: parse(sun): 
dequote(""://xp0/C$"") -> ://xp0/C$
May 14 09:49:52 gw automount[9171]: parse(sun): syntax error or 
duplicate offset /C -> ://xp0/C$
May 14 09:49:52 gw automount[9171]: parse(sun): error adding multi-mount
May 14 09:49:52 gw automount[9171]: cache_delete_offset_list: deleting 
offset key /smb/xp0/ADMIN
May 14 09:49:52 gw automount[9171]: cache_delete_offset_list: deleting 
offset key /smb/xp0/C
May 14 09:49:52 gw automount[9171]: send_fail: token = 71
May 14 09:49:52 gw automount[9171]: failed to mount /smb/xp0
May 14 09:49:52 gw automount[9171]: handle_packet: type = 3
May 14 09:49:52 gw automount[9171]: handle_packet_missing_indirect: 
token 72, name xp0, request pid 15215
May 14 09:49:52 gw automount[9171]: attempting to mount entry /smb/xp0
May 14 09:49:52 gw automount[9171]: lookup_nss_mount: key "xp0" not 
found in map.
May 14 09:49:52 gw automount[9171]: send_fail: token = 72
May 14 09:49:52 gw automount[9171]: failed to mount /smb/xp0
