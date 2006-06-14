From: "Latrell" <is85022@cis.nctu.edu.tw>
Subject: Large number of mount request.
Date: Wed, 14 Jun 2006 15:14:43 +0800
Message-ID: <01e801c68f82$3794d8e0$6cf1718c@administrator>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8027687722403650842=="
Return-path: <autofs-bounces@linux.kernel.org>
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

--===============8027687722403650842==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01E5_01C68FC5.43B06200"

This is a multi-part message in MIME format.

------=_NextPart_000_01E5_01C68FC5.43B06200
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi, all:

I have a problem with the mount and umount packet.
My problem is when I have a large number of mount requests, some mount =
request packets are missing. Thus, when I "cd share1", I will get "fail =
to change directory" because share1 is not mounted. Fewer mount requests =
work normally.=20
Another question, who sends the packets? I'm tracing source code, and =
found the mount and umount begain with handle_packet() function. But I =
don't know how it receive the packets.

Thanks,
Latrell.
------=_NextPart_000_01E5_01C68FC5.43B06200
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>Hi, =
all:</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 =
size=3D4></FONT>&nbsp;</DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>I have a =
problem with the mount and umount=20
packet.</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>My problem is =
when I have a large number of mount=20
requests, some mount request packets are missing. Thus, when I&nbsp;"cd =
share1",=20
I will get "fail to change directory" because share1&nbsp;is not =
mounted. Fewer=20
mount requests work normally. </FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>Another =
question, who sends the packets?&nbsp;I'm=20
tracing source code, and found the mount and umount begain with =
handle_packet()=20
function. But I don't know how it receive the packets.</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 =
size=3D4></FONT>&nbsp;</DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 =
size=3D4>Thanks,</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 =
size=3D4>Latrell.</FONT></DIV></BODY></HTML>

------=_NextPart_000_01E5_01C68FC5.43B06200--


--===============8027687722403650842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8027687722403650842==--

