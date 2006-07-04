From: =?big5?B?TGF0cmVsbCBXYW5nIKT9xG269Q==?= <Latrell.Wang@zyxel.com.tw>
Subject: mount failed: aquire_lock: can't lock lock file
	interrupted: /var/lock/autofs
Date: Tue, 4 Jul 2006 16:43:51 +0800
Message-ID: <E6CE732605104D4D82B2DAA4866C143F0C8F43@zytwbe01.ZyXEL.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0458263491179641822=="
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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

--===============0458263491179641822==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C69F45.FB130397"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C69F45.FB130397
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

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


------_=_NextPart_001_01C69F45.FB130397
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:=B7s=B2=D3=A9=FA=C5=E9;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@=B7s=B2=D3=A9=FA=C5=E9";
	panose-1:2 2 3 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:=B7s=B2=D3=A9=FA=C5=E9;
	color:black;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:18.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-TW link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:18.0pt'>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>Hi All:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>My scenario is as follows:
Use login FTP -&gt; change directory ( autofs will mount the share in =
this time)
-&gt; access -&gt; logout ( autofs umount the share =
)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>I keep running the
scenario continuously, and I have some =
observations:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>1. One continuous ftp
session can operate normally<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>2. When there are many user
sessions run continuous, say 3, the operation </span></font><font =
color=3Dblack><span
lang=3DEN-US style=3D'color:black'>=A1=A7</span></font><font =
color=3Dblack face=3D=B7s=B2=D3=A9=FA=C5=E9><span
lang=3DEN-US =
style=3D'font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'>change =
directory</span></font><font
color=3Dblack><span lang=3DEN-US =
style=3D'color:black'>=A1=A8</span></font><font
color=3Dblack face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US =
style=3D'font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'>
will fail from time to time.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>The log message is as follows,
the home directory is =
/tmp/users/shares/1034(1043):<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>&nbsp;automount[2306]:
aquire_lock: can't lock lock file interrupted: =
/var/lock/autofs<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>&nbsp;automount[2306]:
failed to <st1:place w:st=3D"on"><st1:PlaceType =
w:st=3D"on">mount</st1:PlaceType> <st1:PlaceName
 w:st=3D"on">autofs</st1:PlaceName></st1:place> path =
/tmp/users/shares/1034<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>&nbsp;automount[2306]:
/ramdisk/mnt/var1/tmp/users/shares/1034: mount =
failed!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>&nbsp;automount[2298]:
aquire_lock: can't lock lock file interrupted: =
/var/lock/autofs<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>&nbsp;automount[2298]:
failed to <st1:place w:st=3D"on"><st1:PlaceType =
w:st=3D"on">mount</st1:PlaceType> <st1:PlaceName
 w:st=3D"on">autofs</st1:PlaceName></st1:place> path =
/tmp/users/shares/1043<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>&nbsp;automount[2298]:
/ramdisk/mnt/var1/tmp/users/shares/1043: mount =
failed!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>I also found the related
discussion:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
><a
href=3D"http://www.mail-archive.com/autofs@linux.kernel.org/msg05071.html=
">http://www.mail-archive.com/autofs@linux.kernel.org/msg05071.html</a><o=
:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>The similarity is I mount
and umount frequently in a short time!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>Is there a patch
available for the problem? If not, will the problem be scheduled in =
version 5? &nbsp;If
not, how can I fix it myself?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>Can someone advice me? Any
advice will be appreciated!~<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>Thanks in advance,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack =
face=3D=B7s=B2=D3=A9=FA=C5=E9><span lang=3DEN-US
style=3D'font-size:12.0pt;font-family:=B7s=B2=D3=A9=FA=C5=E9;color:black'=
>Latrell.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C69F45.FB130397--


--===============0458263491179641822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0458263491179641822==--

