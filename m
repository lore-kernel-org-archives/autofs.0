From: Farkas Levente <lfarkas@bppiac.hu>
Subject: Re: automount never umount
Date: Thu, 24 Nov 2005 11:05:09 +0100
Message-ID: <43859055.3020508@bppiac.hu>
References: <4381E865.4070908@bppiac.hu>	<Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>	<4382E835.3020904@bppiac.hu>	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>	<438344F7.8020503@bppiac.hu>	<17283.19512.49399.338448@segfault.boston.redhat.com>	<43838CA9.40105@bppiac.hu>	<17283.46783.748916.772469@segfault.boston.redhat.com>	<438435EF.6080102@bppiac.hu>	<Pine.LNX.4.63.0511232105320.3200@donald.themaw.net>	<43846C1C.3050305@bppiac.hu>	<17284.35467.301318.255602@segfault.boston.redhat.com>	<Pine.LNX.4.63.0511232334300.3253@donald.themaw.net>	<17284.40834.559604.943290@segfault.boston.redhat.com>	<4384A354.9040502@bppiac.hu>
	<17284.41971.660257.356263@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010600080101060507040400"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17284.41971.660257.356263@segfault.boston.redhat.com>
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
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

This is a multi-part message in MIME format.
--------------010600080101060507040400
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jeff Moyer wrote:
> lfarkas> a full lsof ? fuser -v for what?
> 
> For the mount points in question.  I guess something like:
> 
> fuser -v -m <automountpoint>
> 
> lsof +D <automountpoint>

ok now i use only nfs and no smbfs, uprgade to
kernel-2.6.14-1.1641_FC4.jmoyertest.2 but it doesn't show me any
difference. so here is the current daemon log and that's all:-(
-------------------------------
[root@garfield ~]# fuser -v -m /net/

                     USER        PID ACCESS COMMAND
/net/                root       1919 f....  automount
[root@garfield ~]# lsof +D /net/
COMMAND    PID USER   FD   TYPE DEVICE SIZE NODE NAME
automount 1919 root    5r   DIR   0,20    0 5471 /net/
-------------------------------
new tips?

ps. the main problem when i wake up you stiull sleep, and when you
answer i almost go home...


-- 
  Levente                               "Si vis pacem para bellum!"

--------------010600080101060507040400
Content-Type: text/plain;
 name="daemon"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="daemon"

Nov 24 10:52:02 garfield rpc.statd[1740]: Version 1.0.7 Starting
Nov 24 10:52:05 garfield automount[1917]: starting automounter version 4.1.4-5, path = /smb, maptype = program, mapname = /etc/auto.smb
Nov 24 10:52:05 garfield automount[1919]: starting automounter version 4.1.4-5, path = /net, maptype = program, mapname = /etc/auto.net
Nov 24 10:52:05 garfield automount[1917]: mount(bind): bind_works = 1 
Nov 24 10:52:05 garfield automount[1919]: mount(bind): bind_works = 1 
Nov 24 10:52:05 garfield smartd[1945]: smartd version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce Allen 
Nov 24 10:52:05 garfield automount[1917]: using kernel protocol version 4.07
Nov 24 10:52:05 garfield automount[1919]: using kernel protocol version 4.07
Nov 24 10:52:05 garfield smartd[1945]: Home page is http://smartmontools.sourceforge.net/  
Nov 24 10:52:05 garfield automount[1917]: using timeout 60 seconds; freq 15 secs
Nov 24 10:52:05 garfield automount[1919]: using timeout 60 seconds; freq 15 secs
Nov 24 10:52:05 garfield smartd[1945]: Opened configuration file /etc/smartd.conf 
Nov 24 10:52:06 garfield smartd[1945]: Configuration file /etc/smartd.conf parsed. 
Nov 24 10:52:06 garfield smartd[1945]: Device: /dev/hda, opened 
Nov 24 10:52:06 garfield smartd[1945]: Device: /dev/hda, found in smartd database. 
Nov 24 10:52:06 garfield smartd[1945]: Device: /dev/hda, is SMART capable. Adding to "monitor" list. 
Nov 24 10:52:06 garfield smartd[1945]: Monitoring 1 ATA and 0 SCSI devices 
Nov 24 10:52:06 garfield smartd[1951]: smartd has fork()ed into background mode. New PID=1951. 
Nov 24 10:52:07 garfield ntpdate[1980]: step time server 192.168.0.2 offset -0.470773 sec
Nov 24 10:52:07 garfield ntpd[1986]: ntpd 4.2.0a@1.1190-r Thu Apr 14 07:47:25 EDT 2005 (1)
Nov 24 10:52:07 garfield ntpd[1986]: precision = 1.000 usec
Nov 24 10:52:07 garfield ntpd[1986]: Listening on interface wildcard, 0.0.0.0#123
Nov 24 10:52:08 garfield ntpd[1986]: Listening on interface lo, 127.0.0.1#123
Nov 24 10:52:08 garfield ntpd[1986]: Listening on interface eth0, 192.168.0.50#123
Nov 24 10:52:08 garfield ntpd[1986]: kernel time sync status 0040
Nov 24 10:52:08 garfield ntpd[1986]: frequency initialized -12.994 PPM from /var/lib/ntp/drift
Nov 24 10:52:32 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:52:32 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:52:32 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:52:32 garfield automount[1917]: expire_proc: exp_proc=2536
Nov 24 10:52:32 garfield automount[1917]: handle_child: got pid 2536, sig 0 (0), stat 0 
Nov 24 10:52:32 garfield automount[1917]: sigchld: exp 2536 finished, switching from 2 to 1
Nov 24 10:52:32 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:52:32 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:52:34 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:52:34 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:52:34 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:52:34 garfield automount[1919]: expire_proc: exp_proc=2537
Nov 24 10:52:34 garfield automount[1919]: handle_child: got pid 2537, sig 0 (0), stat 0 
Nov 24 10:52:34 garfield automount[1919]: sigchld: exp 2537 finished, switching from 2 to 1
Nov 24 10:52:34 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:52:34 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:52:47 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:52:47 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:52:47 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:52:47 garfield automount[1917]: expire_proc: exp_proc=2543
Nov 24 10:52:47 garfield automount[1917]: handle_child: got pid 2543, sig 0 (0), stat 0 
Nov 24 10:52:47 garfield automount[1917]: sigchld: exp 2543 finished, switching from 2 to 1
Nov 24 10:52:47 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:52:47 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:52:49 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:52:49 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:52:49 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:52:49 garfield automount[1919]: expire_proc: exp_proc=2544
Nov 24 10:52:49 garfield automount[1919]: handle_child: got pid 2544, sig 0 (0), stat 0 
Nov 24 10:52:49 garfield automount[1919]: sigchld: exp 2544 finished, switching from 2 to 1
Nov 24 10:52:49 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:52:49 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:53:02 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:53:02 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:53:02 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:53:02 garfield automount[1917]: expire_proc: exp_proc=2545
Nov 24 10:53:02 garfield automount[1917]: handle_child: got pid 2545, sig 0 (0), stat 0 
Nov 24 10:53:02 garfield automount[1917]: sigchld: exp 2545 finished, switching from 2 to 1
Nov 24 10:53:02 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:53:02 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:53:04 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:53:04 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:53:04 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:53:04 garfield automount[1919]: expire_proc: exp_proc=2546
Nov 24 10:53:04 garfield automount[1919]: handle_child: got pid 2546, sig 0 (0), stat 0 
Nov 24 10:53:04 garfield automount[1919]: sigchld: exp 2546 finished, switching from 2 to 1
Nov 24 10:53:04 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:53:04 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:53:17 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:53:17 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:53:17 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:53:17 garfield automount[1917]: expire_proc: exp_proc=2547
Nov 24 10:53:17 garfield automount[1917]: handle_child: got pid 2547, sig 0 (0), stat 0 
Nov 24 10:53:17 garfield automount[1917]: sigchld: exp 2547 finished, switching from 2 to 1
Nov 24 10:53:17 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:53:17 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:53:19 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:53:19 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:53:19 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:53:19 garfield automount[1919]: expire_proc: exp_proc=2548
Nov 24 10:53:19 garfield automount[1919]: handle_child: got pid 2548, sig 0 (0), stat 0 
Nov 24 10:53:19 garfield automount[1919]: sigchld: exp 2548 finished, switching from 2 to 1
Nov 24 10:53:19 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:53:19 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:53:32 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:53:32 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:53:32 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:53:32 garfield automount[1917]: expire_proc: exp_proc=2549
Nov 24 10:53:32 garfield automount[1917]: handle_child: got pid 2549, sig 0 (0), stat 0 
Nov 24 10:53:32 garfield automount[1917]: sigchld: exp 2549 finished, switching from 2 to 1
Nov 24 10:53:32 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:53:32 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:53:34 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:53:34 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:53:34 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:53:34 garfield automount[1919]: expire_proc: exp_proc=2550
Nov 24 10:53:34 garfield automount[1919]: handle_child: got pid 2550, sig 0 (0), stat 0 
Nov 24 10:53:34 garfield automount[1919]: sigchld: exp 2550 finished, switching from 2 to 1
Nov 24 10:53:34 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:53:34 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:53:47 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:53:47 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:53:47 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:53:47 garfield automount[1917]: expire_proc: exp_proc=2551
Nov 24 10:53:47 garfield automount[1917]: handle_child: got pid 2551, sig 0 (0), stat 0 
Nov 24 10:53:47 garfield automount[1917]: sigchld: exp 2551 finished, switching from 2 to 1
Nov 24 10:53:47 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:53:47 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:53:49 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:53:49 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:53:49 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:53:49 garfield automount[1919]: expire_proc: exp_proc=2552
Nov 24 10:53:49 garfield automount[1919]: handle_child: got pid 2552, sig 0 (0), stat 0 
Nov 24 10:53:49 garfield automount[1919]: sigchld: exp 2552 finished, switching from 2 to 1
Nov 24 10:53:49 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:53:49 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:54:02 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:54:02 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:54:02 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:54:02 garfield automount[1917]: expire_proc: exp_proc=2553
Nov 24 10:54:02 garfield automount[1917]: handle_child: got pid 2553, sig 0 (0), stat 0 
Nov 24 10:54:02 garfield automount[1917]: sigchld: exp 2553 finished, switching from 2 to 1
Nov 24 10:54:02 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:54:02 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:54:04 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:54:04 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:54:04 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:54:04 garfield automount[1919]: expire_proc: exp_proc=2554
Nov 24 10:54:04 garfield automount[1919]: handle_child: got pid 2554, sig 0 (0), stat 0 
Nov 24 10:54:04 garfield automount[1919]: sigchld: exp 2554 finished, switching from 2 to 1
Nov 24 10:54:04 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:54:04 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:54:17 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:54:17 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:54:17 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:54:17 garfield automount[1917]: expire_proc: exp_proc=2555
Nov 24 10:54:17 garfield automount[1917]: handle_child: got pid 2555, sig 0 (0), stat 0 
Nov 24 10:54:17 garfield automount[1917]: sigchld: exp 2555 finished, switching from 2 to 1
Nov 24 10:54:17 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:54:17 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:54:19 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:54:19 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:54:19 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:54:19 garfield automount[1919]: expire_proc: exp_proc=2556
Nov 24 10:54:19 garfield automount[1919]: handle_child: got pid 2556, sig 0 (0), stat 0 
Nov 24 10:54:19 garfield automount[1919]: sigchld: exp 2556 finished, switching from 2 to 1
Nov 24 10:54:19 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:54:19 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:54:32 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:54:32 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:54:32 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:54:32 garfield automount[1917]: expire_proc: exp_proc=2557
Nov 24 10:54:32 garfield automount[1917]: handle_child: got pid 2557, sig 0 (0), stat 0 
Nov 24 10:54:32 garfield automount[1917]: sigchld: exp 2557 finished, switching from 2 to 1
Nov 24 10:54:32 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:54:32 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:54:34 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:54:34 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:54:34 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:54:34 garfield automount[1919]: expire_proc: exp_proc=2558
Nov 24 10:54:34 garfield automount[1919]: handle_child: got pid 2558, sig 0 (0), stat 0 
Nov 24 10:54:34 garfield automount[1919]: sigchld: exp 2558 finished, switching from 2 to 1
Nov 24 10:54:34 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:54:34 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:54:47 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:54:47 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:54:47 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:54:47 garfield automount[1917]: expire_proc: exp_proc=2559
Nov 24 10:54:47 garfield automount[1917]: handle_child: got pid 2559, sig 0 (0), stat 0 
Nov 24 10:54:47 garfield automount[1917]: sigchld: exp 2559 finished, switching from 2 to 1
Nov 24 10:54:47 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:54:47 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:54:49 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:54:49 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:54:49 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:54:49 garfield automount[1919]: expire_proc: exp_proc=2560
Nov 24 10:54:49 garfield automount[1919]: handle_child: got pid 2560, sig 0 (0), stat 0 
Nov 24 10:54:49 garfield automount[1919]: sigchld: exp 2560 finished, switching from 2 to 1
Nov 24 10:54:49 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:54:49 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:55:02 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:55:02 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:55:02 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:55:02 garfield automount[1917]: expire_proc: exp_proc=2561
Nov 24 10:55:02 garfield automount[1917]: handle_child: got pid 2561, sig 0 (0), stat 0 
Nov 24 10:55:02 garfield automount[1917]: sigchld: exp 2561 finished, switching from 2 to 1
Nov 24 10:55:02 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:55:02 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:55:04 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:55:04 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:55:04 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:55:04 garfield automount[1919]: expire_proc: exp_proc=2562
Nov 24 10:55:04 garfield automount[1919]: handle_child: got pid 2562, sig 0 (0), stat 0 
Nov 24 10:55:04 garfield automount[1919]: sigchld: exp 2562 finished, switching from 2 to 1
Nov 24 10:55:04 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:55:04 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:55:17 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:55:17 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:55:17 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:55:17 garfield automount[1917]: expire_proc: exp_proc=2563
Nov 24 10:55:17 garfield automount[1917]: handle_child: got pid 2563, sig 0 (0), stat 0 
Nov 24 10:55:17 garfield automount[1917]: sigchld: exp 2563 finished, switching from 2 to 1
Nov 24 10:55:17 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:55:17 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:55:19 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:55:19 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:55:19 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:55:19 garfield automount[1919]: expire_proc: exp_proc=2564
Nov 24 10:55:19 garfield automount[1919]: handle_child: got pid 2564, sig 0 (0), stat 0 
Nov 24 10:55:19 garfield automount[1919]: sigchld: exp 2564 finished, switching from 2 to 1
Nov 24 10:55:19 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:55:19 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:55:25 garfield ntpd[1986]: synchronized to LOCAL(0), stratum 10
Nov 24 10:55:25 garfield ntpd[1986]: kernel time sync disabled 0041
Nov 24 10:55:32 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:55:32 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:55:32 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:55:32 garfield automount[1917]: expire_proc: exp_proc=2565
Nov 24 10:55:32 garfield automount[1917]: handle_child: got pid 2565, sig 0 (0), stat 0 
Nov 24 10:55:32 garfield automount[1917]: sigchld: exp 2565 finished, switching from 2 to 1
Nov 24 10:55:32 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:55:32 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:55:34 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:55:34 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:55:34 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:55:34 garfield automount[1919]: expire_proc: exp_proc=2566
Nov 24 10:55:34 garfield automount[1919]: handle_child: got pid 2566, sig 0 (0), stat 0 
Nov 24 10:55:34 garfield automount[1919]: sigchld: exp 2566 finished, switching from 2 to 1
Nov 24 10:55:34 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:55:34 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:55:47 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:55:47 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:55:47 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:55:47 garfield automount[1917]: expire_proc: exp_proc=2567
Nov 24 10:55:47 garfield automount[1917]: handle_child: got pid 2567, sig 0 (0), stat 0 
Nov 24 10:55:47 garfield automount[1917]: sigchld: exp 2567 finished, switching from 2 to 1
Nov 24 10:55:47 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:55:47 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:55:49 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:55:49 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:55:49 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:55:49 garfield automount[1919]: expire_proc: exp_proc=2568
Nov 24 10:55:49 garfield automount[1919]: handle_child: got pid 2568, sig 0 (0), stat 0 
Nov 24 10:55:49 garfield automount[1919]: sigchld: exp 2568 finished, switching from 2 to 1
Nov 24 10:55:49 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:55:49 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:56:02 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:56:02 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:56:02 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:56:02 garfield automount[1917]: expire_proc: exp_proc=2569
Nov 24 10:56:02 garfield automount[1917]: handle_child: got pid 2569, sig 0 (0), stat 0 
Nov 24 10:56:02 garfield automount[1917]: sigchld: exp 2569 finished, switching from 2 to 1
Nov 24 10:56:02 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:56:02 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:56:04 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:56:04 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:56:04 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:56:04 garfield automount[1919]: expire_proc: exp_proc=2570
Nov 24 10:56:04 garfield automount[1919]: handle_child: got pid 2570, sig 0 (0), stat 0 
Nov 24 10:56:04 garfield automount[1919]: sigchld: exp 2570 finished, switching from 2 to 1
Nov 24 10:56:04 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:56:04 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:56:17 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:56:17 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:56:17 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:56:17 garfield automount[1917]: expire_proc: exp_proc=2571
Nov 24 10:56:17 garfield automount[1917]: handle_child: got pid 2571, sig 0 (0), stat 0 
Nov 24 10:56:17 garfield automount[1917]: sigchld: exp 2571 finished, switching from 2 to 1
Nov 24 10:56:17 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:56:17 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:56:19 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:56:19 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:56:19 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:56:19 garfield automount[1919]: expire_proc: exp_proc=2572
Nov 24 10:56:19 garfield automount[1919]: handle_child: got pid 2572, sig 0 (0), stat 0 
Nov 24 10:56:19 garfield automount[1919]: sigchld: exp 2572 finished, switching from 2 to 1
Nov 24 10:56:19 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:56:19 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:56:28 garfield ntpd[1986]: synchronized to 192.168.1.3, stratum 3
Nov 24 10:56:32 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:56:32 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:56:32 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:56:32 garfield automount[1917]: expire_proc: exp_proc=2710
Nov 24 10:56:32 garfield automount[1917]: handle_child: got pid 2710, sig 0 (0), stat 0 
Nov 24 10:56:32 garfield automount[1917]: sigchld: exp 2710 finished, switching from 2 to 1
Nov 24 10:56:32 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:56:32 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:56:34 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:56:34 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:56:34 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:56:34 garfield automount[1919]: expire_proc: exp_proc=2719
Nov 24 10:56:34 garfield automount[1919]: handle_child: got pid 2719, sig 0 (0), stat 0 
Nov 24 10:56:34 garfield automount[1919]: sigchld: exp 2719 finished, switching from 2 to 1
Nov 24 10:56:34 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:56:34 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:56:47 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:56:47 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:56:47 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:56:47 garfield automount[1917]: expire_proc: exp_proc=2765
Nov 24 10:56:47 garfield automount[1917]: handle_child: got pid 2765, sig 0 (0), stat 0 
Nov 24 10:56:47 garfield automount[1917]: sigchld: exp 2765 finished, switching from 2 to 1
Nov 24 10:56:47 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:56:47 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:56:49 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:56:49 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:56:49 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:56:49 garfield automount[1919]: expire_proc: exp_proc=2766
Nov 24 10:56:49 garfield automount[1919]: handle_child: got pid 2766, sig 0 (0), stat 0 
Nov 24 10:56:49 garfield automount[1919]: sigchld: exp 2766 finished, switching from 2 to 1
Nov 24 10:56:49 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:56:49 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:57:02 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:57:02 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:57:02 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:57:02 garfield automount[1917]: expire_proc: exp_proc=2785
Nov 24 10:57:02 garfield automount[1917]: handle_child: got pid 2785, sig 0 (0), stat 0 
Nov 24 10:57:02 garfield automount[1917]: sigchld: exp 2785 finished, switching from 2 to 1
Nov 24 10:57:02 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:57:02 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:57:04 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:57:04 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:57:04 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:57:04 garfield automount[1919]: expire_proc: exp_proc=2793
Nov 24 10:57:04 garfield automount[1919]: handle_child: got pid 2793, sig 0 (0), stat 0 
Nov 24 10:57:04 garfield automount[1919]: sigchld: exp 2793 finished, switching from 2 to 1
Nov 24 10:57:04 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:57:04 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:57:10 garfield automount[1919]: handle_packet: type = 0 
Nov 24 10:57:10 garfield automount[1919]: handle_packet_missing: token 1, name mirror 
Nov 24 10:57:10 garfield automount[1919]: attempting to mount entry /net/mirror
Nov 24 10:57:10 garfield automount[2795]: lookup(program): looking up mirror
Nov 24 10:57:10 garfield automount[2795]: lookup(program): mirror -> -fstype=nfs,hard,intr,nodev,nosuid  	/mnt/md2/download mirror:/mnt/md2/download
Nov 24 10:57:10 garfield automount[2795]: parse(sun): expanded entry: -fstype=nfs,hard,intr,nodev,nosuid  	/mnt/md2/download mirror:/mnt/md2/download
Nov 24 10:57:10 garfield automount[2795]: parse(sun): dequote("fstype=nfs,hard,intr,nodev,nosuid") -> fstype=nfs,hard,intr,nodev,nosuid
Nov 24 10:57:10 garfield automount[2795]: parse(sun): gathered options: fstype=nfs,hard,intr,nodev,nosuid
Nov 24 10:57:10 garfield automount[2795]: parse(sun): dequote("/mnt/md2/download") -> /mnt/md2/download
Nov 24 10:57:10 garfield automount[2795]: parse(sun): dequote("mirror:/mnt/md2/download") -> mirror:/mnt/md2/download
Nov 24 10:57:10 garfield automount[2795]: parse(sun): multimount: mirror:/mnt/md2/download on /mnt/md2/download with options fstype=nfs,hard,intr,nodev,nosuid
Nov 24 10:57:10 garfield automount[2795]: parse(sun): mounting root /net/mirror, mountpoint mnt/md2/download, what mirror:/mnt/md2/download, fstype nfs, options hard,intr,nodev,nosuid 
Nov 24 10:57:10 garfield automount[2795]: mount(nfs): root=/net/mirror name=mnt/md2/download what=mirror:/mnt/md2/download, fstype=nfs, options=hard,intr,nodev,nosuid
Nov 24 10:57:10 garfield automount[2795]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
Nov 24 10:57:10 garfield automount[2795]: mount(nfs): is_local_mount: mirror
Nov 24 10:57:10 garfield automount[2795]: mount(nfs): winner = mirror local = 0
Nov 24 10:57:10 garfield automount[2795]: mount(nfs): all hosts timed out for 'mirror:/mnt/md2/download', retrying with longer timeout
Nov 24 10:57:10 garfield automount[2795]: mount(nfs): winner = mirror local = 0
Nov 24 10:57:10 garfield automount[2795]: mount(nfs): from mirror:/mnt/md2/download elected mirror:/mnt/md2/download
Nov 24 10:57:10 garfield automount[2795]: mount(nfs): calling mkdir_path /net/mirror/mnt/md2/download
Nov 24 10:57:10 garfield automount[2795]: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid mirror:/mnt/md2/download /net/mirror/mnt/md2/download
Nov 24 10:57:10 garfield automount[2795]: mount(nfs): mounted mirror:/mnt/md2/download on /net/mirror/mnt/md2/download
Nov 24 10:57:10 garfield automount[1919]: handle_child: got pid 2795, sig 0 (0), stat 0 
Nov 24 10:57:10 garfield automount[1919]: sig_child: found pending iop pid 2795: signalled 0 (sig 0), exit status 0
Nov 24 10:57:10 garfield automount[1919]: send_ready: token=1 
Nov 24 10:57:17 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:57:17 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:57:17 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:57:17 garfield automount[1917]: expire_proc: exp_proc=2811
Nov 24 10:57:17 garfield automount[1917]: handle_child: got pid 2811, sig 0 (0), stat 0 
Nov 24 10:57:17 garfield automount[1917]: sigchld: exp 2811 finished, switching from 2 to 1
Nov 24 10:57:17 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:57:17 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:57:19 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:57:19 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:57:19 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:57:19 garfield automount[1919]: expire_proc: exp_proc=2812
Nov 24 10:57:19 garfield automount[2812]: expire_proc: 1 remaining in /net 
Nov 24 10:57:19 garfield automount[1919]: handle_child: got pid 2812, sig 0 (0), stat 1 
Nov 24 10:57:19 garfield automount[1919]: sigchld: exp 2812 finished, switching from 2 to 1
Nov 24 10:57:19 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:57:19 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:57:32 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:57:32 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:57:32 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:57:32 garfield automount[1917]: expire_proc: exp_proc=2814
Nov 24 10:57:32 garfield automount[1917]: handle_child: got pid 2814, sig 0 (0), stat 0 
Nov 24 10:57:32 garfield automount[1917]: sigchld: exp 2814 finished, switching from 2 to 1
Nov 24 10:57:32 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:57:32 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:57:34 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:57:34 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:57:34 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:57:34 garfield automount[1919]: expire_proc: exp_proc=2816
Nov 24 10:57:34 garfield automount[2816]: expire_proc: 1 remaining in /net 
Nov 24 10:57:34 garfield automount[1919]: handle_child: got pid 2816, sig 0 (0), stat 1 
Nov 24 10:57:34 garfield automount[1919]: sigchld: exp 2816 finished, switching from 2 to 1
Nov 24 10:57:34 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:57:34 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:57:47 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:57:47 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:57:47 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:57:47 garfield automount[1917]: expire_proc: exp_proc=2846
Nov 24 10:57:47 garfield automount[1917]: handle_child: got pid 2846, sig 0 (0), stat 0 
Nov 24 10:57:47 garfield automount[1917]: sigchld: exp 2846 finished, switching from 2 to 1
Nov 24 10:57:47 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:57:47 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:57:49 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:57:49 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:57:49 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:57:49 garfield automount[1919]: expire_proc: exp_proc=2849
Nov 24 10:57:49 garfield automount[2849]: expire_proc: 1 remaining in /net 
Nov 24 10:57:49 garfield automount[1919]: handle_child: got pid 2849, sig 0 (0), stat 1 
Nov 24 10:57:49 garfield automount[1919]: sigchld: exp 2849 finished, switching from 2 to 1
Nov 24 10:57:49 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:57:49 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:58:02 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:58:02 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:58:02 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:58:02 garfield automount[1917]: expire_proc: exp_proc=2856
Nov 24 10:58:02 garfield automount[1917]: handle_child: got pid 2856, sig 0 (0), stat 0 
Nov 24 10:58:02 garfield automount[1917]: sigchld: exp 2856 finished, switching from 2 to 1
Nov 24 10:58:02 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:58:02 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:58:04 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:58:04 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:58:04 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:58:04 garfield automount[1919]: expire_proc: exp_proc=2857
Nov 24 10:58:04 garfield automount[2857]: expire_proc: 1 remaining in /net 
Nov 24 10:58:04 garfield automount[1919]: handle_child: got pid 2857, sig 0 (0), stat 1 
Nov 24 10:58:04 garfield automount[1919]: sigchld: exp 2857 finished, switching from 2 to 1
Nov 24 10:58:04 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:58:04 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:58:17 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:58:17 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:58:17 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:58:17 garfield automount[1917]: expire_proc: exp_proc=2858
Nov 24 10:58:17 garfield automount[1917]: handle_child: got pid 2858, sig 0 (0), stat 0 
Nov 24 10:58:17 garfield automount[1917]: sigchld: exp 2858 finished, switching from 2 to 1
Nov 24 10:58:17 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:58:17 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:58:19 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:58:19 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:58:19 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:58:19 garfield automount[1919]: expire_proc: exp_proc=2859
Nov 24 10:58:19 garfield automount[2859]: expire_proc: 1 remaining in /net 
Nov 24 10:58:19 garfield automount[1919]: handle_child: got pid 2859, sig 0 (0), stat 1 
Nov 24 10:58:19 garfield automount[1919]: sigchld: exp 2859 finished, switching from 2 to 1
Nov 24 10:58:19 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:58:19 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:58:32 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:58:32 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:58:32 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:58:32 garfield automount[1917]: expire_proc: exp_proc=2860
Nov 24 10:58:32 garfield automount[1917]: handle_child: got pid 2860, sig 0 (0), stat 0 
Nov 24 10:58:32 garfield automount[1917]: sigchld: exp 2860 finished, switching from 2 to 1
Nov 24 10:58:32 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:58:32 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:58:34 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:58:34 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:58:34 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:58:34 garfield automount[1919]: expire_proc: exp_proc=2861
Nov 24 10:58:34 garfield automount[2861]: expire_proc: 1 remaining in /net 
Nov 24 10:58:34 garfield automount[1919]: handle_child: got pid 2861, sig 0 (0), stat 1 
Nov 24 10:58:34 garfield automount[1919]: sigchld: exp 2861 finished, switching from 2 to 1
Nov 24 10:58:34 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:58:34 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:58:47 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:58:47 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:58:47 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:58:47 garfield automount[1917]: expire_proc: exp_proc=2862
Nov 24 10:58:47 garfield automount[1917]: handle_child: got pid 2862, sig 0 (0), stat 0 
Nov 24 10:58:47 garfield automount[1917]: sigchld: exp 2862 finished, switching from 2 to 1
Nov 24 10:58:47 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:58:47 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:58:49 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:58:49 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:58:49 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:58:49 garfield automount[1919]: expire_proc: exp_proc=2863
Nov 24 10:58:49 garfield automount[2863]: expire_proc: 1 remaining in /net 
Nov 24 10:58:49 garfield automount[1919]: handle_child: got pid 2863, sig 0 (0), stat 1 
Nov 24 10:58:49 garfield automount[1919]: sigchld: exp 2863 finished, switching from 2 to 1
Nov 24 10:58:49 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:58:49 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:59:02 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:59:02 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:59:02 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:59:02 garfield automount[1917]: expire_proc: exp_proc=2865
Nov 24 10:59:02 garfield automount[1917]: handle_child: got pid 2865, sig 0 (0), stat 0 
Nov 24 10:59:02 garfield automount[1917]: sigchld: exp 2865 finished, switching from 2 to 1
Nov 24 10:59:02 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:59:02 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:59:04 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:59:04 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:59:04 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:59:04 garfield automount[1919]: expire_proc: exp_proc=2867
Nov 24 10:59:04 garfield automount[2867]: expire_proc: 1 remaining in /net 
Nov 24 10:59:04 garfield automount[1919]: handle_child: got pid 2867, sig 0 (0), stat 1 
Nov 24 10:59:04 garfield automount[1919]: sigchld: exp 2867 finished, switching from 2 to 1
Nov 24 10:59:04 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:59:04 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:59:17 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:59:17 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:59:17 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:59:17 garfield automount[1917]: expire_proc: exp_proc=2868
Nov 24 10:59:17 garfield automount[1917]: handle_child: got pid 2868, sig 0 (0), stat 0 
Nov 24 10:59:17 garfield automount[1917]: sigchld: exp 2868 finished, switching from 2 to 1
Nov 24 10:59:17 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:59:17 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:59:19 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:59:20 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:59:20 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:59:20 garfield automount[1919]: expire_proc: exp_proc=2870
Nov 24 10:59:20 garfield automount[2870]: expire_proc: 1 remaining in /net 
Nov 24 10:59:20 garfield automount[1919]: handle_child: got pid 2870, sig 0 (0), stat 1 
Nov 24 10:59:20 garfield automount[1919]: sigchld: exp 2870 finished, switching from 2 to 1
Nov 24 10:59:20 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:59:20 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:59:32 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:59:32 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:59:32 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:59:32 garfield automount[1917]: expire_proc: exp_proc=2942
Nov 24 10:59:32 garfield automount[1917]: handle_child: got pid 2942, sig 0 (0), stat 0 
Nov 24 10:59:32 garfield automount[1917]: sigchld: exp 2942 finished, switching from 2 to 1
Nov 24 10:59:32 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:59:32 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:59:35 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:59:35 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:59:35 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:59:35 garfield automount[2943]: expire_proc: 1 remaining in /net 
Nov 24 10:59:35 garfield automount[1919]: expire_proc: exp_proc=2943
Nov 24 10:59:40 garfield automount[1919]: handle_child: got pid 2943, sig 0 (0), stat 1 
Nov 24 10:59:40 garfield automount[1919]: sigchld: exp 2943 finished, switching from 2 to 1
Nov 24 10:59:40 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:59:40 garfield automount[1919]: st_ready(): state = 2 
Nov 24 10:59:47 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 10:59:47 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 10:59:47 garfield automount[1917]: st_expire(): state = 1 
Nov 24 10:59:47 garfield automount[1917]: expire_proc: exp_proc=2944
Nov 24 10:59:47 garfield automount[1917]: handle_child: got pid 2944, sig 0 (0), stat 0 
Nov 24 10:59:47 garfield automount[1917]: sigchld: exp 2944 finished, switching from 2 to 1
Nov 24 10:59:47 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 10:59:47 garfield automount[1917]: st_ready(): state = 2 
Nov 24 10:59:55 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 10:59:55 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 10:59:55 garfield automount[1919]: st_expire(): state = 1 
Nov 24 10:59:55 garfield automount[1919]: expire_proc: exp_proc=2945
Nov 24 10:59:55 garfield automount[2945]: expire_proc: 1 remaining in /net 
Nov 24 10:59:55 garfield automount[1919]: handle_child: got pid 2945, sig 0 (0), stat 1 
Nov 24 10:59:55 garfield automount[1919]: sigchld: exp 2945 finished, switching from 2 to 1
Nov 24 10:59:55 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 10:59:55 garfield automount[1919]: st_ready(): state = 2 
Nov 24 11:00:02 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 11:00:02 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 11:00:02 garfield automount[1917]: st_expire(): state = 1 
Nov 24 11:00:02 garfield automount[1917]: expire_proc: exp_proc=2949
Nov 24 11:00:02 garfield automount[1917]: handle_child: got pid 2949, sig 0 (0), stat 0 
Nov 24 11:00:02 garfield automount[1917]: sigchld: exp 2949 finished, switching from 2 to 1
Nov 24 11:00:02 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 11:00:02 garfield automount[1917]: st_ready(): state = 2 
Nov 24 11:00:10 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 11:00:10 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 11:00:10 garfield automount[1919]: st_expire(): state = 1 
Nov 24 11:00:10 garfield automount[1919]: expire_proc: exp_proc=2950
Nov 24 11:00:10 garfield automount[2950]: expire_proc: 1 remaining in /net 
Nov 24 11:00:10 garfield automount[1919]: handle_child: got pid 2950, sig 0 (0), stat 1 
Nov 24 11:00:10 garfield automount[1919]: sigchld: exp 2950 finished, switching from 2 to 1
Nov 24 11:00:10 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 11:00:10 garfield automount[1919]: st_ready(): state = 2 
Nov 24 11:00:17 garfield automount[1917]: sig 14 switching from 1 to 2
Nov 24 11:00:17 garfield automount[1917]: get_pkt: state 1, next 2
Nov 24 11:00:17 garfield automount[1917]: st_expire(): state = 1 
Nov 24 11:00:17 garfield automount[1917]: expire_proc: exp_proc=2951
Nov 24 11:00:17 garfield automount[1917]: handle_child: got pid 2951, sig 0 (0), stat 0 
Nov 24 11:00:17 garfield automount[1917]: sigchld: exp 2951 finished, switching from 2 to 1
Nov 24 11:00:17 garfield automount[1917]: get_pkt: state 2, next 1
Nov 24 11:00:17 garfield automount[1917]: st_ready(): state = 2 
Nov 24 11:00:25 garfield automount[1919]: sig 14 switching from 1 to 2
Nov 24 11:00:25 garfield automount[1919]: get_pkt: state 1, next 2
Nov 24 11:00:25 garfield automount[1919]: st_expire(): state = 1 
Nov 24 11:00:25 garfield automount[1919]: expire_proc: exp_proc=2952
Nov 24 11:00:25 garfield automount[2952]: expire_proc: 1 remaining in /net 
Nov 24 11:00:25 garfield automount[1919]: handle_child: got pid 2952, sig 0 (0), stat 1 
Nov 24 11:00:25 garfield automount[1919]: sigchld: exp 2952 finished, switching from 2 to 1
Nov 24 11:00:25 garfield automount[1919]: get_pkt: state 2, next 1
Nov 24 11:00:25 garfield automount[1919]: st_ready(): state = 2 

--------------010600080101060507040400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------010600080101060507040400--

