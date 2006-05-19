From: "Latrell" <is85022@cis.nctu.edu.tw>
Subject: kill automount processes at the same time
Date: Fri, 19 May 2006 13:55:18 +0800
Message-ID: <009d01c67b08$cfa06cf0$6cf1718c@administrator>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4798495022217182648=="
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

--===============4798495022217182648==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_009A_01C67B4B.DD04F0D0"

This is a multi-part message in MIME format.

------=_NextPart_000_009A_01C67B4B.DD04F0D0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi All:

I have a problem with kill automount processes. My secenario is as =
follows:
5 automount processes running in my system. When I want to umount and =
stop automount processes, I used kill pid1 pid2 pid3 pid4 pid5. The =
result is more than 5 automount processes (8 in the case) in my system! =
Some automount processes were killed, some automount processes fork =
processes! Did I do something wrong?

I looked into the source code, and find the abnormal processes all =
blocked in=20
a while(ioctl(ap.ioctlfd,AUTOFS_IOC_EXPIRE_MULTI,&how)&&count--) of =
automount.c and=20
the count didn't decrease.  I also noticed that when I kill less than 3 =
automount processes at the same time, the problem didn't happen. It =
seems automount has problem
dealing with too many kill at the same time. Please give me some advice.

Thanks in advance,
Latrell

------=_NextPart_000_009A_01C67B4B.DD04F0D0
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
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>Hi =
All:</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 =
size=3D4></FONT>&nbsp;</DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>I have a =
problem with kill automount processes.=20
My secenario is as follows:</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>5 automount =
processes running in my system. When=20
I want to umount and stop automount processes, I used kill pid1 pid2 =
pid3 pid4=20
pid5. The result is more than 5 automount processes (8 in the case) in =
my=20
system! Some automount processes were killed, some automount processes =
fork=20
processes! Did I do something wrong?</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 =
size=3D4></FONT>&nbsp;</DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>I&nbsp;looked =
into the source code, and find the=20
abnormal processes all blocked in </FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>a=20
while(ioctl(ap.ioctlfd,AUTOFS_IOC_EXPIRE_MULTI,&amp;how)&amp;&amp;count--=
) of=20
automount.c and </FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>the count =
didn't decrease. &nbsp;I also noticed=20
that when I kill less than 3 automount processes at the same time, the =
problem=20
didn't happen. It seems automount has problem</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>dealing with =
too many kill at the same time.=20
Please give me some advice.</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 =
size=3D4></FONT>&nbsp;</DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 size=3D4>Thanks in =
advance,</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 =
size=3D4>Latrell</FONT></DIV>
<DIV><FONT face=3D=B5=D8=B1d=B4=CE=B4=CE=C5=E9W5 =
size=3D4></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_009A_01C67B4B.DD04F0D0--


--===============4798495022217182648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4798495022217182648==--

