From: "James Richardson" <jrichardson@x-iss.com>
Subject: Re: Slow mounts when using large round robin sets
Date: Fri, 21 Dec 2007 15:04:30 -0600
Message-ID: <98E55D6E1B3CFD43BDA59EEB56DD7D724438C2@sbs01.xiss.private>
References: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private><98E55D6E1B3CFD43BDA59EEB56DD7D724431C0@sbs01.xiss.private><1196921804.3089.28.camel@raven.themaw.net><98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private><x49zlwm5hf1.fsf@segfault.boston.devel.redhat.com><98E55D6E1B3CFD43BDA59EEB56DD7D7244386E@sbs01.xiss.private><1198241367.3488.26.camel@raven.themaw.net>
	<x49odck175r.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8449616581004014528=="
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
To: Jeff Moyer <jmoyer@redhat.com>, Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--===============8449616581004014528==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C84415.16B71EE1"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C84415.16B71EE1
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Jeff,

=20

Using the latest Autofs source code from I received the following
results:

=20

large-rr.domain.tld contains 49 A records in DNS.

small-rr.domain.tld contains 16 A records (a subset of large-rr).

=20

=20

Test 1:

I configured auto.home with the entry:

      brian -rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3
large-rr:/home/brian

=20

# time ls /home/brian/.bash_history

/home/brian/.bash_history

real    0m0.734s

user    0m0.000s

sys     0m0.000s

=20

Test 2:

I then rebooted the server to remove any local cached anything and
updated auto.home to have:

      brian -rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3
small-rr:/home/brian

=20

# time ls -alht /home/brian/.bash_history

-rw-------  1 brian support 13K Nov 15 10:39=20

real    0m0.126s

user    0m0.000s

sys     0m0.004s

=20

=20

During Test 1 there were 1,160 DNS packets (580 UDP packets, 580 TCP
packets). During Test 2 there were 196 packets (all UDP).

=20

=20

---

James T. Richardson, Jr.

jrichardson@x-iss.com

eXcellence in IS Solutions, Inc.

713-862-9200 x226

=20

Making IT Work for You

HPC & Enterprise IT Solutions

* HPC Application Acceleration

* Cluster Design, Deploy, Manage, Train

* Linux/Windows Integration

* Remote Management, Backup, Anti-Spam/Virus

* Network Assessments, Design

* Security Audits, Design

* Datacenter Design, Relocation

* Messaging and Collaboration

=20

=20

-----Original Message-----
From: Jeff Moyer [mailto:jmoyer@redhat.com]=20
Sent: Friday, December 21, 2007 7:58 AM
To: Ian Kent
Cc: James Richardson; autofs@linux.kernel.org
Subject: Re: [autofs] Slow mounts when using large round robin sets

=20

Ian Kent <raven@themaw.net> writes:

=20

> On Thu, 2007-12-20 at 16:42 -0600, James Richardson wrote:

>> Jeff,

>>=20

>> I downloaded the sources via git

>> (git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git)
however

>> when automount starts up I get a floating point exception. I would

>> appreciate those debug patches you mentioned as I'm not sure where
the

>> floating point exception is occurring.

>=20

> I don't remember saying anything about debugging patches?

=20

I mentioned that we could provide targeted debugging patches to

try to figure out the problem.  They do not exist yet, and they

certainly would not point out why he's getting a floating point

exception!  ;)

=20

>> # strace automount -d

>> execve("/usr/sbin/automount", ["automount", "-d"], [/* 24 vars */]) =3D
0

>> uname({sys=3D"Linux", node=3D"c33n69", ...}) =3D 0

>> brk(0)                                  =3D 0x80041000

>> --- SIGFPE (Floating point exception) @ 0 (0) ---

>> +++ killed by SIGFPE +++

>> Process 3702 detached

>> [root@c33n69 ~]# uname -a

>> Linux c33n69 2.6.21-GX #1 SMP Thu Apr 26 14:03:16 CDT 2007 i686 i686

>> i386 GNU/Linux

>=20

> I really don't know what's happening here.

> There's not enough info.

=20

What Ian means is that you'd have to provide a stack trace from gdb at

the very least.  The output from automount -V wouldn't hurt, either.

=20

-Jeff


NOTICE:
This message may contain privileged or otherwise confidential information.
If you are not the intended recipient, please immediately advise the sender
by reply email and delete the message and any attachments without using,
copying or disclosing the contents.



------_=_NextPart_001_01C84415.16B71EE1
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:Consolas;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText>Jeff,<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Using the latest Autofs source code from I received=
 the
following results:<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>large-rr.domain.tld contains 49 A records in DNS.<o=
:p></o:p></p>

<p class=3DMsoPlainText>small-rr.domain.tld contains 16 A records (a subset=
 of
large-rr).<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Test 1:<o:p></o:p></p>

<p class=3DMsoPlainText>I configured auto.home with the entry:<o:p></o:p></=
p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brian
-rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
large-rr:/home/brian<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'># time ls
/home/brian/.bash_history<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>/home/brian/.bash_histor=
y<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>real&nbsp;&nbsp;&nbsp; 0=
m0.734s<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>user&nbsp;&nbsp;&nbsp; 0=
m0.000s<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>sys&nbsp;&nbsp;&nbsp;&nb=
sp;
0m0.000s<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Test 2:<o:p></o:p></p>

<p class=3DMsoPlainText>I then rebooted the server to remove any local cach=
ed
anything and updated auto.home to have:<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brian
-rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
small-rr:/home/brian<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'># time ls -alht
/home/brian/.bash_history<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>-rw-------&nbsp; 1 brian=
 support
13K Nov 15 10:39 <o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>real&nbsp;&nbsp;&nbsp; 0=
m0.126s<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>user&nbsp;&nbsp;&nbsp; 0=
m0.000s<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>sys&nbsp;&nbsp;&nbsp;&nb=
sp;
0m0.004s<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>During Test 1 there were 1,160 DNS packets (580 UDP
packets, 580 TCP packets). During Test 2 there were 196 packets (all UDP).<=
o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>---<o:p></o:p></p>

<p class=3DMsoPlainText>James T. Richardson, Jr.<o:p></o:p></p>

<p class=3DMsoPlainText>jrichardson@x-iss.com<o:p></o:p></p>

<p class=3DMsoPlainText>eXcellence in IS Solutions, Inc.<o:p></o:p></p>

<p class=3DMsoPlainText>713-862-9200 x226<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Making IT Work for You<o:p></o:p></p>

<p class=3DMsoPlainText>HPC &amp; Enterprise IT Solutions<o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; HPC Application Acceleration<o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; Cluster Design, Deploy, Manage, Train<o:p><=
/o:p></p>

<p class=3DMsoPlainText>&#8226; Linux/Windows Integration<o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; Remote Management, Backup, Anti-Spam/Virus<=
o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; Network Assessments, Design<o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; Security Audits, Design<o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; Datacenter Design, Relocation<o:p></o:p></p=
>

<p class=3DMsoPlainText>&#8226; Messaging and Collaboration<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>-----Original Message-----<br>
From: Jeff Moyer [mailto:jmoyer@redhat.com] <br>
Sent: Friday, December 21, 2007 7:58 AM<br>
To: Ian Kent<br>
Cc: James Richardson; autofs@linux.kernel.org<br>
Subject: Re: [autofs] Slow mounts when using large round robin sets<o:p></o=
:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Ian Kent &lt;raven@themaw.net&gt; writes:<o:p></o:p=
></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; On Thu, 2007-12-20 at 16:42 -0600, James Richa=
rdson
wrote:<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; Jeff,<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; <o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; I downloaded the sources via git<o:p></o:p=
></p>

<p class=3DMsoPlainText>&gt;&gt;
(git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git) however<o:p>=
</o:p></p>

<p class=3DMsoPlainText>&gt;&gt; when automount starts up I get a floating =
point
exception. I would<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; appreciate those debug patches you mention=
ed as
I'm not sure where the<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; floating point exception is occurring.<o:p=
></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; I don't remember saying anything about debuggi=
ng
patches?<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>I mentioned that we could provide targeted debuggin=
g
patches to<o:p></o:p></p>

<p class=3DMsoPlainText>try to figure out the problem.&nbsp; They do not ex=
ist
yet, and they<o:p></o:p></p>

<p class=3DMsoPlainText>certainly would not point out why he's getting a fl=
oating
point<o:p></o:p></p>

<p class=3DMsoPlainText>exception!&nbsp; ;)<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt;&gt; # strace automount -d<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; execve(&quot;/usr/sbin/automount&quot;,
[&quot;automount&quot;, &quot;-d&quot;], [/* 24 vars */]) =3D 0<o:p></o:p><=
/p>

<p class=3DMsoPlainText>&gt;&gt; uname({sys=3D&quot;Linux&quot;,
node=3D&quot;c33n69&quot;, ...}) =3D 0<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt;
brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x80041000<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; --- SIGFPE (Floating point exception) @ 0 =
(0)
---<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; +++ killed by SIGFPE +++<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; Process 3702 detached<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; [root@c33n69 ~]# uname -a<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; Linux c33n69 2.6.21-GX #1 SMP Thu Apr 26
14:03:16 CDT 2007 i686 i686<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;&gt; i386 GNU/Linux<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; I really don't know what's happening here.<o:p=
></o:p></p>

<p class=3DMsoPlainText>&gt; There's not enough info.<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>What Ian means is that you'd have to provide a stac=
k
trace from gdb at<o:p></o:p></p>

<p class=3DMsoPlainText>the very least.&nbsp; The output from automount -V
wouldn't hurt, either.<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>-Jeff<o:p></o:p></p>

</div>

<br><pre>NOTICE:
This message may contain privileged or otherwise confidential information.
If you are not the intended recipient, please immediately advise the sender
by reply email and delete the message and any attachments without using,
copying or disclosing the contents.
</pre></body>

</html>


------_=_NextPart_001_01C84415.16B71EE1--


--===============8449616581004014528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8449616581004014528==--

