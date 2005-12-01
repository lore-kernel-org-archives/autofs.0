From: "Gomez, Daniel" <dgomez@tigr.org>
Subject: OpenSolaris code importation
Date: Thu, 1 Dec 2005 14:02:55 -0500
Message-ID: <7F0AA25C9B1706448E8B73DFDD109B31017DED98@EXCHANGE.TIGR.ORG>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0756105190=="
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--===============0756105190==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5F6A9.D656B6E0"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5F6A9.D656B6E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I was wondering, now that solaris is opensource are there any plans of
importing some of the functionality found only in the solaris version
for linux?
=20
(For example, solaris can will lookup both local file and ldap maps for
a single mount space and will allow one to override the settings for the
other, but in linux the first db location found for the particular mount
point in question is used exclusively and thus forcing you to use either
purely local file maps or ldap maps for the same name space. Thus if you
have a site wide ldap automount policy but wish to override say the
write permission for a subset of hosts through a local configuration
file you can't. I don't expect an answer for this problem, but it did
cause me to wonder raise the question above.)

------_=_NextPart_001_01C5F6A9.D656B6E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Message</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2769" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D456195518-01122005><FONT face=3DArial size=3D2>I was =
wondering, now=20
that solaris is opensource are there any plans of importing some of the=20
functionality found only in the solaris version for =
linux?</FONT></SPAN></DIV>
<DIV><SPAN class=3D456195518-01122005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D456195518-01122005><FONT face=3DArial size=3D2>(For =
example,=20
solaris can will lookup both local file and ldap maps for a single mount =
space=20
and will allow one to override the settings for the other, but in linux =
the=20
first db location found for the particular mount point in question is =
used=20
exclusively and thus forcing you to use either purely local file maps or =
ldap=20
maps for the same name space. Thus if you have a site wide ldap =
automount policy=20
but wish to override say the write permission for a subset of hosts =
through a=20
local configuration file you can't. I don't expect an answer for this =
problem,=20
but it did cause me to wonder raise the question=20
above.)</FONT></SPAN></DIV></BODY></HTML>
=00
------_=_NextPart_001_01C5F6A9.D656B6E0--


--===============0756105190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0756105190==--

