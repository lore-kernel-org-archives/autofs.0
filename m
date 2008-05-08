From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Automounter losing mount points on restart
Date: Thu, 8 May 2008 13:27:53 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC7014E02BB7@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1872329582552826904=="
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

This is a multi-part message in MIME format.

--===============1872329582552826904==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B149.FE277554"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B149.FE277554
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

(Resending, as I might not have been subscribed correctly the first
time.)

We have a system with an NIS yp home directory.  Running a Whitebox
distribution, so Redhatish, with vanilla 2.6.24 kernel, automounter
5.0.3 unpatched.

The typical configuration is a home directory automounted via NFS.

Opening up two ssh terminals to a machine in question gives the
following (as an example):

Terminal 1:
$ whoami
sbiggs
$ cd ~/lower_directory
$ /bin/pwd
/home/sbiggs/lower_directory
$

Terminal 2 is a root prompt:
# pkill -9 automount
#

Back to Terminal 1:
$ /bin/pwd
/home/sbiggs/lower_directory
$

Then, on Terminal 2:
#  /etc/init.d/autofs start
Starting automount: done.
#

Back to Terminal 1:
$ /bin/pwd
lower_directory
$

Running automount -fd gives a log of it mounting /home as part of its
startup.  Does that throw away all of the mounts even if they are
already mounted?

Again at Terminal 1:
$ cd .
$ /bin/pwd
/home/sbiggs/lower_directory
$

Only as part of the "cd ." does automount mount "sbiggs" again.

We are being plagued by this issue. We have a huge amount of automounted
directories and at any given time, quite a few of them have the
erroneous relative path/lost mount point CWD.

Can anybody give any insight as to what to do about this?  Is this a
known bug? I ran a couple of searches in the archives of this mailing
list but didn't find much that was germane.

TIA
=20


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

------_=_NextPart_001_01C8B149.FE277554
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
<TITLE>Automounter losing mount points on restart</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">(Resending, as I might not have been sub=
scribed correctly the first time.)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We have a system with an NIS yp home dir=
ectory.&nbsp; Running a Whitebox distribution, so Redhatish, with vanilla=
=202.6.24 kernel, automounter 5.0.3 unpatched.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The typical configuration is a home dire=
ctory automounted via NFS.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Opening up two ssh terminals to a machin=
e in question gives the following (as an example):</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Terminal 1:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ whoami</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">sbiggs</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ cd ~/lower_directory</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ /bin/pwd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/home/sbiggs/lower_directory</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Terminal 2 is a root prompt:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial"># pkill -9 automount</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Back to Terminal 1:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ /bin/pwd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/home/sbiggs/lower_directory</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Then, on Terminal 2:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#&nbsp; /etc/init.d/autofs start</FONT>=


<BR><FONT SIZE=3D2 FACE=3D"Arial">Starting automount: done.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">#</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Back to Terminal 1:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ /bin/pwd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">lower_directory</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Running automount -fd gives a log of it =
mounting /home as part of its startup.&nbsp; Does that throw away all of =
the mounts even if they are already mounted?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Again at Terminal 1:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ cd .</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$ /bin/pwd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/home/sbiggs/lower_directory</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">$</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Only as part of the &quot;cd .&quot; doe=
s automount mount &quot;sbiggs&quot; again.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We are being plagued by this issue. We h=
ave a huge amount of automounted directories and at any given time, quite=
=20a few of them have the erroneous relative path/lost mount point CWD.</=
FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Can anybody give any insight as to what =
to do about this?&nbsp; Is this a known bug? I ran a couple of searches i=
n the archives of this mailing list but didn't find much that was germane=
.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">TIA<BR>
&nbsp;</FONT>
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

------_=_NextPart_001_01C8B149.FE277554--


--===============1872329582552826904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1872329582552826904==--

