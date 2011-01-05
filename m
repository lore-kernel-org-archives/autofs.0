From: "Carter, Joel" <JoelC@trailerwizards.com>
Subject: Re: Autofs SMBFS no write in files
Date: Wed, 5 Jan 2011 08:38:06 -0800
Message-ID: <7A014DE1422A694A89BA2CE1F5692DF503831E91@niihau.lionsgate.ca>
References: <alpine.LNX.2.00.1012182238560.17400@swampdragon.chaosbits.net>
	<4D207520.60200@gmail.Com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1360573303720904576=="
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <4D207520.60200@gmail.Com>
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
To: Issa <frechdesign@gmail.com>, Jesper Juhl <jj@chaosbits.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

This is a multi-part message in MIME format.

--===============1360573303720904576==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CBACF6.FD32C417"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CBACF6.FD32C417
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hey there.

=20

Who is the owner and what are the permissions of your /mnt/smb/win1 =
mount point after autofs kicks in? Can you write to it using root (or =
using sudo, same thing)?

=20

Joel.

=20

From: autofs-bounces@linux.kernel.org =
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of Issa
Sent: January-02-11 4:53 AM
To: Jesper Juhl
Cc: autofs@linux.kernel.org; linux-kernel@vger.kernel.org; Ian Kent
Subject: [autofs] Autofs SMBFS no write in files

=20

Hello,


Autofs acc=E9s smbfs no way to write in smbfs share ?


Autofs smbfs no writing ?

Im usint autofs with ubuntu 10.10
Im using autofs like this

sudo nano /etc/auto.master

+auto.master
/mnt/smb       /etc/auto.auto   --timeout=3D60 --ghost

et le fichier sudo nano /etc/auto.auto

#directory name         option for mount                                 =
                 device to mount
win1            -fstype=3Dsmbfs,rw,credentials=3D/etc/smb.auth         =
://win1/docs/

Authentication files :
sudo nano /etc/smb.auth

username=3Dusers1
password=3DmotDePasse
domain=3DwindowsDomaine
=20
now with this i can access only in read
/mnt/smb/win1

My question how add acess to write ?

because i can write for the moment.

thanks


------_=_NextPart_001_01CBACF6.FD32C417
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta name=3DGenerator =
content=3D"Microsoft Word 12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";
	color:black;}
h3
	{mso-style-priority:9;
	mso-style-link:"Heading 3 Char";
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:13.5pt;
	font-family:"Times New Roman","serif";
	color:black;
	font-weight:bold;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";
	color:black;}
code
	{mso-style-priority:99;
	font-family:"Courier New";}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.Heading3Char
	{mso-style-name:"Heading 3 Char";
	mso-style-priority:9;
	mso-style-link:"Heading 3";
	font-family:"Cambria","serif";
	color:#4F81BD;
	font-weight:bold;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Consolas","serif";
	color:black;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Arial","sans-serif";
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
span.re2
	{mso-style-name:re2;}
span.nu0
	{mso-style-name:nu0;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body bgcolor=3Dwhite =
lang=3DEN-CA link=3Dblue vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:windowte=
xt'>Hey there.<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:windowte=
xt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:windowte=
xt'>Who is the owner and what are the permissions of your /mnt/smb/win1 =
mount point after autofs kicks in? Can you write to it using root (or =
using sudo, same thing)?<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:windowte=
xt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:windowte=
xt'>Joel.<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:windowte=
xt'><o:p>&nbsp;</o:p></span></p><div><div =
style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm'><p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:windowt=
ext'>From:</span></b><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:windowt=
ext'> autofs-bounces@linux.kernel.org =
[mailto:autofs-bounces@linux.kernel.org] <b>On Behalf Of =
</b>Issa<br><b>Sent:</b> January-02-11 4:53 AM<br><b>To:</b> Jesper =
Juhl<br><b>Cc:</b> autofs@linux.kernel.org; =
linux-kernel@vger.kernel.org; Ian Kent<br><b>Subject:</b> [autofs] =
Autofs SMBFS no write in files<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><p class=3DMsoNormal =
style=3D'margin-bottom:12.0pt'>Hello,<o:p></o:p></p><h3>Autofs acc=E9s =
smbfs no way to write in smbfs share ?<o:p></o:p></h3><p =
class=3DMsoNormal>Autofs smbfs no writing ?<br><br>Im usint autofs with =
ubuntu 10.10<br>Im using autofs like this<o:p></o:p></p><p>sudo nano =
/etc/auto.master<o:p></o:p></p><div><pre><code>+auto.master<o:p></o:p></c=
ode></pre><pre><code>/mnt/smb=A0=A0=A0=A0=A0=A0 /etc/auto.auto=A0=A0 =
--timeout=3D60 --ghost</code><o:p></o:p></pre></div><p>et le fichier =
sudo nano /etc/auto.auto<o:p></o:p></p><div><pre><code>#directory =
name=A0=A0=A0=A0=A0=A0=A0=A0 option for =
mount=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 device to =
mount<o:p></o:p></code></pre><pre><code>win1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =
-fstype=3Dsmbfs,rw,credentials=3D/etc/smb.auth=A0=A0=A0=A0=A0=A0=A0=A0 =
://win1/docs/</code><o:p></o:p></pre></div><p>Authentication files =
:<br>sudo nano =
/etc/smb.auth<o:p></o:p></p><div><pre><code>username=3Dusers1<o:p></o:p><=
/code></pre><pre><code>password=3DmotDePasse<o:p></o:p></code></pre><pre>=
<code>domain=3DwindowsDomaine</code><o:p></o:p></pre></div><pre><code><o:=
p>&nbsp;</o:p></code></pre><pre><code>now with this i can access only in =
read<o:p></o:p></code></pre><pre><code>/mnt/smb/win1</code><o:p></o:p></p=
re><p>My question how add acess to write ?<o:p></o:p></p><p>because i =
can write for the =
moment.<o:p></o:p></p><p>thanks<o:p></o:p></p></div></div></body></html>
------_=_NextPart_001_01CBACF6.FD32C417--


--===============1360573303720904576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1360573303720904576==--

