From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Minor update to submitted minor patches...
Date: Mon, 16 Jun 2008 15:09:55 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC7014E02CF4@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8875887674880992515=="
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
Cc: Ian Kent <raven@themaw.net>

This is a multi-part message in MIME format.

--===============8875887674880992515==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8CFFD.B561A0D0"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8CFFD.B561A0D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

For the previously submitted patch, I forgot to run diff with the -p
option, but the only C file that was changed was daemon/automount.c.
The change was in the function "handle_mounts".  The "@@" line in the
patch file can be replaced by the next line:
@@ -1554,7 +1554,6 @@ void *handle_mounts(void *arg)


Agan CC'ing to Ian Kent directly to do an end run around any posting
problems to the autofs list.

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

------_=_NextPart_001_01C8CFFD.B561A0D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-asci=
i">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7652.2=
4">
<TITLE>Minor update to submitted minor patches...</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">For the previously submitted patch, I fo=
rgot to run diff with the -p option, but the only C file that was changed=
=20was daemon/automount.c.&nbsp; The change was in the function &quot;han=
dle_mounts&quot;.&nbsp; The &quot;@@&quot; line in the patch file can be =
replaced by the next line:</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">@@ -1554,7 +1554,6 @@ void *handle_mount=
s(void *arg)</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Agan CC'ing to Ian Kent directly to do a=
n end run around any posting problems to the autofs list.</FONT>
</P>


<DIV>
<HR>
</DIV>
<DIV>This email message is for the sole use of the intended recipient(s) =
and may=20
contain confidential information.&nbsp; Any unauthorized review, use, dis=
closure=20
or distribution is prohibited.&nbsp; If you are not the intended recipien=
t,=20
please contact the sender by reply email and destroy all copies of the or=
iginal=20
message. </DIV>
<DIV>
<HR>
</DIV>
<P></P>
</BODY>
</HTML>

------_=_NextPart_001_01C8CFFD.B561A0D0--


--===============8875887674880992515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8875887674880992515==--

