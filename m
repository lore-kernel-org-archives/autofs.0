From: "Darren Gitelman" <d.gitelman@gmail.com>
Subject: autofs errors - expire_cleanup, st_expire, etc.
Date: Fri, 27 Jun 2008 23:35:27 -0500
Message-ID: <bb02c53c0806272135m3958f08el6adecac4aea5c15a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6170423565898154511=="
Return-path: <autofs-bounces@linux.kernel.org>
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

--===============6170423565898154511==
Content-Type: multipart/alternative; 
	boundary="----=_Part_14959_27337822.1214627727304"

------=_Part_14959_27337822.1214627727304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Within the last 2 weeks automount has started to generate thousands of
errors (about every 10-15 secs) in the system log (/var/log/messages). The
directories all seem to mount properly but all these error messages must be
having some impact. I cannot find anything about this. Turning off autofs
stops the errors. I have the exact same configuration and program versions
on 2 other machines, but don't see these errors.

Any help appreciated.


Jun 27 16:21:47 mistral automount[3353]: st_ready: st_ready(): state = 2
path /-
Jun 27 16:21:47 mistral automount[3353]: st_ready: st_ready(): state = 2
path /home/users
Jun 27 16:22:02 mistral automount[3353]: st_expire: state 1 path /-
Jun 27 16:22:02 mistral automount[3353]: expire_proc: exp_proc = 3081669520
path /-
Jun 27 16:22:02 mistral automount[3353]: expire_cleanup: got thid 3081669520
path /- stat 0
Jun 27 16:22:02 mistral automount[3353]: expire_cleanup: sigchld: exp
3081669520 finished, switching from 2 to 1
Jun 27 16:22:02 mistral automount[3353]: st_ready: st_ready(): state = 2
path /-
Jun 27 16:22:17 mistral automount[3353]: st_expire: state 1 path /home/users
Jun 27 16:22:17 mistral automount[3353]: expire_proc: exp_proc = 3081669520
path /home/users
Jun 27 16:22:17 mistral automount[3353]: st_expire: state 1 path /-
Jun 27 16:22:17 mistral automount[3353]: expire_proc: exp_proc = 3078917008
path /-
Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: got thid 3081669520
path /home/users stat 0
Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: sigchld: exp
3081669520 finished, switching from 2 to 1
Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: got thid 3078917008
path /- stat 0
Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: sigchld: exp
3078917008 finished, switching from 2 to 1

[root@mistral log]$ automount --version
Linux automount version 5.0.1-0.rc2.88

Directories:
        config dir:     /etc/sysconfig
        maps dir:       /etc
        modules dir:    /usr/lib/autofs

Compile options:
  DISABLE_MOUNT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS WITH_HESIOD WITH_LDAP
  WITH_SASL

The /etc/sysconfig/autofs file contains all default entries.

thank you
Darren

[root@mistral log]$ cat /proc/version
Linux version 2.6.18-53.1.21.el5 (brewbuilder@ls20-bc2-13.build.redhat.com)
(gcc version 4.1.2 20070626 (Red Hat 4.1.2-14)) #1 SMP Wed May 7 08:42:13
EDT 2008

[root@mistral log]$ cat /etc/auto.home
*               -fstype=nfs,rw,intr,retry=3,async,noatime
zephyr.nbmg:/mnt/vg01/home/&


[root@mistral log]$ cat /etc/auto.data
/data/chin1     -fstype=nfs,rw,intr,retry=3,async,noatime
chinook.nbmg:/export/chin1
/data/mistral1  -fstype=nfs,rw,intr,retry=3,async,noatime
mistral.nbmg:/export/mistral1
/data/diablo1   -fstype=nfs,rw,intr,retry=3,async,noatime
diablo.nbmg:/export/diablo1
/data/zephyr1   -fstype=nfs,rw,intr,retry=3,async,noatime
zephyr.nbmg:/mnt/vg00/data/zephyr1


[root@mistral log]$ cat /etc/auto.master
#
# $Id: auto.master,v 1.3 2003/09/29 08:22:35 raven Exp $
#
# Sample auto.master file
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# For details of the format look at autofs(5).
#/media /etc/auto.misc --timeout=10
#/net   /etc/auto.net
/home/users     /etc/auto.home --timeout=120
/-              /etc/auto.data --timeout=120

------=_Part_14959_27337822.1214627727304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Within the last 2 weeks automount has started to generate thousands of errors (about every 10-15 secs) in the system log (/var/log/messages). The directories all seem to mount properly but all these error messages must be having some impact. I cannot find anything about this. Turning off autofs stops the errors. I have the exact same configuration and program versions on 2 other machines, but don&#39;t see these errors. <br>
<br>Any help appreciated.<br><br><br>Jun 27 16:21:47 mistral automount[3353]: st_ready: st_ready(): state = 2 path /-<br>Jun 27 16:21:47 mistral automount[3353]: st_ready: st_ready(): state = 2 path /home/users<br>Jun 27 16:22:02 mistral automount[3353]: st_expire: state 1 path /-<br>
Jun 27 16:22:02 mistral automount[3353]: expire_proc: exp_proc = 3081669520 path /-<br>Jun 27 16:22:02 mistral automount[3353]: expire_cleanup: got thid 3081669520 path /- stat 0<br>Jun 27 16:22:02 mistral automount[3353]: expire_cleanup: sigchld: exp 3081669520 finished, switching from 2 to 1<br>
Jun 27 16:22:02 mistral automount[3353]: st_ready: st_ready(): state = 2 path /-<br>Jun 27 16:22:17 mistral automount[3353]: st_expire: state 1 path /home/users<br>Jun 27 16:22:17 mistral automount[3353]: expire_proc: exp_proc = 3081669520 path /home/users<br>
Jun 27 16:22:17 mistral automount[3353]: st_expire: state 1 path /-<br>Jun 27 16:22:17 mistral automount[3353]: expire_proc: exp_proc = 3078917008 path /-<br>Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: got thid 3081669520 path /home/users stat 0<br>
Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: sigchld: exp 3081669520 finished, switching from 2 to 1<br>Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: got thid 3078917008 path /- stat 0<br>Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: sigchld: exp 3078917008 finished, switching from 2 to 1<br>
<br>[root@mistral log]$ automount --version<br>Linux automount version 5.0.1-0.rc2.88<br><br>Directories:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config dir:&nbsp;&nbsp;&nbsp;&nbsp; /etc/sysconfig<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; maps dir:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /etc<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; modules dir:&nbsp;&nbsp;&nbsp; /usr/lib/autofs<br>
<br>Compile options:<br>&nbsp; DISABLE_MOUNT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS WITH_HESIOD WITH_LDAP <br>&nbsp; WITH_SASL <br><br>The /etc/sysconfig/autofs file contains all default entries.<br><br>thank you<br>Darren<br><br>[root@mistral log]$ cat /proc/version <br>
Linux version 2.6.18-53.1.21.el5 (<a href="mailto:brewbuilder@ls20-bc2-13.build.redhat.com">brewbuilder@ls20-bc2-13.build.redhat.com</a>) (gcc version 4.1.2 20070626 (Red Hat 4.1.2-14)) #1 SMP Wed May 7 08:42:13 EDT 2008<br>
<br>[root@mistral log]$ cat /etc/auto.home<br>*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -fstype=nfs,rw,intr,retry=3,async,noatime&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zephyr.nbmg:/mnt/vg01/home/&amp;<br><br><br>[root@mistral log]$ cat /etc/auto.data<br>/data/chin1&nbsp;&nbsp;&nbsp;&nbsp; -fstype=nfs,rw,intr,retry=3,async,noatime&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chinook.nbmg:/export/chin1<br>
/data/mistral1&nbsp; -fstype=nfs,rw,intr,retry=3,async,noatime&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mistral.nbmg:/export/mistral1<br>/data/diablo1&nbsp;&nbsp; -fstype=nfs,rw,intr,retry=3,async,noatime&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diablo.nbmg:/export/diablo1<br>/data/zephyr1&nbsp;&nbsp; -fstype=nfs,rw,intr,retry=3,async,noatime&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zephyr.nbmg:/mnt/vg00/data/zephyr1<br>
<br><br>[root@mistral log]$ cat /etc/auto.master<br>#<br># $Id: auto.master,v 1.3 2003/09/29 08:22:35 raven Exp $<br>#<br># Sample auto.master file<br># This is an automounter map and it has the following format<br># key [ -mount-options-separated-by-comma ] location<br>
# For details of the format look at autofs(5).<br>#/media /etc/auto.misc --timeout=10<br>#/net&nbsp;&nbsp; /etc/<a href="http://auto.net">auto.net</a><br>/home/users&nbsp;&nbsp;&nbsp;&nbsp; /etc/auto.home --timeout=120<br>/-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /etc/auto.data --timeout=120<br>
<br><br>

------=_Part_14959_27337822.1214627727304--


--===============6170423565898154511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6170423565898154511==--

