From: <Daniel.Buchanan@gtri.gatech.edu>
Subject: Having trouble getting automaps to work in RH EL5
Date: Fri, 25 Jan 2008 10:38:29 -0500
Message-ID: <11CC5B53BC64814C9957D35E934D0A92A89DC6@apatlittmail07.ittl.gtri.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5901253224140224674=="
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

--===============5901253224140224674==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C85F68.55982B36"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85F68.55982B36
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

(I suspect that I've run into a bug with my distro)

=20

I'm running RH version 2.6.18-53.1.6.el5 and autofs version
autofs-5.0.1-0.rc2.55.el5.2.  I have applied all the patches that yum
found.  I have manually connected to the share server so I know that
that's working correctly. =20

My auto.master has a line /home2   /etc/auto.home (this is the first
active line in the file)

My auto.home currently reads as follows:  *
-fstype=3Dnfs,rw,sync,soft,intr,rsize=3D8192,wsize=3D8192
host.domain:/home/&

=20

Showmount for host.domain shows the following share:  /home *

Showmount for 127.0.0.1 shows program not registered.  (we do not have
any nfs shares running)

=20

I see the home2 directory but I cannot access any directory under it, cd
home2/userdir nor ls home2/userdir work.  I have done this before in RH
AS4 with no problems.  The final result we want is to remap the standard
home directories to our share server, to keep our users from 'loosing'
files because they are on the local machine.  I eventually set up an all
log on both servers (set the filter to *.*) but there isn't really
anything useful in either log.  I get no access denied messages nor any
cannot connect errors....

=20

I have exhausted all the hints and tips that I have found on the web, so
I have tried several different modifications of the auto.home line.

=20

Daniel Buchanan

ITTL

404-407-7700 - Helpdesk

404-407-6074 - Office

=20


------_=_NextPart_001_01C85F68.55982B36
Content-Type: text/html;
	charset="US-ASCII"
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
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>(I suspect that I&#8217;ve run into a bug with my =
distro)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;m running RH version 2.6.18-53.1.6.el5 and =
autofs version
autofs-5.0.1-0.rc2.55.el5.2.&nbsp; I have applied all the patches that =
yum
found.&nbsp; I have manually connected to the share server so I know =
that that&#8217;s
working correctly.&nbsp; <o:p></o:p></p>

<p class=3DMsoNormal>My auto.master has a line /home2&nbsp;&nbsp; =
/etc/auto.home
(this is the first active line in the file)<o:p></o:p></p>

<p class=3DMsoNormal>My auto.home currently reads as follows:&nbsp; =
*&nbsp;
-fstype=3Dnfs,rw,sync,soft,intr,rsize=3D8192,wsize=3D8192&nbsp;&nbsp; =
host.domain:/home/&amp;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Showmount for host.domain shows the following =
share:&nbsp;
/home *<o:p></o:p></p>

<p class=3DMsoNormal>Showmount for 127.0.0.1 shows program not =
registered.&nbsp;
(we do not have any nfs shares running)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I see the home2 directory but I cannot access any =
directory
under it, cd home2/userdir nor ls home2/userdir work.&nbsp; I have done =
this
before in RH AS4 with no problems.&nbsp; The final result we want is to =
remap
the standard home directories to our share server, to keep our users =
from &#8216;loosing&#8217;
files because they are on the local machine.&nbsp; I eventually set up =
an all
log on both servers (set the filter to *.*) but there isn&#8217;t really
anything useful in either log.&nbsp; I get no access denied messages nor =
any cannot
connect errors&#8230;.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have exhausted all the hints and tips that I have =
found on
the web, so I have tried several different modifications of the =
auto.home line.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Daniel Buchanan<o:p></o:p></p>

<p class=3DMsoNormal>ITTL<o:p></o:p></p>

<p class=3DMsoNormal>404-407-7700 - Helpdesk<o:p></o:p></p>

<p class=3DMsoNormal>404-407-6074 - Office<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C85F68.55982B36--


--===============5901253224140224674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5901253224140224674==--

