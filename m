From: "Shawn Starr" <sstarr@platform.com>
Subject: Re: Automount with a local NFS export and a remote NFS
	export using the same mount path name over LDAP
Date: Fri, 17 Nov 2006 17:27:35 -0500
Message-ID: <E2AC825D4FC7764DA86D9C8ECA27A2DEAF7B34@catoexm05.noam.corp.platform.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5138934521697432919=="
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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

--===============5138934521697432919==
content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C70A97.949C01E0"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C70A97.949C01E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Nevermind, I found an ugly workaround.

Just add another entry to auto.home in the LDAP config to map back to =
the local machine.

>  -----Original Message-----
> From: 	Shawn Starr =20
> Sent:	Friday, November 17, 2006 3:46 PM
> To:	'autofs@linux.kernel.org'
> Subject:	Automount with a local NFS export and a remote NFS export =
using the same mount path name over LDAP
>=20
> Hi,=20
>=20
> Does Automount v4 support the ability do the following:
>=20
>=20
> 1) A local machine with NFS export /home mounted with a local =
/etc/auto.home map.
>=20
> 2) a external machine with NFS export /home and using LDAP to export a =
auto.home map to automount.
>=20
> If I set nsswitch.conf on the local machine to:  automount: files =
ldap. Automount ignores LDAP mounts and only mounts the local files.=20
>=20
> If I flip the order and use 'ldap files' automount only mounts the =
remote NFS /home and clobbers the local NFS /home map. Yet if I try to =
pass more than one auto.home mapping via LDAP to automount it ignores =
them.
>=20
> If Automount 4 can't do this does version 5? :)
>=20
> Thanks,=20
> --
> Shawn Starr
> Software Developer, Open Source Grid Development Center (OSGDC)
> Platform Computing
> 3760 14th Avenue
> Markham, ON L3R3T7
> direct: 905.948.4229
> http://www.platform.com
>=20

------_=_NextPart_001_01C70A97.949C01E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6618.4">
<TITLE>RE: Automount with a local NFS export and a remote NFS export =
using the same mount path name over LDAP</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Arial">Nevermind, I found an =
ugly workaround.</FONT>
</P>

<P><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Arial">Just add another =
entry to auto.home in the LDAP config to map back to the local =
machine.</FONT>
</P>
<UL>
<P><FONT FACE=3D"Arial"><SPAN LANG=3D"en-us"></SPAN></FONT><SPAN =
LANG=3D"en-us">&nbsp;<FONT SIZE=3D1 FACE=3D"Tahoma">-----Original =
Message-----</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D1 FACE=3D"Tahoma">From: =
&nbsp;</FONT></B> <FONT SIZE=3D1 FACE=3D"Tahoma">Shawn Starr&nbsp; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D1 =
FACE=3D"Tahoma">Sent:&nbsp;&nbsp;</FONT></B> <FONT SIZE=3D1 =
FACE=3D"Tahoma">Friday, November 17, 2006 3:46 PM</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D1 =
FACE=3D"Tahoma">To:&nbsp;&nbsp;&nbsp;&nbsp;</FONT></B> <FONT SIZE=3D1 =
FACE=3D"Tahoma">'autofs@linux.kernel.org'</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D1 =
FACE=3D"Tahoma">Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>=
</B> <FONT SIZE=3D1 FACE=3D"Tahoma">Automount with a local NFS export =
and a remote NFS export using the same mount path name over =
LDAP</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Hi, </FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Does Automount v4 =
support the ability do the following:</FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">1) A local machine =
with NFS export /home mounted with a local /etc/auto.home =
map.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">2) a external =
machine with NFS export /home and using LDAP to export a auto.home map =
to automount.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">If I set =
nsswitch.conf on the local machine to:&nbsp; automount: files ldap. =
Automount ignores LDAP mounts and only mounts the local files. =
</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">If I flip the =
order and use 'ldap files' automount only mounts the remote NFS /home =
and clobbers the local NFS /home map. Yet if I try to pass more than one =
auto.home mapping via LDAP to automount it ignores =
them.</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">If Automount 4 =
can't do this does version 5? :)</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Thanks, =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT COLOR=3D"#800000" SIZE=3D2 =
FACE=3D"Arial">--<BR>
Shawn Starr<BR>
</FONT></B><FONT SIZE=3D2 FACE=3D"Arial">Software Developer, Open Source =
Grid Development Center (OSGDC)<BR>
</FONT><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">Platform =
Computing<BR>
</FONT><FONT FACE=3D"Times New Roman">3760 14th Avenue<BR>
Markham, ON L3R3T7<BR>
direct: 905.948.4229<BR>
<U></U></FONT><U><FONT COLOR=3D"#000080" FACE=3D"Times New Roman"><A =
HREF=3D"http://www.platform.com">http://www.platform.com</A></FONT></U></=
SPAN>
</P>
</UL>
</BODY>
</HTML>
------_=_NextPart_001_01C70A97.949C01E0--


--===============5138934521697432919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5138934521697432919==--

