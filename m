From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Suggested minor patches for the automounter daemon...
Date: Mon, 16 Jun 2008 12:56:16 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC7014E02CF0@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2257574395521124962=="
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

--===============2257574395521124962==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8CFEB.09B7F8DD"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8CFEB.09B7F8DD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20Hi...

=20As part of my compilation and execution efforts, I have accumulated a
small set of minor fixes to some of the automounter daemon files.
Presented for your approval. These apply to the git HEAD and the
previous set of patches that Ian had provided to me.  The biggest fix is
the one for redhat'ish systems in rc.autofs.in that fixes the daemon
"stop" function.

=20I am CC'ing this directly to Ian just in case there is a problem with
posting to the autofs list.  Sorry for any noise.

----

=20daemon/automount.c: Remove compile warning of unused variable
=20Makefile: Remove "modification time in the future" messages generated
by parallelism in some versions of make
=20modules/Makefile: Avoid creating soft link to non-existent library if
LDAP not specified in configure
=20samples/rc.autofs.in: Specify full path for invocation of daemon,
making pkill function more exact,
=20                      Reverse sense of test of return of pidof to
correctly kill daemon on stop function.

---


=20Makefile             |    2 ++
=20daemon/automount.c   |    1 -
=20modules/Makefile     |    2 ++
=20samples/rc.autofs.in |    4 ++--
=204 files changed, 6 insertions(+), 3 deletions(-)


diff -urd autofs-5.0.3-git-ian_kent_patches-vanilla/daemon/automount.c
autofs-5.0.3-git-ian_kent_patches/daemon/automount.c
--- autofs-5.0.3-git-ian_kent_patches-vanilla/daemon/automount.c
2008-05-19 17:02:17.083219000 -0700
+++ autofs-5.0.3-git-ian_kent_patches/daemon/automount.c
2008-05-19 13:55:10.608330000 -0700
@@ -1554,7 +1554,6 @@

=20       while (ap->state !=3D ST_SHUTDOWN) {
=20               if (handle_packet(ap)) {
-                       struct ioctl_ops *ops =3D get_ioctl_ops();
=20                       int ret, cur_state;

=20                       /*
diff -urd autofs-5.0.3-git-ian_kent_patches-vanilla/Makefile
autofs-5.0.3-git-ian_kent_patches/Makefile
--- autofs-5.0.3-git-ian_kent_patches-vanilla/Makefile  2008-05-19
11:59:15.333785000 -0700
+++ autofs-5.0.3-git-ian_kent_patches/Makefile  2008-05-19
18:28:33.916067000 -0700
@@ -39,6 +39,8 @@
=20       sed -e "s/(\.autofs-[0-9.]\+)/(.autofs-`cat .version`)/" <
configure.in > configure.in.tmp
=20       mv -f configure.in.tmp configure.in
=20       rm -f configure
+# get rid of "modification time in the future" messages
+       @sleep 1
=20       $(MAKE) configure

=20TODAY  :=3D $(shell date +'%Y%m%d')
diff -urd autofs-5.0.3-git-ian_kent_patches-vanilla/modules/Makefile
autofs-5.0.3-git-ian_kent_patches/modules/Makefile
--- autofs-5.0.3-git-ian_kent_patches-vanilla/modules/Makefile
2008-05-19 11:59:15.528977000 -0700
+++ autofs-5.0.3-git-ian_kent_patches/modules/Makefile  2008-05-19
13:52:40.466366000 -0700
@@ -63,7 +63,9 @@
=20       -rm -f $(INSTALLROOT)$(autofslibdir)/mount_smbfs.so
=20       ln -fs lookup_file.so
$(INSTALLROOT)$(autofslibdir)/lookup_files.so
=20       ln -fs lookup_yp.so $(INSTALLROOT)$(autofslibdir)/lookup_nis.so=

+ifeq ($(LDAP), 1)
=20       ln -fs lookup_ldap.so
$(INSTALLROOT)$(autofslibdir)/lookup_ldaps.so
+endif
=20       ln -fs mount_nfs.so $(INSTALLROOT)$(autofslibdir)/mount_nfs4.so=

=20ifeq ($(EXT2FS), 1)
=20 ifeq ($(EXT3FS), 1)
diff -urd autofs-5.0.3-git-ian_kent_patches-vanilla/samples/rc.autofs.in
autofs-5.0.3-git-ian_kent_patches/samples/rc.autofs.in
--- autofs-5.0.3-git-ian_kent_patches-vanilla/samples/rc.autofs.in
2008-05-19 17:02:17.071234000 -0700
+++ autofs-5.0.3-git-ian_kent_patches/samples/rc.autofs.in
2008-05-19 18:15:39.881408000 -0700
@@ -56,7 +56,7 @@
=20               fi
=20       fi

-       $prog $OPTIONS
+       $DAEMON $OPTIONS
=20       RETVAL=3D$?
=20       if [ $RETVAL -eq 0 ] ; then
=20               echo "done."
@@ -75,7 +75,7 @@
=20               [ $RETVAL =3D 0 -a -z "`pidof $DAEMON`" ] || sleep 3
=20               count=3D`expr $count + 1`
=20       done
-       if [ -n "`pidof $DAEMON`" ] ; then
+       if [ -z "`pidof $DAEMON`" ] ; then
=20               echo "done."
=20       else
=20               echo "failed."

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

------_=_NextPart_001_01C8CFEB.09B7F8DD
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
<TITLE>Suggested minor patches for the automounter daemon...</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;Hi&#8230;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;As part of my compilation and exec=
ution efforts, I have accumulated a small set of minor fixes to some of t=
he automounter daemon files.&nbsp; Presented for your approval. These app=
ly to the git HEAD and the previous set of patches that Ian had provided =
to me.&nbsp; The biggest fix is the one for redhat'ish systems in rc.auto=
fs.in that fixes the daemon &quot;stop&quot; function.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;I am CC'ing this directly to Ian j=
ust in case there is a problem with posting to the autofs list.&nbsp; Sor=
ry for any noise.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">----</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;daemon/automount.c: Remove compile=
=20warning of unused variable</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;Makefile: Remove &quot;modificati=
on time in the future&quot; messages generated by parallelism in some ver=
sions of make</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;modules/Makefile: Avoid creating =
soft link to non-existent library if LDAP not specified in configure</FON=
T>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;samples/rc.autofs.in: Specify ful=
l path for invocation of daemon, making pkill function more exact,</FONT>=


<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; Reverse sense of test of return of pidof to correctl=
y kill daemon on stop function.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">---</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;Makefile&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 ++</=
FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;daemon/automount.c&nbsp;&nbsp; |&=
nbsp;&nbsp;&nbsp; 1 -</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;modules/Makefile&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp;&nbsp;&nbsp; 2 ++</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;samples/rc.autofs.in |&nbsp;&nbsp=
;&nbsp; 4 ++--</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;4 files changed, 6 insertions(+),=
=203 deletions(-)</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">diff -urd autofs-5.0.3-git-ian_kent_patc=
hes-vanilla/daemon/automount.c autofs-5.0.3-git-ian_kent_patches/daemon/a=
utomount.c</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">--- autofs-5.0.3-git-ian_kent_patches-va=
nilla/daemon/automount.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-0=
5-19 17:02:17.083219000 -0700</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+++ autofs-5.0.3-git-ian_kent_patches/d=
aemon/automount.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-05-19 13=
:55:10.608330000 -0700</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">@@ -1554,7 +1554,6 @@</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; while (ap-&gt;state !=3D ST_SHUTDOWN) {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (handle_packet(ap)=
) {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct ioctl_ops *ops =3D get_ioctl_ops();</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; int ret, cur_state;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /*</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">diff -urd autofs-5.0.3-git-ian_kent_pat=
ches-vanilla/Makefile autofs-5.0.3-git-ian_kent_patches/Makefile</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">--- autofs-5.0.3-git-ian_kent_patches-v=
anilla/Makefile&nbsp; 2008-05-19 11:59:15.333785000 -0700</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+++ autofs-5.0.3-git-ian_kent_patches/M=
akefile&nbsp; 2008-05-19 18:28:33.916067000 -0700</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">@@ -39,6 +39,8 @@</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; sed -e &quot;s/(\.autofs-[0-9.]\+)/(.autofs-`cat .version`)/&quot; &l=
t; configure.in &gt; configure.in.tmp</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mv -f configure.in.tmp configure.in</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rm -f configure</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+# get rid of &quot;modification time i=
n the future&quot; messages</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @=
sleep 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; $(MAKE) configure</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;TODAY&nbsp; :=3D $(shell date +'%Y=
%m%d')</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">diff -urd autofs-5.0.3-git-ian_kent_pat=
ches-vanilla/modules/Makefile autofs-5.0.3-git-ian_kent_patches/modules/M=
akefile</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">--- autofs-5.0.3-git-ian_kent_patches-v=
anilla/modules/Makefile&nbsp; 2008-05-19 11:59:15.528977000 -0700</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+++ autofs-5.0.3-git-ian_kent_patches/m=
odules/Makefile&nbsp; 2008-05-19 13:52:40.466366000 -0700</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">@@ -63,7 +63,9 @@</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; -rm -f $(INSTALLROOT)$(autofslibdir)/mount_smbfs.so</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ln -fs lookup_file.so $(INSTALLROOT)$(autofslibdir)/lookup_files.so</=
FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ln -fs lookup_yp.so $(INSTALLROOT)$(autofslibdir)/lookup_nis.so</FONT=
>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+ifeq ($(LDAP), 1)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ln -fs lookup_ldap.so $(INSTALLROOT)$(autofslibdir)/lookup_ldaps.so</=
FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+endif</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ln -fs mount_nfs.so $(INSTALLROOT)$(autofslibdir)/mount_nfs4.so</FONT=
>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;ifeq ($(EXT2FS), 1)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; ifeq ($(EXT3FS), 1)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">diff -urd autofs-5.0.3-git-ian_kent_pat=
ches-vanilla/samples/rc.autofs.in autofs-5.0.3-git-ian_kent_patches/sampl=
es/rc.autofs.in</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">--- autofs-5.0.3-git-ian_kent_patches-va=
nilla/samples/rc.autofs.in&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-05-19 17:02=
:17.071234000 -0700</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+++ autofs-5.0.3-git-ian_kent_patches/s=
amples/rc.autofs.in&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-05-19 18:15:39.881=
408000 -0700</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">@@ -56,7 +56,7 @@</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; fi</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $p=
rog $OPTIONS</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $=
DAEMON $OPTIONS</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; RETVAL=3D$?</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if [ $RETVAL -eq 0 ] ; then</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;done.&quot=
;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">@@ -75,7 +75,7 @@</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ $RETVAL =3D 0 -a -z=
=20&quot;`pidof $DAEMON`&quot; ] || sleep 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=3D`expr $count =
+ 1`</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; done</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f [ -n &quot;`pidof $DAEMON`&quot; ] ; then</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f [ -z &quot;`pidof $DAEMON`&quot; ] ; then</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;done.&quot=
;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo &quot;failed.&qu=
ot;</FONT>
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

------_=_NextPart_001_01C8CFEB.09B7F8DD--


--===============2257574395521124962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2257574395521124962==--

