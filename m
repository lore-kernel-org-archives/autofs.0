From: Antonio Messina <arcimboldo@gmail.com>
Subject: autofs changes process's current working directory
Date: Mon, 7 Sep 2009 13:36:59 +0200
Message-ID: <bd985a450909070436x2ddf0fa8l3b20e908f2f2e3c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7910767763928006234=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:date:message-id:subject
	:from:to:content-type;
	bh=3OWy5efxnIRz7VIDVTtH6STYJQsA883eSOf0SFnDa5A=;
	b=exaj5FVGq+Z4HRPoiTuE05CXA3sypanJkG7FJqsEowZPItYowdZCh3gfPTD2UuXu3m
	KeeqB5B4u+8pQeWVD7ODpRQJtAVEo3bVZZS2ko58j2S+Er6YFKGk2T2jDhSN+eorqP1U
	ZrWTfPSLIWYO7RRrr7kF9DeKeRGEcagOVexbI=
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

--===============7910767763928006234==
Content-Type: multipart/alternative; boundary=001485f7cc0a9228f60472fb440f

--001485f7cc0a9228f60472fb440f
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I'm experiencing a problem with autofs. It seems that when a process
is inside an automounted nfs filesystem, if I restart the automount
daemon the current working directory of the process is changed and a
few leading directory are removed leading to a non-existent cwd.

I have to say, however, that the process will continue to see the
current directory: for instance, if we are running a shell, a "ls"
will gives you the correct answer, I can edit files (but vi
complains about not finding the file when saving) and the "pwd"
command returns the right directory.

In order to reproduce the problem I've wrote a very simple program:

#include <unistd.h>
#include <stdio.h>
#include <sys/stat.h>

int main(){
  /* check if the current directory is right */
  char lpath[1024];
  int res;
  getcwd(lpath, 1024);
  res = access(lpath,F_OK);
  if(0 != res)
      printf("Error! My CWD is %s but it doens't exists!\n", lpath);
  else
      printf("My CWD is %s and it exists\n", lpath);
  return res;
}


a simple session follows:

[root@pc-amessina ~]# cd /home/RAID3-D3/vmware
[root@pc-amessina vmware]# ~/cwdcheck
My CWD is /home/RAID3-D3/vmware and it exists
[root@pc-amessina vmware]# service autofs restart
Stopping autofs:                                                [  OK  ]
Starting autofs:                                                [  OK  ]
[root@pc-amessina vmware]# ~/cwdcheck
Error! My CWD is /vmware but it doens't exists!


My auto.master is:

/home /etc/auto.home  -rw,soft,intr,rsize=8192,wsize=8192,sync

my auto.home is very long but the relevant line is:

RAID3-D3 climaserv3:/RAID3/D3

(we mount a few different filesystems from the climaserv3 machine,
but they are exported separately by the server)

My system is:

[root@pc-amessina ~]# uname -a
Linux pc-amessina.ictp.it 2.6.24.7-desktop-2mnb #1 SMP Thu Oct 30
18:03:14 EDT 2008 i686 Intel(R) Core(TM)2 Duo CPU     E8400  @
3.00GHz GNU/Linux

[root@pc-amessina ~]# cat /etc/redhat-release
Mandriva Linux release 2008.1 (Official) for i586

[root@pc-amessina ~]# rpm -q autofs
autofs-5.0.4-7mdv2008.1


Logs from automount follows:

Sep  3 12:55:33 localhost automount[11856]: Starting automounter
version 5.0.4, master map auto.master
Sep  3 12:55:33 localhost automount[11856]: using kernel protocol
version 5.00
Sep  3 12:55:33 localhost automount[11856]: mounted indirect on
/home with timeout 900, freq 225 seconds
Sep  3 12:55:53 localhost automount[11856]: attempting to mount
entry /home/RAID3-D3
Sep  3 12:55:53 localhost automount[11856]: mount(nfs): mounted
climaserv3:/RAID3/D3 on /home/RAID3-D3
Sep  3 12:55:53 localhost automount[11856]: mounted /home/RAID3-D3
Sep  3 12:55:59 localhost automount[11856]: 1 remaining in /home
Sep  3 12:55:59 localhost automount[11856]: filesystem /home still busy
Sep  3 12:56:04 localhost automount[11915]: Starting automounter
version 5.0.4, master map auto.master
Sep  3 12:56:04 localhost automount[11915]: using kernel protocol
version 5.00
Sep  3 12:56:04 localhost automount[11915]: mounted indirect on
/home with timeout 900, freq 225 seconds
Sep  3 12:56:09 localhost automount[11915]: attempting to mount
entry /home/RAID3-D3
Sep  3 12:56:09 localhost automount[11915]: mount(nfs): mounted
climaserv3:/RAID3/D3 on /home/RAID3-D3
Sep  3 12:56:09 localhost automount[11915]: mounted /home/RAID3-D3

--001485f7cc0a9228f60472fb440f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I&#39;m experiencing a problem with autofs. It seems that wh=
en a process<br>is inside an automounted nfs filesystem, if I restart the a=
utomount<br>daemon the current working directory of the process is changed =
and a<br>
few leading directory are removed leading to a non-existent cwd.<br><br>I h=
ave to say, however, that the process will continue to see the<br>current d=
irectory: for instance, if we are running a shell, a &quot;ls&quot;<br>
will gives you the correct answer, I can edit files (but vi<br>complains ab=
out not finding the file when saving) and the &quot;pwd&quot;<br>command re=
turns the right directory.<br><br>In order to reproduce the problem I&#39;v=
e wrote a very simple program:<br>
<br>#include &lt;unistd.h&gt;<br>#include &lt;stdio.h&gt;<br>#include &lt;s=
ys/stat.h&gt;<br><br>int main(){<br>=A0 /* check if the current directory i=
s right */<br>=A0 char lpath[1024];<br>=A0 int res;<br>=A0 getcwd(lpath, 10=
24);<br>
=A0 res =3D access(lpath,F_OK);<br>=A0 if(0 !=3D res)<br>=A0=A0=A0 =A0 prin=
tf(&quot;Error! My CWD is %s but it doens&#39;t exists!\n&quot;, lpath);<br=
>=A0 else<br>=A0=A0=A0 =A0 printf(&quot;My CWD is %s and it exists\n&quot;,=
 lpath);<br>=A0 return res;<br>
}<br><br><br>a simple session follows:<br><br>[root@pc-amessina ~]# cd /hom=
e/RAID3-D3/vmware<br>[root@pc-amessina vmware]# ~/cwdcheck<br>My CWD is /ho=
me/RAID3-D3/vmware and it exists<br>[root@pc-amessina vmware]# service auto=
fs restart<br>
Stopping autofs:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [=A0 OK=A0 ]<br>Starting autofs:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=A0 OK=A0 ]<br>[root@pc-amessina vmware]=
# ~/cwdcheck<br>Error! My CWD is /vmware but it doens&#39;t exists!<br>
<br><br>My auto.master is:<br><br>/home /etc/auto.home=A0 -rw,soft,intr,rsi=
ze=3D8192,wsize=3D8192,sync<br><br>my auto.home is very long but the releva=
nt line is:<br><br>RAID3-D3 climaserv3:/RAID3/D3<br><br>(we mount a few dif=
ferent filesystems from the climaserv3 machine,<br>
but they are exported separately by the server)<br><br>My system is:<br><br=
>[root@pc-amessina ~]# uname -a<br>Linux <a href=3D"http://pc-amessina.ictp=
.it">pc-amessina.ictp.it</a> 2.6.24.7-desktop-2mnb #1 SMP Thu Oct 30<br>18:=
03:14 EDT 2008 i686 Intel(R) Core(TM)2 Duo CPU=A0=A0=A0=A0 E8400=A0 @<br>
3.00GHz GNU/Linux<br><br>[root@pc-amessina ~]# cat /etc/redhat-release<br>M=
andriva Linux release 2008.1 (Official) for i586<br><br>[root@pc-amessina ~=
]# rpm -q autofs<br>autofs-5.0.4-7mdv2008.1<br><br><br>Logs from automount =
follows:<br>
<br>Sep=A0 3 12:55:33 localhost automount[11856]: Starting automounter<br>v=
ersion 5.0.4, master map auto.master<br>Sep=A0 3 12:55:33 localhost automou=
nt[11856]: using kernel protocol<br>version 5.00<br>Sep=A0 3 12:55:33 local=
host automount[11856]: mounted indirect on<br>
/home with timeout 900, freq 225 seconds<br>Sep=A0 3 12:55:53 localhost aut=
omount[11856]: attempting to mount<br>entry /home/RAID3-D3<br>Sep=A0 3 12:5=
5:53 localhost automount[11856]: mount(nfs): mounted<br>climaserv3:/RAID3/D=
3 on /home/RAID3-D3<br>
Sep=A0 3 12:55:53 localhost automount[11856]: mounted /home/RAID3-D3<br>Sep=
=A0 3 12:55:59 localhost automount[11856]: 1 remaining in /home<br>Sep=A0 3=
 12:55:59 localhost automount[11856]: filesystem /home still busy<br>Sep=A0=
 3 12:56:04 localhost automount[11915]: Starting automounter<br>
version 5.0.4, master map auto.master<br>Sep=A0 3 12:56:04 localhost automo=
unt[11915]: using kernel protocol<br>version 5.00<br>Sep=A0 3 12:56:04 loca=
lhost automount[11915]: mounted indirect on<br>/home with timeout 900, freq=
 225 seconds<br>
Sep=A0 3 12:56:09 localhost automount[11915]: attempting to mount<br>entry =
/home/RAID3-D3<br>Sep=A0 3 12:56:09 localhost automount[11915]: mount(nfs):=
 mounted<br>climaserv3:/RAID3/D3 on /home/RAID3-D3<br>Sep=A0 3 12:56:09 loc=
alhost automount[11915]: mounted /home/RAID3-D3<br>
<br><br>

--001485f7cc0a9228f60472fb440f--


--===============7910767763928006234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7910767763928006234==--

