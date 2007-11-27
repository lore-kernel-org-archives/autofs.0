From: "James Richardson" <jrichardson@x-iss.com>
Subject: Slow mounts when using large round robin sets
Date: Tue, 27 Nov 2007 10:11:10 -0600
Message-ID: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2978718235448136499=="
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

--===============2978718235448136499==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83110.2095DA78"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83110.2095DA78
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

All,

=20

I have stumbled upon an interesting situation when using AutoFS to mount
nfs shares where the the NFS server is served from a large (over 20)
round robin set.

=20

For example, I use NIS to distribute my auto.home NIS map. Each of my
users has their home directory located on a central NFS server with
multiple network interfaces (about 50). Those 50 IP's are in a DNS round
robin set. When using autofs to mount one of their home directories
dynamically it can take anywhere from one to 7-8 seconds (usually about
2 seconds).=20

=20

When the DNS RR set is scaled down to only have 15-20 entries the
mounting time is around half of one second - (.5 seconds).  Mounting
directly using the mount command is the fastest and always mounts in
under .5 seconds.

=20

There are no errors in the syslog (messages or daemon.log). I'm using
kernel 2.6.21 and autofs 5.0.1`-9 (and have tested this with 5.0.2-1).

=20

One interesting side note, I did some packet captures with the larger
DNS RR set, and found that for a single autofs mount, there could be
anywhere from 3,000-5,000 DNS queries for the NFS server.

=20

I'm puzzled as to why this is happening or how to further troubleshoot
the issue.=20

=20

Thanks,

=20

---

James T. Richardson, Jr.

jrichardson@x-iss.com

eXcellence in IS Solutions, Inc.

713-862-9200 x226

=20


NOTICE:
This message may contain privileged or otherwise confidential information.
If you are not the intended recipient, please immediately advise the sender
by reply email and delete the message and any attachments without using,
copying or disclosing the contents.



------_=_NextPart_001_01C83110.2095DA78
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:p=3D"urn:schemas-m=
icrosoft-com:office:powerpoint" xmlns:a=3D"urn:schemas-microsoft-com:office=
:access" xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:s=3D"=
uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" xmlns:rs=3D"urn:schemas-microsof=
t-com:rowset" xmlns:z=3D"#RowsetSchema" xmlns:b=3D"urn:schemas-microsoft-co=
m:office:publisher" xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadshee=
t" xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" xmlns=
:oa=3D"urn:schemas-microsoft-com:office:activation" xmlns:html=3D"http://ww=
w.w3.org/TR/REC-html40" xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope=
/" xmlns:D=3D"DAV:" xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2=
003/xml" xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" xm=
lns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" xmlns:d=
s=3D"http://www.w3.org/2000/09/xmldsig#" xmlns:dsp=3D"http://schemas.micros=
oft.com/sharepoint/dsp" xmlns:udc=3D"http://schemas.microsoft.com/data/udc"=
 xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" xmlns:sps=3D"http://schemas=
.microsoft.com/sharepoint/soap/" xmlns:xsi=3D"http://www.w3.org/2001/XMLSch=
ema-instance" xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile"=
 xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" xmlns:=
mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:=
m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns:mrels=3D"http:=
//schemas.openxmlformats.org/package/2006/relationships" xmlns:ex12t=3D"htt=
p://schemas.microsoft.com/exchange/services/2006/types" xmlns:ex12m=3D"http=
://schemas.microsoft.com/exchange/services/2006/messages" xmlns=3D"http://w=
ww.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
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

<p class=3DMsoNormal>All,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have stumbled upon an interesting situation when usi=
ng
AutoFS to mount nfs shares where the the NFS server is served from a large
(over 20) round robin set.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>For example, I use NIS to distribute my auto.home NIS =
map.
Each of my users has their home directory located on a central NFS server w=
ith
multiple network interfaces (about 50). Those 50 IP&#8217;s are in a DNS ro=
und
robin set. When using autofs to mount one of their home directories dynamic=
ally
it can take anywhere from one to 7-8 seconds (usually about 2 seconds). <o:=
p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>When the DNS RR set is scaled down to only have 15-20
entries the mounting time is around half of one second - (.5 seconds). &nbs=
p;Mounting
directly using the mount command is the fastest and always mounts in under =
.5
seconds.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>There are no errors in the syslog (messages or daemon.=
log).
I&#8217;m using kernel 2.6.21 and autofs 5.0.1`-9 (and have tested this wit=
h
5.0.2-1).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>One interesting side note, I did some packet captures =
with
the larger DNS RR set, and found that for a single autofs mount, there coul=
d be
anywhere from 3,000-5,000 DNS queries for the NFS server.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;m puzzled as to why this is happening or how t=
o
further troubleshoot the issue. <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>---<o:p></o:p></p>

<p class=3DMsoNormal>James T. Richardson, Jr.<o:p></o:p></p>

<p class=3DMsoNormal><a href=3D"mailto:jrichardson@x-iss.com">jrichardson@x=
-iss.com</a><o:p></o:p></p>

<p class=3DMsoNormal>eXcellence in IS Solutions, Inc.<o:p></o:p></p>

<p class=3DMsoNormal>713-862-9200 x226<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<br><pre>NOTICE:
This message may contain privileged or otherwise confidential information.
If you are not the intended recipient, please immediately advise the sender
by reply email and delete the message and any attachments without using,
copying or disclosing the contents.
</pre></body>

</html>


------_=_NextPart_001_01C83110.2095DA78--


--===============2978718235448136499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2978718235448136499==--

