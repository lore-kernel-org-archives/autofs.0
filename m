From: "ergatz" <ergatz@comcast.net>
Subject: Problem between autofs 3 and autofs4
Date: Sat, 15 Apr 2006 08:59:52 -0400
Message-ID: <002701c6608c$7d49bbf0$9700a8c0@mambo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9106369255584431685=="
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

--===============9106369255584431685==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0024_01C6606A.F563DC00"

This is a multi-part message in MIME format.

------=_NextPart_000_0024_01C6606A.F563DC00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have a Solaris 2.6 NIS server and have recently added some Redhat =
Linux hosts to it.

I have:

     1 RH 7.3 machine
     2 RH 3.0 update 0
     1 RH 3.0 update 3
     2 RH 4.0 machines

I have looked at this problem a lot, and the difference I see is that =
7.3 and 3.0U0 use autofs 3.
The 4.0 and 3.0U3 machines use autofs 4

My problem is:  When I moved some users' home directories to a different =
partition, the RH machines using autofs 4 had to be rebooted to pick up =
the changes.  The solaris hosts and the 7.3 and 3.0U0 (running autofs 3) =
picked up the changed locations magically like they are supposed to.  =
The machines using autofs 4 had to be rebooted in order to pick up the =
changes.  I tried everything I could think of to avoid reboot, because =
multiple users are on the the system at all times.

I stopped and restarted autofs and ypbind--SEVERAL times.  Nothing =
worked.

So, who know the differences between autofs 3 and 4, and what can I do =
to hosts running autofs 4 to get them to pick up the NIS changes without =
having to reboot?

dorothy
------=_NextPart_000_0024_01C6606A.F563DC00
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I have a Solaris 2.6 NIS server and =
have recently=20
added some Redhat Linux hosts to it.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;1 RH 7.3=20
machine</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; 2 RH 3.0 =
update=20
0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; 1 RH 3.0 =
update=20
3</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; 2 RH 4.0=20
machines</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have looked at this problem a lot, =
and the=20
difference I see is that 7.3 and 3.0U0 use autofs 3.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The 4.0 and 3.0U3 machines use autofs=20
4</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My problem is:&nbsp; When I moved some =
users' home=20
directories to a different partition, the RH machines using autofs 4 had =
to be=20
rebooted to pick up the changes.&nbsp; The solaris hosts and the 7.3 and =
3.0U0=20
(running autofs 3) picked up the changed locations magically like they =
are=20
supposed to.&nbsp; The machines using autofs 4 had to be rebooted in =
order to=20
pick up the changes.&nbsp; I tried everything I could think of to avoid =
reboot,=20
because multiple users are on the the system at all times.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I stopped and restarted autofs and =
ypbind--SEVERAL=20
times.&nbsp; Nothing worked.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>So, who know the differences between =
autofs 3 and=20
4, and what can I do to hosts running autofs 4 to get them to pick up =
the NIS=20
changes without having to reboot?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>dorothy</FONT></DIV></BODY></HTML>

------=_NextPart_000_0024_01C6606A.F563DC00--


--===============9106369255584431685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============9106369255584431685==--

