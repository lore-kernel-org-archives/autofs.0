From: "idiot)_) supreme" <ejw50@hotmail.com>
Subject: error in 2.6
Date: Wed, 28 Apr 2004 04:58:49 +0000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Sea2-F25dMtyYZMqDu30002a966@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3381872413504603=="
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
To: autofs@linux.kernel.org

--===============3381872413504603==
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id i3TCkTpG029311

<html><div style=3D'background-color:'><DIV class=3DRTE>I am running auto=
fs4.1, kernel 2.6.5, with the ~7 or so patches.&nbsp; I got this error to=
day (/net/d4m/ears is an automount directory).&nbsp; It logged me out, th=
en when I tried on a different directory I got the second error&nbsp; and=
 got kicked out again.&nbsp; I did not do any further debugging, but I th=
ought you might want to know.&nbsp; If there's anything you want me to tr=
y, let me know.</DIV>
<DIV class=3DRTE>&nbsp;</DIV>
<DIV class=3DRTE>&nbsp;</DIV>
<DIV class=3DRTE>&nbsp;</DIV>
<DIV class=3DRTE>Apr 28 00:45:53 e206 automount[21131]: BUG: /net/d4m/ear=
s already mounted<BR>Apr 28 00:45:55 e206 automount[21136]: BUG: /net/d4m=
/ears already mounted<BR>Apr 28 00:45:58 e206 automount[21139]: BUG: /net=
/d4m/ears already mounted<BR>Apr 28 00:45:58 e206 kernel: Unable to handl=
e kernel NULL pointer dereference at virtual address 00000010<BR>Apr 28 0=
0:45:58 e206 kernel:&nbsp; printing eip:<BR>Apr 28 00:45:58 e206 kernel: =
c0223348<BR>Apr 28 00:45:58 e206 kernel: *pde =3D 00000000<BR>Apr 28 00:4=
5:58 e206 kernel: Oops: 0000 [#1]<BR>Apr 28 00:45:58 e206 kernel: SMP <BR=
>Apr 28 00:45:58 e206 kernel: CPU:&nbsp;&nbsp;&nbsp; 1<BR>Apr 28 00:45:58=
 e206 kernel: EIP:&nbsp;&nbsp;&nbsp; 0060:[try_to_fill_dentry+296/464]&nb=
sp;&nbsp;&nbsp; Not tainted<BR>Apr 28 00:45:58 e206 kernel: EFLAGS: 00010=
246&nbsp;&nbsp; (2.6.5-1ear) <BR>Apr 28 00:45:58 e206 kernel: EIP is at t=
ry_to_fill_dentry+0x128/0x1d0<BR>Apr 28 00:45:58 e206 kernel: eax: 000000=
00&nbsp;&nbsp; ebx: 00000000&nbsp;&nbsp; ecx: 00000000&nbsp;&nbsp; edx: 0=
0000181<BR>Apr 28 00:45:58 e206 kernel: esi: f66764b4&nbsp;&nbsp; edi: cf=
364000&nbsp;&nbsp; ebp: cf364000&nbsp;&nbsp; esp: cf365dbc<BR>Apr 28 00:4=
5:58 e206 kernel: ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068<BR>A=
pr 28 00:45:58 e206 kernel: Process bash (pid: 21077, threadinfo=3Dcf3640=
00 task=3Df6d54c20)<BR>Apr 28 00:45:58 e206 sshd(pam_unix)[21075]: sessio=
n closed for user root<BR>Apr 28 00:45:58 e206 kernel: Stack: f7ff292c f6=
6764b4 f6bd0650 f6bd0670 c383dca0 0000073d f66764b4 f706b6f4 <BR>Apr 28 0=
0:45:58 e206 kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f7647084 0=
0000001 c0223564 f66764b4 f7647084 f706b6f4 00000001 00000001 <BR>Apr 28 =
00:45:58 e206 kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 =
f66764b4 cf365f38 f7ff292c cf365f00 c016acb4 f66764b4 cf365f38 <BR>Apr 28=
 00:45:58 e206 kernel: Call Trace:<BR>Apr 28 00:45:58 e206 kernel:&nbsp; =
[autofs4_revalidate+372/480] autofs4_revalidate+0x174/0x1e0<BR>Apr 28 00:=
45:58 e206 kernel:&nbsp; [kmem_cache_free+561/656] kmem_cache_free+0x231/=
0x290<BR>Apr 28 00:45:58 e206 kernel:&nbsp; [cp_new_stat64+271/304] cp_ne=
w_stat64+0x10f/0x130<BR>Apr 28 00:45:58 e206 kernel:&nbsp; [getname+94/16=
0] getname+0x5e/0xa0<BR>Apr 28 00:45:58 e206 kernel:&nbsp; [__user_walk+3=
6/64] __user_walk+0x24/0x40<BR>Apr 28 00:45:58 e206 kernel:&nbsp; [vfs_st=
at+23/80] vfs_stat+0x17/0x50<BR>Apr 28 00:45:58 e206 kernel:&nbsp; [sys_s=
tat64+17/48] sys_stat64+0x11/0x30<BR>Apr 28 00:45:58 e206 kernel:&nbsp; [=
syscall_call+7/11] syscall_call+0x7/0xb<BR>Apr 28 00:45:58 e206 kernel: <=
BR>Apr 28 00:45:58 e206 kernel: Code: 8b 6b 10 55 53 8b 07 8b 88 40 05 00=
 00 51 e8 85 97 f5 ff eb <BR>Apr 28 00:46:01 e206 sshd(pam_unix)[21141]: =
authentication failure; logname=3D uid=3D0 euid=3D0 tty=3DNODEVssh ruser=3D=
 rhost=3Djaco.b<BR>bn.com&nbsp; user=3Droot<BR>Apr 28 00:46:05 e206 sshd(=
pam_unix)[21141]: session opened for user root by (uid=3D0)<BR>Apr 28 00:=
46:17 e206 automount[21191]: BUG: /net/d4m/ears already mounted<BR>Apr 28=
 00:46:48 e206 kernel:&nbsp; nfs warning: mount version older than kernel=
<BR>Apr 28 00:47:03 e206 automount[21232]: BUG: /net/d4m/cube already mou=
nted<BR>Apr 28 00:47:03 e206 kernel: Unable to handle kernel NULL pointer=
 dereference at virtual address 00000010<BR>Apr 28 00:47:03 e206 kernel:&=
nbsp; printing eip:<BR>Apr 28 00:47:03 e206 kernel: c0223348<BR>Apr 28 00=
:47:03 e206 kernel: *pde =3D 00000000<BR>Apr 28 00:47:03 e206 kernel: Oop=
s: 0000 [#2]<BR>Apr 28 00:47:03 e206 kernel: SMP <BR>Apr 28 00:47:03 e206=
 kernel: CPU:&nbsp;&nbsp;&nbsp; 0<BR>Apr 28 00:47:03 e206 kernel: EIP:&nb=
sp;&nbsp;&nbsp; 0060:[try_to_fill_dentry+296/464]&nbsp;&nbsp;&nbsp; Not t=
ainted<BR>Apr 28 00:47:03 e206 kernel: EFLAGS: 00010246&nbsp;&nbsp; (2.6.=
5-1ear) <BR>Apr 28 00:47:03 e206 kernel: EIP is at try_to_fill_dentry+0x1=
28/0x1d0<BR>Apr 28 00:47:03 e206 kernel: eax: 00000000&nbsp;&nbsp; ebx: 0=
0000000&nbsp;&nbsp; ecx: 00000000&nbsp;&nbsp; edx: 0000014e<BR>Apr 28 00:=
47:03 e206 kernel: esi: f67a4190&nbsp;&nbsp; edi: cf364000&nbsp;&nbsp; eb=
p: cf364000&nbsp;&nbsp; esp: cf365f08<BR>Apr 28 00:47:03 e206 kernel: ds:=
 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068<BR>Apr 28 00:47:03 e206 s=
shd(pam_unix)[21141]: session closed for user root<BR>Apr 28 00:47:03 e20=
6 kernel: Process bash (pid: 21143, threadinfo=3Dcf364000 task=3Df6bd17c0=
)<BR>Apr 28 00:47:03 e206 kernel: Stack: f7ff292c f67a4190 c017471c f6676=
4b4 c0510f80 00001000 f67a4190 f706b6f4 <BR>Apr 28 00:47:03 e206 kernel:&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f7647084 00000003 c0223564 f67a=
4190 f7647084 f706b6f4 00000003 00000003 <BR>Apr 28 00:47:03 e206 kernel:=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00000000 f7ff292c f66=
764b4 cf365f80 c015b043 f67a4190 cf365f80 <BR>Apr 28 00:47:03 e206 kernel=
: Call Trace:<BR>Apr 28 00:47:03 e206 kernel:&nbsp; [dput+28/736] dput+0x=
1c/0x2e0<BR>Apr 28 00:47:03 e206 kernel:&nbsp; [autofs4_revalidate+372/48=
0] autofs4_revalidate+0x174/0x1e0<BR>Apr 28 00:47:03 e206 kernel:&nbsp; [=
sys_chdir+195/336] sys_chdir+0xc3/0x150<BR>Apr 28 00:47:03 e206 kernel:&n=
bsp; [sys_stat64+34/48] sys_stat64+0x22/0x30<BR>Apr 28 00:47:03 e206 kern=
el:&nbsp; [syscall_call+7/11] syscall_call+0x7/0xb<BR>Apr 28 00:47:03 e20=
6 kernel: <BR>Apr 28 00:47:03 e206 kernel: Code: 8b 6b 10 55 53 8b 07 8b =
88 40 05 00 00 51 e8 85 97 f5 ff eb </DIV></div><br clear=3Dall><hr> <a h=
ref=3D"http://g.msn.com/8HMAENUS/2752??PS=3D">Get rid of annoying pop-up =
ads with the new MSN Toolbar =96 FREE!</a> </html>


--===============3381872413504603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3381872413504603==--
