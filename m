From: "Bazan, Wojciech " <wojciech.bazan@citi.com>
Subject: auto direct
Date: Thu, 18 Dec 2008 08:42:30 -0000
Message-ID: <4D504F823BABAE439E6113BCD536DAA506EA00C9@Exukmb77.eur.nsroot.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4660330340478758404=="
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

--===============4660330340478758404==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C960EC.900DEA20"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C960EC.900DEA20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

Are there any known issues with auto direct automounts on RHEL.... (see
details below)

=20

# uname -r

2.6.9-78.0.8.ELsmp

# more /etc/redhat-release=20

Red Hat Enterprise Linux AS release 4 (Nahant Update 7)

# rpm -qi autofs-4.1.3-234

Name        : autofs                       Relocations: (not
relocatable)

Version     : 4.1.3                             Vendor: Red Hat, Inc.

Release     : 234                           Build Date: Thu 19 Jun 2008
05:18:46 PM BST

Install Date: Tue 16 Dec 2008 06:08:11 PM GMT      Build Host:
hs20-bc1-5.build.redhat.com

Group       : System Environment/Daemons    Source RPM:
autofs-4.1.3-234.src.rpm

Size        : 960684                           License: GPL

Signature   : DSA/SHA1, Tue 01 Jul 2008 02:32:36 PM BST, Key ID
219180cddb42a60e

Packager    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla>

Summary     : A tool for automatically mounting and unmounting
filesystems.

Description :

Autofs controls the operation of the automount daemons. The automount

daemons automatically mount filesystems when you use them and

unmount them after a period of inactivity. Filesystems can include

network filesystems, CD-ROMs, floppies, and other media.

=20

Install this package if you want a program for automatically mounting

and unmounting filesystems. If your Red Hat Linux machine is on a

network, you should install autofs.

=20

=20

Although the configuration seems to be perfectly fine:

=20

# more /etc/auto.master

...

/misc   /etc/auto.misc

/net    /etc/auto.net

/-      /etc/auto.direct

=20

# more /etc/auto.direct=20

...

/PKGrep <host>:/export/PKGrep

=20

It does not want to start autofs saying:

=20

automount[9521]: cache_ghost: entry in file:/etc/auto.direct not valid
map format, key /PKGrep

=20

=20

Auto direct work however if we do not use the dir directly under root.

=20

Any ideas?

=20

Many thanks,

Wojtek

=20

=20

=20

=20

=20

=20

=20


------_=_NextPart_001_01C960EC.900DEA20
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:Consolas;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DPL link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText>Hello,<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Are there any known issues =
with auto direct
automounts on RHEL.... (see details below)<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><b><span lang=3DEN-US># uname =
-r<o:p></o:p></span></b></p>

<p class=3DMsoPlainText><span =
lang=3DEN-US>2.6.9-78.0.8.ELsmp<o:p></o:p></span></p>

<p class=3DMsoPlainText><b><span lang=3DEN-US># more /etc/redhat-release =
<o:p></o:p></span></b></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Red Hat Enterprise Linux AS =
release 4
(Nahant Update 7)<o:p></o:p></span></p>

<p class=3DMsoPlainText><b><span lang=3DEN-US># rpm -qi =
autofs-4.1.3-234<o:p></o:p></span></b></p>

<p class=3DMsoPlainText><span =
lang=3DEN-US>Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
:
autofs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Relocations: (not relocatable)<o:p></o:p></span></p>

<p class=3DMsoPlainText><span =
lang=3DEN-US>Version&nbsp;&nbsp;&nbsp;&nbsp; :
4.1.3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vendor: Red =
Hat,
Inc.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span =
lang=3DEN-US>Release&nbsp;&nbsp;&nbsp;&nbsp; :
234&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
Build Date: Thu 19 Jun 2008 05:18:46 PM BST<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Install Date: Tue 16 Dec 2008 =
06:08:11
PM GMT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Build Host: =
hs20-bc1-5.build.redhat.com<o:p></o:p></span></p>

<p class=3DMsoPlainText><span =
lang=3DEN-US>Group&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
: System Environment/Daemons&nbsp;&nbsp;&nbsp; Source RPM:
autofs-4.1.3-234.src.rpm<o:p></o:p></span></p>

<p class=3DMsoPlainText><span =
lang=3DEN-US>Size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
:
960684&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;
License: GPL<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Signature&nbsp;&nbsp; : =
DSA/SHA1, Tue 01
Jul 2008 02:32:36 PM BST, Key ID 219180cddb42a60e<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Packager&nbsp;&nbsp;&nbsp; : =
Red Hat,
Inc. &lt;http://bugzilla.redhat.com/bugzilla&gt;<o:p></o:p></span></p>

<p class=3DMsoPlainText><span =
lang=3DEN-US>Summary&nbsp;&nbsp;&nbsp;&nbsp; : A tool
for automatically mounting and unmounting =
filesystems.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Description =
:<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Autofs controls the operation =
of the
automount daemons. The automount<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>daemons automatically mount =
filesystems
when you use them and<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>unmount them after a period =
of inactivity.
Filesystems can include<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>network filesystems, CD-ROMs, =
floppies,
and other media.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Install this package if you =
want a
program for automatically mounting<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>and unmounting filesystems. =
If your Red
Hat Linux machine is on a<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>network, you should install =
autofs.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Although the configuration =
seems to be perfectly
fine:<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><b><span lang=3DEN-US># more =
/etc/auto.master<o:p></o:p></span></b></p>

<p class=3DMsoPlainText><span lang=3DEN-US>&#8230;<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>/misc&nbsp;&nbsp; =
/etc/auto.misc<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>/net&nbsp;&nbsp;&nbsp; =
/etc/auto.net<o:p></o:p></span></p>

<p class=3DMsoPlainText><span =
lang=3DEN-US>/-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
/etc/auto.direct<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><b><span lang=3DEN-US># more /etc/auto.direct =
<o:p></o:p></span></b></p>

<p class=3DMsoPlainText><b><span =
lang=3DEN-US>&#8230;<o:p></o:p></span></b></p>

<p class=3DMsoPlainText><span lang=3DEN-US>/PKGrep =
&lt;host&gt;:/export/PKGrep<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>It does not want to start =
autofs saying:<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>automount[9521]: cache_ghost: =
entry in
file:/etc/auto.direct not valid map format, key =
/PKGrep<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Auto direct work however if =
we do not
use the dir directly under root.<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Any =
ideas?<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Many =
thanks,<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US>Wojtek<o:p></o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoPlainText><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>

------_=_NextPart_001_01C960EC.900DEA20--


--===============4660330340478758404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4660330340478758404==--

