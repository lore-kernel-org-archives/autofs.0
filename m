From: "Counterman, Daniel" <DCounterman@Limitedbrands.com>
Subject: Autofs not unmounting cifs/samba share
Date: Tue, 10 Oct 2006 08:02:56 -0400
Message-ID: <BB02210D064ADA4FBAB0B2F9EC47D3A7E52427@EXCHSERV2.Limited.brands.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4764922503241178787=="
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

--===============4764922503241178787==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6EC64.05AE5DFB"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6EC64.05AE5DFB
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Autofs is not unmounting a cifs share after a minute of inactivity per =
the
/etc/auto.master file.

Here is some debug information for autofs when performing a test on the =
cifs
share, and the share does not get unmounted.

If anyone has ideas on how I can fix this, please let me know.


Thanks,

Dan

Running Red Hat ES 4 -   2.6.9-42.0.3.ELsmp
Packages -=20
autofs-4.1.3-187
samba-3.0.10-1.4E.9
samba-client-3.0.10-1.4E.9
samba-common-3.0.10-1.4E.9


[root@ftpcl1n1 /]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-lvRoot
                      4.0G  258M  3.5G   7% /
/dev/cciss/c0d0p1     244M   24M  208M  10% /boot
none                 1014M     0 1014M   0% /dev/shm
/dev/mapper/VolGroup00-lvHome
                      4.0G   41M  3.7G   2% /home
/dev/mapper/VolGroup00-lvads
                      496M   11M  460M   3% /home/adsftp
/dev/mapper/VolGroup00-lvOpt
                      7.9G  191M  7.3G   3% /opt
/dev/mapper/VolGroup00-lvTmp
                     1008M   39M  919M   4% /tmp
/dev/mapper/VolGroup00-lvUsr
                      9.9G  2.1G  7.3G  23% /usr
/dev/mapper/VolGroup00-lvVar
                      4.0G  169M  3.6G   5% /var
//ssnetapp1/ltsftp$   2.1T  2.1T  2.9G 100% /ftpmnt/banksftp
[root@ftpcl1n1 /]# date
Tue Oct 10 07:09:30 EDT 2006

STILL MOUNTED - after minute of inactivity

[root@ftpcl1n1 /]# date
Tue Oct 10 07:11:27 EDT 2006
[root@ftpcl1n1 /]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-lvRoot
                      4.0G  258M  3.5G   7% /
/dev/cciss/c0d0p1     244M   24M  208M  10% /boot
none                 1014M     0 1014M   0% /dev/shm
/dev/mapper/VolGroup00-lvHome
                      4.0G   41M  3.7G   2% /home
/dev/mapper/VolGroup00-lvads
                      496M   11M  460M   3% /home/adsftp
/dev/mapper/VolGroup00-lvOpt
                      7.9G  191M  7.3G   3% /opt
/dev/mapper/VolGroup00-lvTmp
                     1008M   39M  919M   4% /tmp
/dev/mapper/VolGroup00-lvUsr
                      9.9G  2.1G  7.3G  23% /usr
/dev/mapper/VolGroup00-lvVar
                      4.0G  169M  3.6G   5% /var
//ssnetapp1/ltsftp$   2.1T  2.1T  2.9G 100% /ftpmnt/banksftp



Oct 10 07:09:23 ftpcl1n1 automount[7756]: map_modified: no changes
Oct 10 07:09:23 ftpcl1n1 automount[7756]: lookup(file): banksftp ->
-fstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/cre=
dentials/cr
e.banksftp ://ssnetapp1/ltsftp\$
Oct 10 07:09:23 ftpcl1n1 automount[7756]: parse(sun): expanded entry:
-fstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/cre=
dentials/cr
e.banksftp ://ssnetapp1/ltsftp\$
Oct 10 07:09:23 ftpcl1n1 automount[7756]: parse(sun):
dequote("fstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D=
/etc/creden
tials/cre.banksftp") ->
fstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/cred=
entials/cre
.banksftp
Oct 10 07:09:23 ftpcl1n1 automount[7756]: parse(sun): gathered options:
fstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/cred=
entials/cre
.banksftp
Oct 10 07:09:23 ftpcl1n1 automount[7756]: parse(sun):
dequote("//ssnetapp1/ltsftp\$") -> //ssnetapp1/ltsftp$
Oct 10 07:09:23 ftpcl1n1 automount[7756]: parse(sun): core of entry:
options=3Dfstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D=
/etc/credent
ials/cre.banksftp, loc=3D//ssnetapp1/ltsftp$
Oct 10 07:09:23 ftpcl1n1 automount[7756]: parse(sun): mounting root =
/ftpmnt,
mountpoint banksftp, what //ssnetapp1/ltsftp$, fstype cifs, options
file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/credentials/cre.ba=
nksftp
Oct 10 07:09:23 ftpcl1n1 automount[7756]: do_mount //ssnetapp1/ltsftp$
/ftpmnt/banksftp type cifs options
file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/credentials/cre.ba=
nksftp
using module generic
Oct 10 07:09:23 ftpcl1n1 automount[7756]: mount(generic): calling =
mkdir_path
/ftpmnt/banksftp
Oct 10 07:09:23 ftpcl1n1 automount[7756]: mount(generic): calling mount =
-t
cifs -s -o
file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/credentials/cre.ba=
nksftp
//ssnetapp1/ltsftp$ /ftpmnt/banksftp
Oct 10 07:09:23 ftpcl1n1 kernel: SELinux: initialized (dev cifs, type =
cifs),
uses genfs_contexts
Oct 10 07:09:23 ftpcl1n1 automount[7756]: mount(generic): mounted
//ssnetapp1/ltsftp$ type cifs on /ftpmnt/banksftp
Oct 10 07:09:23 ftpcl1n1 automount[7594]: handle_child: got pid 7756, =
sig 0
(0), stat 0
Oct 10 07:09:23 ftpcl1n1 automount[7594]: sig_child: found pending iop =
pid
7756: signalled 0 (sig 0), exit status 0
Oct 10 07:09:23 ftpcl1n1 automount[7594]: send_ready: token=3D10
Oct 10 07:09:32 ftpcl1n1 automount[7724]: sig 14 switching from 1 to 2
Oct 10 07:09:32 ftpcl1n1 automount[7724]: get_pkt: state 1, next 2
Oct 10 07:09:32 ftpcl1n1 automount[7724]: st_expire(): state =3D 1
Oct 10 07:09:32 ftpcl1n1 automount[7724]: expire_proc: exp_proc=3D7765
Oct 10 07:09:32 ftpcl1n1 automount[7724]: handle_child: got pid 7765, =
sig 0
(0), stat 0
Oct 10 07:09:32 ftpcl1n1 automount[7724]: sigchld: exp 7765 finished,
switching from 2 to 1
Oct 10 07:09:32 ftpcl1n1 automount[7724]: get_pkt: state 2, next 1
Oct 10 07:09:32 ftpcl1n1 automount[7724]: st_ready(): state =3D 2
Oct 10 07:09:34 ftpcl1n1 automount[7711]: sig 14 switching from 1 to 2
Oct 10 07:09:34 ftpcl1n1 automount[7711]: get_pkt: state 1, next 2
Oct 10 07:09:34 ftpcl1n1 automount[7711]: st_expire(): state =3D 1
Oct 10 07:09:34 ftpcl1n1 automount[7711]: expire_proc: exp_proc=3D7766
Oct 10 07:09:34 ftpcl1n1 automount[7711]: handle_child: got pid 7766, =
sig 0
(0), stat 0
Oct 10 07:09:34 ftpcl1n1 automount[7711]: sigchld: exp 7766 finished,
switching from 2 to 1
Oct 10 07:09:34 ftpcl1n1 automount[7711]: get_pkt: state 2, next 1
Oct 10 07:09:34 ftpcl1n1 automount[7711]: st_ready(): state =3D 2
Oct 10 07:09:37 ftpcl1n1 automount[7594]: sig 14 switching from 1 to 2
Oct 10 07:09:37 ftpcl1n1 automount[7594]: get_pkt: state 1, next 2
Oct 10 07:09:37 ftpcl1n1 automount[7594]: st_expire(): state =3D 1
Oct 10 07:09:37 ftpcl1n1 automount[7594]: expire_proc: exp_proc=3D7784
Oct 10 07:09:37 ftpcl1n1 automount[7784]: expire_proc: 1 remaining in
/ftpmnt
Oct 10 07:09:37 ftpcl1n1 automount[7594]: handle_child: got pid 7784, =
sig 0
(0), stat 1
Oct 10 07:09:37 ftpcl1n1 automount[7594]: sigchld: exp 7784 finished,
switching from 2 to 1
Oct 10 07:09:37 ftpcl1n1 automount[7594]: get_pkt: state 2, next 1
Oct 10 07:09:37 ftpcl1n1 automount[7594]: st_ready(): state =3D 2
Oct 10 07:09:47 ftpcl1n1 automount[7724]: sig 14 switching from 1 to 2
Oct 10 07:09:47 ftpcl1n1 automount[7724]: get_pkt: state 1, next 2
Oct 10 07:09:47 ftpcl1n1 automount[7724]: st_expire(): state =3D 1
Oct 10 07:09:47 ftpcl1n1 automount[7724]: expire_proc: exp_proc=3D7790
Oct 10 07:09:47 ftpcl1n1 automount[7724]: handle_child: got pid 7790, =
sig 0
(0), stat 0
Oct 10 07:09:47 ftpcl1n1 automount[7724]: sigchld: exp 7790 finished,
switching from 2 to 1
Oct 10 07:09:47 ftpcl1n1 automount[7724]: get_pkt: state 2, next 1
Oct 10 07:09:47 ftpcl1n1 automount[7724]: st_ready(): state =3D 2
Oct 10 07:09:49 ftpcl1n1 automount[7711]: sig 14 switching from 1 to 2
Oct 10 07:09:49 ftpcl1n1 automount[7711]: get_pkt: state 1, next 2
Oct 10 07:09:49 ftpcl1n1 automount[7711]: st_expire(): state =3D 1
Oct 10 07:09:49 ftpcl1n1 automount[7711]: expire_proc: exp_proc=3D7791
Oct 10 07:09:49 ftpcl1n1 automount[7711]: handle_child: got pid 7791, =
sig 0
(0), stat 0
Oct 10 07:09:49 ftpcl1n1 automount[7711]: sigchld: exp 7791 finished,
switching from 2 to 1
Oct 10 07:09:49 ftpcl1n1 automount[7711]: get_pkt: state 2, next 1
Oct 10 07:09:49 ftpcl1n1 automount[7711]: st_ready(): state =3D 2
Oct 10 07:09:52 ftpcl1n1 automount[7594]: sig 14 switching from 1 to 2
Oct 10 07:09:52 ftpcl1n1 automount[7594]: get_pkt: state 1, next 2
Oct 10 07:09:52 ftpcl1n1 automount[7594]: st_expire(): state =3D 1
Oct 10 07:09:52 ftpcl1n1 automount[7594]: expire_proc: exp_proc=3D7792
Oct 10 07:09:52 ftpcl1n1 automount[7792]: expire_proc: 1 remaining in
/ftpmnt
Oct 10 07:09:52 ftpcl1n1 automount[7594]: handle_child: got pid 7792, =
sig 0
(0), stat 1
Oct 10 07:09:52 ftpcl1n1 automount[7594]: sigchld: exp 7792 finished,
switching from 2 to 1
Oct 10 07:09:52 ftpcl1n1 automount[7594]: get_pkt: state 2, next 1
Oct 10 07:09:52 ftpcl1n1 automount[7594]: st_ready(): state =3D 2
Oct 10 07:10:01 ftpcl1n1 crond[7795]: (root) CMD (/usr/lib/sa/sa1 1 1)
Oct 10 07:10:02 ftpcl1n1 automount[7724]: sig 14 switching from 1 to 2
Oct 10 07:10:02 ftpcl1n1 automount[7724]: get_pkt: state 1, next 2
Oct 10 07:10:02 ftpcl1n1 automount[7724]: st_expire(): state =3D 1
Oct 10 07:10:02 ftpcl1n1 automount[7724]: expire_proc: exp_proc=3D7797
Oct 10 07:10:02 ftpcl1n1 automount[7724]: handle_child: got pid 7797, =
sig 0
(0), stat 0
Oct 10 07:10:02 ftpcl1n1 automount[7724]: sigchld: exp 7797 finished,
switching from 2 to 1
Oct 10 07:10:02 ftpcl1n1 automount[7724]: get_pkt: state 2, next 1
Oct 10 07:10:02 ftpcl1n1 automount[7724]: st_ready(): state =3D 2
Oct 10 07:10:04 ftpcl1n1 automount[7711]: sig 14 switching from 1 to 2
Oct 10 07:10:04 ftpcl1n1 automount[7711]: get_pkt: state 1, next 2
Oct 10 07:10:04 ftpcl1n1 automount[7711]: st_expire(): state =3D 1
Oct 10 07:10:04 ftpcl1n1 automount[7711]: expire_proc: exp_proc=3D7798
Oct 10 07:10:04 ftpcl1n1 automount[7711]: handle_child: got pid 7798, =
sig 0
(0), stat 0
Oct 10 07:10:04 ftpcl1n1 automount[7711]: sigchld: exp 7798 finished,
switching from 2 to 1
Oct 10 07:10:04 ftpcl1n1 automount[7711]: get_pkt: state 2, next 1
Oct 10 07:10:04 ftpcl1n1 automount[7711]: st_ready(): state =3D 2
Oct 10 07:10:07 ftpcl1n1 automount[7594]: sig 14 switching from 1 to 2
Oct 10 07:10:07 ftpcl1n1 automount[7594]: get_pkt: state 1, next 2
Oct 10 07:10:07 ftpcl1n1 automount[7594]: st_expire(): state =3D 1
Oct 10 07:10:07 ftpcl1n1 automount[7594]: expire_proc: exp_proc=3D7799
Oct 10 07:10:07 ftpcl1n1 automount[7799]: expire_proc: 1 remaining in
/ftpmnt
Oct 10 07:10:07 ftpcl1n1 automount[7594]: handle_child: got pid 7799, =
sig 0
(0), stat 1
Oct 10 07:10:07 ftpcl1n1 automount[7594]: sigchld: exp 7799 finished,
switching from 2 to 1
Oct 10 07:10:07 ftpcl1n1 automount[7594]: get_pkt: state 2, next 1
Oct 10 07:10:07 ftpcl1n1 automount[7594]: st_ready(): state =3D 2
Oct 10 07:10:17 ftpcl1n1 automount[7724]: sig 14 switching from 1 to 2
Oct 10 07:10:17 ftpcl1n1 automount[7724]: get_pkt: state 1, next 2
Oct 10 07:10:17 ftpcl1n1 automount[7724]: st_expire(): state =3D 1
Oct 10 07:10:17 ftpcl1n1 automount[7724]: expire_proc: exp_proc=3D7821
Oct 10 07:10:17 ftpcl1n1 automount[7724]: handle_child: got pid 7821, =
sig 0
(0), stat 0
Oct 10 07:10:17 ftpcl1n1 automount[7724]: sigchld: exp 7821 finished,
switching from 2 to 1
Oct 10 07:10:17 ftpcl1n1 automount[7724]: get_pkt: state 2, next 1
Oct 10 07:10:17 ftpcl1n1 automount[7724]: st_ready(): state =3D 2
Oct 10 07:10:19 ftpcl1n1 automount[7711]: sig 14 switching from 1 to 2
Oct 10 07:10:19 ftpcl1n1 automount[7711]: get_pkt: state 1, next 2
Oct 10 07:10:19 ftpcl1n1 automount[7711]: st_expire(): state =3D 1
Oct 10 07:10:19 ftpcl1n1 automount[7711]: expire_proc: exp_proc=3D7822
Oct 10 07:10:19 ftpcl1n1 automount[7711]: handle_child: got pid 7822, =
sig 0
(0), stat 0
Oct 10 07:10:19 ftpcl1n1 automount[7711]: sigchld: exp 7822 finished,
switching from 2 to 1
Oct 10 07:10:19 ftpcl1n1 automount[7711]: get_pkt: state 2, next 1
Oct 10 07:10:19 ftpcl1n1 automount[7711]: st_ready(): state =3D 2
Oct 10 07:10:22 ftpcl1n1 automount[7594]: sig 14 switching from 1 to 2
Oct 10 07:10:22 ftpcl1n1 automount[7594]: get_pkt: state 1, next 2
Oct 10 07:10:22 ftpcl1n1 automount[7594]: st_expire(): state =3D 1
Oct 10 07:10:22 ftpcl1n1 automount[7594]: expire_proc: exp_proc=3D7823
Oct 10 07:10:22 ftpcl1n1 automount[7823]: expire_proc: 1 remaining in
/ftpmnt
Oct 10 07:10:22 ftpcl1n1 automount[7594]: handle_child: got pid 7823, =
sig 0
(0), stat 1
Oct 10 07:10:22 ftpcl1n1 automount[7594]: sigchld: exp 7823 finished,
switching from 2 to 1
Oct 10 07:10:22 ftpcl1n1 automount[7594]: get_pkt: state 2, next 1
Oct 10 07:10:22 ftpcl1n1 automount[7594]: st_ready(): state =3D 2
Oct 10 07:10:32 ftpcl1n1 automount[7724]: sig 14 switching from 1 to 2
Oct 10 07:10:32 ftpcl1n1 automount[7724]: get_pkt: state 1, next 2

------_=_NextPart_001_01C6EC64.05AE5DFB
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7650.21">
<TITLE>Autofs not unmounting cifs/samba share</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Autofs is not unmounting a cifs share =
after a minute of inactivity per the /etc/auto.master file.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here is some debug information for =
autofs when performing a test on the cifs share, and the share does not =
get unmounted.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If anyone has ideas on how I can fix =
this, please let me know.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Dan</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Running Red Hat ES 4 -&nbsp;&nbsp; =
2.6.9-42.0.3.ELsmp</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Packages - </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">autofs-4.1.3-187</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">samba-3.0.10-1.4E.9</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">samba-client-3.0.10-1.4E.9</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">samba-common-3.0.10-1.4E.9</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">[root@ftpcl1n1 /]# df -h</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">Filesystem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; Size&nbsp; Used Avail Use% Mounted on</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvRoot</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4.0G&nbsp; 258M&nbsp; 3.5G&nbsp;&nbsp; 7% /</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">/dev/cciss/c0d0p1&nbsp;&nbsp;&nbsp;&nbsp; =
244M&nbsp;&nbsp; 24M&nbsp; 208M&nbsp; 10% /boot</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">none&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1014M&nbsp;&nbsp;&nbsp;&nbsp; =
0 1014M&nbsp;&nbsp; 0% /dev/shm</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvHome</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4.0G&nbsp;&nbsp; 41M&nbsp; 3.7G&nbsp;&nbsp; 2% /home</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvads</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
496M&nbsp;&nbsp; 11M&nbsp; 460M&nbsp;&nbsp; 3% /home/adsftp</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvOpt</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.9G&nbsp; 191M&nbsp; 7.3G&nbsp;&nbsp; 3% /opt</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvTmp</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1008M&nbsp;&nbsp; 39M&nbsp; 919M&nbsp;&nbsp; 4% /tmp</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvUsr</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.9G&nbsp; 2.1G&nbsp; 7.3G&nbsp; 23% /usr</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvVar</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4.0G&nbsp; 169M&nbsp; 3.6G&nbsp;&nbsp; 5% /var</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">//ssnetapp1/ltsftp$&nbsp;&nbsp; =
2.1T&nbsp; 2.1T&nbsp; 2.9G 100% /ftpmnt/banksftp</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[root@ftpcl1n1 /]# date</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Tue Oct 10 07:09:30 EDT 2006</FONT>
</P>

<P><B><FONT SIZE=3D2 FACE=3D"Arial">STILL MOUNTED - after minute of =
inactivity</FONT></B>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">[root@ftpcl1n1 /]# date</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Tue Oct 10 07:11:27 EDT 2006</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">[root@ftpcl1n1 /]# df -h</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">Filesystem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; Size&nbsp; Used Avail Use% Mounted on</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvRoot</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4.0G&nbsp; 258M&nbsp; 3.5G&nbsp;&nbsp; 7% /</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">/dev/cciss/c0d0p1&nbsp;&nbsp;&nbsp;&nbsp; =
244M&nbsp;&nbsp; 24M&nbsp; 208M&nbsp; 10% /boot</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">none&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1014M&nbsp;&nbsp;&nbsp;&nbsp; =
0 1014M&nbsp;&nbsp; 0% /dev/shm</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvHome</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4.0G&nbsp;&nbsp; 41M&nbsp; 3.7G&nbsp;&nbsp; 2% /home</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvads</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
496M&nbsp;&nbsp; 11M&nbsp; 460M&nbsp;&nbsp; 3% /home/adsftp</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvOpt</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.9G&nbsp; 191M&nbsp; 7.3G&nbsp;&nbsp; 3% /opt</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvTmp</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1008M&nbsp;&nbsp; 39M&nbsp; 919M&nbsp;&nbsp; 4% /tmp</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvUsr</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9.9G&nbsp; 2.1G&nbsp; 7.3G&nbsp; 23% /usr</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">/dev/mapper/VolGroup00-lvVar</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4.0G&nbsp; 169M&nbsp; 3.6G&nbsp;&nbsp; 5% /var</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">//ssnetapp1/ltsftp$&nbsp;&nbsp; =
2.1T&nbsp; 2.1T&nbsp; 2.9G 100% /ftpmnt/banksftp</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: map_modified: no changes</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: lookup(file): banksftp -&gt; =
-fstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/cre=
dentials/cre.banksftp ://ssnetapp1/ltsftp\$</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: parse(sun): expanded entry: =
-fstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/cre=
dentials/cre.banksftp ://ssnetapp1/ltsftp\$</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: parse(sun): =
dequote(&quot;fstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentia=
ls=3D/etc/credentials/cre.banksftp&quot;) -&gt; =
fstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/cred=
entials/cre.banksftp</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: parse(sun): gathered options: =
fstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/cred=
entials/cre.banksftp</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: parse(sun): dequote(&quot;//ssnetapp1/ltsftp\$&quot;) =
-&gt; //ssnetapp1/ltsftp$</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: parse(sun): core of entry: =
options=3Dfstype=3Dcifs,file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D=
/etc/credentials/cre.banksftp, loc=3D//ssnetapp1/ltsftp$</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: parse(sun): mounting root /ftpmnt, mountpoint banksftp, =
what //ssnetapp1/ltsftp$, fstype cifs, options =
file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/credentials/cre.ba=
nksftp</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: do_mount //ssnetapp1/ltsftp$ /ftpmnt/banksftp type cifs =
options =
file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/credentials/cre.ba=
nksftp using module generic</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: mount(generic): calling mkdir_path =
/ftpmnt/banksftp</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: mount(generic): calling mount -t cifs -s -o =
file_mode=3D0777,dir_mode=3D0777,rw,credentials=3D/etc/credentials/cre.ba=
nksftp //ssnetapp1/ltsftp$ /ftpmnt/banksftp</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 kernel: =
SELinux: initialized (dev cifs, type cifs), uses genfs_contexts</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7756]: mount(generic): mounted //ssnetapp1/ltsftp$ type cifs =
on /ftpmnt/banksftp</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7594]: handle_child: got pid 7756, sig 0 (0), stat 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7594]: sig_child: found pending iop pid 7756: signalled 0 (sig =
0), exit status 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:23 ftpcl1n1 =
automount[7594]: send_ready: token=3D10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:32 ftpcl1n1 =
automount[7724]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:32 ftpcl1n1 =
automount[7724]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:32 ftpcl1n1 =
automount[7724]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:32 ftpcl1n1 =
automount[7724]: expire_proc: exp_proc=3D7765</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:32 ftpcl1n1 =
automount[7724]: handle_child: got pid 7765, sig 0 (0), stat 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:32 ftpcl1n1 =
automount[7724]: sigchld: exp 7765 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:32 ftpcl1n1 =
automount[7724]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:32 ftpcl1n1 =
automount[7724]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:34 ftpcl1n1 =
automount[7711]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:34 ftpcl1n1 =
automount[7711]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:34 ftpcl1n1 =
automount[7711]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:34 ftpcl1n1 =
automount[7711]: expire_proc: exp_proc=3D7766</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:34 ftpcl1n1 =
automount[7711]: handle_child: got pid 7766, sig 0 (0), stat 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:34 ftpcl1n1 =
automount[7711]: sigchld: exp 7766 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:34 ftpcl1n1 =
automount[7711]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:34 ftpcl1n1 =
automount[7711]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:37 ftpcl1n1 =
automount[7594]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:37 ftpcl1n1 =
automount[7594]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:37 ftpcl1n1 =
automount[7594]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:37 ftpcl1n1 =
automount[7594]: expire_proc: exp_proc=3D7784</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:37 ftpcl1n1 =
automount[7784]: expire_proc: 1 remaining in /ftpmnt</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:37 ftpcl1n1 =
automount[7594]: handle_child: got pid 7784, sig 0 (0), stat 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:37 ftpcl1n1 =
automount[7594]: sigchld: exp 7784 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:37 ftpcl1n1 =
automount[7594]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:37 ftpcl1n1 =
automount[7594]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:47 ftpcl1n1 =
automount[7724]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:47 ftpcl1n1 =
automount[7724]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:47 ftpcl1n1 =
automount[7724]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:47 ftpcl1n1 =
automount[7724]: expire_proc: exp_proc=3D7790</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:47 ftpcl1n1 =
automount[7724]: handle_child: got pid 7790, sig 0 (0), stat 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:47 ftpcl1n1 =
automount[7724]: sigchld: exp 7790 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:47 ftpcl1n1 =
automount[7724]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:47 ftpcl1n1 =
automount[7724]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:49 ftpcl1n1 =
automount[7711]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:49 ftpcl1n1 =
automount[7711]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:49 ftpcl1n1 =
automount[7711]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:49 ftpcl1n1 =
automount[7711]: expire_proc: exp_proc=3D7791</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:49 ftpcl1n1 =
automount[7711]: handle_child: got pid 7791, sig 0 (0), stat 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:49 ftpcl1n1 =
automount[7711]: sigchld: exp 7791 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:49 ftpcl1n1 =
automount[7711]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:49 ftpcl1n1 =
automount[7711]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:52 ftpcl1n1 =
automount[7594]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:52 ftpcl1n1 =
automount[7594]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:52 ftpcl1n1 =
automount[7594]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:52 ftpcl1n1 =
automount[7594]: expire_proc: exp_proc=3D7792</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:52 ftpcl1n1 =
automount[7792]: expire_proc: 1 remaining in /ftpmnt</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:52 ftpcl1n1 =
automount[7594]: handle_child: got pid 7792, sig 0 (0), stat 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:52 ftpcl1n1 =
automount[7594]: sigchld: exp 7792 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:52 ftpcl1n1 =
automount[7594]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:09:52 ftpcl1n1 =
automount[7594]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:01 ftpcl1n1 crond[7795]: =
(root) CMD (/usr/lib/sa/sa1 1 1)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:02 ftpcl1n1 =
automount[7724]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:02 ftpcl1n1 =
automount[7724]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:02 ftpcl1n1 =
automount[7724]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:02 ftpcl1n1 =
automount[7724]: expire_proc: exp_proc=3D7797</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:02 ftpcl1n1 =
automount[7724]: handle_child: got pid 7797, sig 0 (0), stat 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:02 ftpcl1n1 =
automount[7724]: sigchld: exp 7797 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:02 ftpcl1n1 =
automount[7724]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:02 ftpcl1n1 =
automount[7724]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:04 ftpcl1n1 =
automount[7711]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:04 ftpcl1n1 =
automount[7711]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:04 ftpcl1n1 =
automount[7711]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:04 ftpcl1n1 =
automount[7711]: expire_proc: exp_proc=3D7798</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:04 ftpcl1n1 =
automount[7711]: handle_child: got pid 7798, sig 0 (0), stat 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:04 ftpcl1n1 =
automount[7711]: sigchld: exp 7798 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:04 ftpcl1n1 =
automount[7711]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:04 ftpcl1n1 =
automount[7711]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:07 ftpcl1n1 =
automount[7594]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:07 ftpcl1n1 =
automount[7594]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:07 ftpcl1n1 =
automount[7594]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:07 ftpcl1n1 =
automount[7594]: expire_proc: exp_proc=3D7799</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:07 ftpcl1n1 =
automount[7799]: expire_proc: 1 remaining in /ftpmnt</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:07 ftpcl1n1 =
automount[7594]: handle_child: got pid 7799, sig 0 (0), stat 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:07 ftpcl1n1 =
automount[7594]: sigchld: exp 7799 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:07 ftpcl1n1 =
automount[7594]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:07 ftpcl1n1 =
automount[7594]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:17 ftpcl1n1 =
automount[7724]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:17 ftpcl1n1 =
automount[7724]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:17 ftpcl1n1 =
automount[7724]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:17 ftpcl1n1 =
automount[7724]: expire_proc: exp_proc=3D7821</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:17 ftpcl1n1 =
automount[7724]: handle_child: got pid 7821, sig 0 (0), stat 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:17 ftpcl1n1 =
automount[7724]: sigchld: exp 7821 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:17 ftpcl1n1 =
automount[7724]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:17 ftpcl1n1 =
automount[7724]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:19 ftpcl1n1 =
automount[7711]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:19 ftpcl1n1 =
automount[7711]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:19 ftpcl1n1 =
automount[7711]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:19 ftpcl1n1 =
automount[7711]: expire_proc: exp_proc=3D7822</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:19 ftpcl1n1 =
automount[7711]: handle_child: got pid 7822, sig 0 (0), stat 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:19 ftpcl1n1 =
automount[7711]: sigchld: exp 7822 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:19 ftpcl1n1 =
automount[7711]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:19 ftpcl1n1 =
automount[7711]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:22 ftpcl1n1 =
automount[7594]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:22 ftpcl1n1 =
automount[7594]: get_pkt: state 1, next 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:22 ftpcl1n1 =
automount[7594]: st_expire(): state =3D 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:22 ftpcl1n1 =
automount[7594]: expire_proc: exp_proc=3D7823</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:22 ftpcl1n1 =
automount[7823]: expire_proc: 1 remaining in /ftpmnt</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:22 ftpcl1n1 =
automount[7594]: handle_child: got pid 7823, sig 0 (0), stat 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:22 ftpcl1n1 =
automount[7594]: sigchld: exp 7823 finished, switching from 2 to =
1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:22 ftpcl1n1 =
automount[7594]: get_pkt: state 2, next 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:22 ftpcl1n1 =
automount[7594]: st_ready(): state =3D 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:32 ftpcl1n1 =
automount[7724]: sig 14 switching from 1 to 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Oct 10 07:10:32 ftpcl1n1 =
automount[7724]: get_pkt: state 1, next 2</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6EC64.05AE5DFB--


--===============4764922503241178787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4764922503241178787==--

