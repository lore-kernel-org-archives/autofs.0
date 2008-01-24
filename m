From: "Jim Dennis" <jdennis@cadence.com>
Subject: Transient chdir() failures: cd initially fails,
	where ls works
Date: Thu, 24 Jan 2008 15:37:47 -0800
Message-ID: <920746F6DF728345915EF4D6DA610D0F04710E16@MAILSJ2.global.cadence.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7070735530583468586=="
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

--===============7070735530583468586==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C85EE2.20331F72"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85EE2.20331F72
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
 All,
=20
 I think i saw a discussion of this issue once before but I don't
remember
 the cause nor any resolution (and I can' t think of suitable keywords
to
 search on).
=20
 Symptom:
   Example 1:=20
     $ sudo service autofs restart
     $ cd /some/automount/path
     sh: cd: /some/automount/path: No such file or directory
     $ cd /some/automount/path
# <--- Repeated
     $
# <--- Succeeds
=20
   Example 2:
     $ sudo service autofs restart
     $ ls /some/automount/path
# <--- 'ls' works!
     ....
=20
   Example 3
     $ sudo service autofs restart
     $ cat /some/automount/path/somefile.txt
     sh: cat: /some/automount/path/somefile.txt: No such file or
directory
  =20
=20
 This is on a RHEL5.1 (x86_64) system using autofs-5.0.1-0.rc2.55 with
 LDAP driven autofs maps.  It's running under the 2.6.18-53.el5xen
kernel
 (in Dom0).  (I see the same behavior from a system running on the=20
 2.6.18-53.el5 (non-Xen) kernel.
=20
  /etc/sysconfig/autofs only has the following 3 non-comment lines
(sanitized):
=20
        DEFAULT_TIMEOUT=3D600
        DEFAULT_BROWSE_MODE=3D"no"
        OPTIONS=3D"-DOURPLATFORM=3D2008 -DOSREL=3D`cat /etc/IT/osrel`"

 (Where osrel is a simple string describing our internal release
versioning
 for dynamically mapping to NFS subdirectories).
=20
 Note that initial user logins succeed (users are chdir()'d to their
automounted
 home directories without any reported error messages).
=20
 Here is a sanitized log of everything related to autofs, ldap and nscd
(and the
 one entry that relates to FS-Cache).
=20
Jan 22 18:05:38 rhel51svr automount[2389]: lookup_read_master:
lookup(nisplus): couldn't locat nis+ table auto.master
Jan 22 18:09:02 rhel51svr kernel: FS-Cache: netfs 'nfs' registered for
caching
Jan 22 18:21:21 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.1.10
Jan 22 20:29:24 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.2.20
Jan 23 00:15:01 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.1.10
Jan 23 04:15:20 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30 after 1 attempt
Jan 23 05:00:01 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30 after 1 attempt
Jan 23 05:08:20 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.1.10
Jan 23 08:20:12 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.1.10
Jan 23 13:25:03 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30 after 1 attempt
Jan 23 14:25:05 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30 after 1 attempt
Jan 23 15:25:06 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30 after 1 attempt
Jan 23 17:25:09 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30 after 1 attempt
Jan 23 18:30:01 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30 after 1 attempt
Jan 23 18:42:29 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.2.20
Jan 23 18:54:47 rhel51svr automount[5677]: do_mount_indirect: failed to
get group info from getgrgid_r
Jan 23 19:00:08 rhel51svr automount[5677]: umount_autofs_indirect: ask
umount returned busy /home
Jan 23 20:21:54 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.1.10
Jan 24 00:20:53 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30 after 1 attempt
Jan 24 00:34:46 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.2.20
Jan 24 02:21:31 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30
Jan 24 04:35:23 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.2.20
Jan 24 09:02:25 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.1.10
Jan 24 13:45:06 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30 after 1 attempt
Jan 24 14:21:35 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.3.30 after 1 attempt
Jan 24 14:31:40 rhel51svr nscd: nss_ldap: reconnected to LDAP server
ldap://123.45.1.10
Jan 24 14:33:15 rhel51svr automount[18844]: umount_autofs_indirect: ask
umount returned busy /home
Jan 24 14:33:15 rhel51svr automount[18844]: umount_autofs_indirect: ask
umount returned busy /repo/it
Jan 24 14:33:16 rhel51svr kernel: automount[18858]: segfault at
00002aaaacf04d80 rip 00002aaaacf04d80 rsp 00000000410290e8 error 14
Jan 24 14:35:14 rhel51svr automount[32662]: umount_autofs_indirect: ask
umount returned busy /net
Jan 24 14:35:39 rhel51svr kernel: automount[4150]: segfault at
00002aaaacf04d80 rip 00002aaaacf04d80 rsp 00000000410290e8 error 14
Jan 24 14:38:49 rhel51svr kernel: automount[5540]: segfault at
00002aaaacf04d80 rip 00002aaaacf04d80 rsp 00000000422320e8 error 14
Jan 24 14:41:57 rhel51svr kernel: automount[17825]: segfault at
00002aaaacf04d80 rip 00002aaaacf04d80 rsp 00000000410290e8 error 14

 The early automount lookup_read_master:lookup(nisplus) seems to to be
something in the
 initrd or very early in the boot process (it's not part of our
configuration).
=20
 The segfaults are worrisome --- and it's notable that they all occurred
during the interval when I was
 restarting autofs for reproducing the behavior here.
=20
 I will try these tests with a fresh reboot and nscd disable.
=20
 Meanwhile if any of this rings a bell, I'd like to hear about it (and
especially any pointers to related discussions
 from the past.
=20
JDennis

------_=_NextPart_001_01C85EE2.20331F72
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.3790.2993" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;All,</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;I think i saw=20
a discussion of this issue once before but I don't =
remember</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;the cause nor=20
any resolution (and I can' t think of suitable keywords =
to</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;search=20
on).</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;Symptom:</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;&nbsp; Example=20
1: </FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial size=3D2>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; $ sudo service autofs=20
restart</FONT></SPAN></DIV></FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; $ cd =
/some/automount/path</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008></SPAN><SPAN =
class=3D741135422-24012008><FONT=20
face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; sh: cd: =
/some/automount/path: No such=20
file or directory</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; $ cd=20
/some/automount/path&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
# &lt;--- Repeated</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;=20
$&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
# &lt;--- Succeeds</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;&nbsp; Example=20
2:</FONT></SPAN></DIV><SPAN class=3D741135422-24012008>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; $ sudo service autofs=20
restart</FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; $ ls=20
/some/automount/path&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
# &lt;--- 'ls' works!</FONT></DIV>
<DIV></SPAN><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; ....</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;&nbsp; Example=20
3</FONT></SPAN></DIV><SPAN class=3D741135422-24012008>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; $ sudo service autofs=20
restart</FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; =
$&nbsp;cat<SPAN=20
class=3D741135422-24012008> /s</SPAN>ome/automount/path<SPAN=20
class=3D741135422-24012008>/somefile.txt</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D741135422-24012008>&nbsp;&nbsp;&nbsp;&nbsp; sh: cat:=20
/some/automount/path/somefile.txt: No such file or =
directory</SPAN></FONT></DIV>
<DIV></SPAN><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;</FONT></SPAN></DIV></SPAN></DIV></SPAN></DIV>=

<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;This is on a=20
RHEL5.1 (x86_64) system using autofs-5.0.1-0.rc2.55 =
with</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;LDAP driven=20
autofs maps.&nbsp; It's running under the 2.6.18-53.el5xen=20
kernel</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;(in=20
Dom0).&nbsp; (I see the same behavior from a system running on the=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;2.6.18-53.el5=20
(non-Xen) kernel.</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;/etc/sysconfig/autofs only has the following 3 =
non-comment=20
lines (sanitized):</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DEFAULT_TIMEOUT=3D=
600<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
DEFAULT_BROWSE_MODE=3D"no"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

OPTIONS=3D"-DOURPLATFORM=3D2008 -DOSREL=3D`cat =
/etc/IT/osrel`"<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;(Where osrel=20
is a simple string describing our internal release=20
versioning</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;for=20
dynamically mapping to NFS subdirectories).</DIV></FONT></SPAN>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;Note that=20
initial user logins succeed (users are chdir()'d to their=20
automounted</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;home=20
directories without any reported error messages).</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;Here is a=20
sanitized log of&nbsp;everything related to autofs, ldap and nscd (and=20
the</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;one=20
entry&nbsp;that relates to FS-Cache).</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008>&nbsp;</SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial size=3D2>Jan 22 =
18:05:38=20
rhel51svr automount[2389]: lookup_read_master: lookup(nisplus): couldn't =
locat=20
nis+ table auto.master<BR>Jan 22 18:09:02 rhel51svr kernel: FS-Cache: =
netfs=20
'nfs' registered for caching<BR>Jan 22 18:21:21 rhel51svr nscd: =
nss_ldap:=20
reconnected to LDAP server <A=20
href=3D"ldap://123.45.1.10">ldap://123.45.1.10</A><BR>Jan 22 20:29:24 =
rhel51svr=20
nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.2.20">ldap://123.45.2.20</A><BR>Jan 23 00:15:01 =
rhel51svr=20
nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.1.10">ldap://123.45.1.10</A><BR>Jan 23 04:15:20 =
rhel51svr=20
nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A> after 1 =
attempt<BR>Jan 23=20
05:00:01 rhel51svr nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A> after 1 =
attempt<BR>Jan 23=20
05:08:20 rhel51svr nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.1.10">ldap://123.45.1.10</A><BR>Jan 23 08:20:12 =
rhel51svr=20
nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.1.10">ldap://123.45.1.10</A><BR>Jan 23 13:25:03 =
rhel51svr=20
nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A> after 1 =
attempt<BR>Jan 23=20
14:25:05 rhel51svr nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A> after 1 =
attempt<BR>Jan 23=20
15:25:06 rhel51svr nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A> after 1 =
attempt<BR>Jan 23=20
17:25:09 rhel51svr nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A> after 1 =
attempt<BR>Jan 23=20
18:30:01 rhel51svr nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A> after 1 =
attempt<BR>Jan 23=20
18:42:29 rhel51svr nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.2.20">ldap://123.45.2.20</A><BR>Jan 23 18:54:47 =
rhel51svr=20
automount[5677]: do_mount_indirect: failed to get group info from=20
getgrgid_r<BR>Jan 23 19:00:08 rhel51svr automount[5677]: =
umount_autofs_indirect:=20
ask umount returned busy /home<BR>Jan 23 20:21:54 rhel51svr nscd: =
nss_ldap:=20
reconnected to LDAP server <A=20
href=3D"ldap://123.45.1.10">ldap://123.45.1.10</A><BR>Jan 24 00:20:53 =
rhel51svr=20
nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A> after 1 =
attempt<BR>Jan 24=20
00:34:46 rhel51svr nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.2.20">ldap://123.45.2.20</A><BR>Jan 24 02:21:31 =
rhel51svr=20
nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A><BR>Jan 24 04:35:23 =
rhel51svr=20
nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.2.20">ldap://123.45.2.20</A><BR>Jan 24 09:02:25 =
rhel51svr=20
nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.1.10">ldap://123.45.1.10</A><BR>Jan 24 13:45:06 =
rhel51svr=20
nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A> after 1 =
attempt<BR>Jan 24=20
14:21:35 rhel51svr nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.3.30">ldap://123.45.3.30</A> after 1 =
attempt<BR>Jan 24=20
14:31:40 rhel51svr nscd: nss_ldap: reconnected to LDAP server <A=20
href=3D"ldap://123.45.1.10">ldap://123.45.1.10</A><BR>Jan 24 14:33:15 =
rhel51svr=20
automount[18844]: umount_autofs_indirect: ask umount returned busy =
/home<BR>Jan=20
24 14:33:15 rhel51svr automount[18844]: umount_autofs_indirect: ask =
umount=20
returned busy /repo/it<BR>Jan 24 14:33:16 rhel51svr kernel: =
automount[18858]:=20
segfault at 00002aaaacf04d80 rip 00002aaaacf04d80 rsp 00000000410290e8 =
error=20
14<BR>Jan 24 14:35:14 rhel51svr automount[32662]: =
umount_autofs_indirect: ask=20
umount returned busy /net<BR>Jan 24 14:35:39 rhel51svr kernel: =
automount[4150]:=20
segfault at 00002aaaacf04d80 rip 00002aaaacf04d80 rsp 00000000410290e8 =
error=20
14<BR>Jan 24 14:38:49 rhel51svr kernel: automount[5540]: segfault at=20
00002aaaacf04d80 rip 00002aaaacf04d80 rsp 00000000422320e8 error =
14<BR>Jan 24=20
14:41:57 rhel51svr kernel: automount[17825]: segfault at =
00002aaaacf04d80 rip=20
00002aaaacf04d80 rsp 00000000410290e8 error 14<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;The early=20
automount lookup_read_master:lookup(nisplus) seems to to be something in =

the</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;initrd or very=20
early in the boot process (it's not part of our=20
configuration).</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;The segfaults=20
are worrisome --- and it's notable that they all occurred during the =
interval=20
when I was</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;restarting=20
autofs for reproducing the behavior here.</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;I will try=20
these tests with a fresh reboot and nscd disable.</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;Meanwhile if=20
any of this rings a bell, I'd like to hear about it (and especially any =
pointers=20
to related discussions</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial =
size=3D2>&nbsp;from the=20
past.</FONT></SPAN></DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D741135422-24012008><FONT face=3DArial=20
size=3D2>JDennis</DIV></FONT></SPAN></BODY></HTML>

------_=_NextPart_001_01C85EE2.20331F72--


--===============7070735530583468586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7070735530583468586==--

