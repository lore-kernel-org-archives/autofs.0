From: "Lohin, Daniel" <daniel.lohin@lmco.com>
Subject: Help on nfs4 interpolarity between Solaris 10 and Linux
Date: Wed, 17 Dec 2008 10:42:18 -0500
Message-ID: <803A3BBEF4925F429A040C890141E6BB0E5C505E@emss04m23.us.lmco.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9116771338315318633=="
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

--===============9116771338315318633==
Content-type: multipart/alternative; boundary="Boundary_(ID_6O/0GYDXwGiRRwEV8Mp5ZQ)"
Content-class: urn:content-classes:message

This is a multi-part message in MIME format.

--Boundary_(ID_6O/0GYDXwGiRRwEV8Mp5ZQ)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT

We are using Red Hat 4.5 with autofs 4.1.3.  We are in a mixed
Solaris/Linux environment.  We have an automountMapName that needs to
support both NFS 3 and NFS4.  To complicate things, the solution must
work on both Solaris and Linux.  Here is what I have:

 

AUTO_MASTER:

dn: Automountkey=/-,automountMapName=auto_master,dc=foo,dc=bar

automountInformation: auto_direct

automountKey: /-

objectClass: top

objectClass: automount

 

 

dn: automountkey=/.hidden,automountMapName=auto_master,dc=foo,dc=bar

automountInformation: auto_hidden

automountKey: /.hidden

objectClass: top

objectClass: automount

 

 

Auto_hidden:

 

dn: automountkey=hiddenNfs4,automountMapName=auto_hidden,dc=foo,dc=bar

automountInformation:  -fstype=nfs4 server:/

automountKey: hiddenNfs4

objectClass: top

objectClass: automount

 

dn: automountkey=*,automountMapName=auto_hidden,dc=foo,dc=bar

automountInformation:  server2,server3,server4,server5:/vol/&

automountKey: hiddenMain

objectClass: top

objectClass: automount

 

 

 

From above in * of auto_hidden this must be nfs3 as that is all that is
supported by the servers in that automount.  In the hiddenNfs4
automountkey this must be nfs4 as it has to cross a firewall.  

 

The * is working perfectly.  The problem is the hiddenNfs4 automount
map.

 

I can get it to work with Solaris with the following:

 

dn: automountkey=hiddenNfs4,automountMapName=auto_hidden,dc=foo,dc=bar

automountInformation:  -vers=4 server:/

automountKey: hiddenNfs4

objectClass: top

objectClass: automount

 

Linux will work this this:

dn: automountkey=hiddenNfs4,automountMapName=auto_hidden,dc=foo,dc=bar

automountInformation:  -fstype=nfs4 server:/

automountKey: hiddenNfs4

objectClass: top

objectClass: automount

 

Solaris will work with this, but fail for Linux

dn: automountkey=hiddenNfs4,automountMapName=auto_hidden,dc=foo,dc=bar

automountInformation:  -fstype=nfs4,-vers=4 server:/

automountKey: hiddenNfs4

objectClass: top

objectClass: automount

 

Solaris will also work with this:

dn: automountkey=hiddenNfs4,automountMapName=auto_hidden,dc=foo,dc=bar

automountInformation:   server:/

automountKey: hiddenNfs4

objectClass: top

objectClass: automount

 

Solaris looks like it tries nfs4 and then if that fails it will continue
to try 3, 2, etc....  

 

 

What I need is either an automountmap entry that works with both or a
way to have Linux mirror Solaris in trying NFS4 first and not requiring
any options.

 

 

Can anyone please help me out on this.  I have been stumped for a while
on this.

 

Thanks,

Daniel Lohin


--Boundary_(ID_6O/0GYDXwGiRRwEV8Mp5ZQ)
Content-type: text/html; charset=us-ascii
Content-transfer-encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:D=3D"DAV:" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/soap" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:udcp2p=3D"http://schemas.microsoft.com/data/udc/parttopart" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:dsss=3D"http://schemas.microsoft.com/office/2006/digsig-setup" =
xmlns:dssi=3D"http://schemas.microsoft.com/office/2006/digsig" =
xmlns:mdssi=3D"http://schemas.openxmlformats.org/package/2006/digital-sig=
nature" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" xmlns:spwp=3D"http://microsoft.com/sharepoint/webpartpages" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" =
xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/SlideLibrary/=
" =
xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortalServer/Pub=
lishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" =
xmlns:st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
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

<p class=3DMsoNormal>We are using Red Hat 4.5 with autofs 4.1.3.&nbsp; =
We are in
a mixed Solaris/Linux environment.&nbsp; We have an automountMapName =
that needs
to support both NFS 3 and NFS4.&nbsp; To complicate things, the solution =
must
work on both Solaris and Linux.&nbsp; Here is what I =
have:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>AUTO_MASTER:<o:p></o:p></p>

<p class=3DMsoNormal>dn: =
Automountkey=3D/-,automountMapName=3Dauto_master,dc=3Dfoo,dc=3Dbar<o:p></=
o:p></p>

<p class=3DMsoNormal>automountInformation: auto_direct<o:p></o:p></p>

<p class=3DMsoNormal>automountKey: /-<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: top<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: automount<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>dn: =
automountkey=3D/.hidden,automountMapName=3Dauto_master,dc=3Dfoo,dc=3Dbar<=
o:p></o:p></p>

<p class=3DMsoNormal>automountInformation: auto_hidden<o:p></o:p></p>

<p class=3DMsoNormal>automountKey: /.hidden<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: top<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: automount<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Auto_hidden:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>dn: =
automountkey=3DhiddenNfs4,automountMapName=3Dauto_hidden,dc=3Dfoo,dc=3Dba=
r<o:p></o:p></p>

<p class=3DMsoNormal>automountInformation: &nbsp;-fstype=3Dnfs4 =
server:/<o:p></o:p></p>

<p class=3DMsoNormal>automountKey: hiddenNfs4<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: top<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: automount<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>dn: =
automountkey=3D*,automountMapName=3Dauto_hidden,dc=3Dfoo,dc=3Dbar<o:p></o=
:p></p>

<p class=3DMsoNormal>automountInformation: =
&nbsp;server2,server3,server4,server5:/vol/&amp;<o:p></o:p></p>

<p class=3DMsoNormal>automountKey: hiddenMain<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: top<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: automount<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>From above in * of auto_hidden this must be nfs3 as =
that is
all that is supported by the servers in that automount.&nbsp; In the =
hiddenNfs4
automountkey this must be nfs4 as it has to cross a firewall.&nbsp; =
<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The * is working perfectly.&nbsp; The problem is =
the
hiddenNfs4 automount map.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I can get it to work with Solaris with the =
following:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>dn: =
automountkey=3DhiddenNfs4,automountMapName=3Dauto_hidden,dc=3Dfoo,dc=3Dba=
r<o:p></o:p></p>

<p class=3DMsoNormal>automountInformation: &nbsp;-vers=3D4 =
server:/<o:p></o:p></p>

<p class=3DMsoNormal>automountKey: hiddenNfs4<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: top<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: automount<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Linux will work this this:<o:p></o:p></p>

<p class=3DMsoNormal>dn: =
automountkey=3DhiddenNfs4,automountMapName=3Dauto_hidden,dc=3Dfoo,dc=3Dba=
r<o:p></o:p></p>

<p class=3DMsoNormal>automountInformation: &nbsp;-fstype=3Dnfs4 =
server:/<o:p></o:p></p>

<p class=3DMsoNormal>automountKey: hiddenNfs4<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: top<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: automount<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Solaris will work with this, but fail for =
Linux<o:p></o:p></p>

<p class=3DMsoNormal>dn: =
automountkey=3DhiddenNfs4,automountMapName=3Dauto_hidden,dc=3Dfoo,dc=3Dba=
r<o:p></o:p></p>

<p class=3DMsoNormal>automountInformation: =
&nbsp;-fstype=3Dnfs4,-vers=3D4 server:/<o:p></o:p></p>

<p class=3DMsoNormal>automountKey: hiddenNfs4<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: top<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: automount<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Solaris will also work with this:<o:p></o:p></p>

<p class=3DMsoNormal>dn: =
automountkey=3DhiddenNfs4,automountMapName=3Dauto_hidden,dc=3Dfoo,dc=3Dba=
r<o:p></o:p></p>

<p class=3DMsoNormal>automountInformation: =
&nbsp;&nbsp;server:/<o:p></o:p></p>

<p class=3DMsoNormal>automountKey: hiddenNfs4<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: top<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: automount<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Solaris looks like it tries nfs4 and then if that =
fails it
will continue to try 3, 2, etc&#8230;.&nbsp; <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>What I need is either an automountmap entry that =
works with
both or a way to have Linux mirror Solaris in trying NFS4 first and not
requiring any options.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Can anyone please help me out on this.&nbsp; I have =
been
stumped for a while on this.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks,<o:p></o:p></p>

<p class=3DMsoNormal>Daniel Lohin<o:p></o:p></p>

</div>

</body>

</html>

--Boundary_(ID_6O/0GYDXwGiRRwEV8Mp5ZQ)--


--===============9116771338315318633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============9116771338315318633==--

