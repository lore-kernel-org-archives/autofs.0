From: "Trinh, Ngan" <ngan.trinh@unocal.com>
Subject: unacceptable bug in autofs kernel module
Date: Fri, 25 Feb 2005 15:22:35 -0600
Message-ID: <6AB920CC10586340BE1674976E0A991DF755DE@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0157672292=="
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

--===============0157672292==
content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C51B80.1FE6B929"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C51B80.1FE6B929
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


 I am experiencing the same problem with Peter. Is there any fix for
this?


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


[autofs] unacceptable bug in autofs kernel module

peter.a.harris at exgate.tek.com peter.a.harris at exgate.tek.com
<mailto:autofs%40linux.kernel.org?Subject=3D%5Bautofs%5D%20unacceptable%2=
0
bug%20in%20autofs%20kernel%20module&In-Reply-To=3D>=20
Fri Feb 4 10:58:17 PST 2005=20

*	Previous message: [autofs] Re: get_best_mounts fixes.
<http://linux.kernel.org/pipermail/autofs/2005-February/001935.html>=20
*	Next message: [autofs] unacceptable bug in autofs kernel module
<http://linux.kernel.org/pipermail/autofs/2005-February/001896.html>=20
*	Messages sorted by: [ date ]
<http://linux.kernel.org/pipermail/autofs/2005-February/date.html#1895>
[ thread ]
<http://linux.kernel.org/pipermail/autofs/2005-February/thread.html#1895
>  [ subject ]
<http://linux.kernel.org/pipermail/autofs/2005-February/subject.html#189
5>  [ author ]
<http://linux.kernel.org/pipermail/autofs/2005-February/author.html#1895
> =20

  _____ =20

Hello, all,

Funny you should mention - I was just getting ready to ask about this.

We are doing the same thing, i.e. submitting jobs via LSF.  What we see
are
file not found errors when trying to access a file somewhere down in the
tree of an automounted file system.  For instance, a job will execute a
Perl
script that starts with "#!/tools/perl5.8.3/bin/perl", which fails
because
it cannot find the Perl executable.  I log into the machine and do "ls
/tools/perl5.8.3/bin/perl" and get a file not found.  I check
/etc/mnttab or
/proc/mounts and /tools/perl5.8.3 is not mounted.  So then I do an ls of
/tools/perl5.8.3 and the mount is made.  Once I do that, the mount point
is
generally well behaved for some random period of time when we will go
through all this again.

At first we thought it was networking problems because we were also
seeing
some "server not responding" errors on our Solaris boxes.  We found that
if
the mount failed with an RPC timeout, then the automounter would not try
again until you did an ls of the mount point directory (or in some
cases,
you would have to cd to the directory to get the mount to happen).  We
have
fixed some networking problems that we found and the number of these
kinds
of error messages has gone way down.  Now we only see them when the 10
boxes
all run a cron job at 10PM and try to mount the same file system at the
same
time.  Some win but most lose.

Testing (60 second expiry, multiple jobs accessing files every 2 to 3
minutes; caused lots of expirations and remounts) showed that we could
also
lose track of a mount if the mount expired and then immediately
remounted.
Well, it would not remount but the automounter thought it had.
Similarly to
the above, and ls or cd would fix the problem.

Occasionally, the automounter fails to mount without any indication that
I
can find in /var/log/messages.  And, again, an ls or cd of the directory
will cause the mount to happen.

Most of the machines are running Red Hat EL 3 U4 (automount 4.1.3-47,
2.4.21-27.0.1ELhugemem/smp kernel).  One is running 4.1.3-12.  A couple
are
running RHEL 3 U0, 2.4.21-4EL kernel, 4.1.0-2 automouunt.  We have
several
IBM blades with P4's and mostly 4GB of memory.  We also have one HP
DL585
running AMD64 with 16GB of memory.  Most run with a 10 minute expiry,
but
one is set to 30 minutes and one to 1 hour.  That does not seem to
affect
the error rate.  Some are running soft mounts to the tools (which should
be
read only) and some are running hard mounts - this too does not seem to
make
a difference.

And, oh yes, these mounts are all from NetApp Filers.

Anybody else see this and/or have any ideas?


Pete Harris
Tektronix, Inc.
Technical Computing
MS 39-325 / PO BOX 500 / BEAVERTON OR 97077-0500
Phone:	1-503-627-3989
Fax:	1-503-627-5587
----------------------------------------------------------------------
--          Any opinions expressed are those of the author          --
--             and may not be those of Tektronix, Inc.              --

=3D-----Original Message-----
=3DFrom: autofs-bounces at linux.kernel.org
<http://linux.kernel.org/mailman/listinfo/autofs>  [mailto:autofs-
=3Dbounces at linux.kernel.org
<http://linux.kernel.org/mailman/listinfo/autofs> ] On Behalf Of mmarion
at qualcomm.com <http://linux.kernel.org/mailman/listinfo/autofs>=20
=3DSent: Thursday, February 03, 2005 4:39 PM
=3DTo: ramana at intraperson.com
<http://linux.kernel.org/mailman/listinfo/autofs>=20
=3DCc: autofs at linux.kernel.org
<http://linux.kernel.org/mailman/listinfo/autofs>=20
=3DSubject: Re: [autofs] unacceptable bug in autofs kernel module
=3D
=3DOn 28 Dec, ramana wrote:
=3D
=3D> Here is the bug in autofs3 module which causing so much pain. It
simply
=3D> stopped me from adding much more interesting features to Autodir
=3D> http://www.intraperson.com/autodir/
=3D[snip]
=3D> Because of this, user space test program reporting like this:
=3D>
=3D> fail : /test/t944 : No such file or directory
=3D> fail : /test/t4187 : No such file or directory
=3D
=3DHmm.. I wonder if this might be related to a weirdness we're seeing.
=3DRunning
=3Dautofs-4.1.3 with previous latest patch to kernel (pre-2005 release)
and
=3Dusers
=3Duse LSF to submit batch jobs to hosts.  On linux hosts, user level
=3Dprograms
=3Dwill sometimes exit quickly with a "file does not exist" error, even
=3Dthough you
=3Dcan login to the host and see the file/dir just fine.  As a hacked
=3Dwork-around, we have a pre-exec script that tries to stat all the
=3Ddirectories
=3Dthey need to force the mounts to happen before their program touches
the
=3Dfiles.
=3D
=3DI didn't see any attempts to patch this bit.. did you have any ideas =
on
=3Dhow to
=3Dpatch that particular piece of code?   Or just comment it out?
=3D
=3D--
=3DMike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
<http://www.qualcomm.com/>=20
=3DGroundskeeper Willie: "oooh.. Me mule wouldn't walk in the mud.  So I
had
=3Dto
=3Dput 17 bullets in 'em." =3D=3D> Simpsons
=3D
=3D_______________________________________________
=3Dautofs mailing list
=3Dautofs at linux.kernel.org
<http://linux.kernel.org/mailman/listinfo/autofs>=20
=3Dhttp://linux.kernel.org/mailman/listinfo/autofs


  _____ =20


*	Previous message: [autofs] Re: get_best_mounts fixes.
<http://linux.kernel.org/pipermail/autofs/2005-February/001935.html>=20
*	Next message: [autofs] unacceptable bug in autofs kernel module
<http://linux.kernel.org/pipermail/autofs/2005-February/001896.html>=20
*	Messages sorted by: [ date ]
<http://linux.kernel.org/pipermail/autofs/2005-February/date.html#1895>
[ thread ]
<http://linux.kernel.org/pipermail/autofs/2005-February/thread.html#1895
>  [ subject ]
<http://linux.kernel.org/pipermail/autofs/2005-February/subject.html#189
5>  [ author ]
<http://linux.kernel.org/pipermail/autofs/2005-February/author.html#1895
> =20

  _____ =20

More information about the autofs mailing list
<http://linux.kernel.org/mailman/listinfo/autofs>=20


------_=_NextPart_001_01C51B80.1FE6B929
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Message</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1491" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>
<H1><FONT size=3D2><SPAN class=3D085441621-25022005><FONT face=3DCentury =

size=3D2>&nbsp;I am experiencing the same problem with Peter. Is there =
any fix for=20
this?</FONT></SPAN></FONT></H1>
<H1><SPAN=20
class=3D085441621-25022005>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</SPAN></H1>
<H1>[autofs] unacceptable bug in autofs kernel =
module</H1><B>peter.a.harris at=20
exgate.tek.com</B> <A title=3D"[autofs] unacceptable bug in autofs =
kernel module"=20
href=3D"mailto:autofs%40linux.kernel.org?Subject=3D%5Bautofs%5D%20unaccep=
table%20bug%20in%20autofs%20kernel%20module&amp;In-Reply-To=3D">peter.a.h=
arris=20
at exgate.tek.com </A><BR><I>Fri Feb 4 10:58:17 PST 2005</I>=20
<P>
<UL>
  <LI>Previous message: <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/001935.htm=
l">[autofs]=20
  Re: get_best_mounts fixes. </A>
  <LI>Next message: <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/001896.htm=
l">[autofs]=20
  unacceptable bug in autofs kernel module </A>
  <LI><B>Messages sorted by:</B> <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/date.html#=
1895">[=20
  date ]</A> <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/thread.htm=
l#1895">[=20
  thread ]</A> <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/subject.ht=
ml#1895">[=20
  subject ]</A> <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/author.htm=
l#1895">[=20
  author ]</A> </LI></UL>
<HR>
<!--beginarticle--><PRE>Hello, all,

Funny you should mention - I was just getting ready to ask about this.

We are doing the same thing, i.e. submitting jobs via LSF.  What we see =
are
file not found errors when trying to access a file somewhere down in the
tree of an automounted file system.  For instance, a job will execute a =
Perl
script that starts with "#!/tools/perl5.8.3/bin/perl", which fails =
because
it cannot find the Perl executable.  I log into the machine and do "ls
/tools/perl5.8.3/bin/perl" and get a file not found.  I check =
/etc/mnttab or
/proc/mounts and /tools/perl5.8.3 is not mounted.  So then I do an ls of
/tools/perl5.8.3 and the mount is made.  Once I do that, the mount point =
is
generally well behaved for some random period of time when we will go
through all this again.

At first we thought it was networking problems because we were also =
seeing
some "server not responding" errors on our Solaris boxes.  We found that =
if
the mount failed with an RPC timeout, then the automounter would not try
again until you did an ls of the mount point directory (or in some =
cases,
you would have to cd to the directory to get the mount to happen).  We =
have
fixed some networking problems that we found and the number of these =
kinds
of error messages has gone way down.  Now we only see them when the 10 =
boxes
all run a cron job at 10PM and try to mount the same file system at the =
same
time.  Some win but most lose.

Testing (60 second expiry, multiple jobs accessing files every 2 to 3
minutes; caused lots of expirations and remounts) showed that we could =
also
lose track of a mount if the mount expired and then immediately =
remounted.
Well, it would not remount but the automounter thought it had.  =
Similarly to
the above, and ls or cd would fix the problem.

Occasionally, the automounter fails to mount without any indication that =
I
can find in /var/log/messages.  And, again, an ls or cd of the directory
will cause the mount to happen.

Most of the machines are running Red Hat EL 3 U4 (automount 4.1.3-47,
2.4.21-27.0.1ELhugemem/smp kernel).  One is running 4.1.3-12.  A couple =
are
running RHEL 3 U0, 2.4.21-4EL kernel, 4.1.0-2 automouunt.  We have =
several
IBM blades with P4's and mostly 4GB of memory.  We also have one HP =
DL585
running AMD64 with 16GB of memory.  Most run with a 10 minute expiry, =
but
one is set to 30 minutes and one to 1 hour.  That does not seem to =
affect
the error rate.  Some are running soft mounts to the tools (which should =
be
read only) and some are running hard mounts - this too does not seem to =
make
a difference.

And, oh yes, these mounts are all from NetApp Filers.

Anybody else see this and/or have any ideas?


Pete Harris
Tektronix, Inc.
Technical Computing
MS 39-325 / PO BOX 500 / BEAVERTON OR 97077-0500
Phone:	1-503-627-3989
Fax:	1-503-627-5587
----------------------------------------------------------------------
--          Any opinions expressed are those of the author          --
--             and may not be those of Tektronix, Inc.              --

=3D-----Original Message-----
=3DFrom: <A =
href=3D"http://linux.kernel.org/mailman/listinfo/autofs">autofs-bounces =
at linux.kernel.org</A> [mailto:autofs-
=3D<A href=3D"http://linux.kernel.org/mailman/listinfo/autofs">bounces =
at linux.kernel.org</A>] On Behalf Of <A =
href=3D"http://linux.kernel.org/mailman/listinfo/autofs">mmarion at =
qualcomm.com</A>
=3DSent: Thursday, February 03, 2005 4:39 PM
=3DTo: <A =
href=3D"http://linux.kernel.org/mailman/listinfo/autofs">ramana at =
intraperson.com</A>
=3DCc: <A =
href=3D"http://linux.kernel.org/mailman/listinfo/autofs">autofs at =
linux.kernel.org</A>
=3DSubject: Re: [autofs] unacceptable bug in autofs kernel module
=3D
=3DOn 28 Dec, ramana wrote:
=3D
=3D&gt; Here is the bug in autofs3 module which causing so much pain. It =
simply
=3D&gt; stopped me from adding much more interesting features to Autodir
=3D&gt; <A =
href=3D"http://www.intraperson.com/autodir/">http://www.intraperson.com/a=
utodir/</A>
=3D[snip]
=3D&gt; Because of this, user space test program reporting like this:
=3D&gt;
=3D&gt; fail : /test/t944 : No such file or directory
=3D&gt; fail : /test/t4187 : No such file or directory
=3D
=3DHmm.. I wonder if this might be related to a weirdness we're seeing.
=3DRunning
=3Dautofs-4.1.3 with previous latest patch to kernel (pre-2005 release) =
and
=3Dusers
=3Duse LSF to submit batch jobs to hosts.  On linux hosts, user level
=3Dprograms
=3Dwill sometimes exit quickly with a "file does not exist" error, even
=3Dthough you
=3Dcan login to the host and see the file/dir just fine.  As a hacked
=3Dwork-around, we have a pre-exec script that tries to stat all the
=3Ddirectories
=3Dthey need to force the mounts to happen before their program touches =
the
=3Dfiles.
=3D
=3DI didn't see any attempts to patch this bit.. did you have any ideas =
on
=3Dhow to
=3Dpatch that particular piece of code?   Or just comment it out?
=3D
=3D--
=3DMike Marion-Unix SysAdmin/Staff Engineer-<A =
href=3D"http://www.qualcomm.com/">http://www.qualcomm.com</A>
=3DGroundskeeper Willie: "oooh.. Me mule wouldn't walk in the mud.  So I =
had
=3Dto
=3Dput 17 bullets in 'em." =3D=3D&gt; Simpsons
=3D
=3D_______________________________________________
=3Dautofs mailing list
=3D<A href=3D"http://linux.kernel.org/mailman/listinfo/autofs">autofs at =
linux.kernel.org</A>
=3D<A =
href=3D"http://linux.kernel.org/mailman/listinfo/autofs">http://linux.ker=
nel.org/mailman/listinfo/autofs</A>

</PRE><!--endarticle-->
<HR>

<P>
<UL><!--threads-->
  <LI>Previous message: <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/001935.htm=
l">[autofs]=20
  Re: get_best_mounts fixes. </A>
  <LI>Next message: <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/001896.htm=
l">[autofs]=20
  unacceptable bug in autofs kernel module </A>
  <LI><B>Messages sorted by:</B> <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/date.html#=
1895">[=20
  date ]</A> <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/thread.htm=
l#1895">[=20
  thread ]</A> <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/subject.ht=
ml#1895">[=20
  subject ]</A> <A=20
  =
href=3D"http://linux.kernel.org/pipermail/autofs/2005-February/author.htm=
l#1895">[=20
  author ]</A> </LI></UL>
<HR>
<A href=3D"http://linux.kernel.org/mailman/listinfo/autofs">More =
information about=20
the autofs mailing list</A><BR></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C51B80.1FE6B929--


--===============0157672292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0157672292==--

