From: "Keeler, Wayne T \(Wayne\)" <wtkeeler@agere.com>
Subject: Replicated hosts in autofs
Date: Fri, 12 Nov 2004 13:53:34 -0500
Message-ID: <69612FDB757A504ABA194C8B3AC7FED994E064@pauex2ku06.agere.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45056738566088095=="
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

--===============45056738566088095==
content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4C8E8.E95D44EE"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4C8E8.E95D44EE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

I have read many threads regarding replicated hosts for autofs v3 and
v4.=20

Here is my scenario:

On a linux host (Opteron running RHEL 3 WS kernel 2.4.21-20.ELsmp, I
have the following automount configured:

mountpoint -fstype=3Dnfs,-proto=3Dtcp,ro host1,host2:/tmp/ro

The goal in my implementation is that after the initial mount occurs to
host1 or host2, if that particular host fails, nfs will pick up the
mount on the alternate host. Note that since both mount points are read
only, this serves as a lower cost, higher availability solution. This
works on Solaris.

I have had no success with this on Linux. It seems that the replication
only works on the initial mount/rpc call. Once the initial mount occurs,
it doesn't appear there is any fail-over capability.

I have even installed RedHat's Beta version of E4 (kernel
2.6.9-1.648_ELsmp). The result is the same. If I crash the machine that
originally had the mount-point, the end result is a hung mount and
fail-over never occurs.

I can't seem to find any information that indicates that this should or
should not work by design.

Can someone please definitively tell me if the capability I am seeking
is available via the autofs supplied by RedHat in Enterprise 3?

Regards,
Wayne



------_=_NextPart_001_01C4C8E8.E95D44EE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6617.6">
<TITLE>[autofs] Replicated hosts in autofs </TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Hi,</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">I have read</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">many threads =
regarding replicated hosts for autofs v3 and v4.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> </SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Here is my scenario:</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">On a linux host (Opteron running RHEL 3 WS =
kernel</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"></FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">2.4.21-20.ELsmp</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">,</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">I</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> have the following automount =
configured:</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">mountpoint</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> =
-fstype=3Dnfs,-proto=3Dtcp,ro</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">host1</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">,</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">host2</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">:/tmp/ro</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">The goal in my implementati</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">on is that after the initial mount occurs to host1 =
or host2, if that particular host fails, nfs will pick up the mount on =
the alternate host. Note that since both mount points are read =
only,</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Courier New">this</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">serves</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> as a lower cost, higher =
availabil</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">it</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">y solution. This work</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">s</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> on =
Solaris.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">I have had no success with this on Linux. It seems that the =
replication only works on the initial mount/rpc call.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> Once the initial mount occurs</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">, it doesn</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">t appear</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Courier New">there is</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> any fail-over capability.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">I have even installed RedHat</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">s Beta version of E</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">4</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> =
(kernel</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Courier New">2.6.9-1.648_ELsmp). The result is =
the same. If I crash the machine that originally had the mount-point, =
the end result is a</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">h</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">ung</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> mount and fail-over =
never occurs.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">I can</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New">t seem to find any =
information that indicates that this should or should not work =
b</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">y</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> design.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Can someone please</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> definitively tell me =
if the capability I am seeking is available via the autofs supplied by =
RedHat</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier New"> in Enterprise =
3</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Courier New">?</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Regards,</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Wayne</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C4C8E8.E95D44EE--


--===============45056738566088095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============45056738566088095==--

