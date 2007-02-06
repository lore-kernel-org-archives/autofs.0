From: "Harmuth, Florian" <fhar@msc-ge.com>
Subject: Automount and timeout option?
Date: Tue, 6 Feb 2007 16:49:23 +0100
Message-ID: <2D6F4E675EF5F04D8F97184E32378A1B2C3EF1@msc-ex02.msc-ge.mscnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4578997068330088017=="
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

--===============4578997068330088017==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C74A06.292DC0DE"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C74A06.292DC0DE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,
i start automount during my startup with the following line:
automount -d --timeout=3D10 /tmp/media file /etc/auto.msc

Which results in the following output:
-bash-2.05b# tail -f /var/log/messages
Jan 31 05:11:21 (none) daemon.info automount[919]: starting automounter =
version 4.1.4, path =3D /tmp/media, maptype =3D file, mapname =3D =
/etc/auto.msc
Jan 31 05:11:21 (none) daemon.debug automount[919]: mount(bind): =
bind_works =3D 1=20
Jan 31 05:11:21 (none) daemon.debug automount[919]: kproto sub: Function =
not implemented
Jan 31 05:11:21 (none) daemon.info automount[919]: using kernel protocol =
version 3.00
Jan 31 05:11:21 (none) daemon.info automount[919]: using timeout 10 =
seconds; freq 3 secs
Jan 31 05:11:25 (none) daemon.debug automount[919]: sig 14 switching =
from 1 to 2
Jan 31 05:11:25 (none) daemon.debug automount[919]: get_pkt: state 1, =
next 2
Jan 31 05:11:25 (none) daemon.debug automount[919]: st_expire(): state =
=3D 1=20
Jan 31 05:11:28 (none) daemon.debug automount[919]: sig 14 switching =
from 1 to 2
Jan 31 05:11:28 (none) daemon.debug automount[919]: get_pkt: state 1, =
next 2
Jan 31 05:11:28 (none) daemon.debug automount[919]: st_expire(): state =
=3D 1=20

Now i go to my usb device cd /tmp/media/usbstick and get the following =
output:
...
Jan 31 05:12:37 (none) daemon.debug automount[919]: handle_packet: type =
=3D 0=20
Jan 31 05:12:37 (none) daemon.debug automount[919]: =
handle_packet_missing: token 5, name usbstick=20
Jan 31 05:12:37 (none) daemon.info automount[919]: attempting to mount =
entry /tmp/media/usbstick
Jan 31 05:12:37 (none) daemon.debug automount[1167]: lookup(file): =
usbstick -> -fstype=3Dauto :/dev/sda1
Jan 31 05:12:37 (none) daemon.debug automount[1167]: parse(sun): =
expanded entry: -fstype=3Dauto :/dev/sda1
Jan 31 05:12:37 (none) daemon.debug automount[1167]: parse(sun): =
dequote("fstype=3Dauto") -> fstype=3Dauto
Jan 31 05:12:37 (none) daemon.debug automount[1167]: parse(sun): =
gathered options: fstype=3Dauto
Jan 31 05:12:37 (none) daemon.debug automount[1167]: parse(sun): =
dequote("/dev/sda1") -> /dev/sda1
Jan 31 05:12:37 (none) daemon.debug automount[1167]: parse(sun): core of =
entry: options=3Dfstype=3Dauto, loc=3D/dev/sda1
Jan 31 05:12:37 (none) daemon.debug automount[1167]: parse(sun): =
mounting root /tmp/media, mountpoint usbstick, what /dev/sda1, fstype =
auto, options =20
Jan 31 05:12:37 (none) daemon.debug automount[1167]: do_mount /dev/sda1 =
/tmp/media/usbstick type auto options  using module generic
Jan 31 05:12:37 (none) daemon.debug automount[1167]: mount(generic): =
calling mkdir_path /tmp/media/usbstick
Jan 31 05:12:37 (none) daemon.debug automount[1167]: mount(generic): =
calling mount -t auto /dev/sda1 /tmp/media/usbstick
Jan 31 05:12:38 (none) daemon.debug automount[1167]: mount(generic): =
mounted /dev/sda1 type auto on /tmp/media/usbstick
Jan 31 05:12:38 (none) daemon.debug automount[919]: handle_child: got =
pid 1167, sig 0 (0), stat 0=20
Jan 31 05:12:38 (none) daemon.debug automount[919]: sig_child: found =
pending iop pid 1167: signalled 0 (sig 0), exit status 0
Jan 31 05:12:38 (none) daemon.debug automount[919]: send_ready: =
token=3D5=20
Jan 31 05:12:40 (none) daemon.debug automount[919]: sig 14 switching =
from 1 to 2
Jan 31 05:12:40 (none) daemon.debug automount[919]: get_pkt: state 1, =
next 2
Jan 31 05:12:40 (none) daemon.debug automount[919]: st_expire(): state =
=3D 1=20
Jan 31 05:12:43 (none) daemon.debug automount[919]: sig 14 switching =
from 1 to 2
Jan 31 05:12:43 (none) daemon.debug automount[919]: get_pkt: state 1, =
next 2
Jan 31 05:12:43 (none) daemon.debug automount[919]: st_expire(): state =
=3D 1=20

If i changenow to the root dir (cd /) i get after a few seconds the =
following output:
...
Jan 31 05:14:25 (none) daemon.debug automount[919]: st_expire(): state =
=3D 1=20
Jan 31 05:14:25 (none) daemon.debug automount[1190]: expiring path =
/tmp/media/usbstick
Jan 31 05:14:25 (none) daemon.debug automount[1190]: umount_multi: =
path=3D/tmp/media/usbstick incl=3D1=20
Jan 31 05:14:25 (none) daemon.warn automount[1190]: umount_multi: no =
mounts found under /tmp/media/usbstick
Jan 31 05:14:25 (none) daemon.info automount[1190]: expired =
/tmp/media/usbstick
Jan 31 05:14:25 (none) daemon.debug automount[919]: handle_child: got =
pid 1190, sig 0 (0), stat 0=20
Jan 31 05:14:25 (none) daemon.debug automount[919]: sig_child: found =
pending iop pid 1190: signalled 0 (sig 0), exit status 0
Jan 31 05:14:28 (none) daemon.debug automount[919]: sig 14 switching =
from 1 to 2
Jan 31 05:14:28 (none) daemon.debug automount[919]: get_pkt: state 1, =
next 2
Jan 31 05:14:28 (none) daemon.debug automount[919]: st_expire(): state =
=3D 1=20

Is it safe to remove the stick now? I aks because under /tmp/media/ the =
folder usbstick is still there.

Best Regards,
flo





------_=_NextPart_001_01C74A06.292DC0DE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7650.28">
<TITLE>Automount and timeout option?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello all,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">i start automount during my startup =
with the following line:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">automount -d --timeout=3D10 /tmp/media =
file /etc/auto.msc</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Which results in the following =
output:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">-bash-2.05b# tail -f =
/var/log/messages</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:21 (none) daemon.info =
automount[919]: starting automounter version 4.1.4, path =3D /tmp/media, =
maptype =3D file, mapname =3D /etc/auto.msc</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:21 (none) daemon.debug =
automount[919]: mount(bind): bind_works =3D 1 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:21 (none) daemon.debug =
automount[919]: kproto sub: Function not implemented</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:21 (none) daemon.info =
automount[919]: using kernel protocol version 3.00</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:21 (none) daemon.info =
automount[919]: using timeout 10 seconds; freq 3 secs</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:25 (none) daemon.debug =
automount[919]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:25 (none) daemon.debug =
automount[919]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:25 (none) daemon.debug =
automount[919]: st_expire(): state =3D 1 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:28 (none) daemon.debug =
automount[919]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:28 (none) daemon.debug =
automount[919]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:11:28 (none) daemon.debug =
automount[919]: st_expire(): state =3D 1 </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Now i go to my usb device cd =
/tmp/media/usbstick and get the following output:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[919]: handle_packet: type =3D 0 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[919]: handle_packet_missing: token 5, name usbstick </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.info =
automount[919]: attempting to mount entry /tmp/media/usbstick</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[1167]: lookup(file): usbstick -&gt; -fstype=3Dauto =
:/dev/sda1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[1167]: parse(sun): expanded entry: -fstype=3Dauto =
:/dev/sda1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[1167]: parse(sun): dequote(&quot;fstype=3Dauto&quot;) -&gt; =
fstype=3Dauto</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[1167]: parse(sun): gathered options: fstype=3Dauto</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[1167]: parse(sun): dequote(&quot;/dev/sda1&quot;) -&gt; =
/dev/sda1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[1167]: parse(sun): core of entry: options=3Dfstype=3Dauto, =
loc=3D/dev/sda1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[1167]: parse(sun): mounting root /tmp/media, mountpoint =
usbstick, what /dev/sda1, fstype auto, options&nbsp; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[1167]: do_mount /dev/sda1 /tmp/media/usbstick type auto =
options&nbsp; using module generic</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[1167]: mount(generic): calling mkdir_path =
/tmp/media/usbstick</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:37 (none) daemon.debug =
automount[1167]: mount(generic): calling mount -t auto /dev/sda1 =
/tmp/media/usbstick</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:38 (none) daemon.debug =
automount[1167]: mount(generic): mounted /dev/sda1 type auto on =
/tmp/media/usbstick</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:38 (none) daemon.debug =
automount[919]: handle_child: got pid 1167, sig 0 (0), stat 0 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:38 (none) daemon.debug =
automount[919]: sig_child: found pending iop pid 1167: signalled 0 (sig =
0), exit status 0</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:38 (none) daemon.debug =
automount[919]: send_ready: token=3D5 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:40 (none) daemon.debug =
automount[919]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:40 (none) daemon.debug =
automount[919]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:40 (none) daemon.debug =
automount[919]: st_expire(): state =3D 1 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:43 (none) daemon.debug =
automount[919]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:43 (none) daemon.debug =
automount[919]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:12:43 (none) daemon.debug =
automount[919]: st_expire(): state =3D 1 </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If i changenow to the root dir (cd /) i =
get after a few seconds the following output:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:14:25 (none) daemon.debug =
automount[919]: st_expire(): state =3D 1 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:14:25 (none) daemon.debug =
automount[1190]: expiring path /tmp/media/usbstick</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:14:25 (none) daemon.debug =
automount[1190]: umount_multi: path=3D/tmp/media/usbstick incl=3D1 =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:14:25 (none) daemon.warn =
automount[1190]: umount_multi: no mounts found under =
/tmp/media/usbstick</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:14:25 (none) daemon.info =
automount[1190]: expired /tmp/media/usbstick</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:14:25 (none) daemon.debug =
automount[919]: handle_child: got pid 1190, sig 0 (0), stat 0 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:14:25 (none) daemon.debug =
automount[919]: sig_child: found pending iop pid 1190: signalled 0 (sig =
0), exit status 0</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:14:28 (none) daemon.debug =
automount[919]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:14:28 (none) daemon.debug =
automount[919]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Jan 31 05:14:28 (none) daemon.debug =
automount[919]: st_expire(): state =3D 1 </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Is it safe to remove the stick now? I =
aks because under /tmp/media/ the folder usbstick is still there.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Best Regards,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">flo</FONT>
</P>
<BR>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C74A06.292DC0DE--


--===============4578997068330088017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4578997068330088017==--

