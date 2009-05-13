From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: unable to automount windows C$
Date: Wed, 13 May 2009 14:57:30 +1000
Message-ID: <4A0A533A.3060203@edcint.co.nz>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7033797876197565083=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A08FEE6.7000604@themaw.net>
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

This is a multi-part message in MIME format.
--===============7033797876197565083==
Content-Type: multipart/alternative;
 boundary="------------050704060906060609000405"

This is a multi-part message in MIME format.
--------------050704060906060609000405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ian Kent wrote:
> Matthew Jurgens wrote:
>   
>> I've had this same problem from time to time and since upgrading to
>> Fedora 10 it has come back:
>> Fedora 10 - kernel 2.6.27.21-170.2.56.fc10.i686.PAE
>> autofs-5.0.3-41.i386
>>
>> The correctly mounted manual entry:
>> //xp0/C$ on /mnt type cifs (rw,mand)
>>
>> The autofs entry:
>> //xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)
>>
>> If you need anymore debug info let me know
>>     
>
> I have no idea what you are trying to say.
> The above, //xp0/C/$, doesn't correspond to what autofs-5.0.3-41 passes
> to mount(8) and I have no idea what has happened since you haven't
> provided any log information
Sorry, here is more information:

Windows machine called xp0.
cd /smb/xp0/C$ yields the following debug:

May 13 14:43:28 gw automount[15573]: handle_packet: type = 3
May 13 14:43:28 gw automount[15573]: handle_packet_missing_indirect: 
token 57, name xp0, request pid 15215
May 13 14:43:28 gw automount[15573]: attempting to mount entry /smb/xp0
May 13 14:43:28 gw automount[15573]: lookup_mount: lookup(program): 
looking up xp0
May 13 14:43:28 gw automount[15573]: lookup_mount: lookup(program): xp0 
-> -fstype=cifs,username=USERNAME,password=PASSWORD  #011 /C "://xp0/C"  
#011 /ADMIN\$ "://xp0/ADMIN\$"  #011 /C\$ "://xp0/C\$"
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): expanded 
entry: -fstype=cifs,username=USERNAME,password=PASSWORD  #011 /C 
"://xp0/C"  #011 /ADMIN\$ "://xp0/ADMIN\$"  #011 /C\$ "://xp0/C\$"
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): gathered 
options: fstype=cifs,username=USERNAME,password=PASSWORD
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): 
dequote("/C") -> /C
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): gathered 
options: fstype=cifs,username=USERNAME,password=PASSWORD
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): 
dequote(""://xp0/C"") -> ://xp0/C
May 13 14:43:28 gw automount[15573]: add_offset_entry: parse(sun): added 
multi-mount offset /C -> 
-fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): 
dequote("/ADMIN\$") -> /ADMIN$
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): gathered 
options: fstype=cifs,username=USERNAME,password=PASSWORD
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): 
dequote(""://xp0/ADMIN\$"") -> ://xp0/ADMIN\$
May 13 14:43:28 gw automount[15573]: add_offset_entry: parse(sun): added 
multi-mount offset /ADMIN$ -> 
-fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/ADMIN\$
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): 
dequote("/C\$") -> /C$
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): gathered 
options: fstype=cifs,username=USERNAME,password=PASSWORD
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): 
dequote(""://xp0/C\$"") -> ://xp0/C\$
May 13 14:43:28 gw automount[15573]: add_offset_entry: parse(sun): added 
multi-mount offset /C$ -> 
-fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C\$
May 13 14:43:28 gw automount[15573]: mount_multi_triggers: mount offset 
/smb/xp0/ADMIN$ at /smb/xp0
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: calling mount 
-t autofs -s  -o fd=18,pgrp=15573,minproto=5,maxproto=5,offset automount 
/smb/xp0/ADMIN$
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: mounted 
trigger /smb/xp0/ADMIN$ at /smb/xp0/ADMIN$
May 13 14:43:28 gw automount[15573]: mount_multi_triggers: mount offset 
/smb/xp0/C at /smb/xp0
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: calling mount 
-t autofs -s  -o fd=18,pgrp=15573,minproto=5,maxproto=5,offset automount 
/smb/xp0/C
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: mounted 
trigger /smb/xp0/C at /smb/xp0/C
May 13 14:43:28 gw automount[15573]: mount_multi_triggers: mount offset 
/smb/xp0/C$ at /smb/xp0
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: calling mount 
-t autofs -s  -o fd=18,pgrp=15573,minproto=5,maxproto=5,offset automount 
/smb/xp0/C$
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: mounted 
trigger /smb/xp0/C$ at /smb/xp0/C$
May 13 14:43:28 gw automount[15573]: send_ready: token = 57
May 13 14:43:28 gw automount[15573]: mounted /smb/xp0
May 13 14:43:28 gw automount[15573]: handle_packet: type = 5
May 13 14:43:28 gw automount[15573]: handle_packet_missing_direct: token 
58, name /smb/xp0/C$, request pid 15215
May 13 14:43:28 gw automount[15573]: attempting to mount entry /smb/xp0/C$
May 13 14:43:28 gw automount[15573]: lookup_mount: lookup(program): 
/smb/xp0/C$ -> -fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C\$
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): expanded 
entry: -fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C\$
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): gathered 
options: fstype=cifs,username=USERNAME,password=PASSWORD
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): core of 
entry: options=fstype=cifs,username=USERNAME,password=PASSWORD, 
loc=://xp0/C\$
May 13 14:43:28 gw automount[15573]: sun_mount: parse(sun): mounting 
root /tmp/auto6t8L4W, mountpoint /smb/xp0/C$, what //xp0/C\$, fstype 
cifs, options username=USERNAME,password=PASSWORD
May 13 14:43:28 gw automount[15573]: do_mount: //xp0/C\$ 
/tmp/auto6t8L4W//smb/xp0/C$ type cifs options 
username=USERNAME,password=PASSWORD using module generic
May 13 14:43:28 gw automount[15573]: mount_mount: mount(generic): 
calling mkdir_path /tmp/auto6t8L4W
May 13 14:43:28 gw automount[15573]: mount_mount: mount(generic): 
calling mount -t cifs -s -o username=USERNAME,password=PASSWORD 
//xp0/C\$ /tmp/auto6t8L4W
May 13 14:43:28 gw automount[15573]: mount(generic): mounted //xp0/C\$ 
type cifs on /tmp/auto6t8L4W
May 13 14:43:28 gw automount[15573]: move_mount: moved mount tree from 
/tmp/auto6t8L4W to /smb/xp0/C$
May 13 14:43:28 gw automount[15573]: send_ready: token = 58
May 13 14:43:28 gw automount[15573]: mounted /smb/xp0/C$

The output of a mount command is:
//xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)

The incorrect target of //xp0/C/$ does not appear to be reflected in the 
debug output

The correct output of the mount command should be:
//xp0/C$ on /smb/xp0/C$ type cifs (rw,mand)

-------------------------------------------------------------------------------------------------------------------
http://www.smartmon.com.au

--------------050704060906060609000405
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Ian Kent wrote:
<blockquote cite="mid:4A08FEE6.7000604@themaw.net" type="cite">
  <pre wrap="">Matthew Jurgens wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I've had this same problem from time to time and since upgrading to
Fedora 10 it has come back:
Fedora 10 - kernel 2.6.27.21-170.2.56.fc10.i686.PAE
autofs-5.0.3-41.i386

The correctly mounted manual entry:
//xp0/C$ on /mnt type cifs (rw,mand)

The autofs entry:
//xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)

If you need anymore debug info let me know
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I have no idea what you are trying to say.
The above, //xp0/C/$, doesn't correspond to what autofs-5.0.3-41 passes
to mount(8) and I have no idea what has happened since you haven't
provided any log information</pre>
</blockquote>
Sorry, here is more information:<br>
<br>
Windows machine called xp0.<br>
cd /smb/xp0/C$ yields the following debug:<br>
<br>
May 13 14:43:28 gw automount[15573]: handle_packet: type = 3<br>
May 13 14:43:28 gw automount[15573]: handle_packet_missing_indirect:
token 57, name xp0, request pid 15215<br>
May 13 14:43:28 gw automount[15573]: attempting to mount entry /smb/xp0<br>
May 13 14:43:28 gw automount[15573]: lookup_mount: lookup(program):
looking up xp0<br>
May 13 14:43:28 gw automount[15573]: lookup_mount: lookup(program): xp0
-&gt; -fstype=cifs,username=USERNAME,password=PASSWORD&nbsp; #011 /C
"://xp0/C"&nbsp; #011 /ADMIN\$ "://xp0/ADMIN\$"&nbsp; #011 /C\$ "://xp0/C\$"<br>
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): expanded
entry: -fstype=cifs,username=USERNAME,password=PASSWORD&nbsp; #011 /C
"://xp0/C"&nbsp; #011 /ADMIN\$ "://xp0/ADMIN\$"&nbsp; #011 /C\$ "://xp0/C\$"<br>
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): gathered
options: fstype=cifs,username=USERNAME,password=PASSWORD<br>
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun):
dequote("/C") -&gt; /C<br>
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): gathered
options: fstype=cifs,username=USERNAME,password=PASSWORD<br>
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun):
dequote(""://xp0/C"") -&gt; ://xp0/C<br>
May 13 14:43:28 gw automount[15573]: add_offset_entry: parse(sun):
added multi-mount offset /C -&gt;
-fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C<br>
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun):
dequote("/ADMIN\$") -&gt; /ADMIN$<br>
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): gathered
options: fstype=cifs,username=USERNAME,password=PASSWORD<br>
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun):
dequote(""://xp0/ADMIN\$"") -&gt; ://xp0/ADMIN\$<br>
May 13 14:43:28 gw automount[15573]: add_offset_entry: parse(sun):
added multi-mount offset /ADMIN$ -&gt;
-fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/ADMIN\$<br>
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun):
dequote("/C\$") -&gt; /C$<br>
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun): gathered
options: fstype=cifs,username=USERNAME,password=PASSWORD<br>
May 13 14:43:28 gw automount[15573]: parse_mapent: parse(sun):
dequote(""://xp0/C\$"") -&gt; ://xp0/C\$<br>
May 13 14:43:28 gw automount[15573]: add_offset_entry: parse(sun):
added multi-mount offset /C$ -&gt;
-fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C\$<br>
May 13 14:43:28 gw automount[15573]: mount_multi_triggers: mount offset
/smb/xp0/ADMIN$ at /smb/xp0<br>
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: calling mount
-t autofs -s&nbsp; -o fd=18,pgrp=15573,minproto=5,maxproto=5,offset
automount /smb/xp0/ADMIN$<br>
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: mounted
trigger /smb/xp0/ADMIN$ at /smb/xp0/ADMIN$<br>
May 13 14:43:28 gw automount[15573]: mount_multi_triggers: mount offset
/smb/xp0/C at /smb/xp0<br>
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: calling mount
-t autofs -s&nbsp; -o fd=18,pgrp=15573,minproto=5,maxproto=5,offset
automount /smb/xp0/C<br>
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: mounted
trigger /smb/xp0/C at /smb/xp0/C<br>
May 13 14:43:28 gw automount[15573]: mount_multi_triggers: mount offset
/smb/xp0/C$ at /smb/xp0<br>
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: calling mount
-t autofs -s&nbsp; -o fd=18,pgrp=15573,minproto=5,maxproto=5,offset
automount /smb/xp0/C$<br>
May 13 14:43:28 gw automount[15573]: mount_autofs_offset: mounted
trigger /smb/xp0/C$ at /smb/xp0/C$<br>
May 13 14:43:28 gw automount[15573]: send_ready: token = 57<br>
May 13 14:43:28 gw automount[15573]: mounted /smb/xp0<br>
May 13 14:43:28 gw automount[15573]: handle_packet: type = 5<br>
May 13 14:43:28 gw automount[15573]: handle_packet_missing_direct:
token 58, name /smb/xp0/C$, request pid 15215<br>
May 13 14:43:28 gw automount[15573]: attempting to mount entry
/smb/xp0/C$<br>
May 13 14:43:28 gw automount[15573]: lookup_mount: lookup(program):
/smb/xp0/C$ -&gt; -fstype=cifs,username=USERNAME,password=PASSWORD
://xp0/C\$<br>
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): expanded
entry: -fstype=cifs,username=USERNAME,password=PASSWORD ://xp0/C\$<br>
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): gathered
options: fstype=cifs,username=USERNAME,password=PASSWORD<br>
May 13 14:43:28 gw automount[15573]: parse_mount: parse(sun): core of
entry: options=fstype=cifs,username=USERNAME,password=PASSWORD,
loc=://xp0/C\$<br>
May 13 14:43:28 gw automount[15573]: sun_mount: parse(sun): mounting
root /tmp/auto6t8L4W, mountpoint /smb/xp0/C$, what //xp0/C\$, fstype
cifs, options username=USERNAME,password=PASSWORD<br>
May 13 14:43:28 gw automount[15573]: do_mount: //xp0/C\$
/tmp/auto6t8L4W//smb/xp0/C$ type cifs options
username=USERNAME,password=PASSWORD using module generic<br>
May 13 14:43:28 gw automount[15573]: mount_mount: mount(generic):
calling mkdir_path /tmp/auto6t8L4W<br>
May 13 14:43:28 gw automount[15573]: mount_mount: mount(generic):
calling mount -t cifs -s -o username=USERNAME,password=PASSWORD
//xp0/C\$ /tmp/auto6t8L4W<br>
May 13 14:43:28 gw automount[15573]: mount(generic): mounted //xp0/C\$
type cifs on /tmp/auto6t8L4W<br>
May 13 14:43:28 gw automount[15573]: move_mount: moved mount tree from
/tmp/auto6t8L4W to /smb/xp0/C$<br>
May 13 14:43:28 gw automount[15573]: send_ready: token = 58<br>
May 13 14:43:28 gw automount[15573]: mounted /smb/xp0/C$<br>
<br>
The output of a mount command is:<br>
//xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)<br>
<br>
The incorrect target of //xp0/C/$ does not appear to be reflected in
the debug output<br>
<br>
The correct output of the mount command should be:<br>
//xp0/C$ on /smb/xp0/C$ type cifs (rw,mand)<br>
<br>
-------------------------------------------------------------------------------------------------------------------<br>
<a class="moz-txt-link-freetext" href="http://www.smartmon.com.au">http://www.smartmon.com.au</a><br>
</body>
</html>

--------------050704060906060609000405--


--===============7033797876197565083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7033797876197565083==--

