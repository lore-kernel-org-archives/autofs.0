From: Farkas Levente <lfarkas@bppiac.hu>
Subject: Re: automount never umount
Date: Wed, 23 Nov 2005 10:27:11 +0100
Message-ID: <438435EF.6080102@bppiac.hu>
References: <4381E865.4070908@bppiac.hu>	<Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>	<4382E835.3020904@bppiac.hu>	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>	<438344F7.8020503@bppiac.hu>	<17283.19512.49399.338448@segfault.boston.redhat.com>	<43838CA9.40105@bppiac.hu>
	<17283.46783.748916.772469@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030506090004080305090307"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17283.46783.748916.772469@segfault.boston.redhat.com>
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
--------------030506090004080305090307
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jeff Moyer wrote:
> lfarkas> i'll happy to test it.
> 
> Try the kernel rpm located here:
> 
> 	http://people.redhat.com/jmoyer/farkas/kernel-2.6.14-1.1641_FC4.jmoyertest.1.i686.rpm
> 
> It has the potential to generate a good bit of output.  I've attached the
> patch that is incorporated there.  You'll want to post the output of dmesg
> to this list when you get it.

output of dmesg or /var/log/daemon? there is nothing in dmesg.
i'm running this kernel currently and mount nfs and smbfs servers.
---------------------------
root      1974  0.0  0.0   1788   736 ?        Ss   10:05   0:00
/usr/sbin/automount --timeout=60 --debug /smb program /etc/auto.smb
root      1976  0.0  0.0   1788   736 ?        Ss   10:05   0:00
/usr/sbin/automount --timeout=60 --debug /net program /etc/auto.net
---------------------------
how long should i wait? as the timeout is 1 minute, they should have to
be umounted, but not. here is the relevant part of daemon log which
don't tell me too much:-(

-- 
  Levente                               "Si vis pacem para bellum!"

--------------030506090004080305090307
Content-Type: text/plain;
 name="daemon"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="daemon"

Nov 23 10:05:42 garfield automount[1974]: starting automounter version 4.1.4-5, path = /smb, maptype = program, mapname = /etc/auto.smb
Nov 23 10:05:42 garfield automount[1976]: starting automounter version 4.1.4-5, path = /net, maptype = program, mapname = /etc/auto.net
Nov 23 10:05:42 garfield automount[1974]: mount(bind): bind_works = 1 
Nov 23 10:05:42 garfield automount[1976]: mount(bind): bind_works = 1 
Nov 23 10:05:42 garfield nscd: 1989 invalid persistent database file "/var/db/nscd/hosts": verification failed
Nov 23 10:05:43 garfield smartd[1996]: smartd version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce Allen 
Nov 23 10:05:43 garfield automount[1974]: using kernel protocol version 4.07
Nov 23 10:05:43 garfield automount[1976]: using kernel protocol version 4.07
Nov 23 10:05:43 garfield smartd[1996]: Home page is http://smartmontools.sourceforge.net/  
Nov 23 10:05:43 garfield automount[1974]: using timeout 60 seconds; freq 15 secs
Nov 23 10:05:43 garfield automount[1976]: using timeout 60 seconds; freq 15 secs
Nov 23 10:05:43 garfield smartd[1996]: Opened configuration file /etc/smartd.conf 
Nov 23 10:05:43 garfield smartd[1996]: Configuration file /etc/smartd.conf parsed. 
Nov 23 10:05:43 garfield smartd[1996]: Device: /dev/hda, opened 
Nov 23 10:05:43 garfield smartd[1996]: Device: /dev/hda, found in smartd database. 
Nov 23 10:05:43 garfield smartd[1996]: Device: /dev/hda, is SMART capable. Adding to "monitor" list. 
Nov 23 10:05:43 garfield smartd[1996]: Monitoring 1 ATA and 0 SCSI devices 
Nov 23 10:05:44 garfield smartd[2008]: smartd has fork()ed into background mode. New PID=2008. 
Nov 23 10:05:44 garfield ntpdate[2035]: step time server 192.168.0.2 offset -0.499336 sec
Nov 23 10:05:44 garfield ntpd[2043]: ntpd 4.2.0a@1.1190-r Thu Apr 14 07:47:25 EDT 2005 (1)
Nov 23 10:05:45 garfield ntpd[2043]: precision = 1.000 usec
Nov 23 10:05:45 garfield ntpd[2043]: Listening on interface wildcard, 0.0.0.0#123
Nov 23 10:05:45 garfield ntpd[2043]: Listening on interface lo, 127.0.0.1#123
Nov 23 10:05:45 garfield ntpd[2043]: Listening on interface eth0, 192.168.0.50#123
Nov 23 10:05:45 garfield ntpd[2043]: kernel time sync status 0040
Nov 23 10:05:45 garfield ntpd[2043]: frequency initialized -12.897 PPM from /var/lib/ntp/drift
Nov 23 10:06:06 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:06:06 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:06:06 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:06:06 garfield automount[1974]: expire_proc: exp_proc=2559
Nov 23 10:06:06 garfield automount[1974]: handle_child: got pid 2559, sig 0 (0), stat 0 
Nov 23 10:06:06 garfield automount[1974]: sigchld: exp 2559 finished, switching from 2 to 1
Nov 23 10:06:06 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:06:06 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:06:08 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:06:08 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:06:08 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:06:08 garfield automount[1976]: expire_proc: exp_proc=2580
Nov 23 10:06:08 garfield automount[1976]: handle_child: got pid 2580, sig 0 (0), stat 0 
Nov 23 10:06:08 garfield automount[1976]: sigchld: exp 2580 finished, switching from 2 to 1
Nov 23 10:06:08 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:06:08 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:06:21 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:06:21 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:06:21 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:06:21 garfield automount[1974]: expire_proc: exp_proc=2587
Nov 23 10:06:21 garfield automount[1974]: handle_child: got pid 2587, sig 0 (0), stat 0 
Nov 23 10:06:21 garfield automount[1974]: sigchld: exp 2587 finished, switching from 2 to 1
Nov 23 10:06:21 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:06:21 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:06:23 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:06:23 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:06:23 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:06:23 garfield automount[1976]: expire_proc: exp_proc=2588
Nov 23 10:06:23 garfield automount[1976]: handle_child: got pid 2588, sig 0 (0), stat 0 
Nov 23 10:06:23 garfield automount[1976]: sigchld: exp 2588 finished, switching from 2 to 1
Nov 23 10:06:23 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:06:23 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:06:36 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:06:36 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:06:36 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:06:36 garfield automount[1974]: expire_proc: exp_proc=2589
Nov 23 10:06:36 garfield automount[1974]: handle_child: got pid 2589, sig 0 (0), stat 0 
Nov 23 10:06:36 garfield automount[1974]: sigchld: exp 2589 finished, switching from 2 to 1
Nov 23 10:06:36 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:06:36 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:06:38 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:06:38 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:06:38 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:06:38 garfield automount[1976]: expire_proc: exp_proc=2590
Nov 23 10:06:38 garfield automount[1976]: handle_child: got pid 2590, sig 0 (0), stat 0 
Nov 23 10:06:38 garfield automount[1976]: sigchld: exp 2590 finished, switching from 2 to 1
Nov 23 10:06:38 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:06:38 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:06:51 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:06:51 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:06:51 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:06:51 garfield automount[1974]: expire_proc: exp_proc=2591
Nov 23 10:06:51 garfield automount[1974]: handle_child: got pid 2591, sig 0 (0), stat 0 
Nov 23 10:06:51 garfield automount[1974]: sigchld: exp 2591 finished, switching from 2 to 1
Nov 23 10:06:51 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:06:51 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:06:53 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:06:53 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:06:53 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:06:53 garfield automount[1976]: expire_proc: exp_proc=2592
Nov 23 10:06:53 garfield automount[1976]: handle_child: got pid 2592, sig 0 (0), stat 0 
Nov 23 10:06:53 garfield automount[1976]: sigchld: exp 2592 finished, switching from 2 to 1
Nov 23 10:06:53 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:06:53 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:07:06 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:07:06 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:07:06 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:07:06 garfield automount[1974]: expire_proc: exp_proc=2593
Nov 23 10:07:06 garfield automount[1974]: handle_child: got pid 2593, sig 0 (0), stat 0 
Nov 23 10:07:06 garfield automount[1974]: sigchld: exp 2593 finished, switching from 2 to 1
Nov 23 10:07:06 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:07:06 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:07:08 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:07:08 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:07:08 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:07:08 garfield automount[1976]: expire_proc: exp_proc=2594
Nov 23 10:07:08 garfield automount[1976]: handle_child: got pid 2594, sig 0 (0), stat 0 
Nov 23 10:07:08 garfield automount[1976]: sigchld: exp 2594 finished, switching from 2 to 1
Nov 23 10:07:08 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:07:08 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:07:21 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:07:21 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:07:21 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:07:21 garfield automount[1974]: expire_proc: exp_proc=2595
Nov 23 10:07:21 garfield automount[1974]: handle_child: got pid 2595, sig 0 (0), stat 0 
Nov 23 10:07:21 garfield automount[1974]: sigchld: exp 2595 finished, switching from 2 to 1
Nov 23 10:07:21 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:07:21 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:07:23 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:07:23 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:07:23 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:07:23 garfield automount[1976]: expire_proc: exp_proc=2596
Nov 23 10:07:23 garfield automount[1976]: handle_child: got pid 2596, sig 0 (0), stat 0 
Nov 23 10:07:23 garfield automount[1976]: sigchld: exp 2596 finished, switching from 2 to 1
Nov 23 10:07:23 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:07:23 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:07:36 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:07:36 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:07:36 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:07:36 garfield automount[1974]: expire_proc: exp_proc=2597
Nov 23 10:07:36 garfield automount[1974]: handle_child: got pid 2597, sig 0 (0), stat 0 
Nov 23 10:07:36 garfield automount[1974]: sigchld: exp 2597 finished, switching from 2 to 1
Nov 23 10:07:36 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:07:36 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:07:38 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:07:38 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:07:38 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:07:38 garfield automount[1976]: expire_proc: exp_proc=2598
Nov 23 10:07:38 garfield automount[1976]: handle_child: got pid 2598, sig 0 (0), stat 0 
Nov 23 10:07:38 garfield automount[1976]: sigchld: exp 2598 finished, switching from 2 to 1
Nov 23 10:07:38 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:07:38 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:07:51 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:07:51 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:07:51 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:07:51 garfield automount[1974]: expire_proc: exp_proc=2599
Nov 23 10:07:51 garfield automount[1974]: handle_child: got pid 2599, sig 0 (0), stat 0 
Nov 23 10:07:51 garfield automount[1974]: sigchld: exp 2599 finished, switching from 2 to 1
Nov 23 10:07:51 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:07:51 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:07:53 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:07:53 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:07:53 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:07:53 garfield automount[1976]: expire_proc: exp_proc=2600
Nov 23 10:07:53 garfield automount[1976]: handle_child: got pid 2600, sig 0 (0), stat 0 
Nov 23 10:07:53 garfield automount[1976]: sigchld: exp 2600 finished, switching from 2 to 1
Nov 23 10:07:53 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:07:53 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:08:06 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:08:06 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:08:06 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:08:06 garfield automount[1974]: expire_proc: exp_proc=2601
Nov 23 10:08:06 garfield automount[1974]: handle_child: got pid 2601, sig 0 (0), stat 0 
Nov 23 10:08:06 garfield automount[1974]: sigchld: exp 2601 finished, switching from 2 to 1
Nov 23 10:08:06 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:08:06 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:08:08 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:08:08 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:08:08 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:08:08 garfield automount[1976]: expire_proc: exp_proc=2602
Nov 23 10:08:08 garfield automount[1976]: handle_child: got pid 2602, sig 0 (0), stat 0 
Nov 23 10:08:08 garfield automount[1976]: sigchld: exp 2602 finished, switching from 2 to 1
Nov 23 10:08:08 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:08:08 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:08:21 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:08:21 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:08:21 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:08:21 garfield automount[1974]: expire_proc: exp_proc=2603
Nov 23 10:08:21 garfield automount[1974]: handle_child: got pid 2603, sig 0 (0), stat 0 
Nov 23 10:08:21 garfield automount[1974]: sigchld: exp 2603 finished, switching from 2 to 1
Nov 23 10:08:21 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:08:21 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:08:23 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:08:23 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:08:23 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:08:23 garfield automount[1976]: expire_proc: exp_proc=2604
Nov 23 10:08:23 garfield automount[1976]: handle_child: got pid 2604, sig 0 (0), stat 0 
Nov 23 10:08:23 garfield automount[1976]: sigchld: exp 2604 finished, switching from 2 to 1
Nov 23 10:08:23 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:08:23 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:08:36 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:08:36 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:08:36 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:08:36 garfield automount[1974]: expire_proc: exp_proc=2605
Nov 23 10:08:36 garfield automount[1974]: handle_child: got pid 2605, sig 0 (0), stat 0 
Nov 23 10:08:36 garfield automount[1974]: sigchld: exp 2605 finished, switching from 2 to 1
Nov 23 10:08:36 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:08:36 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:08:38 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:08:38 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:08:38 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:08:38 garfield automount[1976]: expire_proc: exp_proc=2606
Nov 23 10:08:38 garfield automount[1976]: handle_child: got pid 2606, sig 0 (0), stat 0 
Nov 23 10:08:38 garfield automount[1976]: sigchld: exp 2606 finished, switching from 2 to 1
Nov 23 10:08:38 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:08:38 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:08:51 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:08:51 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:08:51 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:08:51 garfield automount[1974]: expire_proc: exp_proc=2607
Nov 23 10:08:51 garfield automount[1974]: handle_child: got pid 2607, sig 0 (0), stat 0 
Nov 23 10:08:51 garfield automount[1974]: sigchld: exp 2607 finished, switching from 2 to 1
Nov 23 10:08:51 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:08:51 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:08:53 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:08:53 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:08:53 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:08:53 garfield automount[1976]: expire_proc: exp_proc=2608
Nov 23 10:08:53 garfield automount[1976]: handle_child: got pid 2608, sig 0 (0), stat 0 
Nov 23 10:08:53 garfield automount[1976]: sigchld: exp 2608 finished, switching from 2 to 1
Nov 23 10:08:53 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:08:53 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:09:01 garfield ntpd[2043]: synchronized to LOCAL(0), stratum 10
Nov 23 10:09:01 garfield ntpd[2043]: kernel time sync disabled 0041
Nov 23 10:09:06 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:09:06 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:09:06 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:09:06 garfield automount[1974]: expire_proc: exp_proc=2609
Nov 23 10:09:06 garfield automount[1974]: handle_child: got pid 2609, sig 0 (0), stat 0 
Nov 23 10:09:06 garfield automount[1974]: sigchld: exp 2609 finished, switching from 2 to 1
Nov 23 10:09:06 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:09:06 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:09:08 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:09:08 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:09:08 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:09:08 garfield automount[1976]: expire_proc: exp_proc=2610
Nov 23 10:09:08 garfield automount[1976]: handle_child: got pid 2610, sig 0 (0), stat 0 
Nov 23 10:09:08 garfield automount[1976]: sigchld: exp 2610 finished, switching from 2 to 1
Nov 23 10:09:08 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:09:08 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:09:21 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:09:21 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:09:21 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:09:21 garfield automount[1974]: expire_proc: exp_proc=2611
Nov 23 10:09:21 garfield automount[1974]: handle_child: got pid 2611, sig 0 (0), stat 0 
Nov 23 10:09:21 garfield automount[1974]: sigchld: exp 2611 finished, switching from 2 to 1
Nov 23 10:09:21 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:09:21 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:09:23 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:09:23 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:09:23 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:09:23 garfield automount[1976]: expire_proc: exp_proc=2612
Nov 23 10:09:23 garfield automount[1976]: handle_child: got pid 2612, sig 0 (0), stat 0 
Nov 23 10:09:23 garfield automount[1976]: sigchld: exp 2612 finished, switching from 2 to 1
Nov 23 10:09:23 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:09:23 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:09:36 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:09:36 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:09:36 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:09:36 garfield automount[1974]: expire_proc: exp_proc=2613
Nov 23 10:09:36 garfield automount[1974]: handle_child: got pid 2613, sig 0 (0), stat 0 
Nov 23 10:09:36 garfield automount[1974]: sigchld: exp 2613 finished, switching from 2 to 1
Nov 23 10:09:36 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:09:36 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:09:38 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:09:38 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:09:38 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:09:38 garfield automount[1976]: expire_proc: exp_proc=2614
Nov 23 10:09:38 garfield automount[1976]: handle_child: got pid 2614, sig 0 (0), stat 0 
Nov 23 10:09:38 garfield automount[1976]: sigchld: exp 2614 finished, switching from 2 to 1
Nov 23 10:09:38 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:09:38 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:09:51 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:09:51 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:09:51 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:09:51 garfield automount[1974]: expire_proc: exp_proc=2615
Nov 23 10:09:51 garfield automount[1974]: handle_child: got pid 2615, sig 0 (0), stat 0 
Nov 23 10:09:51 garfield automount[1974]: sigchld: exp 2615 finished, switching from 2 to 1
Nov 23 10:09:51 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:09:51 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:09:53 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:09:53 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:09:53 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:09:53 garfield automount[1976]: expire_proc: exp_proc=2616
Nov 23 10:09:53 garfield automount[1976]: handle_child: got pid 2616, sig 0 (0), stat 0 
Nov 23 10:09:53 garfield automount[1976]: sigchld: exp 2616 finished, switching from 2 to 1
Nov 23 10:09:53 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:09:53 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:10:05 garfield ntpd[2043]: synchronized to 192.168.1.3, stratum 3
Nov 23 10:10:05 garfield ntpd[2043]: kernel time sync enabled 0001
Nov 23 10:10:06 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:10:06 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:10:06 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:10:06 garfield automount[1974]: expire_proc: exp_proc=2682
Nov 23 10:10:06 garfield automount[1974]: handle_child: got pid 2682, sig 0 (0), stat 0 
Nov 23 10:10:06 garfield automount[1974]: sigchld: exp 2682 finished, switching from 2 to 1
Nov 23 10:10:06 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:10:06 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:10:08 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:10:08 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:10:08 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:10:08 garfield automount[1976]: expire_proc: exp_proc=2683
Nov 23 10:10:08 garfield automount[1976]: handle_child: got pid 2683, sig 0 (0), stat 0 
Nov 23 10:10:08 garfield automount[1976]: sigchld: exp 2683 finished, switching from 2 to 1
Nov 23 10:10:08 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:10:08 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:10:21 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:10:21 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:10:21 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:10:21 garfield automount[1974]: expire_proc: exp_proc=2812
Nov 23 10:10:21 garfield automount[1974]: handle_child: got pid 2812, sig 0 (0), stat 0 
Nov 23 10:10:21 garfield automount[1974]: sigchld: exp 2812 finished, switching from 2 to 1
Nov 23 10:10:21 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:10:21 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:10:23 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:10:23 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:10:23 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:10:23 garfield automount[1976]: expire_proc: exp_proc=2813
Nov 23 10:10:23 garfield automount[1976]: handle_child: got pid 2813, sig 0 (0), stat 0 
Nov 23 10:10:23 garfield automount[1976]: sigchld: exp 2813 finished, switching from 2 to 1
Nov 23 10:10:23 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:10:23 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:10:36 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:10:36 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:10:36 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:10:36 garfield automount[1974]: expire_proc: exp_proc=2815
Nov 23 10:10:36 garfield automount[1974]: handle_child: got pid 2815, sig 0 (0), stat 0 
Nov 23 10:10:36 garfield automount[1974]: sigchld: exp 2815 finished, switching from 2 to 1
Nov 23 10:10:36 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:10:36 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:10:38 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:10:38 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:10:38 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:10:38 garfield automount[1976]: expire_proc: exp_proc=2816
Nov 23 10:10:38 garfield automount[1976]: handle_child: got pid 2816, sig 0 (0), stat 0 
Nov 23 10:10:38 garfield automount[1976]: sigchld: exp 2816 finished, switching from 2 to 1
Nov 23 10:10:38 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:10:38 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:10:51 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:10:51 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:10:51 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:10:51 garfield automount[1974]: expire_proc: exp_proc=2818
Nov 23 10:10:51 garfield automount[1974]: handle_child: got pid 2818, sig 0 (0), stat 0 
Nov 23 10:10:51 garfield automount[1974]: sigchld: exp 2818 finished, switching from 2 to 1
Nov 23 10:10:51 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:10:51 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:10:53 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:10:53 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:10:53 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:10:53 garfield automount[1976]: expire_proc: exp_proc=2819
Nov 23 10:10:53 garfield automount[1976]: handle_child: got pid 2819, sig 0 (0), stat 0 
Nov 23 10:10:53 garfield automount[1976]: sigchld: exp 2819 finished, switching from 2 to 1
Nov 23 10:10:53 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:10:53 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:10:55 garfield automount[1976]: handle_packet: type = 0 
Nov 23 10:10:55 garfield automount[1976]: handle_packet_missing: token 1, name mirror 
Nov 23 10:10:55 garfield automount[1976]: attempting to mount entry /net/mirror
Nov 23 10:10:55 garfield automount[2820]: lookup(program): looking up mirror
Nov 23 10:10:55 garfield automount[2820]: lookup(program): mirror -> -fstype=nfs,hard,intr,nodev,nosuid  	/mnt/md2/download mirror:/mnt/md2/download
Nov 23 10:10:55 garfield automount[2820]: parse(sun): expanded entry: -fstype=nfs,hard,intr,nodev,nosuid  	/mnt/md2/download mirror:/mnt/md2/download
Nov 23 10:10:55 garfield automount[2820]: parse(sun): dequote("fstype=nfs,hard,intr,nodev,nosuid") -> fstype=nfs,hard,intr,nodev,nosuid
Nov 23 10:10:55 garfield automount[2820]: parse(sun): gathered options: fstype=nfs,hard,intr,nodev,nosuid
Nov 23 10:10:55 garfield automount[2820]: parse(sun): dequote("/mnt/md2/download") -> /mnt/md2/download
Nov 23 10:10:55 garfield automount[2820]: parse(sun): dequote("mirror:/mnt/md2/download") -> mirror:/mnt/md2/download
Nov 23 10:10:55 garfield automount[2820]: parse(sun): multimount: mirror:/mnt/md2/download on /mnt/md2/download with options fstype=nfs,hard,intr,nodev,nosuid
Nov 23 10:10:55 garfield automount[2820]: parse(sun): mounting root /net/mirror, mountpoint mnt/md2/download, what mirror:/mnt/md2/download, fstype nfs, options hard,intr,nodev,nosuid 
Nov 23 10:10:55 garfield automount[2820]: mount(nfs): root=/net/mirror name=mnt/md2/download what=mirror:/mnt/md2/download, fstype=nfs, options=hard,intr,nodev,nosuid
Nov 23 10:10:55 garfield automount[2820]: mount(nfs): nfs options="hard,intr,nodev,nosuid", nosymlink=0, ro=0
Nov 23 10:10:55 garfield automount[2820]: mount(nfs): is_local_mount: mirror
Nov 23 10:10:55 garfield automount[2820]: mount(nfs): winner = mirror local = 0
Nov 23 10:10:55 garfield automount[2820]: mount(nfs): all hosts timed out for 'mirror:/mnt/md2/download', retrying with longer timeout
Nov 23 10:10:55 garfield automount[2820]: mount(nfs): winner = mirror local = 0
Nov 23 10:10:55 garfield automount[2820]: mount(nfs): from mirror:/mnt/md2/download elected mirror:/mnt/md2/download
Nov 23 10:10:55 garfield automount[2820]: mount(nfs): calling mkdir_path /net/mirror/mnt/md2/download
Nov 23 10:10:55 garfield automount[2820]: mount(nfs): calling mount -t nfs -s  -o hard,intr,nodev,nosuid mirror:/mnt/md2/download /net/mirror/mnt/md2/download
Nov 23 10:10:55 garfield automount[2820]: mount(nfs): mounted mirror:/mnt/md2/download on /net/mirror/mnt/md2/download
Nov 23 10:10:55 garfield automount[1976]: handle_child: got pid 2820, sig 0 (0), stat 0 
Nov 23 10:10:55 garfield automount[1976]: sig_child: found pending iop pid 2820: signalled 0 (sig 0), exit status 0
Nov 23 10:10:55 garfield automount[1976]: send_ready: token=1 
Nov 23 10:10:58 garfield automount[1974]: handle_packet: type = 0 
Nov 23 10:10:58 garfield automount[1974]: handle_packet_missing: token 2, name atom 
Nov 23 10:10:58 garfield automount[1974]: attempting to mount entry /smb/atom
Nov 23 10:10:58 garfield automount[2836]: lookup(program): looking up atom
Nov 23 10:10:58 garfield automount[2836]: lookup(program): atom -> -fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755  	 /inf ://atom/inf  	 /install ://atom/install  	 /ellenorz ://atom/ellenorz  	 /fotosok ://atom/fotosok  	 /piac-ujsag ://atom/piac-ujsag  	 /piac-install ://atom/piac-install  	 /piac-egyeb ://atom/piac-egyeb  	 /piac-archive ://atom/piac-archive  	 /nap-archive ://atom/nap-archive  	 /penzugy ://atom/penzugy  	 /program ://atom/program  	 /szerkesztok ://atom/szerkesztok  	 /temp ://atom/temp  	 /ugyfelsz ://atom/ugyfelsz  	 /web ://atom/web
Nov 23 10:10:58 garfield automount[2836]: parse(sun): expanded entry: -fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755  	 /inf ://atom/inf  	 /install ://atom/install  	 /ellenorz ://atom/ellenorz  	 /fotosok ://atom/fotosok  	 /piac-ujsag ://atom/piac-ujsag  	 /piac-install ://atom/piac-install  	 /piac-egyeb ://atom/piac-egyeb  	 /piac-archive ://atom/piac-archive  	 /nap-archive ://atom/nap-archive  	 /penzugy ://atom/penzugy  	 /program ://atom/program  	 /szerkesztok ://atom/szerkesztok  	 /temp ://atom/temp  	 /ugyfelsz ://atom/ugyfelsz  	 /web ://atom/web
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755") -> fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:10:58 garfield automount[2836]: parse(sun): gathered options: fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/inf") -> /inf
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/inf") -> //atom/inf
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/install") -> /install
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/install") -> //atom/install
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/ellenorz") -> /ellenorz
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/ellenorz") -> //atom/ellenorz
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/fotosok") -> /fotosok
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/fotosok") -> //atom/fotosok
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/piac-ujsag") -> /piac-ujsag
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/piac-ujsag") -> //atom/piac-ujsag
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/piac-install") -> /piac-install
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/piac-install") -> //atom/piac-install
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/piac-egyeb") -> /piac-egyeb
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/piac-egyeb") -> //atom/piac-egyeb
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/piac-archive") -> /piac-archive
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/piac-archive") -> //atom/piac-archive
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/nap-archive") -> /nap-archive
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/nap-archive") -> //atom/nap-archive
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/penzugy") -> /penzugy
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/penzugy") -> //atom/penzugy
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/program") -> /program
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/program") -> //atom/program
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/szerkesztok") -> /szerkesztok
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/szerkesztok") -> //atom/szerkesztok
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/temp") -> /temp
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/temp") -> //atom/temp
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/ugyfelsz") -> /ugyfelsz
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/ugyfelsz") -> //atom/ugyfelsz
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("/web") -> /web
Nov 23 10:10:58 garfield automount[2836]: parse(sun): dequote("//atom/web") -> //atom/web
Nov 23 10:10:58 garfield automount[2836]: parse(sun): multimount: //atom/web on /web with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:10:58 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint web, what //atom/web, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:10:58 garfield automount[2836]: do_mount //atom/web /smb/atom/web type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:10:58 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/web
Nov 23 10:10:58 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/web /smb/atom/web
Nov 23 10:10:59 garfield automount[2836]: mount(generic): mounted //atom/web type smbfs on /smb/atom/web
Nov 23 10:10:59 garfield automount[2836]: parse(sun): multimount: //atom/inf on /inf with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:10:59 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint inf, what //atom/inf, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:10:59 garfield automount[2836]: do_mount //atom/inf /smb/atom/inf type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/inf
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/inf /smb/atom/inf
Nov 23 10:10:59 garfield mount.smbfs[2842]: [2005/11/23 10:10:59, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:10:59 garfield mount.smbfs[2842]:   mount.smbfs: entering daemon mode for service \\atom\web, pid=2842 
Nov 23 10:10:59 garfield mount.smbfs[2855]: [2005/11/23 10:10:59, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:10:59 garfield mount.smbfs[2855]:   mount.smbfs: entering daemon mode for service \\atom\inf, pid=2855 
Nov 23 10:10:59 garfield automount[2836]: mount(generic): mounted //atom/inf type smbfs on /smb/atom/inf
Nov 23 10:10:59 garfield automount[2836]: parse(sun): multimount: //atom/temp on /temp with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:10:59 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint temp, what //atom/temp, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:10:59 garfield automount[2836]: do_mount //atom/temp /smb/atom/temp type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/temp
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/temp /smb/atom/temp
Nov 23 10:10:59 garfield automount[2836]: mount(generic): mounted //atom/temp type smbfs on /smb/atom/temp
Nov 23 10:10:59 garfield automount[2836]: parse(sun): multimount: //atom/program on /program with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:10:59 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint program, what //atom/program, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:10:59 garfield automount[2836]: do_mount //atom/program /smb/atom/program type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/program
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/program /smb/atom/program
Nov 23 10:10:59 garfield mount.smbfs[2859]: [2005/11/23 10:10:59, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:10:59 garfield mount.smbfs[2859]:   mount.smbfs: entering daemon mode for service \\atom\temp, pid=2859 
Nov 23 10:10:59 garfield automount[2836]: mount(generic): mounted //atom/program type smbfs on /smb/atom/program
Nov 23 10:10:59 garfield automount[2836]: parse(sun): multimount: //atom/penzugy on /penzugy with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:10:59 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint penzugy, what //atom/penzugy, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:10:59 garfield automount[2836]: do_mount //atom/penzugy /smb/atom/penzugy type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/penzugy
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/penzugy /smb/atom/penzugy
Nov 23 10:10:59 garfield mount.smbfs[2863]: [2005/11/23 10:10:59, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:10:59 garfield mount.smbfs[2863]:   mount.smbfs: entering daemon mode for service \\atom\program, pid=2863 
Nov 23 10:10:59 garfield automount[2836]: mount(generic): mounted //atom/penzugy type smbfs on /smb/atom/penzugy
Nov 23 10:10:59 garfield automount[2836]: parse(sun): multimount: //atom/fotosok on /fotosok with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:10:59 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint fotosok, what //atom/fotosok, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:10:59 garfield automount[2836]: do_mount //atom/fotosok /smb/atom/fotosok type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/fotosok
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/fotosok /smb/atom/fotosok
Nov 23 10:10:59 garfield mount.smbfs[2867]: [2005/11/23 10:10:59, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:10:59 garfield mount.smbfs[2867]:   mount.smbfs: entering daemon mode for service \\atom\penzugy, pid=2867 
Nov 23 10:10:59 garfield automount[2836]: mount(generic): mounted //atom/fotosok type smbfs on /smb/atom/fotosok
Nov 23 10:10:59 garfield automount[2836]: parse(sun): multimount: //atom/install on /install with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:10:59 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint install, what //atom/install, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:10:59 garfield automount[2836]: do_mount //atom/install /smb/atom/install type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/install
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/install /smb/atom/install
Nov 23 10:10:59 garfield mount.smbfs[2871]: [2005/11/23 10:10:59, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:10:59 garfield mount.smbfs[2871]:   mount.smbfs: entering daemon mode for service \\atom\fotosok, pid=2871 
Nov 23 10:10:59 garfield automount[2836]: mount(generic): mounted //atom/install type smbfs on /smb/atom/install
Nov 23 10:10:59 garfield automount[2836]: parse(sun): multimount: //atom/ugyfelsz on /ugyfelsz with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:10:59 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint ugyfelsz, what //atom/ugyfelsz, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:10:59 garfield automount[2836]: do_mount //atom/ugyfelsz /smb/atom/ugyfelsz type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/ugyfelsz
Nov 23 10:10:59 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/ugyfelsz /smb/atom/ugyfelsz
Nov 23 10:10:59 garfield mount.smbfs[2875]: [2005/11/23 10:10:59, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:10:59 garfield mount.smbfs[2875]:   mount.smbfs: entering daemon mode for service \\atom\install, pid=2875 
Nov 23 10:11:00 garfield mount.smbfs[2879]: [2005/11/23 10:11:00, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:11:00 garfield mount.smbfs[2879]:   mount.smbfs: entering daemon mode for service \\atom\ugyfelsz, pid=2879 
Nov 23 10:11:00 garfield automount[2836]: mount(generic): mounted //atom/ugyfelsz type smbfs on /smb/atom/ugyfelsz
Nov 23 10:11:00 garfield automount[2836]: parse(sun): multimount: //atom/ellenorz on /ellenorz with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:11:00 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint ellenorz, what //atom/ellenorz, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:11:00 garfield automount[2836]: do_mount //atom/ellenorz /smb/atom/ellenorz type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/ellenorz
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/ellenorz /smb/atom/ellenorz
Nov 23 10:11:00 garfield mount.smbfs[2883]: [2005/11/23 10:11:00, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:11:00 garfield mount.smbfs[2883]:   mount.smbfs: entering daemon mode for service \\atom\ellenorz, pid=2883 
Nov 23 10:11:00 garfield automount[2836]: mount(generic): mounted //atom/ellenorz type smbfs on /smb/atom/ellenorz
Nov 23 10:11:00 garfield automount[2836]: parse(sun): multimount: //atom/piac-egyeb on /piac-egyeb with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:11:00 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint piac-egyeb, what //atom/piac-egyeb, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:11:00 garfield automount[2836]: do_mount //atom/piac-egyeb /smb/atom/piac-egyeb type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/piac-egyeb
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/piac-egyeb /smb/atom/piac-egyeb
Nov 23 10:11:00 garfield mount.smbfs[2887]: [2005/11/23 10:11:00, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:11:00 garfield mount.smbfs[2887]:   mount.smbfs: entering daemon mode for service \\atom\piac-egyeb, pid=2887 
Nov 23 10:11:00 garfield automount[2836]: mount(generic): mounted //atom/piac-egyeb type smbfs on /smb/atom/piac-egyeb
Nov 23 10:11:00 garfield automount[2836]: parse(sun): multimount: //atom/piac-ujsag on /piac-ujsag with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:11:00 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint piac-ujsag, what //atom/piac-ujsag, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:11:00 garfield automount[2836]: do_mount //atom/piac-ujsag /smb/atom/piac-ujsag type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/piac-ujsag
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/piac-ujsag /smb/atom/piac-ujsag
Nov 23 10:11:00 garfield mount.smbfs[2891]: [2005/11/23 10:11:00, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:11:00 garfield mount.smbfs[2891]:   mount.smbfs: entering daemon mode for service \\atom\piac-ujsag, pid=2891 
Nov 23 10:11:00 garfield automount[2836]: mount(generic): mounted //atom/piac-ujsag type smbfs on /smb/atom/piac-ujsag
Nov 23 10:11:00 garfield automount[2836]: parse(sun): multimount: //atom/szerkesztok on /szerkesztok with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:11:00 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint szerkesztok, what //atom/szerkesztok, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:11:00 garfield automount[2836]: do_mount //atom/szerkesztok /smb/atom/szerkesztok type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/szerkesztok
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/szerkesztok /smb/atom/szerkesztok
Nov 23 10:11:00 garfield mount.smbfs[2895]: [2005/11/23 10:11:00, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:11:00 garfield mount.smbfs[2895]:   mount.smbfs: entering daemon mode for service \\atom\szerkesztok, pid=2895 
Nov 23 10:11:00 garfield automount[2836]: mount(generic): mounted //atom/szerkesztok type smbfs on /smb/atom/szerkesztok
Nov 23 10:11:00 garfield automount[2836]: parse(sun): multimount: //atom/nap-archive on /nap-archive with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:11:00 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint nap-archive, what //atom/nap-archive, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:11:00 garfield automount[2836]: do_mount //atom/nap-archive /smb/atom/nap-archive type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/nap-archive
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/nap-archive /smb/atom/nap-archive
Nov 23 10:11:00 garfield mount.smbfs[2899]: [2005/11/23 10:11:00, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:11:00 garfield mount.smbfs[2899]:   mount.smbfs: entering daemon mode for service \\atom\nap-archive, pid=2899 
Nov 23 10:11:00 garfield automount[2836]: mount(generic): mounted //atom/nap-archive type smbfs on /smb/atom/nap-archive
Nov 23 10:11:00 garfield automount[2836]: parse(sun): multimount: //atom/piac-archive on /piac-archive with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:11:00 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint piac-archive, what //atom/piac-archive, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:11:00 garfield automount[2836]: do_mount //atom/piac-archive /smb/atom/piac-archive type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/piac-archive
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/piac-archive /smb/atom/piac-archive
Nov 23 10:11:00 garfield mount.smbfs[2903]: [2005/11/23 10:11:00, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:11:00 garfield mount.smbfs[2903]:   mount.smbfs: entering daemon mode for service \\atom\piac-archive, pid=2903 
Nov 23 10:11:00 garfield automount[2836]: mount(generic): mounted //atom/piac-archive type smbfs on /smb/atom/piac-archive
Nov 23 10:11:00 garfield automount[2836]: parse(sun): multimount: //atom/piac-install on /piac-install with options fstype=smbfs,credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755
Nov 23 10:11:00 garfield automount[2836]: parse(sun): mounting root /smb/atom, mountpoint piac-install, what //atom/piac-install, fstype smbfs, options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 
Nov 23 10:11:00 garfield automount[2836]: do_mount //atom/piac-install /smb/atom/piac-install type smbfs options credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 using module generic
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mkdir_path /smb/atom/piac-install
Nov 23 10:11:00 garfield automount[2836]: mount(generic): calling mount -t smbfs -s -o credentials=/home/lfarkas/.smb/atom.cred,workgroup=BPPIAC,uid=501,gid=501,fmask=0644,dmask=0755 //atom/piac-install /smb/atom/piac-install
Nov 23 10:11:00 garfield mount.smbfs[2907]: [2005/11/23 10:11:00, 0] client/smbmount.c:send_fs_socket(406) 
Nov 23 10:11:00 garfield mount.smbfs[2907]:   mount.smbfs: entering daemon mode for service \\atom\piac-install, pid=2907 
Nov 23 10:11:00 garfield automount[2836]: mount(generic): mounted //atom/piac-install type smbfs on /smb/atom/piac-install
Nov 23 10:11:00 garfield automount[1974]: handle_child: got pid 2836, sig 0 (0), stat 0 
Nov 23 10:11:00 garfield automount[1974]: sig_child: found pending iop pid 2836: signalled 0 (sig 0), exit status 0
Nov 23 10:11:00 garfield automount[1974]: send_ready: token=2 
Nov 23 10:11:06 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:11:06 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:11:06 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:11:06 garfield automount[1974]: expire_proc: exp_proc=2920
Nov 23 10:11:06 garfield automount[2920]: expire_proc: 15 remaining in /smb 
Nov 23 10:11:06 garfield automount[1974]: handle_child: got pid 2920, sig 0 (0), stat 1 
Nov 23 10:11:06 garfield automount[1974]: sigchld: exp 2920 finished, switching from 2 to 1
Nov 23 10:11:06 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:11:06 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:11:08 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:11:08 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:11:08 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:11:08 garfield automount[2921]: expire_proc: 1 remaining in /net 
Nov 23 10:11:08 garfield automount[1976]: expire_proc: exp_proc=2921
Nov 23 10:11:08 garfield automount[1976]: handle_child: got pid 2921, sig 0 (0), stat 1 
Nov 23 10:11:08 garfield automount[1976]: sigchld: exp 2921 finished, switching from 2 to 1
Nov 23 10:11:08 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:11:08 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:11:21 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:11:21 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:11:21 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:11:21 garfield automount[1974]: expire_proc: exp_proc=2970
Nov 23 10:11:21 garfield automount[2970]: expire_proc: 15 remaining in /smb 
Nov 23 10:11:21 garfield automount[1974]: handle_child: got pid 2970, sig 0 (0), stat 1 
Nov 23 10:11:21 garfield automount[1974]: sigchld: exp 2970 finished, switching from 2 to 1
Nov 23 10:11:21 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:11:21 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:11:23 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:11:23 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:11:23 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:11:23 garfield automount[2971]: expire_proc: 1 remaining in /net 
Nov 23 10:11:23 garfield automount[1976]: expire_proc: exp_proc=2971
Nov 23 10:11:23 garfield automount[1976]: handle_child: got pid 2971, sig 0 (0), stat 1 
Nov 23 10:11:23 garfield automount[1976]: sigchld: exp 2971 finished, switching from 2 to 1
Nov 23 10:11:23 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:11:23 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:11:36 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:11:36 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:11:36 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:11:36 garfield automount[1974]: expire_proc: exp_proc=2979
Nov 23 10:11:36 garfield automount[2979]: expire_proc: 15 remaining in /smb 
Nov 23 10:11:36 garfield automount[1974]: handle_child: got pid 2979, sig 0 (0), stat 1 
Nov 23 10:11:36 garfield automount[1974]: sigchld: exp 2979 finished, switching from 2 to 1
Nov 23 10:11:36 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:11:36 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:11:38 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:11:38 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:11:38 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:11:38 garfield automount[2980]: expire_proc: 1 remaining in /net 
Nov 23 10:11:38 garfield automount[1976]: expire_proc: exp_proc=2980
Nov 23 10:11:38 garfield automount[1976]: handle_child: got pid 2980, sig 0 (0), stat 1 
Nov 23 10:11:38 garfield automount[1976]: sigchld: exp 2980 finished, switching from 2 to 1
Nov 23 10:11:38 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:11:38 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:11:51 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:11:51 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:11:51 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:11:51 garfield automount[1974]: expire_proc: exp_proc=2981
Nov 23 10:11:51 garfield automount[2981]: expire_proc: 15 remaining in /smb 
Nov 23 10:11:51 garfield automount[1974]: handle_child: got pid 2981, sig 0 (0), stat 1 
Nov 23 10:11:51 garfield automount[1974]: sigchld: exp 2981 finished, switching from 2 to 1
Nov 23 10:11:51 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:11:51 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:11:53 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:11:53 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:11:53 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:11:53 garfield automount[2982]: expire_proc: 1 remaining in /net 
Nov 23 10:11:53 garfield automount[1976]: expire_proc: exp_proc=2982
Nov 23 10:11:53 garfield automount[1976]: handle_child: got pid 2982, sig 0 (0), stat 1 
Nov 23 10:11:53 garfield automount[1976]: sigchld: exp 2982 finished, switching from 2 to 1
Nov 23 10:11:53 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:11:53 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:12:07 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:12:07 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:12:07 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:12:07 garfield automount[1974]: expire_proc: exp_proc=2983
Nov 23 10:12:07 garfield automount[2983]: expire_proc: 15 remaining in /smb 
Nov 23 10:12:07 garfield automount[1974]: handle_child: got pid 2983, sig 0 (0), stat 1 
Nov 23 10:12:07 garfield automount[1974]: sigchld: exp 2983 finished, switching from 2 to 1
Nov 23 10:12:07 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:12:07 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:12:08 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:12:08 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:12:08 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:12:08 garfield automount[1976]: expire_proc: exp_proc=2984
Nov 23 10:12:08 garfield automount[2984]: expire_proc: 1 remaining in /net 
Nov 23 10:12:08 garfield automount[1976]: handle_child: got pid 2984, sig 0 (0), stat 1 
Nov 23 10:12:08 garfield automount[1976]: sigchld: exp 2984 finished, switching from 2 to 1
Nov 23 10:12:08 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:12:08 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:12:22 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:12:22 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:12:22 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:12:22 garfield automount[1974]: expire_proc: exp_proc=2985
Nov 23 10:12:22 garfield automount[2985]: expire_proc: 15 remaining in /smb 
Nov 23 10:12:22 garfield automount[1974]: handle_child: got pid 2985, sig 0 (0), stat 1 
Nov 23 10:12:22 garfield automount[1974]: sigchld: exp 2985 finished, switching from 2 to 1
Nov 23 10:12:22 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:12:22 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:12:23 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:12:23 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:12:23 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:12:23 garfield automount[2986]: expire_proc: 1 remaining in /net 
Nov 23 10:12:23 garfield automount[1976]: expire_proc: exp_proc=2986
Nov 23 10:12:23 garfield automount[1976]: handle_child: got pid 2986, sig 0 (0), stat 1 
Nov 23 10:12:23 garfield automount[1976]: sigchld: exp 2986 finished, switching from 2 to 1
Nov 23 10:12:23 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:12:23 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:12:37 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:12:37 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:12:37 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:12:37 garfield automount[1974]: expire_proc: exp_proc=2987
Nov 23 10:12:37 garfield automount[2987]: expire_proc: 15 remaining in /smb 
Nov 23 10:12:37 garfield automount[1974]: handle_child: got pid 2987, sig 0 (0), stat 1 
Nov 23 10:12:37 garfield automount[1974]: sigchld: exp 2987 finished, switching from 2 to 1
Nov 23 10:12:37 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:12:37 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:12:38 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:12:38 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:12:38 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:12:38 garfield automount[2988]: expire_proc: 1 remaining in /net 
Nov 23 10:12:38 garfield automount[1976]: expire_proc: exp_proc=2988
Nov 23 10:12:38 garfield automount[1976]: handle_child: got pid 2988, sig 0 (0), stat 1 
Nov 23 10:12:38 garfield automount[1976]: sigchld: exp 2988 finished, switching from 2 to 1
Nov 23 10:12:38 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:12:38 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:12:52 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:12:52 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:12:52 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:12:52 garfield automount[1974]: expire_proc: exp_proc=2989
Nov 23 10:12:52 garfield automount[2989]: expire_proc: 15 remaining in /smb 
Nov 23 10:12:52 garfield automount[1974]: handle_child: got pid 2989, sig 0 (0), stat 1 
Nov 23 10:12:52 garfield automount[1974]: sigchld: exp 2989 finished, switching from 2 to 1
Nov 23 10:12:52 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:12:52 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:12:53 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:12:53 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:12:53 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:12:53 garfield automount[2990]: expire_proc: 1 remaining in /net 
Nov 23 10:12:53 garfield automount[1976]: expire_proc: exp_proc=2990
Nov 23 10:12:53 garfield automount[1976]: handle_child: got pid 2990, sig 0 (0), stat 1 
Nov 23 10:12:53 garfield automount[1976]: sigchld: exp 2990 finished, switching from 2 to 1
Nov 23 10:12:53 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:12:53 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:13:07 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:13:07 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:13:07 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:13:07 garfield automount[1974]: expire_proc: exp_proc=2991
Nov 23 10:13:07 garfield automount[2991]: expire_proc: 15 remaining in /smb 
Nov 23 10:13:07 garfield automount[1974]: handle_child: got pid 2991, sig 0 (0), stat 1 
Nov 23 10:13:07 garfield automount[1974]: sigchld: exp 2991 finished, switching from 2 to 1
Nov 23 10:13:07 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:13:07 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:13:08 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:13:08 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:13:08 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:13:08 garfield automount[2992]: expire_proc: 1 remaining in /net 
Nov 23 10:13:08 garfield automount[1976]: expire_proc: exp_proc=2992
Nov 23 10:13:08 garfield automount[1976]: handle_child: got pid 2992, sig 0 (0), stat 1 
Nov 23 10:13:08 garfield automount[1976]: sigchld: exp 2992 finished, switching from 2 to 1
Nov 23 10:13:08 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:13:08 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:13:22 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:13:22 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:13:22 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:13:22 garfield automount[1974]: expire_proc: exp_proc=2998
Nov 23 10:13:22 garfield automount[2998]: expire_proc: 15 remaining in /smb 
Nov 23 10:13:22 garfield automount[1974]: handle_child: got pid 2998, sig 0 (0), stat 1 
Nov 23 10:13:22 garfield automount[1974]: sigchld: exp 2998 finished, switching from 2 to 1
Nov 23 10:13:22 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:13:22 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:13:24 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:13:24 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:13:24 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:13:24 garfield automount[2999]: expire_proc: 1 remaining in /net 
Nov 23 10:13:24 garfield automount[1976]: expire_proc: exp_proc=2999
Nov 23 10:13:24 garfield automount[1976]: handle_child: got pid 2999, sig 0 (0), stat 1 
Nov 23 10:13:24 garfield automount[1976]: sigchld: exp 2999 finished, switching from 2 to 1
Nov 23 10:13:24 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:13:24 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:13:37 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:13:37 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:13:37 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:13:37 garfield automount[1974]: expire_proc: exp_proc=3025
Nov 23 10:13:37 garfield automount[3025]: expire_proc: 15 remaining in /smb 
Nov 23 10:13:37 garfield automount[1974]: handle_child: got pid 3025, sig 0 (0), stat 1 
Nov 23 10:13:37 garfield automount[1974]: sigchld: exp 3025 finished, switching from 2 to 1
Nov 23 10:13:37 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:13:37 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:13:39 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:13:39 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:13:39 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:13:39 garfield automount[3026]: expire_proc: 1 remaining in /net 
Nov 23 10:13:39 garfield automount[1976]: expire_proc: exp_proc=3026
Nov 23 10:13:39 garfield automount[1976]: handle_child: got pid 3026, sig 0 (0), stat 1 
Nov 23 10:13:39 garfield automount[1976]: sigchld: exp 3026 finished, switching from 2 to 1
Nov 23 10:13:39 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:13:39 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:13:52 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:13:52 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:13:52 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:13:52 garfield automount[1974]: expire_proc: exp_proc=3027
Nov 23 10:13:52 garfield automount[3027]: expire_proc: 15 remaining in /smb 
Nov 23 10:13:52 garfield automount[1974]: handle_child: got pid 3027, sig 0 (0), stat 1 
Nov 23 10:13:52 garfield automount[1974]: sigchld: exp 3027 finished, switching from 2 to 1
Nov 23 10:13:52 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:13:52 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:13:54 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:13:54 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:13:54 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:13:54 garfield automount[3028]: expire_proc: 1 remaining in /net 
Nov 23 10:13:54 garfield automount[1976]: expire_proc: exp_proc=3028
Nov 23 10:13:54 garfield automount[1976]: handle_child: got pid 3028, sig 0 (0), stat 1 
Nov 23 10:13:54 garfield automount[1976]: sigchld: exp 3028 finished, switching from 2 to 1
Nov 23 10:13:54 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:13:54 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:14:07 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:14:07 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:14:07 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:14:07 garfield automount[1974]: expire_proc: exp_proc=3029
Nov 23 10:14:07 garfield automount[3029]: expire_proc: 15 remaining in /smb 
Nov 23 10:14:07 garfield automount[1974]: handle_child: got pid 3029, sig 0 (0), stat 1 
Nov 23 10:14:07 garfield automount[1974]: sigchld: exp 3029 finished, switching from 2 to 1
Nov 23 10:14:07 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:14:07 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:14:09 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:14:09 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:14:09 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:14:09 garfield automount[3030]: expire_proc: 1 remaining in /net 
Nov 23 10:14:09 garfield automount[1976]: expire_proc: exp_proc=3030
Nov 23 10:14:09 garfield automount[1976]: handle_child: got pid 3030, sig 0 (0), stat 1 
Nov 23 10:14:09 garfield automount[1976]: sigchld: exp 3030 finished, switching from 2 to 1
Nov 23 10:14:09 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:14:09 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:14:22 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:14:22 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:14:22 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:14:22 garfield automount[1974]: expire_proc: exp_proc=3031
Nov 23 10:14:22 garfield automount[3031]: expire_proc: 15 remaining in /smb 
Nov 23 10:14:22 garfield automount[1974]: handle_child: got pid 3031, sig 0 (0), stat 1 
Nov 23 10:14:22 garfield automount[1974]: sigchld: exp 3031 finished, switching from 2 to 1
Nov 23 10:14:22 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:14:22 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:14:24 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:14:24 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:14:24 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:14:24 garfield automount[3032]: expire_proc: 1 remaining in /net 
Nov 23 10:14:24 garfield automount[1976]: expire_proc: exp_proc=3032
Nov 23 10:14:24 garfield automount[1976]: handle_child: got pid 3032, sig 0 (0), stat 1 
Nov 23 10:14:24 garfield automount[1976]: sigchld: exp 3032 finished, switching from 2 to 1
Nov 23 10:14:24 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:14:24 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:14:37 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:14:37 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:14:37 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:14:37 garfield automount[1974]: expire_proc: exp_proc=3039
Nov 23 10:14:37 garfield automount[3039]: expire_proc: 15 remaining in /smb 
Nov 23 10:14:37 garfield automount[1974]: handle_child: got pid 3039, sig 0 (0), stat 1 
Nov 23 10:14:37 garfield automount[1974]: sigchld: exp 3039 finished, switching from 2 to 1
Nov 23 10:14:37 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:14:37 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:14:39 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:14:39 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:14:39 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:14:39 garfield automount[3040]: expire_proc: 1 remaining in /net 
Nov 23 10:14:39 garfield automount[1976]: expire_proc: exp_proc=3040
Nov 23 10:14:39 garfield automount[1976]: handle_child: got pid 3040, sig 0 (0), stat 1 
Nov 23 10:14:39 garfield automount[1976]: sigchld: exp 3040 finished, switching from 2 to 1
Nov 23 10:14:39 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:14:39 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:14:52 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:14:52 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:14:52 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:14:52 garfield automount[1974]: expire_proc: exp_proc=3041
Nov 23 10:14:52 garfield automount[3041]: expire_proc: 15 remaining in /smb 
Nov 23 10:14:52 garfield automount[1974]: handle_child: got pid 3041, sig 0 (0), stat 1 
Nov 23 10:14:52 garfield automount[1974]: sigchld: exp 3041 finished, switching from 2 to 1
Nov 23 10:14:52 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:14:52 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:14:54 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:14:54 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:14:54 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:14:54 garfield automount[3042]: expire_proc: 1 remaining in /net 
Nov 23 10:14:54 garfield automount[1976]: expire_proc: exp_proc=3042
Nov 23 10:14:54 garfield automount[1976]: handle_child: got pid 3042, sig 0 (0), stat 1 
Nov 23 10:14:54 garfield automount[1976]: sigchld: exp 3042 finished, switching from 2 to 1
Nov 23 10:14:54 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:14:54 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:15:07 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:15:07 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:15:07 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:15:07 garfield automount[1974]: expire_proc: exp_proc=3043
Nov 23 10:15:07 garfield automount[3043]: expire_proc: 15 remaining in /smb 
Nov 23 10:15:07 garfield automount[1974]: handle_child: got pid 3043, sig 0 (0), stat 1 
Nov 23 10:15:07 garfield automount[1974]: sigchld: exp 3043 finished, switching from 2 to 1
Nov 23 10:15:07 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:15:07 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:15:09 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:15:09 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:15:09 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:15:09 garfield automount[1976]: expire_proc: exp_proc=3044
Nov 23 10:15:09 garfield automount[3044]: expire_proc: 1 remaining in /net 
Nov 23 10:15:09 garfield automount[1976]: handle_child: got pid 3044, sig 0 (0), stat 1 
Nov 23 10:15:09 garfield automount[1976]: sigchld: exp 3044 finished, switching from 2 to 1
Nov 23 10:15:09 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:15:09 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:15:22 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:15:22 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:15:22 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:15:22 garfield automount[1974]: expire_proc: exp_proc=3046
Nov 23 10:15:22 garfield automount[3046]: expire_proc: 15 remaining in /smb 
Nov 23 10:15:22 garfield automount[1974]: handle_child: got pid 3046, sig 0 (0), stat 1 
Nov 23 10:15:22 garfield automount[1974]: sigchld: exp 3046 finished, switching from 2 to 1
Nov 23 10:15:22 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:15:22 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:15:24 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:15:24 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:15:24 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:15:24 garfield automount[3047]: expire_proc: 1 remaining in /net 
Nov 23 10:15:24 garfield automount[1976]: expire_proc: exp_proc=3047
Nov 23 10:15:24 garfield automount[1976]: handle_child: got pid 3047, sig 0 (0), stat 1 
Nov 23 10:15:24 garfield automount[1976]: sigchld: exp 3047 finished, switching from 2 to 1
Nov 23 10:15:24 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:15:24 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:15:37 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:15:37 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:15:37 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:15:37 garfield automount[1974]: expire_proc: exp_proc=3048
Nov 23 10:15:37 garfield automount[3048]: expire_proc: 15 remaining in /smb 
Nov 23 10:15:37 garfield automount[1974]: handle_child: got pid 3048, sig 0 (0), stat 1 
Nov 23 10:15:37 garfield automount[1974]: sigchld: exp 3048 finished, switching from 2 to 1
Nov 23 10:15:37 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:15:37 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:15:39 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:15:39 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:15:39 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:15:39 garfield automount[3049]: expire_proc: 1 remaining in /net 
Nov 23 10:15:39 garfield automount[1976]: expire_proc: exp_proc=3049
Nov 23 10:15:39 garfield automount[1976]: handle_child: got pid 3049, sig 0 (0), stat 1 
Nov 23 10:15:39 garfield automount[1976]: sigchld: exp 3049 finished, switching from 2 to 1
Nov 23 10:15:39 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:15:39 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:15:52 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:15:52 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:15:52 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:15:52 garfield automount[1974]: expire_proc: exp_proc=3050
Nov 23 10:15:52 garfield automount[3050]: expire_proc: 15 remaining in /smb 
Nov 23 10:15:52 garfield automount[1974]: handle_child: got pid 3050, sig 0 (0), stat 1 
Nov 23 10:15:52 garfield automount[1974]: sigchld: exp 3050 finished, switching from 2 to 1
Nov 23 10:15:52 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:15:52 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:15:54 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:15:54 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:15:54 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:15:54 garfield automount[3051]: expire_proc: 1 remaining in /net 
Nov 23 10:15:54 garfield automount[1976]: expire_proc: exp_proc=3051
Nov 23 10:15:54 garfield automount[1976]: handle_child: got pid 3051, sig 0 (0), stat 1 
Nov 23 10:15:54 garfield automount[1976]: sigchld: exp 3051 finished, switching from 2 to 1
Nov 23 10:15:54 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:15:54 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:16:07 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:16:07 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:16:07 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:16:07 garfield automount[1974]: expire_proc: exp_proc=3052
Nov 23 10:16:07 garfield automount[3052]: expire_proc: 15 remaining in /smb 
Nov 23 10:16:07 garfield automount[1974]: handle_child: got pid 3052, sig 0 (0), stat 1 
Nov 23 10:16:07 garfield automount[1974]: sigchld: exp 3052 finished, switching from 2 to 1
Nov 23 10:16:07 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:16:07 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:16:09 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:16:09 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:16:09 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:16:09 garfield automount[3053]: expire_proc: 1 remaining in /net 
Nov 23 10:16:09 garfield automount[1976]: expire_proc: exp_proc=3053
Nov 23 10:16:09 garfield automount[1976]: handle_child: got pid 3053, sig 0 (0), stat 1 
Nov 23 10:16:09 garfield automount[1976]: sigchld: exp 3053 finished, switching from 2 to 1
Nov 23 10:16:09 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:16:09 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:16:22 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:16:22 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:16:22 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:16:22 garfield automount[1974]: expire_proc: exp_proc=3054
Nov 23 10:16:22 garfield automount[3054]: expire_proc: 15 remaining in /smb 
Nov 23 10:16:22 garfield automount[1974]: handle_child: got pid 3054, sig 0 (0), stat 1 
Nov 23 10:16:22 garfield automount[1974]: sigchld: exp 3054 finished, switching from 2 to 1
Nov 23 10:16:22 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:16:22 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:16:24 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:16:24 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:16:24 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:16:24 garfield automount[3055]: expire_proc: 1 remaining in /net 
Nov 23 10:16:24 garfield automount[1976]: expire_proc: exp_proc=3055
Nov 23 10:16:24 garfield automount[1976]: handle_child: got pid 3055, sig 0 (0), stat 1 
Nov 23 10:16:24 garfield automount[1976]: sigchld: exp 3055 finished, switching from 2 to 1
Nov 23 10:16:24 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:16:24 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:16:37 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:16:37 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:16:37 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:16:37 garfield automount[1974]: expire_proc: exp_proc=3058
Nov 23 10:16:37 garfield automount[3058]: expire_proc: 15 remaining in /smb 
Nov 23 10:16:37 garfield automount[1974]: handle_child: got pid 3058, sig 0 (0), stat 1 
Nov 23 10:16:37 garfield automount[1974]: sigchld: exp 3058 finished, switching from 2 to 1
Nov 23 10:16:37 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:16:37 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:16:39 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:16:39 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:16:39 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:16:39 garfield automount[3061]: expire_proc: 1 remaining in /net 
Nov 23 10:16:39 garfield automount[1976]: expire_proc: exp_proc=3061
Nov 23 10:16:39 garfield automount[1976]: handle_child: got pid 3061, sig 0 (0), stat 1 
Nov 23 10:16:39 garfield automount[1976]: sigchld: exp 3061 finished, switching from 2 to 1
Nov 23 10:16:39 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:16:39 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:16:52 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:16:52 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:16:52 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:16:52 garfield automount[1974]: expire_proc: exp_proc=3062
Nov 23 10:16:52 garfield automount[3062]: expire_proc: 15 remaining in /smb 
Nov 23 10:16:52 garfield automount[1974]: handle_child: got pid 3062, sig 0 (0), stat 1 
Nov 23 10:16:52 garfield automount[1974]: sigchld: exp 3062 finished, switching from 2 to 1
Nov 23 10:16:52 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:16:52 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:16:54 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:16:54 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:16:54 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:16:54 garfield automount[3063]: expire_proc: 1 remaining in /net 
Nov 23 10:16:54 garfield automount[1976]: expire_proc: exp_proc=3063
Nov 23 10:16:54 garfield automount[1976]: handle_child: got pid 3063, sig 0 (0), stat 1 
Nov 23 10:16:54 garfield automount[1976]: sigchld: exp 3063 finished, switching from 2 to 1
Nov 23 10:16:54 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:16:54 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:17:07 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:17:07 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:17:07 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:17:07 garfield automount[1974]: expire_proc: exp_proc=3064
Nov 23 10:17:07 garfield automount[3064]: expire_proc: 15 remaining in /smb 
Nov 23 10:17:07 garfield automount[1974]: handle_child: got pid 3064, sig 0 (0), stat 1 
Nov 23 10:17:07 garfield automount[1974]: sigchld: exp 3064 finished, switching from 2 to 1
Nov 23 10:17:07 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:17:07 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:17:09 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:17:09 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:17:09 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:17:09 garfield automount[3065]: expire_proc: 1 remaining in /net 
Nov 23 10:17:09 garfield automount[1976]: expire_proc: exp_proc=3065
Nov 23 10:17:09 garfield automount[1976]: handle_child: got pid 3065, sig 0 (0), stat 1 
Nov 23 10:17:09 garfield automount[1976]: sigchld: exp 3065 finished, switching from 2 to 1
Nov 23 10:17:09 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:17:09 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:17:22 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:17:22 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:17:22 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:17:22 garfield automount[1974]: expire_proc: exp_proc=3088
Nov 23 10:17:22 garfield automount[3088]: expire_proc: 15 remaining in /smb 
Nov 23 10:17:22 garfield automount[1974]: handle_child: got pid 3088, sig 0 (0), stat 1 
Nov 23 10:17:22 garfield automount[1974]: sigchld: exp 3088 finished, switching from 2 to 1
Nov 23 10:17:22 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:17:22 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:17:24 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:17:24 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:17:24 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:17:24 garfield automount[3089]: expire_proc: 1 remaining in /net 
Nov 23 10:17:24 garfield automount[1976]: expire_proc: exp_proc=3089
Nov 23 10:17:24 garfield automount[1976]: handle_child: got pid 3089, sig 0 (0), stat 1 
Nov 23 10:17:24 garfield automount[1976]: sigchld: exp 3089 finished, switching from 2 to 1
Nov 23 10:17:24 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:17:24 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:17:37 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:17:37 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:17:37 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:17:37 garfield automount[1974]: expire_proc: exp_proc=3090
Nov 23 10:17:37 garfield automount[3090]: expire_proc: 15 remaining in /smb 
Nov 23 10:17:37 garfield automount[1974]: handle_child: got pid 3090, sig 0 (0), stat 1 
Nov 23 10:17:37 garfield automount[1974]: sigchld: exp 3090 finished, switching from 2 to 1
Nov 23 10:17:37 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:17:37 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:17:39 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:17:39 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:17:39 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:17:39 garfield automount[3091]: expire_proc: 1 remaining in /net 
Nov 23 10:17:39 garfield automount[1976]: expire_proc: exp_proc=3091
Nov 23 10:17:39 garfield automount[1976]: handle_child: got pid 3091, sig 0 (0), stat 1 
Nov 23 10:17:39 garfield automount[1976]: sigchld: exp 3091 finished, switching from 2 to 1
Nov 23 10:17:39 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:17:39 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:17:52 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:17:52 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:17:52 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:17:52 garfield automount[1974]: expire_proc: exp_proc=3092
Nov 23 10:17:52 garfield automount[3092]: expire_proc: 15 remaining in /smb 
Nov 23 10:17:52 garfield automount[1974]: handle_child: got pid 3092, sig 0 (0), stat 1 
Nov 23 10:17:52 garfield automount[1974]: sigchld: exp 3092 finished, switching from 2 to 1
Nov 23 10:17:52 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:17:52 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:17:54 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:17:54 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:17:54 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:17:54 garfield automount[3093]: expire_proc: 1 remaining in /net 
Nov 23 10:17:54 garfield automount[1976]: expire_proc: exp_proc=3093
Nov 23 10:17:54 garfield automount[1976]: handle_child: got pid 3093, sig 0 (0), stat 1 
Nov 23 10:17:54 garfield automount[1976]: sigchld: exp 3093 finished, switching from 2 to 1
Nov 23 10:17:54 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:17:54 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:18:07 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:18:07 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:18:07 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:18:07 garfield automount[1974]: expire_proc: exp_proc=3095
Nov 23 10:18:07 garfield automount[3095]: expire_proc: 15 remaining in /smb 
Nov 23 10:18:07 garfield automount[1974]: handle_child: got pid 3095, sig 0 (0), stat 1 
Nov 23 10:18:07 garfield automount[1974]: sigchld: exp 3095 finished, switching from 2 to 1
Nov 23 10:18:07 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:18:07 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:18:09 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:18:09 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:18:09 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:18:09 garfield automount[3099]: expire_proc: 1 remaining in /net 
Nov 23 10:18:09 garfield automount[1976]: expire_proc: exp_proc=3099
Nov 23 10:18:09 garfield automount[1976]: handle_child: got pid 3099, sig 0 (0), stat 1 
Nov 23 10:18:09 garfield automount[1976]: sigchld: exp 3099 finished, switching from 2 to 1
Nov 23 10:18:09 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:18:09 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:18:22 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:18:22 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:18:22 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:18:22 garfield automount[1974]: expire_proc: exp_proc=3100
Nov 23 10:18:22 garfield automount[3100]: expire_proc: 15 remaining in /smb 
Nov 23 10:18:22 garfield automount[1974]: handle_child: got pid 3100, sig 0 (0), stat 1 
Nov 23 10:18:22 garfield automount[1974]: sigchld: exp 3100 finished, switching from 2 to 1
Nov 23 10:18:22 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:18:22 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:18:24 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:18:24 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:18:24 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:18:24 garfield automount[3101]: expire_proc: 1 remaining in /net 
Nov 23 10:18:24 garfield automount[1976]: expire_proc: exp_proc=3101
Nov 23 10:18:24 garfield automount[1976]: handle_child: got pid 3101, sig 0 (0), stat 1 
Nov 23 10:18:24 garfield automount[1976]: sigchld: exp 3101 finished, switching from 2 to 1
Nov 23 10:18:24 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:18:24 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:18:37 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:18:37 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:18:37 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:18:37 garfield automount[1974]: expire_proc: exp_proc=3102
Nov 23 10:18:37 garfield automount[3102]: expire_proc: 15 remaining in /smb 
Nov 23 10:18:37 garfield automount[1974]: handle_child: got pid 3102, sig 0 (0), stat 1 
Nov 23 10:18:37 garfield automount[1974]: sigchld: exp 3102 finished, switching from 2 to 1
Nov 23 10:18:37 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:18:37 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:18:39 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:18:39 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:18:39 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:18:39 garfield automount[3103]: expire_proc: 1 remaining in /net 
Nov 23 10:18:39 garfield automount[1976]: expire_proc: exp_proc=3103
Nov 23 10:18:39 garfield automount[1976]: handle_child: got pid 3103, sig 0 (0), stat 1 
Nov 23 10:18:39 garfield automount[1976]: sigchld: exp 3103 finished, switching from 2 to 1
Nov 23 10:18:39 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:18:39 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:18:52 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:18:52 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:18:52 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:18:52 garfield automount[1974]: expire_proc: exp_proc=3104
Nov 23 10:18:52 garfield automount[3104]: expire_proc: 15 remaining in /smb 
Nov 23 10:18:52 garfield automount[1974]: handle_child: got pid 3104, sig 0 (0), stat 1 
Nov 23 10:18:52 garfield automount[1974]: sigchld: exp 3104 finished, switching from 2 to 1
Nov 23 10:18:52 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:18:52 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:18:54 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:18:54 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:18:54 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:18:54 garfield automount[3105]: expire_proc: 1 remaining in /net 
Nov 23 10:18:54 garfield automount[1976]: expire_proc: exp_proc=3105
Nov 23 10:18:54 garfield automount[1976]: handle_child: got pid 3105, sig 0 (0), stat 1 
Nov 23 10:18:54 garfield automount[1976]: sigchld: exp 3105 finished, switching from 2 to 1
Nov 23 10:18:54 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:18:54 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:19:07 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:19:07 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:19:07 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:19:07 garfield automount[1974]: expire_proc: exp_proc=3108
Nov 23 10:19:07 garfield automount[3108]: expire_proc: 15 remaining in /smb 
Nov 23 10:19:07 garfield automount[1974]: handle_child: got pid 3108, sig 0 (0), stat 1 
Nov 23 10:19:07 garfield automount[1974]: sigchld: exp 3108 finished, switching from 2 to 1
Nov 23 10:19:07 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:19:07 garfield automount[1974]: st_ready(): state = 2 
Nov 23 10:19:09 garfield automount[1976]: sig 14 switching from 1 to 2
Nov 23 10:19:09 garfield automount[1976]: get_pkt: state 1, next 2
Nov 23 10:19:09 garfield automount[1976]: st_expire(): state = 1 
Nov 23 10:19:09 garfield automount[3109]: expire_proc: 1 remaining in /net 
Nov 23 10:19:09 garfield automount[1976]: expire_proc: exp_proc=3109
Nov 23 10:19:09 garfield automount[1976]: handle_child: got pid 3109, sig 0 (0), stat 1 
Nov 23 10:19:09 garfield automount[1976]: sigchld: exp 3109 finished, switching from 2 to 1
Nov 23 10:19:09 garfield automount[1976]: get_pkt: state 2, next 1
Nov 23 10:19:09 garfield automount[1976]: st_ready(): state = 2 
Nov 23 10:19:22 garfield automount[1974]: sig 14 switching from 1 to 2
Nov 23 10:19:22 garfield automount[1974]: get_pkt: state 1, next 2
Nov 23 10:19:22 garfield automount[1974]: st_expire(): state = 1 
Nov 23 10:19:22 garfield automount[1974]: expire_proc: exp_proc=3113
Nov 23 10:19:22 garfield automount[3113]: expire_proc: 15 remaining in /smb 
Nov 23 10:19:22 garfield automount[1974]: handle_child: got pid 3113, sig 0 (0), stat 1 
Nov 23 10:19:22 garfield automount[1974]: sigchld: exp 3113 finished, switching from 2 to 1
Nov 23 10:19:22 garfield automount[1974]: get_pkt: state 2, next 1
Nov 23 10:19:22 garfield automount[1974]: st_ready(): state = 2 

--------------030506090004080305090307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------030506090004080305090307--

