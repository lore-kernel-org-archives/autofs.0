From: Ben-Nun Gil <Gil.Ben-nun@comverse.com>
Subject: automounter
Date: Sun, 5 Sep 2004 10:21:54 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4389DC3E2E59694D8B01794D38C1499C13A365@il-tlv-mail02.comverse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70450901484322959=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--===============70450901484322959==
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C49319.0548D76F"

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C49319.0548D76F
Content-Type: text/plain



Can I use the auto mounter in Linux redhat to mount or ftp remote servers ?
Can it work without running a nis service ?
As I understand I have two files :/etc/auto.master which directs to the map
file /etc/auto.misc.
I added a line to the /etc/auto.misc : dsu                      -fstype=auto
1.1.1.1:/share
   the network is o.k., the directory on the remote server is shared -  but
still no luck .
Please help

------_=_NextPart_001_01C49319.0548D76F
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2655.35">
<TITLE>automounter</TITLE>
</HEAD>
<BODY>
<BR>
<BR>

<P><B><FONT COLOR=3D"#0000FF" FACE=3D"Times New Roman">Can I use the =
auto mounter in Linux redhat to mount or ftp remote servers =
?</FONT></B>
<BR><B><FONT COLOR=3D"#0000FF" FACE=3D"Times New Roman">Can it work =
without running a nis service ?</FONT></B>
<BR><B><FONT COLOR=3D"#0000FF" FACE=3D"Times New Roman">As I understand =
I have two files :/etc/auto.master which directs to the map file =
/etc/auto.misc.</FONT></B>
<BR><B><FONT COLOR=3D"#0000FF" FACE=3D"Times New Roman">I added a line =
to the /etc/auto.misc : =
dsu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-fstype=3Dauto&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 1.1.1.1:/share</FONT></B>
<BR><B><FONT COLOR=3D"#0000FF" FACE=3D"Times New Roman">&nbsp;&nbsp; =
the network is o.k., the directory on the remote server is shared =
-&nbsp; but still no luck .</FONT></B>
<BR><B><FONT COLOR=3D"#0000FF" FACE=3D"Times New Roman">Please =
help</FONT></B>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C49319.0548D76F--


--===============70450901484322959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============70450901484322959==--

