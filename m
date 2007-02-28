From: "Martin Dorey" <mdorey@bluearc.com>
Subject: Re: Problem with /net and dropped mounts in 2.6.17.11
Date: Tue, 27 Feb 2007 18:55:00 -0800
Message-ID: <CECD6E8A589E8447BC6E836C8369AFF50C784AE0@us-email.terastack.bluearc.com>
References: <ac37e1230702260721u306898f8g4fae054a5812af8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0024302544580955000=="
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <ac37e1230702260721u306898f8g4fae054a5812af8e@mail.gmail.com>
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
To: Brian Weaver <bjweaverj@gmail.com>, autofs@linux.kernel.org

This is a multi-part message in MIME format.

--===============0024302544580955000==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75AE3.D6D308D8"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75AE3.D6D308D8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> >> /sbin/showmount: can't get address for cvl-xp1/mnt/xp1b
=20
That's one of the symptoms I recently saw twice but couldn't reproduce.
In the email thread ("[autofs] automounted symlink to
automountsometimesfails,doingDNS query of partial path"), Ian Kent said:
=20
>> This may not be related to your problem but Jeff Moyer and I are
working
>> on a resolving a race between mount and expire involving symlinks
right
>> now.
-------------------------------------
Martin's Outlook, BlueArc Engineering
________________________________

From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of Brian Weaver
Sent: Monday, February 26, 2007 7:21
To: autofs@linux.kernel.org
Subject: [autofs] Problem with /net and dropped mounts in 2.6.17.11
=20
Greetings,

We recently moved one of our projects from 2.6.12 up to 2.6.17.11 for
some hardware enablement reasons, but now we are seeing mounts
consistently drop.

We have a dedicated NFS fileserver with 9 exported mount points. Our
Linux clients=20
are using /etc/auto.net to mount these on /net.  Everything works fine
on initial
startup, all of the mounts show up fine, but then after a while, one of
the mounts
disappears, is no longer mounted or in /etc/mtab, and automounter logs
the following=20
to syslog whenever we try to access the mount:
Feb 26 08:01:08 fclw436 automount[25387]: >> /sbin/showmount: can't get
address for cvl-xp1/mnt/xp1b=20
Feb 26 08:01:08 fclw436 automount[25387]: lookup(program): lookup for
cvl-xp1/mnt/xp1b failed=20
Feb 26 08:01:08 fclw436 automount[25387]: failed to mount
/net/cvl-xp1/mnt/xp1b=20

So it looks like showmount is actually failing.. It shouldn't be looking
up host cvl-xp1/mnt/xp1b..=20

Am I just running into an old showmount bug?=20

------_=_NextPart_001_01C75AE3.D6D308D8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C75AA0.C8747110">
<link rel=3DEdit-Time-Data href=3D"cid:editdata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:Zoom>110</w:Zoom>
  <w:DisplayBackgroundShape/>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:SelectEntireFieldWithStartOrEnd/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:553679495 -2147483648 8 0 66047 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><span
style=3D'font-family:"Courier New"'>&gt; </span>&gt;&gt; /<span =
class=3DSpellE>sbin/showmount</span>:
can't get address for cvl-xp1/mnt/xp1b<span =
style=3D'font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><span
style=3D'font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><span
style=3D'font-family:"Courier New"'>That's one of the symptoms I =
recently saw
twice but couldn't reproduce.<span style=3D'mso-spacerun:yes'>&nbsp; =
</span>In the
email thread (&quot;[<span class=3DSpellE>autofs</span>] <span =
class=3DSpellE>automounted</span>
<span class=3DSpellE>symlink</span> to <span =
class=3DSpellE>automountsometimesfails<span
class=3DGramE>,doingDNS</span></span> query of partial path&quot;), Ian =
Kent said:<o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><span
style=3D'font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><span
style=3D'font-family:"Courier New"'>&gt;&gt; This may not be related to =
your
problem but Jeff Moyer and I are working<o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'mso-layout-grid-align:none;text-autospace:none'><span
style=3D'font-family:"Courier New"'>&gt;&gt; <span =
class=3DGramE>on</span> a resolving
a race between mount and expire involving <span =
class=3DSpellE>symlinks</span>
right<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-family:"Courier New"'>&gt;&gt; =
<span
class=3DGramE>now</span>.</span><span =
style=3D'color:navy'><o:p></o:p></span></p>

<div>

<p class=3DMsoNormal><span style=3D'font-family:"Courier =
New";color:navy;
mso-no-proof:yes'>-------------------------------------<br>
Martin's Outlook, BlueArc Engineering</span><o:p></o:p></p>

</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</div>

<p class=3DMsoNormal><b><span =
style=3D'font-family:Tahoma'>From:</span></b><span
style=3D'font-family:Tahoma'> autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] <b>On Behalf Of </b>Brian =
Weaver<br>
<b>Sent:</b> Monday, February 26, 2007 7:21<br>
<b>To:</b> autofs@linux.kernel.org<br>
<b>Subject:</b> [autofs] Problem with /net and dropped mounts in =
2.6.17.11</span><o:p></o:p></p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>Greetings,<br>
<br>
We recently moved one of our projects from 2.6.12 up to <a
href=3D"http://2.6.17.11">2.6.17.11</a> for some hardware enablement =
reasons, but
now we are seeing mounts consistently drop.<br>
<br>
We have a dedicated NFS fileserver with 9 exported mount points. Our =
Linux
clients <br>
are using /etc/auto.net to mount these on /net.&nbsp; Everything works =
fine on
initial<br>
startup, all of the mounts show up fine, but then after a while, one of =
the
mounts<br>
disappears, is no longer mounted or in /etc/mtab, and automounter logs =
the
following <br>
to syslog whenever we try to access the mount:<o:p></o:p></p>

<div>

<p>Feb 26 08:01:08 fclw436 automount[25387]: &gt;&gt; /sbin/showmount: =
can't
get address for cvl-xp1/mnt/xp1b <br>
Feb 26 08:01:08 fclw436 automount[25387]: lookup(program): lookup for
cvl-xp1/mnt/xp1b failed <br>
Feb 26 08:01:08 fclw436 automount[25387]: failed to mount =
/net/cvl-xp1/mnt/xp1b
<o:p></o:p></p>

</div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><br>
So it looks like showmount is actually failing.. It shouldn't be looking =
up
host cvl-xp1/mnt/xp1b.. <br>
<br>
Am I just running into an old showmount bug? <o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C75AE3.D6D308D8--


--===============0024302544580955000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0024302544580955000==--

