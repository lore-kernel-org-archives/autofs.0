From: "idiot)_) supreme" <ejw50@hotmail.com>
Subject: Re: autofs default behavior on syminks?
Date: Sun, 11 Apr 2004 13:08:22 +0000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Sea2-F17J09Z6e2iL550001e1f5@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============15053438162620392=="
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

--===============15053438162620392==
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id i3C3rNpG019146

<html><div style=3D'background-color:'><DIV class=3DRTE>
<P>Hi Ian</P>
<P>&nbsp;</P>
<P>Thanks for replying.&nbsp; I should clarifiy our problems a little bit=
.</P>
<P>&nbsp;</P>
<P>For the most part, we only see this error on the 2.6.5 with 4.1.0 and =
all of the kernel patches.&nbsp; We do not really see this on 2.4.22/4.1.=
0 and kernel patches.&nbsp; When all of the machines are running, we see =
it about 2x an hour.&nbsp; I have tried raising the timeouts to 1 hour (s=
o they never umount once mounted) but I won't know if this "works" until =
next week.&nbsp; Our previous timeouts were 5 minutes.&nbsp; &nbsp;I have=
 also recently tried raising retry, timeo, and other variables, but don't=
 know if&nbsp;will work unti next week.&nbsp; I have not tried 4.1.2 yet.=
</P>
<P>&nbsp;</P>
<P>&nbsp;</P>
<P>We see this error in /var/log/messages</P>
<P>Apr&nbsp; 9 22:16:00 e232 automount[17404]: &gt;&gt; mount: RPC: Remot=
e system error - Connection timed out<BR>Apr&nbsp; 9 22:16:00 e232 automo=
unt[17404]: mount(nfs): nfs: mount failure emc1.bbn.com:/u11 on /net/emc/=
u11<BR>Apr&nbsp; 9 22:16:00 e232 automount[17404]: failed to mount /net/e=
mc/u11</P>
<P>&nbsp;</P>
<P>I can correspond these /var/log/messages logs to error logs in our job=
 running system</P>
<P>&nbsp;</P>
<P>29763 K&nbsp;&nbsp;&nbsp;&nbsp;*username* &nbsp;@ e232&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp; e200&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; racks5n6&nbsp;&nbsp; "13022-SCTM_X-tr-GI-1-2-05"<BR>22:16:00: ca=
n't open task output /d4m/ears/expts/13009/logfiles/13009-SCTM_NX-tr-GI-1=
-1-6.log: No such file or directory<BR>22:16:04: reap pid 17403, task 298=
43, exit 0<BR>22:16:04: syncing with db</P>
<P>The file it can't open is really a link to /net/emc/u11 (which is the =
what automount reports a failure on)</P>
<P>This is why I asked about autofs link behavior.</P>
<P>&nbsp;</P>
<P>Thanks again for your help.&nbsp; IF there is any test you want me to =
run, let me know.</P>
<P>&nbsp;</P>
<P>Eric</P>
<P><BR>&nbsp;</P></DIV>
<DIV></DIV>&gt;From: raven@themaw.net=20
<DIV></DIV>&gt;To: "idiot)_) supreme" &lt;ejw50@hotmail.com&gt;=20
<DIV></DIV>&gt;CC: autofs@linux.kernel.org=20
<DIV></DIV>&gt;Subject: Re: [autofs] autofs default behavior on syminks?=20
<DIV></DIV>&gt;Date: Sun, 11 Apr 2004 14:14:17 +0800 (WST)=20
<DIV></DIV>&gt;=20
<DIV></DIV>&gt;On Sat, 10 Apr 2004, idiot)_) supreme wrote:=20
<DIV></DIV>&gt;=20
<DIV></DIV>&gt; &gt; Hi all=20
<DIV></DIV>&gt; &gt;=20
<DIV></DIV>&gt; &gt; We are running autofs4.1.0 with 2.4.22 on about 100 =
machines, and 2.6.5 on=20
<DIV></DIV>&gt; &gt; about 100 machines with all of the the kernel patche=
s for both.=20
<DIV></DIV>&gt;=20
<DIV></DIV>&gt;Cool. I'm keen to hear how things go. Especially with 2.6.=
=20
<DIV></DIV>&gt;A note to the list from time to time would be appreciated.=
=20
<DIV></DIV>&gt;=20
<DIV></DIV>&gt; &gt;=20
<DIV></DIV>&gt; &gt;=20
<DIV></DIV>&gt; &gt; What is autofs's behavior trying to cross symlinks w=
hen you type 'ls'?=20
<DIV></DIV>&gt; &gt; autofs seems to time out a lot faster than AMD for e=
xample.=20
<DIV></DIV>&gt; &gt;=20
<DIV></DIV>&gt; &gt; We are occasionally seeing problems timeouts trying =
to cross symlinks.&nbsp;&nbsp;If I=20
<DIV></DIV>&gt; &gt; type 'ls' it might show=20
<DIV></DIV>&gt; &gt;=20
<DIV></DIV>&gt; &gt; abc -&gt; /net/emc/u11=20
<DIV></DIV>&gt; &gt;=20
<DIV></DIV>&gt; &gt; as a broken symlink=20
<DIV></DIV>&gt; &gt;=20
<DIV></DIV>&gt; &gt; but if I type 'ls /net/emc/u11'=20
<DIV></DIV>&gt; &gt; the symlink comes back.=20
<DIV></DIV>&gt; &gt;=20
<DIV></DIV>&gt;=20
<DIV></DIV>&gt;In this case autofs doesn't do anything special with symli=
nks.=20
<DIV></DIV>&gt;The colour ls does the 'stat'ing and the results are shown=
.=20
<DIV></DIV>&gt;=20
<DIV></DIV>&gt;This does sound like an autofs bug or lilitation perhaps.=20
<DIV></DIV>&gt;Indeed 'stat'ing the mountpoint itself should not mount it=
, otherwise we=20
<DIV></DIV>&gt;would get undesired mounts, so autofs lies and gives the s=
tat of=20
<DIV></DIV>&gt;the autofs directory instead of the mounted. Actually auto=
fs just doesn't=20
<DIV></DIV>&gt;do anything.=20
<DIV></DIV>&gt;=20
<DIV></DIV>&gt;It's interesting that the symlink shows broken occasionall=
y and not all=20
<DIV></DIV>&gt;the time. There must be a bad return coming back for some =
reason. So=20
<DIV></DIV>&gt;how occasionally?=20
<DIV></DIV>&gt;=20
<DIV></DIV>&gt;Perhaps the 'stat' occurs during an expire sometimes. That=
 could cause a=20
<DIV></DIV>&gt;fail return.=20
<DIV></DIV>&gt;=20
<DIV></DIV>&gt;Ian=20
<DIV></DIV>&gt;=20
<DIV></DIV></div><br clear=3Dall><hr> <a href=3D"http://g.msn.com/8HMAENU=
S/2755??PS=3D">Is your PC infected? Get a FREE online computer virus scan=
 from McAfee=AE Security.</a> </html>


--===============15053438162620392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============15053438162620392==--
