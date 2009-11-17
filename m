From: John Lumby <johnlumby@hotmail.com>
Subject: automount[...]: mount(nfs): no hosts available
Date: Tue, 17 Nov 2009 18:18:07 -0500
Message-ID: <COL116-W33C714ED28D2F1EB15E8B6A3A40@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7008722030014820261=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

--===============7008722030014820261==
Content-Type: multipart/alternative;
	boundary="_77e5d8fb-0ac7-4eb6-a00f-6dddec7edfcc_"

--_77e5d8fb-0ac7-4eb6-a00f-6dddec7edfcc_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I have two different machines each running very recent linux kernel but dif=
ferent vintages of redhat / fedora original distribution.     I have set up=
 an automount of one of my company's ldap-controlled automounts on each.

On the new distro=2C it works fine.

On the older distro=2C it doesn't=2C although I can manually issue the moun=
t -t nfs commands that automount is trying to issue and they are successful=
.

I've pasted comparison of debug output of each system from automount -d  : =
 (I have replaced host and dir names with ???)  -
it seems that old-distro automount is looking for some characteristic of th=
e remote hostname from somewhere and not finding it=2C and giving up before=
 attempting the mjount command even though it has gathered all the mount co=
mmand syntax and could (I guess) try issuing it.    But doesn't.    And as =
mentioned=2C the mount command succeeds when I type it in.=20

if anyone could suggest the cause and remedy for the old-distro failure I'd=
 be grateful

John Lumby

new distro  -  successful :
automount -V

Linux automount version 5.0.1-0.rc3.33

debug output:
Nov 17 17:21:04 ?newdst? automount[9061]: mount_mount: mount(nfs): nfs opti=
ons=3D"hard=2Cintr=2Cnfsvers=3D3=2Ctcp=2Crsize=3D65536=2Cwsize=3D65536=2Cti=
meo=3D200=2Cnosuid=2C"=2C nosymlink=3D1=2C ro=3D0
Nov 17 17:21:06 ?newdst? automount[9061]: mount_mount: mount(nfs): calling =
mkdir_path /??topdir??/??subdir??
Nov 17 17:21:06 ?newdst? automount[9061]: mount_mount: mount(nfs): calling =
mount -t nfs -s -o hard=2Cintr=2Cnfsvers=3D3=2Ctcp=2Crsize=3D65536=2Cwsize=
=3D65536=2Ctimeo=3D200=2Cnosuid=2C ??remote_host_ipname??:/??topdir??/??sub=
dir?? /??topdir??/??subdir??
Nov 17 17:21:06 ?newdst? automount[9061]: mount(nfs): mounted ??remote_host=
_ipname??:/??topdir??/??subdir?? on /??topdir??/??subdir??



old distro  -  unsuccessful :
automount -V

Linux automount version 5.0.5

debug output
Nov 17 17:15:28 ?olddst? automount[9969]: mount_mount: mount(nfs): nfs opti=
ons=3D"hard=2Cintr=2Cnfsvers=3D3=2Ctcp=2Crsize=3D65536=2Cwsize=3D65536=2Cti=
meo=3D200=2Cnosuid=2C"=2C nosymlink=3D1=2C ro=3D0
Nov 17 17:15:28 ?olddst? automount[9969]: get_nfs_info: called for host ??r=
emote_host_ipname?? proto udp version 0x30
Nov 17 17:15:29 ?olddst? automount[9969]: st_expire: state 1 path /net
Nov 17 17:15:29 ?olddst? automount[9969]: expire_proc: exp_proc =3D 3048012=
688 path /net
Nov 17 17:15:29 ?olddst? automount[9969]: st_expire: state 1 path /??topdir=
??
Nov 17 17:15:29 ?olddst? automount[9969]: expire_proc: exp_proc =3D 3046812=
560 path /??topdir??
Nov 17 17:15:29 ?olddst? automount[9969]: expire_cleanup: got thid 30480126=
88 path /net stat 0
Nov 17 17:15:29 ?olddst? automount[9969]: expire_cleanup: sigchld: exp 3048=
012688 finished=2C switching from 2 to 1
Nov 17 17:15:29 ?olddst? automount[9969]: st_ready: st_ready(): state =3D 2=
 path /net
Nov 17 17:15:29 ?olddst? automount[9969]: expire_cleanup: got thid 30468125=
60 path /??topdir?? stat 0
Nov 17 17:15:29 ?olddst? automount[9969]: expire_cleanup: sigchld: exp 3046=
812560 finished=2C switching from 2 to 1
Nov 17 17:15:29 ?olddst? automount[9969]: st_ready: st_ready(): state =3D 2=
 path /??topdir??
Nov 17 17:15:30 ?olddst? automount[9969]: st_expire: state 1 path /misc
Nov 17 17:15:30 ?olddst? automount[9969]: expire_proc: exp_proc =3D 3046812=
560 path /misc
Nov 17 17:15:30 ?olddst? automount[9969]: expire_cleanup: got thid 30468125=
60 path /misc stat 0
Nov 17 17:15:30 ?olddst? automount[9969]: expire_cleanup: sigchld: exp 3046=
812560 finished=2C switching from 2 to 1
Nov 17 17:15:30 ?olddst? automount[9969]: st_ready: st_ready(): state =3D 2=
 path /misc
Nov 17 17:15:34 ?olddst? automount[9969]: get_nfs_info: called for host ??r=
emote_host_ipname?? proto tcp version 0x30
Nov 17 17:15:34 ?olddst? automount[9969]: get_nfs_info: called for host ??r=
emote_host_ipname?? proto udp version 0x30
Nov 17 17:15:40 ?olddst? automount[9969]: get_nfs_info: called for host ??r=
emote_host_ipname?? proto tcp version 0x30
Nov 17 17:15:40 ?olddst? automount[9969]: mount(nfs): no hosts available
Nov 17 17:15:40 ?olddst? automount[9969]: dev_ioctl_send_fail: token =3D 43
Nov 17 17:15:40 ?olddst? automount[9969]: failed to mount /??topdir??/??sub=
dir??





 		 	   		 =20
_________________________________________________________________
Ready. Set. Get a great deal on Windows 7. See fantastic deals on Windows 7=
 now
http://go.microsoft.com/?linkid=3D9691818=

--_77e5d8fb-0ac7-4eb6-a00f-6dddec7edfcc_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
I have two different machines each running very recent linux kernel but dif=
ferent vintages of redhat / fedora original distribution.&nbsp=3B&nbsp=3B&n=
bsp=3B&nbsp=3B I have set up an automount of one of my company's ldap-contr=
olled automounts on each.<br><br>On the new distro=2C it works fine.<br><br=
>On the older distro=2C it doesn't=2C although I can manually issue the mou=
nt -t nfs commands that automount is trying to issue and they are successfu=
l.<br><br>I've pasted comparison of debug output of each system from automo=
unt -d&nbsp=3B :&nbsp=3B (I have replaced host and dir names with ???)&nbsp=
=3B -<br>it seems that old-distro automount is looking for some characteris=
tic of the remote hostname from somewhere and not finding it=2C and giving =
up before attempting the mjount command even though it has gathered all the=
 mount command syntax and could (I guess) try issuing it. &nbsp=3B  But doe=
sn't. &nbsp=3B&nbsp=3B And as mentioned=2C the mount command succeeds when =
I type it in. <br><br>if anyone could suggest the cause and remedy for the =
old-distro failure I'd be grateful<br><br>John Lumby<br><br>new distro&nbsp=
=3B -&nbsp=3B successful :<br>automount -V<br><br>Linux automount version 5=
.0.1-0.rc3.33<br><br>debug output:<br>Nov 17 17:21:04 ?newdst? automount[90=
61]: mount_mount: mount(nfs): nfs options=3D"hard=2Cintr=2Cnfsvers=3D3=2Ctc=
p=2Crsize=3D65536=2Cwsize=3D65536=2Ctimeo=3D200=2Cnosuid=2C"=2C nosymlink=
=3D1=2C ro=3D0<br>Nov 17 17:21:06 ?newdst? automount[9061]: mount_mount: mo=
unt(nfs): calling mkdir_path /??topdir??/??subdir??<br>Nov 17 17:21:06 ?new=
dst? automount[9061]: mount_mount: mount(nfs): calling mount -t nfs -s -o h=
ard=2Cintr=2Cnfsvers=3D3=2Ctcp=2Crsize=3D65536=2Cwsize=3D65536=2Ctimeo=3D20=
0=2Cnosuid=2C ??remote_host_ipname??:/??topdir??/??subdir?? /??topdir??/??s=
ubdir??<br>Nov 17 17:21:06 ?newdst? automount[9061]: mount(nfs): mounted ??=
remote_host_ipname??:/??topdir??/??subdir?? on /??topdir??/??subdir??<br><b=
r><br>
old distro&nbsp=3B -&nbsp=3B unsuccessful :<br>automount -V<br><br>Linux au=
tomount version 5.0.5<br><br>debug output<br>Nov 17 17:15:28 ?olddst? autom=
ount[9969]: mount_mount: mount(nfs): nfs options=3D"hard=2Cintr=2Cnfsvers=
=3D3=2Ctcp=2Crsize=3D65536=2Cwsize=3D65536=2Ctimeo=3D200=2Cnosuid=2C"=2C no=
symlink=3D1=2C ro=3D0<br>Nov 17 17:15:28 ?olddst? automount[9969]: get_nfs_=
info: called for host ??remote_host_ipname?? proto udp version 0x30<br>Nov =
17 17:15:29 ?olddst? automount[9969]: st_expire: state 1 path /net<br>Nov 1=
7 17:15:29 ?olddst? automount[9969]: expire_proc: exp_proc =3D 3048012688 p=
ath /net<br>Nov 17 17:15:29 ?olddst? automount[9969]: st_expire: state 1 pa=
th /??topdir??<br>Nov 17 17:15:29 ?olddst? automount[9969]: expire_proc: ex=
p_proc =3D 3046812560 path /??topdir??<br>Nov 17 17:15:29 ?olddst? automoun=
t[9969]: expire_cleanup: got thid 3048012688 path /net stat 0<br>Nov 17 17:=
15:29 ?olddst? automount[9969]: expire_cleanup: sigchld: exp 3048012688 fin=
ished=2C switching from 2 to 1<br>Nov 17 17:15:29 ?olddst? automount[9969]:=
 st_ready: st_ready(): state =3D 2 path /net<br>Nov 17 17:15:29 ?olddst? au=
tomount[9969]: expire_cleanup: got thid 3046812560 path /??topdir?? stat 0<=
br>Nov 17 17:15:29 ?olddst? automount[9969]: expire_cleanup: sigchld: exp 3=
046812560 finished=2C switching from 2 to 1<br>Nov 17 17:15:29 ?olddst? aut=
omount[9969]: st_ready: st_ready(): state =3D 2 path /??topdir??<br>Nov 17 =
17:15:30 ?olddst? automount[9969]: st_expire: state 1 path /misc<br>Nov 17 =
17:15:30 ?olddst? automount[9969]: expire_proc: exp_proc =3D 3046812560 pat=
h /misc<br>Nov 17 17:15:30 ?olddst? automount[9969]: expire_cleanup: got th=
id 3046812560 path /misc stat 0<br>Nov 17 17:15:30 ?olddst? automount[9969]=
: expire_cleanup: sigchld: exp 3046812560 finished=2C switching from 2 to 1=
<br>Nov 17 17:15:30 ?olddst? automount[9969]: st_ready: st_ready(): state =
=3D 2 path /misc<br>Nov 17 17:15:34 ?olddst? automount[9969]: get_nfs_info:=
 called for host ??remote_host_ipname?? proto tcp version 0x30<br>Nov 17 17=
:15:34 ?olddst? automount[9969]: get_nfs_info: called for host ??remote_hos=
t_ipname?? proto udp version 0x30<br>Nov 17 17:15:40 ?olddst? automount[996=
9]: get_nfs_info: called for host ??remote_host_ipname?? proto tcp version =
0x30<br>Nov 17 17:15:40 ?olddst? automount[9969]: mount(nfs): no hosts avai=
lable<br>Nov 17 17:15:40 ?olddst? automount[9969]: dev_ioctl_send_fail: tok=
en =3D 43<br>Nov 17 17:15:40 ?olddst? automount[9969]: failed to mount /??t=
opdir??/??subdir??<br><br><br>
<br><br> 		 	   		  <br /><hr />Get a great deal on Windows 7 and see how i=
t works the way you want. <a href=3D'http://go.microsoft.com/?linkid=3D9691=
813' target=3D'_new'>See the Windows 7 offers now.</a></body>
</html>=

--_77e5d8fb-0ac7-4eb6-a00f-6dddec7edfcc_--


--===============7008722030014820261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7008722030014820261==--

