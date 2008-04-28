From: "Young, Darren" <Darren.Young@chicagogsb.edu>
Subject: Map errors
Date: Mon, 28 Apr 2008 16:23:07 -0500
Message-ID: <07A371D457B501478C1DB3C3DE8372D7017C265B@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2019916818393431654=="
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

--===============2019916818393431654==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_BFO64pJNwZs7c8LbCXfggw)"
Content-class: urn:content-classes:message

This is a multi-part message in MIME format.

--Boundary_(ID_BFO64pJNwZs7c8LbCXfggw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT

Ok, so I set /etc/sysconfig/autofs to what looks to be the format Sun
wants:

 

DEFAULT_MAP_OBJECT_CLASS="automountMap"

DEFAULT_ENTRY_OBJECT_CLASS="automount"

DEFAULT_MAP_ATTRIBUTE="automountMapName"

DEFAULT_ENTRY_ATTRIBUTE="automountKey"

DEFAULT_VALUE_ATTRIBUTE="automountInformation"

 

And I set the following there:

 

DEFAULT_MASTER_MAP_NAME="ldap:automountMapName=auto_home"

 

And all auto.master has is this:

 

/home  ldap

 

As autofs starts up I receive the following in syslog:

 

Apr 28 12:10:03 gsbtestfilervm automount[22969]: Starting automounter
version 5.0.1-0.rc2.55, master map ldap:automountMapName=auto_home

Apr 28 12:10:03 gsbtestfilervm automount[22969]: using kernel protocol
version 5.00

Apr 28 12:10:55 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /mbahome/& ]

Apr 28 12:10:55 gsbtestfilervm last message repeated 27 times

Apr 28 12:10:55 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /phdhome/& ]

Apr 28 12:10:55 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /mbahome/& ]

Apr 28 12:10:55 gsbtestfilervm last message repeated 10 times

Apr 28 12:10:55 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /vol/facunixhome/home/& ]

Apr 28 12:10:55 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /mbahome/& ]

Apr 28 12:10:55 gsbtestfilervm last message repeated 12 times

Apr 28 12:10:55 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /phdhome/& ]

Apr 28 12:10:55 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /mbahome/& ]

Apr 28 12:10:56 gsbtestfilervm last message repeated 36 times

Apr 28 12:10:56 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /vol/facunixhome/home/& ]

Apr 28 12:10:56 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /mbahome/& ]

Apr 28 12:10:56 gsbtestfilervm last message repeated 6 times

Apr 28 12:10:56 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /vol/facunixhome/home/& ]

Apr 28 12:10:56 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /mbahome/& ]

Apr 28 12:10:56 gsbtestfilervm last message repeated 13 times

Apr 28 12:10:56 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /vol/facunixhome/home/& ]

Apr 28 12:10:56 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /mbahome/& ]

Apr 28 12:10:56 gsbtestfilervm last message repeated 2 times

Apr 28 12:10:56 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /vol/facunixhome/home/& ]

Apr 28 12:10:56 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /mbahome/& ]

Apr 28 12:10:56 gsbtestfilervm last message repeated 15 times

Apr 28 12:10:56 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /export/home/& ]

Apr 28 12:10:56 gsbtestfilervm automount[22969]: master_notify: syntax
error in map near [ /mbahome/& ]

 

It appears as though the Sun tools that migrated the auto_home
information to LDAP pulled in something that's garbage... Problem is I
have well over 11,000 auto.home entries and can't think of a way to
narrow that down to which entries have errors. Is there any way to have
autofs spit back the dn it had the error on?

 

 

Darren Young
Systems & Security Architect
Computing Services
Chicago GSB
5807 South Woodlawn Avenue
Chicago, IL 60637

Voice 773.702.0331 | Fax 773.702.0233


--Boundary_(ID_BFO64pJNwZs7c8LbCXfggw)
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
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" xmlns:Z=3D"urn:schemas-microsoft-com:" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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

<p class=3DMsoNormal>Ok, so I set /etc/sysconfig/autofs to what looks to =
be the
format Sun wants:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p =
class=3DMsoNormal>DEFAULT_MAP_OBJECT_CLASS=3D&quot;automountMap&quot;<o:p=
></o:p></p>

<p =
class=3DMsoNormal>DEFAULT_ENTRY_OBJECT_CLASS=3D&quot;automount&quot;<o:p>=
</o:p></p>

<p =
class=3DMsoNormal>DEFAULT_MAP_ATTRIBUTE=3D&quot;automountMapName&quot;<o:=
p></o:p></p>

<p =
class=3DMsoNormal>DEFAULT_ENTRY_ATTRIBUTE=3D&quot;automountKey&quot;<o:p>=
</o:p></p>

<p =
class=3DMsoNormal>DEFAULT_VALUE_ATTRIBUTE=3D&quot;automountInformation&qu=
ot;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>And I set the following there:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p =
class=3DMsoNormal>DEFAULT_MASTER_MAP_NAME=3D&quot;ldap:automountMapName=3D=
auto_home&quot;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>And all auto.master has is this:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>/home&nbsp; ldap<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>As autofs starts up I receive the following in =
syslog:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:03 gsbtestfilervm automount[22969]: =
Starting
automounter version 5.0.1-0.rc2.55, master map =
ldap:automountMapName=3Dauto_home<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:03 gsbtestfilervm automount[22969]: =
using
kernel protocol version 5.00<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:55 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /mbahome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:55 gsbtestfilervm last message =
repeated 27
times<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:55 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /phdhome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:55 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /mbahome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:55 gsbtestfilervm last message =
repeated 10 times<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:55 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /vol/facunixhome/home/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:55 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /mbahome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:55 gsbtestfilervm last message =
repeated 12
times<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:55 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /phdhome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:55 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /mbahome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm last message =
repeated 36
times<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /vol/facunixhome/home/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /mbahome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm last message =
repeated 6 times<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /vol/facunixhome/home/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /mbahome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm last message =
repeated 13
times<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /vol/facunixhome/home/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /mbahome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm last message =
repeated 2 times<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /vol/facunixhome/home/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /mbahome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm last message =
repeated 15
times<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /export/home/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal>Apr 28 12:10:56 gsbtestfilervm automount[22969]:
master_notify: syntax error in map near [ /mbahome/&amp; =
]<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>It appears as though the Sun tools that migrated =
the
auto_home information to LDAP pulled in something that&#8217;s =
garbage&#8230;
Problem is I have well over 11,000 auto.home entries and can&#8217;t =
think of a
way to narrow that down to which entries have errors. Is there any way =
to have
autofs spit back the dn it had the error on?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><b><span
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Darren =
Young</span></b><b><span
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><br>
</span></b><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Systems
&amp; Security Architect</span><span =
style=3D'font-size:12.0pt;font-family:"Arial","sans-serif"'><br>
</span><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Computing
Services<br>
</span><b><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Chicago
GSB</span></b><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'><br>
5807 South Woodlawn Avenue<br>
Chicago, IL 60637</span><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif"'><o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif"'>Voice
773.702.0331 | Fax 773.702.0233</span><o:p></o:p></p>

</div>

</body>

</html>

--Boundary_(ID_BFO64pJNwZs7c8LbCXfggw)--


--===============2019916818393431654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2019916818393431654==--

