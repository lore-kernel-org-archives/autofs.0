From: "Martin Dorey" <mdorey@bluearc.com>
Subject: Re: automounted symlink to automount sometimesfails,
	doingDNS query of partial path
Date: Fri, 2 Feb 2007 08:25:01 -0800
Message-ID: <CECD6E8A589E8447BC6E836C8369AFF50C4BB949@us-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0324707074411057087=="
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--===============0324707074411057087==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C746E6.B08A6565"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C746E6.B08A6565
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> I just wanted to know if typing mount<ret> showed a mount present on=20
> /net/us-titan.us.dev.bluearc.com/ARCHIVE
=20
I found the output from cat /proc/mounts while "wide" (the machine with
the older kernel) had the problem.  It alleges three mounts from that
server while the problem was happening:
=20
us-titan.us.dev.bluearc.com:/CALLHOME
/net/us-titan.us.dev.bluearc.com/CALLHOME nfs
rw,nosuid,nodev,v3,rsize=3D32768,wsize=3D32768,hard,intr,lock,proto=3Dtcp=
,addr
=3Dus-
titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/ARCHIVE
/net/us-titan.us.dev.bluearc.com/ARCHIVE nfs
rw,nosuid,nodev,v3,rsize=3D32768,wsize=3D32768,hard,intr,lock,proto=3Dtcp=
,addr
=3Dus-ti
tan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/Install
/net/us-titan.us.dev.bluearc.com/Install nfs
rw,nosuid,nodev,v3,rsize=3D32768,wsize=3D32768,hard,intr,lock,proto=3Dtcp=
,addr
=3Dus-ti
tan.us.dev.bluearc.com 0 0
=20
("Install" is the right case but "CALLHOME" and "ARCHIVE" should both be
all lower-case.)
=20
That matches my recollection of the symptom of duezer, though I'm having
a hard time proving it from the console logs.
-------------------------------------
Martin's Outlook, BlueArc Engineering
=20

------_=_NextPart_001_01C746E6.B08A6565
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 11">
<meta name=3DOriginator content=3D"Microsoft Word 11">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C746A3.A2205530">
<!--[if gte mso 9]><xml>
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
   <w:UseWord2002TableStyleRules/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" LatentStyleCount=3D"156">
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	mso-bidi-font-size:12.0pt;
	font-family:Arial;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;
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

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoPlainText>&gt; I just wanted to know if typing =
mount&lt;ret&gt;
showed a mount present on <o:p></o:p></p>

<p class=3DMsoPlainText>&gt; =
/net/us-titan.us.dev.bluearc.com/ARCHIVE<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>I found the output from cat /proc/mounts while
&quot;wide&quot; (the machine with the older kernel) had the =
problem.<span
style=3D'mso-spacerun:yes'>&nbsp; </span>It alleges three mounts from =
that server
while the problem was happening:<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>us-titan.us.dev.bluearc.com:/CALLHOME
/net/us-titan.us.dev.bluearc.com/CALLHOME <span =
class=3DSpellE>nfs</span>
rw,nosuid,nodev,v3,rsize=3D32768,wsize=3D32768,hard,intr,lock,proto=3Dtcp=
,addr=3Dus-<o:p></o:p></p>

<p class=3DMsoPlainText>titan.us.dev.bluearc.com 0 <span =
class=3DSpellE>0</span><o:p></o:p></p>

<p class=3DMsoPlainText>us-titan.us.dev.bluearc.com:/ARCHIVE
/net/us-titan.us.dev.bluearc.com/ARCHIVE <span class=3DSpellE>nfs</span>
rw,nosuid,nodev,v3,rsize=3D32768,wsize=3D32768,hard,intr,lock,proto=3Dtcp=
,addr=3Dus-ti<o:p></o:p></p>

<p class=3DMsoPlainText>tan.us.dev.bluearc.com 0 <span =
class=3DSpellE>0</span><o:p></o:p></p>

<p class=3DMsoPlainText>us-titan.us.dev.bluearc.com:/Install
/net/us-titan.us.dev.bluearc.com/Install <span class=3DSpellE>nfs</span>
rw,nosuid,nodev,v3,rsize=3D32768,wsize=3D32768,hard,intr,lock,proto=3Dtcp=
,addr=3Dus-ti<o:p></o:p></p>

<p class=3DMsoPlainText>tan.us.dev.bluearc.com 0 <span =
class=3DSpellE>0</span><o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>(&quot;Install&quot; is the right case but
&quot;CALLHOME&quot; and &quot;ARCHIVE&quot; should both be all =
lower-case.)<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>That matches my recollection of the symptom of =
<span
class=3DSpellE>duezer</span>, though I'm having a hard time proving it =
from the
console logs.<o:p></o:p></p>

<p class=3DMsoPlainText><span =
style=3D'mso-no-proof:yes'>-------------------------------------<o:p></o:=
p></span></p>

<p class=3DMsoPlainText><span style=3D'mso-no-proof:yes'>Martin's =
Outlook, BlueArc
Engineering<o:p></o:p></span></p>

<p class=3DMsoPlainText><span =
style=3D'mso-no-proof:yes'><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>

------_=_NextPart_001_01C746E6.B08A6565--


--===============0324707074411057087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0324707074411057087==--

