From: "Shawn Starr" <sstarr@platform.com>
Subject: Automount with a local NFS export and a remote NFS export
	using the same mount path name over LDAP
Date: Fri, 17 Nov 2006 15:45:45 -0500
Message-ID: <E2AC825D4FC7764DA86D9C8ECA27A2DEAF7B32@catoexm05.noam.corp.platform.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8436882074869341777=="
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

--===============8436882074869341777==
content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C70A89.5B01FC04"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C70A89.5B01FC04
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=20

Does Automount v4 support the ability do the following:


1) A local machine with NFS export /home mounted with a local =
/etc/auto.home map.

2) a external machine with NFS export /home and using LDAP to export a =
auto.home map to automount.

If I set nsswitch.conf on the local machine to:  automount: files ldap. =
Automount ignores LDAP mounts and only mounts the local files.=20

If I flip the order and use 'ldap files' automount only mounts the =
remote NFS /home and clobbers the local NFS /home map. Yet if I try to =
pass more than one auto.home mapping via LDAP to automount it ignores =
them.

If Automount 4 can't do this does version 5? :)

Thanks,=20
--
Shawn Starr
Software Developer, Open Source Grid Development Center (OSGDC)
Platform Computing
3760 14th Avenue
Markham, ON L3R3T7
direct: 905.948.4229
http://www.platform.com


------_=_NextPart_001_01C70A89.5B01FC04
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
<TITLE>Automount with a local NFS export and a remote NFS export using =
the same mount path name over LDAP</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi, </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Does Automount v4 support the ability =
do the following:</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">1) A local machine with NFS export =
/home mounted with a local /etc/auto.home map.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">2) a external machine with NFS export =
/home and using LDAP to export a auto.home map to automount.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If I set nsswitch.conf on the local =
machine to:&nbsp; automount: files ldap. Automount ignores LDAP mounts =
and only mounts the local files. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If I flip the order and use 'ldap =
files' automount only mounts the remote NFS /home and clobbers the local =
NFS /home map. Yet if I try to pass more than one auto.home mapping via =
LDAP to automount it ignores them.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If Automount 4 can't do this does =
version 5? :)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks, </FONT>

<BR><B><FONT COLOR=3D"#800000" SIZE=3D2 FACE=3D"Arial">--<BR>
Shawn Starr<BR>
</FONT></B><FONT SIZE=3D2 FACE=3D"Arial">Software Developer, Open Source =
Grid Development Center (OSGDC)<BR>
</FONT><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">Platform =
Computing<BR>
</FONT><FONT FACE=3D"Times New Roman">3760 14th Avenue<BR>
Markham, ON L3R3T7<BR>
direct: 905.948.4229<BR>
<U></U></FONT><U><FONT COLOR=3D"#000080" FACE=3D"Times New Roman"><A =
HREF=3D"http://www.platform.com">http://www.platform.com</A></FONT></U>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C70A89.5B01FC04--


--===============8436882074869341777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8436882074869341777==--

