From: "Latrell" <is85022@cis.nctu.edu.tw>
Subject: mount failed: aquire_lock: can't lock lock file
	interrupted: /var/lock/autofs
Date: Thu, 6 Jul 2006 10:17:17 +0800
Message-ID: <004601c6a0a2$5cb575e0$251a17ac@ZyXEL.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5668351386912420074=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--===============5668351386912420074==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0041_01C6A0E5.5BD7C4A0"

This is a multi-part message in MIME format.

------=_NextPart_000_0041_01C6A0E5.5BD7C4A0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

It seems my post didn't sent. I'm sorry if it's a double post.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hi All:

=20

My scenario is as follows: Use login FTP -> change directory ( autofs =
will mount the share in this time) -> access -> logout ( autofs umount =
the share )

I keep running the scenario continuously, and I have some observations:

1. One continuous ftp session can operate normally

2. When there are many user sessions run continuous, say 3, the =
operation =A1=A7change directory=A1=A8 will fail from time to time.

The log message is as follows, the home directory is =
/tmp/users/shares/1034(1043):

 automount[2306]: aquire_lock: can't lock lock file interrupted: =
/var/lock/autofs

 automount[2306]: failed to mount autofs path /tmp/users/shares/1034

 automount[2306]: /ramdisk/mnt/var1/tmp/users/shares/1034: mount failed!

 automount[2298]: aquire_lock: can't lock lock file interrupted: =
/var/lock/autofs

 automount[2298]: failed to mount autofs path /tmp/users/shares/1043

 automount[2298]: /ramdisk/mnt/var1/tmp/users/shares/1043: mount failed!

=20

I also found the related discussion:

http://www.mail-archive.com/autofs@linux.kernel.org/msg05071.html

The similarity is I mount and umount frequently in a short time!

=20

Is there a patch available for the problem? If not, will the problem be =
scheduled in version 5?  If not, how can I fix it myself?

Can someone advice me? Any advice will be appreciated!~

=20

Thanks in advance,

Latrell.

------=_NextPart_000_0041_01C6A0E5.5BD7C4A0
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>
<DIV class=3DSection1 style=3D"LAYOUT-GRID:  18pt none">
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">It seems my post didn't=20
sent. I'm sorry if it's a double post.</SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">Hi All:<?xml:namespace=20
prefix =3D o ns =3D "urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">My scenario is as=20
follows: Use login FTP -&gt; change directory ( autofs will mount the =
share in=20
this time) -&gt; access -&gt; logout ( autofs umount the share=20
)<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">I keep running the=20
scenario continuously, and I have some=20
observations:<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">1. One continuous ftp=20
session can operate normally<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">2. When there are many=20
user sessions run continuous, say 3, the operation </SPAN></FONT><FONT=20
color=3Dblack><SPAN lang=3DEN-US style=3D"COLOR: =
black">=A1=A7</SPAN></FONT><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9=20
color=3Dblack><SPAN lang=3DEN-US style=3D"COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">change=20
directory</SPAN></FONT><FONT color=3Dblack><SPAN lang=3DEN-US=20
style=3D"COLOR: black">=A1=A8</SPAN></FONT><FONT =
face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack><SPAN lang=3DEN-US=20
style=3D"COLOR: black; FONT-FAMILY: =B7s=B2=D3=A9=FA=C5=E9"> will fail =
from time to=20
time.<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">The log message is as=20
follows, the home directory is=20
/tmp/users/shares/1034(1043):<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">&nbsp;automount[2306]:=20
aquire_lock: can't lock lock file interrupted:=20
/var/lock/autofs<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">&nbsp;automount[2306]:=20
failed to <?xml:namespace prefix =3D st1 ns =3D=20
"urn:schemas-microsoft-com:office:smarttags" /><st1:place=20
w:st=3D"on"><st1:PlaceType w:st=3D"on">mount</st1:PlaceType> =
<st1:PlaceName=20
w:st=3D"on">autofs</st1:PlaceName></st1:place> path=20
/tmp/users/shares/1034<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">&nbsp;automount[2306]:=20
/ramdisk/mnt/var1/tmp/users/shares/1034: mount=20
failed!<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">&nbsp;automount[2298]:=20
aquire_lock: can't lock lock file interrupted:=20
/var/lock/autofs<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">&nbsp;automount[2298]:=20
failed to <st1:place w:st=3D"on"><st1:PlaceType =
w:st=3D"on">mount</st1:PlaceType>=20
<st1:PlaceName w:st=3D"on">autofs</st1:PlaceName></st1:place> path=20
/tmp/users/shares/1043<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">&nbsp;automount[2298]:=20
/ramdisk/mnt/var1/tmp/users/shares/1043: mount=20
failed!<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">I also found the=20
related discussion:<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9"><A=20
title=3Dhttp://www.mail-archive.com/autofs@linux.kernel.org/msg05071.html=
=20
href=3D"http://www.mail-archive.com/autofs@linux.kernel.org/msg05071.html=
">http://www.mail-archive.com/autofs@linux.kernel.org/msg05071.html</A><o=
:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">The similarity is I=20
mount and umount frequently in a short =
time!<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">Is there a patch=20
available for the problem? If not, will the problem be scheduled in =
version 5?=20
&nbsp;If not, how can I fix it myself?<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">Can someone advice me?=20
Any advice will be appreciated!~<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9"><o:p>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">Thanks in=20
advance,<o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3D=B7s=B2=D3=A9=FA=C5=E9 color=3Dblack =
size=3D3><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 12pt; COLOR: black; FONT-FAMILY: =
=B7s=B2=D3=A9=FA=C5=E9">Latrell.<o:p></o:p></SPAN></FONT></P></DIV></FONT=
></DIV></BODY></HTML>

------=_NextPart_000_0041_01C6A0E5.5BD7C4A0--


--===============5668351386912420074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5668351386912420074==--

