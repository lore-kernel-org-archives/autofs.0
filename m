From: "Young, Darren" <Darren.Young@chicagogsb.edu>
Subject: auto home failure
Date: Mon, 23 Jun 2008 16:55:36 -0500
Message-ID: <07A371D457B501478C1DB3C3DE8372D701C48632@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2820366219260344707=="
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

--===============2820366219260344707==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_Apu3sv/tiAsqWDXY2gJPeg)"
Content-class: urn:content-classes:message

This is a multi-part message in MIME format.

--Boundary_(ID_Apu3sv/tiAsqWDXY2gJPeg)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT

Have an auto_home entry:

 

dn:
automountKey=dyoung2,automountMapName=auto_home,o=gsb,dc=uchicago,dc=edu

automountInformation: gsbdata3:/export/home/&

automountKey: dyoung2 

objectClass: top

objectClass: automount

 

and get this when trying to mount:

 

Jun 22 05:24:34 gsbtestfilervm automount[14488]: attempting to mount
entry /home/dyoung2

Jun 22 05:24:34 gsbtestfilervm automount[14488]: failed to mount
/home/dyoung2

 

/etc/sysconfig/autofs:

 

#

# Define default options for autofs.

#

# DEFAULT_MASTER_MAP_NAME - default map name for the master map.

#

#DEFAULT_MASTER_MAP_NAME="ldap:automountMapName=auto_master"

#

# DEFAULT_TIMEOUT - set the default mount timeout (default 600).

#

DEFAULT_TIMEOUT=300

#

# DEFAULT_BROWSE_MODE - maps are browsable by default.

#

DEFAULT_BROWSE_MODE="no"

#

# DEFAULT_APPEND_OPTIONS - append to global options instead of replace.

#

#DEFAULT_APPEND_OPTIONS="yes"

#

# DEFAULT_LOGGING - set default log level "none", "verbose" or "debug"

#

DEFAULT_LOGGING="debug"

#

# Define the default LDAP schema to use for lookups

#

# System default

#

#DEFAULT_MAP_OBJECT_CLASS="nisMap"

#DEFAULT_ENTRY_OBJECT_CLASS="nisObject"

#DEFAULT_MAP_ATTRIBUTE="nisMapName"

#DEFAULT_ENTRY_ATTRIBUTE="cn"

#DEFAULT_VALUE_ATTRIBUTE="nisMapEntry"

#

# Other common LDAP nameing

#

#DEFAULT_MAP_OBJECT_CLASS="automountMap"

#DEFAULT_ENTRY_OBJECT_CLASS="automount"

#DEFAULT_MAP_ATTRIBUTE="ou"

#DEFAULT_ENTRY_ATTRIBUTE="cn"

#DEFAULT_VALUE_ATTRIBUTE="automountInformation"

#

DEFAULT_MAP_OBJECT_CLASS="automountMap"

DEFAULT_ENTRY_OBJECT_CLASS="automount"

DEFAULT_MAP_ATTRIBUTE="automountMapName"

DEFAULT_ENTRY_ATTRIBUTE="automountKey"

DEFAULT_VALUE_ATTRIBUTE="automountInformation"

#

# DEFAULT_AUTH_CONF_FILE - set the default location for the SASL

#                          authentication configuration file.

#

#DEFAULT_AUTH_CONF_FILE="/etc/autofs_ldap_auth.conf"

#

# General global options

#

OPTIONS=""

#

 

/etc/openldap/ldap.conf

#

# LDAP Defaults

#

 

# See ldap.conf(5) for details

# This file should be world readable but not world writable.

 

URI ldap://gsbids1.uchicago.edu

 

#SIZELIMIT      12

#TIMELIMIT      15

#DEREF          never

BASE o=gsb,dc=uchicago,dc=edu

TLS_CACERTDIR /etc/openldap/cacerts

Darren Young
Systems & Security Architect
Computing Services
Chicago GSB
5807 South Woodlawn Avenue
Chicago, IL 60637

Voice 773.702.0331 | Fax 773.702.0233


--Boundary_(ID_Apu3sv/tiAsqWDXY2gJPeg)
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

<p class=3DMsoNormal>Have an auto_home entry:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>dn:
automountKey=3Ddyoung2,automountMapName=3Dauto_home,o=3Dgsb,dc=3Duchicago=
,dc=3Dedu<o:p></o:p></p>

<p class=3DMsoNormal>automountInformation: =
gsbdata3:/export/home/&amp;<o:p></o:p></p>

<p class=3DMsoNormal>automountKey: dyoung2 <o:p></o:p></p>

<p class=3DMsoNormal>objectClass: top<o:p></o:p></p>

<p class=3DMsoNormal>objectClass: automount<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>and get this when trying to mount:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Jun 22 05:24:34 gsbtestfilervm automount[14488]: =
attempting
to mount entry /home/dyoung2<o:p></o:p></p>

<p class=3DMsoNormal>Jun 22 05:24:34 gsbtestfilervm automount[14488]: =
failed to
mount /home/dyoung2<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>/etc/sysconfig/autofs:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># Define default options for autofs.<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># DEFAULT_MASTER_MAP_NAME - default map name for =
the master
map.<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p =
class=3DMsoNormal>#DEFAULT_MASTER_MAP_NAME=3D&quot;ldap:automountMapName=3D=
auto_master&quot;<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># DEFAULT_TIMEOUT - set the default mount timeout =
(default
600).<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal>DEFAULT_TIMEOUT=3D300<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># DEFAULT_BROWSE_MODE - maps are browsable by =
default.<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal>DEFAULT_BROWSE_MODE=3D&quot;no&quot;<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># DEFAULT_APPEND_OPTIONS - append to global options =
instead
of replace.<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p =
class=3DMsoNormal>#DEFAULT_APPEND_OPTIONS=3D&quot;yes&quot;<o:p></o:p></p=
>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># DEFAULT_LOGGING - set default log level =
&quot;none&quot;,
&quot;verbose&quot; or &quot;debug&quot;<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal>DEFAULT_LOGGING=3D&quot;debug&quot;<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># Define the default LDAP schema to use for =
lookups<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># System default<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p =
class=3DMsoNormal>#DEFAULT_MAP_OBJECT_CLASS=3D&quot;nisMap&quot;<o:p></o:=
p></p>

<p =
class=3DMsoNormal>#DEFAULT_ENTRY_OBJECT_CLASS=3D&quot;nisObject&quot;<o:p=
></o:p></p>

<p =
class=3DMsoNormal>#DEFAULT_MAP_ATTRIBUTE=3D&quot;nisMapName&quot;<o:p></o=
:p></p>

<p =
class=3DMsoNormal>#DEFAULT_ENTRY_ATTRIBUTE=3D&quot;cn&quot;<o:p></o:p></p=
>

<p =
class=3DMsoNormal>#DEFAULT_VALUE_ATTRIBUTE=3D&quot;nisMapEntry&quot;<o:p>=
</o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># Other common LDAP nameing<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p =
class=3DMsoNormal>#DEFAULT_MAP_OBJECT_CLASS=3D&quot;automountMap&quot;<o:=
p></o:p></p>

<p =
class=3DMsoNormal>#DEFAULT_ENTRY_OBJECT_CLASS=3D&quot;automount&quot;<o:p=
></o:p></p>

<p =
class=3DMsoNormal>#DEFAULT_MAP_ATTRIBUTE=3D&quot;ou&quot;<o:p></o:p></p>

<p =
class=3DMsoNormal>#DEFAULT_ENTRY_ATTRIBUTE=3D&quot;cn&quot;<o:p></o:p></p=
>

<p =
class=3DMsoNormal>#DEFAULT_VALUE_ATTRIBUTE=3D&quot;automountInformation&q=
uot;<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

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

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># DEFAULT_AUTH_CONF_FILE - set the default location =
for the
SASL<o:p></o:p></p>

<p =
class=3DMsoNormal>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; authentication configuration
file.<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p =
class=3DMsoNormal>#DEFAULT_AUTH_CONF_FILE=3D&quot;/etc/autofs_ldap_auth.c=
onf&quot;<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># General global options<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal>OPTIONS=3D&quot;&quot;<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>/etc/openldap/ldap.conf<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal># LDAP Defaults<o:p></o:p></p>

<p class=3DMsoNormal>#<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal># See ldap.conf(5) for details<o:p></o:p></p>

<p class=3DMsoNormal># This file should be world readable but not world =
writable.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>URI ldap://gsbids1.uchicago.edu<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>#SIZELIMIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
12<o:p></o:p></p>

<p class=3DMsoNormal>#TIMELIMIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
15<o:p></o:p></p>

<p =
class=3DMsoNormal>#DEREF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; never<o:p></o:p></p>

<p class=3DMsoNormal>BASE o=3Dgsb,dc=3Duchicago,dc=3Dedu<o:p></o:p></p>

<p class=3DMsoNormal>TLS_CACERTDIR /etc/openldap/cacerts<o:p></o:p></p>

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

--Boundary_(ID_Apu3sv/tiAsqWDXY2gJPeg)--


--===============2820366219260344707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2820366219260344707==--

