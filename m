From: Bill Geddes <wkgeddes@gmail.com>
Subject: automounter works for some maps, fails on another
Date: Thu, 6 Oct 2005 11:43:22 -0600
Message-ID: <56eb9cd10510061043t1ec2b762kab81d85c42fe12e1@mail.gmail.com>
Reply-To: Bill Geddes <wkgeddes@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1237332418=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

--===============1237332418==
Content-Type: multipart/alternative; 
	boundary="----=_Part_177_29631089.1128620602094"

------=_Part_177_29631089.1128620602094
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have a puzzling problem. When I start the autofs
service on a client, the local /var/log/messages file shows:

Sep 29 13:41:34 clonehost2 autofs: automount startup succeeded Sep 29
13:41:34 clonehost2 automount[10732]: failed to load map, exiting

- automount processes are all running, but
On the server side, I get ' rpc.mountd: getfh failed: Operation not
permitted'.

Here's the output of `ypcat -k auto.master`
/server/homes server.homes
/server/File_Access auto.file_access
/auto/data auto.data
/auto/bitsrus auto.bitsrus
/nfs auto.hosts

** The automounter manages to mount these maps just fine!

and `ypcat -k server.homes`
svr_homes -rw,intr,rsize=3D8192,wsize=3D8192,timeo=3D14 svr:/vol3/server_ho=
mes

** This is the one that fails.
Manually mounting this fails as well.

This system is one of 3 clones. 2 of these machines work just
fine. I built the first of 3 machine with RedHat 3 AS 64bit
linux. I then used dd to clone that disk to the other
two disks. Thus, each machine started life as a clone of
the first. We assign static IP addresses, so each machine
had to be made unique. We are using NIS to authenticate
logins and to push automounter maps. Home directories and
other files are managed via a fileserver and are served up
via automounter - one map for Home directories, everything
else from other automounter map files.

This fileserver has been in production for years, and in
use 24x7x36N. Playing with the exports on that machine
is out of the question, and should be irrelevant given
that the sibling machines and 100+ other machines work
fine getting this mount point from this fileserver.

This problem has led me to re-install nfs, automounter,
and other packages on the affected machine. No progress.
I've switched network interfaces (eth1, eth2), but no
change. I've cleared arp caches, changed IP addresses,
and I still cannot figure this out. Any help would be
appreciated.
System Details:
automount --version returns:
Linux automount version 4.1.3-130

Hardware:
AMD dual opteron CPU, SuperMicro
MB, 16Gb RAM, SATA (Intel controller) disks, 2 Gbit nics
(tg3 driver), 1 100Mbit nic (e100), 1u packaging.

`uname -a`
Linux clonehost2 2.4.21-32.ELsmp #1 SMP Fri Apr 15 21:03:28 EDT 2005 x86_64
x86_64 x86_64 GNU/Linux



--

------=_Part_177_29631089.1128620602094
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have a puzzling problem.&nbsp; When I start the autofs<br>
service on a client, the local /var/log/messages file shows:<br>
<br>
Sep 29 13:41:34 clonehost2 autofs: automount startup succeeded Sep 29
13:41:34 clonehost2 automount[10732]: failed to load map, exiting<br>
<br>
- automount processes are all running, but<br>
On the server side, I get ' rpc.mountd: getfh failed: Operation not permitt=
ed'.<br>
<br>
Here's the output of `ypcat -k auto.master`<br>
/server/homes server.homes<br>
/server/File_Access auto.file_access<br>
/auto/data auto.data<br>
/auto/bitsrus auto.bitsrus<br>
/nfs auto.hosts&nbsp;&nbsp; <br>
<br>
** The automounter manages to mount these maps just fine!<br>
<br>
and `ypcat -k server.homes`<br>
svr_homes -rw,intr,rsize=3D8192,wsize=3D8192,timeo=3D14&nbsp; svr:/vol3/ser=
ver_homes<br>
<br>
** This is the one that fails.<br>
Manually mounting this fails as well.<br>
<br>
This system is one of 3 clones.&nbsp; 2 of these machines work just<br>
fine. I built the first of 3 machine with RedHat 3 AS 64bit<br>
linux.&nbsp; I then used dd to clone that disk to the other<br>
two disks.&nbsp; Thus, each machine started life as a clone of<br>
the first.&nbsp; We assign static IP addresses, so each machine<br>
had to be made unique.&nbsp; We are using NIS to authenticate<br>
logins and to push automounter maps.&nbsp; Home directories and<br>
other files are managed via a fileserver and are served up<br>
via automounter - one map for Home directories, everything<br>
else from other automounter map files.<br>
&nbsp;<br>
This fileserver has been in production for years, and in<br>
use 24x7x36N.&nbsp; Playing with the exports on that machine<br>
is out of the question, and should be irrelevant given<br>
that the sibling machines and 100+ other machines work<br>
fine getting this mount point from this fileserver.<br>
<br>
This problem has led me to re-install nfs, automounter,<br>
and other packages on the affected machine.&nbsp; No progress.<br>
I've switched network interfaces (eth1, eth2), but no<br>
change.&nbsp; I've cleared arp caches, changed IP addresses,<br>
and I still cannot figure this out.&nbsp; Any help would be<br>
appreciated.<br>
System Details:<br>
automount --version returns:<br>
Linux automount version 4.1.3-130<br>
<br>
Hardware:<br>
AMD dual opteron CPU, SuperMicro<br>
MB, 16Gb RAM, SATA (Intel controller) disks, 2 Gbit nics<br>
(tg3 driver), 1 100Mbit nic (e100), 1u packaging.<br>
<br>
`uname -a`<br>
Linux clonehost2 2.4.21-32.ELsmp #1 SMP Fri Apr 15 21:03:28 EDT 2005 x86_64=
 x86_64 x86_64 GNU/Linux<br>
<br>
<br clear=3D"all"><br>-- <br><br>

------=_Part_177_29631089.1128620602094--


--===============1237332418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1237332418==--

