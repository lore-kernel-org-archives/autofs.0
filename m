From: "Oliver Weinmann" <oliver.weinmann@vega.de>
Subject: Patching Autofs on SLES9 (autofs-4.1.3-included-maps.patch)
Date: Tue, 15 Jun 2010 11:14:33 +0200
Message-ID: <577798A82D8C2746B9461A64C5F4562802383A50@GEDACV2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4073271860514869560=="
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--===============4073271860514869560==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB0C6B.2B53790A"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB0C6B.2B53790A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear All,

We are widely using SLES9 in our environment. I noticed that the autofs
that comes with sles9 is not capable of treating the +auto.map in the
autofs files. We were asking novell support to fix this and after a
really long time (5 months) they came back to us saying that this is not
possible to implement without a service pack. It is very unlikely to be
released for SLES9 since it is too old. I'm not so much into autofs, but
I just can't believe this. I downloaded the autofs5 sources and compiled
them fine. I just can't run them since the kernel 2.6.5.7-322 doesn't
seem to support autofs5. Now I wonder If I can get an up to date autofs4
package running under SLES9. The patch that seems to fix this is called:

autofs-4.1.3-included-maps.patch

Any help would be appreciated.

Regards,
Oliver

------_=_NextPart_001_01CB0C6B.2B53790A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Patching Autofs on SLES9 =
(autofs-4.1.3-included-maps.patch)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Dear All,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We are widely using SLES9 in our =
environment. I noticed that the autofs that comes with sles9 is not =
capable of treating the +auto.map in the autofs files. We were asking =
novell support to fix this and after a really long time (5 months) they =
came back to us saying that this is not possible to implement without a =
service pack. It is very unlikely to be released for SLES9 since it is =
too old. I'm not so much into autofs, but I just can't believe this. I =
downloaded the autofs5 sources and compiled them fine. I just can't run =
them since the kernel 2.6.5.7-322 doesn't seem to support autofs5. Now I =
wonder If I can get an up to date autofs4 package running under SLES9. =
The patch that seems to fix this is called:</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">autofs-4.1.3-included-maps.patch</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Any help would be =
appreciated.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Regards,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Oliver</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB0C6B.2B53790A--


--===============4073271860514869560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4073271860514869560==--

