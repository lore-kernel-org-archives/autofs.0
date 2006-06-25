From: "Steinar H. Gunderson" <sesse@debian.org>
Subject: [schmorp@schmorp.de: Bug#349073: more insights]
Date: Sun, 25 Jun 2006 13:30:09 +0200
Message-ID: <20060625113009.GA2627@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Passing further on :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--UugvWAfsgieZRqgk
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <sesse=root=trofast.ipv6.sesse.net=kxteebrj@samfundet.no>
Envelope-to: root@trofast.ipv6.sesse.net
Delivery-date: Sun, 25 Jun 2006 13:25:26 +0200
Received: from [2001:700:300:dc0f:2e0:81ff:fe2b:4b25]
	(helo=cassarossa.samfundet.no)
	by trofast.sesse.net with esmtp (Exim 3.36 #1 (Debian))
	id 1FuSk2-0000l2-00
	for <root@trofast.ipv6.sesse.net>; Sun, 25 Jun 2006 13:25:26 +0200
Received: from sesse by cassarossa.samfundet.no with local (Exim 4.50)
	id 1FuSk2-0004X6-OL
	for root@trofast.ipv6.sesse.net; Sun, 25 Jun 2006 13:25:26 +0200
Received: from mail-kr.bigfoot.com ([211.115.216.228])
	by cassarossa.samfundet.no with smtp (Exim 4.50) id 1FuSjz-0004CN-V7
	for sesse@samfundet.no; Sun, 25 Jun 2006 13:25:26 +0200
Received: from spohr.debian.org ([140.211.166.43])
	by BFLITEMAIL-KR4.bigfoot.com (LiteMail v3.03(BFLITEMAIL-KR4)) with
	SMTP id 0606250721_BFLITEMAIL-KR4_591883_17952135; 
	Sun, 25 Jun 2006 07:24:54 -0400 EST
Received: from debbugs by spohr.debian.org with local (Exim 4.50)
	id 1FuSd4-0002CJ-Hu; Sun, 25 Jun 2006 04:18:14 -0700
X-Loop: owner@bugs.debian.org
Subject: Bug#349073: more insights
Reply-To: Marc Lehmann <schmorp@schmorp.de>, 349073@bugs.debian.org
Resent-From: Marc Lehmann <schmorp@schmorp.de>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: sesse@debian.org (Steinar H. Gunderson)
Resent-Date: Sun, 25 Jun 2006 11:18:13 UTC
Resent-Message-ID: <handler.349073.B349073.115123284410538@bugs.debian.org>
X-Debian-PR-Message: report 349073
X-Debian-PR-Package: autofs
X-Debian-PR-Keywords: 
X-Debian-Pr-Source: autofs
Received: via spool by 349073-submit@bugs.debian.org id=B349073.115123284410538
	(code B ref 349073); Sun, 25 Jun 2006 11:18:13 UTC
Received: (at 349073) by bugs.debian.org; 25 Jun 2006 10:54:04 +0000
Received: from rain.plan9.de ([193.108.181.162] ident=schmorp)
	by spohr.debian.org with esmtp (Exim 4.50) id 1FuSFf-0002iB-Mi
	for 349073@bugs.debian.org; Sun, 25 Jun 2006 03:54:04 -0700
Received: from [10.0.0.17] (helo=ruth.plan9.de ident=mail)
	by rain.plan9.de with esmtp (Exim 4.50) id 1FuSFi-00037v-0q
	for 349073@bugs.debian.org; Sun, 25 Jun 2006 12:54:06 +0200
Received: from [10.0.0.5] (helo=mailout.schmorp.de ident=schmorp)
	by ruth.plan9.de with esmtp (Exim 4.54) id 1FuSFd-0004V4-Li
	for 349073@bugs.debian.org; Sun, 25 Jun 2006 12:54:01 +0200
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by mailout.schmorp.de with esmtp (Exim 4.60)
	(envelope-from <root@schmorp.de>) id 1FuSFd-0004fr-Ay
	for 349073@bugs.debian.org; Sun, 25 Jun 2006 12:54:01 +0200
Received: from root by cerebro.laendle with local (Exim 4.34)
	id 1FuSFd-0002vY-2g
	for 349073@bugs.debian.org; Sun, 25 Jun 2006 12:54:01 +0200
Date: Sun, 25 Jun 2006 12:54:01 +0200
From: Marc Lehmann <schmorp@schmorp.de>
To: 349073@bugs.debian.org
Message-ID: <20060625105400.GA11114@schmorp.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
	Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02 
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Level: 
X-Spam-Status: No, hits=0.6 required=4.0 tests=BAYES_00, UPPERCASE_25_50, WIFE 
	autolearn=no version=2.60-bugs.debian.org_2005_01_02
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
Resent-Date: Sun, 25 Jun 2006 04:18:14 -0700
X-CRM114-Version: 20060118-BlameTheReavers ( TRE 0.7.3 (LGPL) ) MF-53A4E894
	[pR: 56.6020]
X-CRM114-Status: Good  ( pR: 56.6020 )


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, I now got some much better insights, and I can reproduce it at will, too
:)

Attached is an strace of automount that was made when I did "cd
archive". I checked that neither /fs/doom nor /fs/doom_localvol4 were
mounted (they were expired by automount earlier).

What seems to cause the problem is this:

   doom:/localvol4 /debian32/fs/doom_localvol4 nfs rw,v3,rsize=8192,wsize=8192,hard,intr,lock,proto=tcp,addr=doom 0 0
   doom:/ /debian32/fs/doom nfs rw,v3,rsize=8192,wsize=8192,hard,intr,lock,proto=tcp,addr=doom 0 0

Let me explain. I have a 32 bit chrooted debian on /debian32, and I do
"mount -n --rbind /fs /debian32/fs".

This seems to cause the (now reproducable) problem. However, I have
similar problems with the same automount setup on my 32 bit laptop where I
do not use a chrooted debian env or mount --rbind.

Hope this helps.

Here's my /proc/mounts, for reference:

   rootfs / rootfs rw 0 0
   /dev/root / xfs rw,nodiratime 0 0
   none /proc proc rw 0 0
   none /sys sysfs rw 0 0
   none /dev/pts devpts rw 0 0
   /dev/vg_cerebro/localvol /localvol reiserfs rw,nodiratime 0 0
   none /dev/shm tmpfs rw 0 0
   none /proc/bus/usb usbfs rw 0 0
   automount(pid1309) /fs autofs rw 0 0
   nfsd /proc/fs/nfsd nfsd rw 0 0
   /dev/loop6 /wd reiserfs rw,noatime 0 0
   /dev/loop5 /temp xfs rw,noatime,sunit=32,swidth=96 0 0
   /dev/vg_cerebro/localvol /debian32/root reiserfs rw,nodiratime 0 0
   none /debian32/proc proc rw 0 0
   none /debian32/proc/bus/usb usbfs rw 0 0
   nfsd /debian32/proc/fs/nfsd nfsd rw 0 0
   none /debian32/dev/pts devpts rw 0 0
   /dev/root /debian32/tmp xfs rw,nodiratime 0 0
   /dev/vg_cerebro/localvol /debian32/usr/src reiserfs rw,nodiratime 0 0
   automount(pid1309) /debian32/fs autofs rw 0 0
   doom:/localvol4 /debian32/fs/doom_localvol4 nfs rw,v3,rsize=8192,wsize=8192,hard,intr,lock,proto=tcp,addr=doom 0 0
   doom:/ /debian32/fs/doom nfs rw,v3,rsize=8192,wsize=8192,hard,intr,lock,proto=tcp,addr=doom 0 0
   /dev/root /debian32/etc/gvpe xfs rw,nodiratime 0 0
   /dev/root /debian32/home xfs rw,nodiratime 0 0
   /dev/loop5 /debian32/temp xfs rw,noatime,sunit=32,swidth=96 0 0


-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=x

1309  poll([{fd=3, events=POLLIN, revents=POLLIN}, {fd=5, events=POLLIN}], 2, -1) = 1
1309  read(3, "\4\0\0\0\0\0\0\0>\0\0\0\10\0\0\0doom/var\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 272) = 272
1309  time([1151232422])                = 1151232422
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:02 automount[1309]: handle_packet: type = 0\n", 61, MSG_NOSIGNAL, NULL, 0) = 61
1309  time([1151232422])                = 1151232422
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:02 automount[1309]: handle_packet_missing: token 62, name doom/var\n", 84, MSG_NOSIGNAL, NULL, 0) = 84
1309  chdir("/fs")                      = 0
1309  lstat("doom/var", 0x7ffffff40430) = -1 ENOENT (No such file or directory)
1309  chdir("/")                        = 0
1309  rt_sigprocmask(SIG_BLOCK, [CHLD], NULL, 8) = 0
1309  rt_sigprocmask(SIG_UNBLOCK, [CHLD], NULL, 8) = 0
1309  time([1151232422])                = 1151232422
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<30>Jun 25 12:47:02 automount[1309]: attempting to mount entry /fs/doom/var", 75, MSG_NOSIGNAL, NULL, 0) = 75
1309  rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [], 8) = 0
1309  clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x2b9369407d10) = 11158
1309  rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
1309  chdir("/")                        = 0
1309  poll( <unfinished ...>
11158 rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], NULL, 8) = 0
11158 rt_sigaction(SIGHUP, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGQUIT, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGILL, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGTRAP, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGABRT, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGBUS, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGFPE, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGKILL, {SIG_IGN}, NULL, 8) = -1 EINVAL (Invalid argument)
11158 rt_sigaction(SIGUSR1, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGSEGV, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGUSR2, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGALRM, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGTERM, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGSTKFLT, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGCHLD, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGCONT, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGSTOP, {SIG_IGN}, NULL, 8) = -1 EINVAL (Invalid argument)
11158 rt_sigaction(SIGTSTP, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGTTIN, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGTTOU, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGURG, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGXCPU, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGXFSZ, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGVTALRM, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGPROF, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGWINCH, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGIO, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGPWR, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGSYS, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_2, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_3, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_4, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_5, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_6, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_7, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_8, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_9, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_10, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_11, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_12, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_13, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_14, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_15, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_16, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_17, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_18, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_19, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_20, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_21, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_22, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_23, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_24, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_25, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_26, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_27, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_28, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_29, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_30, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_31, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGRT_32, {SIG_IGN}, NULL, 8) = 0
11158 rt_sigaction(SIGCHLD, {SIG_DFL}, NULL, 8) = 0
11158 rt_sigprocmask(SIG_UNBLOCK, ~[RTMIN RT_1], NULL, 8) = 0
11158 close(3)                          = 0
11158 close(4)                          = 0
11158 close(5)                          = 0
11158 close(6)                          = 0
11158 chdir("/fs")                      = 0
11158 time(NULL)                        = 1151232422
11158 stat("/etc/maps/fs", {st_mode=S_IFREG|0644, st_size=1741, ...}) = 0
11158 chdir("/")                        = 0
11158 time([1151232422])                = 1151232422
11158 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11158 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11158 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11158 sendto(7, "<27>Jun 25 12:47:02 automount[11158]: failed to mount /fs/doom/var", 66, MSG_NOSIGNAL, NULL, 0) = 66
11158 time([1151232422])                = 1151232422
11158 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11158 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11158 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11158 sendto(7, "<31>Jun 25 12:47:02 automount[11158]: umount_multi: path=/fs/doom/var incl=1\n", 77, MSG_NOSIGNAL, NULL, 0) = 77
11158 open("/etc/mtab", O_RDONLY)       = 3
11158 fstat(3, {st_mode=S_IFREG|0644, st_size=361, ...}) = 0
11158 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b9368fc6000
11158 read(3, "/dev/sda2 / xfs rw,nodiratime 0 0\n/dev/mapper/vg_cerebro-localvol /localvol reiserfs rw,nodiratime,data=writeback 0 0\nnone /dev/shm tmpfs rw,size=128M,mode=1777 0 0\nnone /proc/bus/usb usbfs rw 0 0\nautomount(pid1309) /fs autofs rw,fd=4,pgrp=1309,minproto=2,maxproto=4 0 0\n/dev/loop6 /wd reiserfs rw,noatime,data=writeback 0 0\n/dev/loop5 /temp xfs rw,noatime 0 0\n", 4096) = 361
11158 read(3, "", 4096)                 = 0
11158 close(3)                          = 0
11158 munmap(0x2b9368fc6000, 4096)      = 0
11158 time([1151232422])                = 1151232422
11158 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11158 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11158 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11158 sendto(7, "<28>Jun 25 12:47:02 automount[11158]: umount_multi: no mounts found under /fs/doom/var", 86, MSG_NOSIGNAL, NULL, 0) = 86
11158 lstat("/fs/doom/var", 0x7ffffff3e100) = -1 ENOENT (No such file or directory)
11158 exit_group(1)                     = ?
1309  <... poll resumed> [{fd=3, events=POLLIN}, {fd=5, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
1309  --- SIGCHLD (Child exited) @ 0 (0) ---
1309  wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], WNOHANG, NULL) = 11158
1309  time([1151232422])                = 1151232422
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:02 automount[1309]: handle_child: got pid 11158, sig 0 (0), stat 1\n", 84, MSG_NOSIGNAL, NULL, 0) = 84
1309  time([1151232422])                = 1151232422
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:02 automount[1309]: sig_child: found pending iop pid 11158: signalled 0 (sig 0), exit status 1", 111, MSG_NOSIGNAL, NULL, 0) = 111
1309  time([1151232422])                = 1151232422
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:02 automount[1309]: send_fail: token=62\n", 57, MSG_NOSIGNAL, NULL, 0) = 57
1309  ioctl(4, AUTOFS_IOC_FAIL, 0x3e)   = 0
1309  wait4(-1, 0x7ffffff3f034, WNOHANG, NULL) = -1 ECHILD (No child processes)
1309  rt_sigreturn(0xffffffffffffffff)  = -1 EINTR (Interrupted system call)
1309  poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
1309  --- SIGALRM (Alarm clock) @ 0 (0) ---
1309  write(6, "\2\0\0\0", 4)           = 4
1309  time([1151232423])                = 1151232423
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:03 automount[1309]: sig 14 switching from 1 to 2", 65, MSG_NOSIGNAL, NULL, 0) = 65
1309  rt_sigreturn(0x5555556668c0)      = -1 EINTR (Interrupted system call)
1309  poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN, revents=POLLIN}], 2, -1) = 1
1309  read(5, "\2\0\0\0", 4)            = 4
1309  rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [], 8) = 0
1309  time([1151232423])                = 1151232423
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:03 automount[1309]: get_pkt: state 1, next 2", 61, MSG_NOSIGNAL, NULL, 0) = 61
1309  time([1151232423])                = 1151232423
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:03 automount[1309]: st_expire(): state = 1\n", 60, MSG_NOSIGNAL, NULL, 0) = 60
1309  rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [HUP USR1 USR2 ALRM TERM CHLD], 8) = 0
1309  clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x2b9369407d10) = 11159
1309  time([1151232423])                = 1151232423
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:03 automount[1309]: expire_proc: exp_proc=11159", 64, MSG_NOSIGNAL, NULL, 0) = 64
11159 rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1],  <unfinished ...>
1309  rt_sigprocmask(SIG_SETMASK, [HUP USR1 USR2 ALRM TERM], NULL, 8) = 0
1309  poll( <unfinished ...>
11159 <... rt_sigprocmask resumed> NULL, 8) = 0
11159 rt_sigaction(SIGHUP, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGQUIT, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGILL, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGTRAP, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGABRT, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGBUS, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGFPE, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGKILL, {SIG_IGN}, NULL, 8) = -1 EINVAL (Invalid argument)
11159 rt_sigaction(SIGUSR1, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGSEGV, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGUSR2, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGALRM, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGTERM, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGSTKFLT, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGCHLD, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGCONT, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGSTOP, {SIG_IGN}, NULL, 8) = -1 EINVAL (Invalid argument)
11159 rt_sigaction(SIGTSTP, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGTTIN, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGTTOU, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGURG, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGXCPU, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGXFSZ, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGVTALRM, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGPROF, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGWINCH, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGIO, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGPWR, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGSYS, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_2, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_3, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_4, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_5, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_6, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_7, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_8, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_9, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_10, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_11, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_12, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_13, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_14, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_15, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_16, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_17, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_18, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_19, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_20, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_21, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_22, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_23, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_24, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_25, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_26, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_27, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_28, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_29, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_30, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_31, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGRT_32, {SIG_IGN}, NULL, 8) = 0
11159 rt_sigaction(SIGCHLD, {SIG_DFL}, NULL, 8) = 0
11159 rt_sigprocmask(SIG_UNBLOCK, ~[RTMIN RT_1], NULL, 8) = 0
11159 close(3)                          = 0
11159 close(5)                          = 0
11159 close(6)                          = 0
11159 getpriority(PRIO_PROCESS, 0)      = 20
11159 setpriority(PRIO_PROCESS, 0, 4294967292) = 0
11159 getpriority(PRIO_PROCESS, 0)      = 24
11159 lstat("/fs", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
11159 open("/fs", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
11159 fstat(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
11159 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
11159 getdents64(3, /* 6 entries */, 4096) = 160
11159 getdents64(3, /* 0 entries */, 4096) = 0
11159 close(3)                          = 0
11159 lstat("/fs/wd", {st_mode=S_IFLNK|0555, st_size=3, ...}) = 0
11159 lstat("/fs/exg", {st_mode=S_IFLNK|0555, st_size=11, ...}) = 0
11159 lstat("/fs/doom_localvol4", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
11159 open("/fs/doom_localvol4", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
11159 fstat(3, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
11159 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
11159 getdents64(3, /* 2 entries */, 4096) = 48
11159 getdents64(3, /* 0 entries */, 4096) = 0
11159 close(3)                          = 0
11159 lstat("/fs/doom", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
11159 open("/fs/doom", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
11159 fstat(3, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
11159 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
11159 getdents64(3, /* 2 entries */, 4096) = 48
11159 getdents64(3, /* 0 entries */, 4096) = 0
11159 close(3)                          = 0
11159 ioctl(4, AUTOFS_IOC_EXPIRE_MULTI, 0x7ffffff3f2bc) = -1 EAGAIN (Resource temporarily unavailable)
11159 lstat("/fs", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
11159 open("/fs", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
11159 fstat(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
11159 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
11159 getdents64(3, /* 6 entries */, 4096) = 160
11159 getdents64(3, /* 0 entries */, 4096) = 0
11159 close(3)                          = 0
11159 lstat("/fs/wd", {st_mode=S_IFLNK|0555, st_size=3, ...}) = 0
11159 lstat("/fs/exg", {st_mode=S_IFLNK|0555, st_size=11, ...}) = 0
11159 lstat("/fs/doom_localvol4", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
11159 open("/fs/doom_localvol4", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
11159 fstat(3, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
11159 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
11159 getdents64(3, /* 2 entries */, 4096) = 48
11159 getdents64(3, /* 0 entries */, 4096) = 0
11159 close(3)                          = 0
11159 lstat("/fs/doom", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
11159 open("/fs/doom", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
11159 fstat(3, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
11159 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
11159 getdents64(3, /* 2 entries */, 4096) = 48
11159 getdents64(3, /* 0 entries */, 4096) = 0
11159 close(3)                          = 0
11159 time([1151232423])                = 1151232423
11159 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11159 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11159 stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
11159 sendto(7, "<31>Jun 25 12:47:03 automount[11159]: expire_proc: 2 remaining in /fs\n", 70, MSG_NOSIGNAL, NULL, 0) = 70
11159 exit_group(1)                     = ?
1309  <... poll resumed> [{fd=3, events=POLLIN}, {fd=5, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
1309  --- SIGCHLD (Child exited) @ 0 (0) ---
1309  wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], WNOHANG, NULL) = 11159
1309  time([1151232423])                = 1151232423
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:03 automount[1309]: handle_child: got pid 11159, sig 0 (0), stat 1\n", 84, MSG_NOSIGNAL, NULL, 0) = 84
1309  alarm(8)                          = 0
1309  time([1151232423])                = 1151232423
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:03 automount[1309]: sigchld: exp 11159 finished, switching from 2 to 1", 87, MSG_NOSIGNAL, NULL, 0) = 87
1309  wait4(-1, 0x7ffffff3f034, WNOHANG, NULL) = -1 ECHILD (No child processes)
1309  write(6, "\1\0\0\0", 4)           = 4
1309  rt_sigreturn(0x6)                 = -1 EINTR (Interrupted system call)
1309  poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN, revents=POLLIN}], 2, -1) = 1
1309  read(5, "\1\0\0\0", 4)            = 4
1309  rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [HUP USR1 USR2 ALRM TERM], 8) = 0
1309  time([1151232423])                = 1151232423
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:03 automount[1309]: get_pkt: state 2, next 1", 61, MSG_NOSIGNAL, NULL, 0) = 61
1309  time([1151232423])                = 1151232423
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  stat("/etc/localtime", {st_mode=S_IFREG|0644, st_size=837, ...}) = 0
1309  sendto(7, "<31>Jun 25 12:47:03 automount[1309]: st_ready(): state = 2\n", 59, MSG_NOSIGNAL, NULL, 0) = 59
1309  rt_sigprocmask(SIG_UNBLOCK, [HUP USR1 USR2 ALRM TERM CHLD], NULL, 8) = 0
1309  poll( <unfinished ...>

--nFreZHaLTZJo0R7j--



--UugvWAfsgieZRqgk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--UugvWAfsgieZRqgk--

