From: "Lucas Peet" <lpeet@velociti.us>
Subject: mount -o bind
Date: Mon, 18 Apr 2005 15:56:26 -0500
Message-ID: <200504182056.j3IKutJ30896@mail.velociti.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0883061913=="
Return-path: <autofs-bounces@linux.kernel.org>
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

--===============0883061913==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_015C_01C5442F.2D896D60"

This is a multi-part message in MIME format.

------=_NextPart_000_015C_01C5442F.2D896D60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

Does autofs / automount have the ability to bind one directory to another
like 'mount -o bind dir1 dir2'?  And if so, can this be handled by using
wildcards in the maps?  Here is my situation:

 

I have a large directory of user's home directories.  These are in a chroot
jail, so making soft links isn't an option, and hard links won't work for
directories.  I need to bind (mount) a directory that lives outside the
chroot jail to a directory / mount point inside each home directory.  The
users will only be accessing this directory for short periods (to copy a
file or two), and I think it would be more practical to have autofs mount it
whenever they needed access to it, and unmount it when they're done.

 

I'm not sure on the exact number of mounted filesystems Linux can handle (or
if a directory mounded via -o bind counts towards that, though I'd assume it
would), but I would think that using automount instead of putting hundreds
of entries into fstab would be more the Linux way of doing things.  Even if
I had to put an entry for each user in a map, that would be a better
solution to me than using fstab, since they all wouldn't be mounted at the
same time, all the time.

 

Dir to be accessed by all users:  /home/stuff/everyone

 

Mounted to: /home/users/*/everyone

 

Is this even possible?

 

Thanks,

 

-Lucas


------=_NextPart_000_015C_01C5442F.2D896D60
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Does autofs / automount have the ability to bind one
directory to another like &#8216;mount &#8211;o bind dir1 =
dir2&#8217;?&nbsp;
And if so, can this be handled by using wildcards in the maps?&nbsp; =
Here is my
situation:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have a large directory of user&#8217;s home
directories.&nbsp; These are in a chroot jail, so making soft links =
isn&#8217;t
an option, and hard links won&#8217;t work for directories.&nbsp; I need =
to bind
(mount) a directory that lives outside the chroot jail to a directory / =
mount
point inside each home directory.&nbsp; The users will only be accessing =
this
directory for short periods (to copy a file or two), and I think it =
would be
more practical to have autofs mount it whenever they needed access to =
it, and
unmount it when they&#8217;re done.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m not sure on the exact number of mounted
filesystems Linux can handle (or if a directory mounded via &#8211;o =
bind
counts towards that, though I&#8217;d assume it would), but I would =
think that
using automount instead of putting hundreds of entries into fstab would =
be more
the Linux way of doing things.&nbsp; Even if I had to put an entry for =
each
user in a map, that would be a better solution to me than using fstab, =
since
they all wouldn&#8217;t be mounted at the same time, all the =
time.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Dir to be accessed by all users:&nbsp; =
/home/stuff/everyone<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mounted to: =
/home/users/*/everyone<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Is this even possible?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Lucas<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_015C_01C5442F.2D896D60--


--===============0883061913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0883061913==--

