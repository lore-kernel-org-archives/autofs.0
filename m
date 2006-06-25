From: "Steinar H. Gunderson" <sesse@debian.org>
Subject: [schmorp@schmorp.de: Bug#349073: mounting manually works
	just fine]
Date: Sun, 25 Jun 2006 13:14:18 +0200
Message-ID: <20060625111418.GB2739@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
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


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I'm not sure how useful this is in tracking down the expiry problems, but it
might give you a couple of hints, so I'm passing it on. :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--GvXjxJ+pjyke8COw
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <sesse=root=trofast.ipv6.sesse.net=kxteebrj@samfundet.no>
Envelope-to: root@trofast.ipv6.sesse.net
Delivery-date: Sun, 25 Jun 2006 12:49:12 +0200
Received: from [2001:700:300:dc0f:2e0:81ff:fe2b:4b25]
	(helo=cassarossa.samfundet.no)
	by trofast.sesse.net with esmtp (Exim 3.36 #1 (Debian))
	id 1FuSAy-0000gx-00
	for <root@trofast.ipv6.sesse.net>; Sun, 25 Jun 2006 12:49:12 +0200
Received: from sesse by cassarossa.samfundet.no with local (Exim 4.50)
	id 1FuSAy-0001jU-5y
	for root@trofast.ipv6.sesse.net; Sun, 25 Jun 2006 12:49:12 +0200
Received: from mail-kr.bigfoot.com ([211.115.216.252])
	by cassarossa.samfundet.no with smtp (Exim 4.50) id 1FuSAv-0001jJ-6q
	for sesse@samfundet.no; Sun, 25 Jun 2006 12:49:12 +0200
Received: from spohr.debian.org ([140.211.166.43])
	by BFLITEMAIL-KR5.bigfoot.com (LiteMail v3.03(BFLITEMAIL-KR5)) with
	SMTP id 0606251944_BFLITEMAIL-KR5_508807_24078731; 
	Sun, 25 Jun 2006 19:48:36 +0900 EST
Received: from debbugs by spohr.debian.org with local (Exim 4.50)
	id 1FuRva-00032d-Ie; Sun, 25 Jun 2006 03:33:18 -0700
X-Loop: owner@bugs.debian.org
Subject: Bug#349073: mounting manually works just fine
Reply-To: Marc Lehmann <schmorp@schmorp.de>, 349073@bugs.debian.org
Resent-From: Marc Lehmann <schmorp@schmorp.de>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: sesse@debian.org (Steinar H. Gunderson)
Resent-Date: Sun, 25 Jun 2006 10:33:17 UTC
Resent-Message-ID: <handler.349073.B349073.11512314685319@bugs.debian.org>
X-Debian-PR-Message: report 349073
X-Debian-PR-Package: autofs
X-Debian-PR-Keywords: 
X-Debian-Pr-Source: autofs
Received: via spool by 349073-submit@bugs.debian.org id=B349073.11512314685319
	(code B ref 349073); Sun, 25 Jun 2006 10:33:17 UTC
Received: (at 349073) by bugs.debian.org; 25 Jun 2006 10:31:08 +0000
Received: from rain.plan9.de ([193.108.181.162] ident=schmorp)
	by spohr.debian.org with esmtp (Exim 4.50) id 1FuRtU-0001N7-5k
	for 349073@bugs.debian.org; Sun, 25 Jun 2006 03:31:08 -0700
Received: from [10.0.0.17] (helo=ruth.plan9.de ident=mail)
	by rain.plan9.de with esmtp (Exim 4.50) id 1FuRtW-0002El-Dr
	for 349073@bugs.debian.org; Sun, 25 Jun 2006 12:31:10 +0200
Received: from [10.0.0.5] (helo=mailout.schmorp.de ident=schmorp)
	by ruth.plan9.de with esmtp (Exim 4.54) id 1FuRtS-0004M6-3P
	for 349073@bugs.debian.org; Sun, 25 Jun 2006 12:31:06 +0200
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by mailout.schmorp.de with esmtp (Exim 4.60)
	(envelope-from <root@schmorp.de>) id 1FuRtR-0004M6-RC
	for 349073@bugs.debian.org; Sun, 25 Jun 2006 12:31:05 +0200
Received: from root by cerebro.laendle with local (Exim 4.34)
	id 1FuRtR-0002cQ-DD
	for 349073@bugs.debian.org; Sun, 25 Jun 2006 12:31:05 +0200
Date: Sun, 25 Jun 2006 12:31:04 +0200
From: Marc Lehmann <schmorp@schmorp.de>
To: 349073@bugs.debian.org
Message-ID: <20060625103103.GA5433@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
	Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02 
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Level: 
X-Spam-Status: No, hits=-3.0 required=4.0 tests=BAYES_00 autolearn=no 
	version=2.60-bugs.debian.org_2005_01_02
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
Resent-Date: Sun, 25 Jun 2006 03:33:18 -0700
X-CRM114-Version: 20060118-BlameTheReavers ( TRE 0.7.3 (LGPL) ) MF-53A4E894
	[pR: 59.2012]
X-CRM114-Status: Good  ( pR: 59.2012 )

Just to entertain you a bit, I found out that often (but not always), one
can manually mount the required nfs volumes and everything works again.

   $ cd archive
   bash: cd: archive: No such file or directory
   $ ls -ld archive
   lrwxrwxrwx 1 root root 32 May  8 10:19 archive -> /fs/doom/var/lib/mythtv/archive/

(== the usual case, although with kernel 2.6.16.9).

   $ mount doom:/ /fs/doom
   $ mount doom:/localvol4 /fs/doom_localvol4
   $ cd archive
   $ # worked

So just *maybe*, what hapeons is that automount tries to mount the volume
and fails for whatever reason (it would be interesting to know it, maybe
I can find out), and then leaves the mountpoint in an unusable state till
reboot.

I think one could investigate this path, to see what happens if mounting
the volume fails in autmount. Likely it doesn't have a clean path to back
out if this happens (it might return an error in this access, but *must*
retry eventually, otherwise intermittent errors would require reboots of
clients).

Just a theory, of course. I'll try to find out what causes the mount
failure, although this will not be easy.

Peculiar are these messages:

   Jun 25 12:08:02 cerebro automount[1309]: attempting to mount entry /fs/doom/var
   Jun 25 12:08:02 cerebro automount[3452]: failed to mount /fs/doom/var
   Jun 25 12:08:02 cerebro automount[3452]: umount_multi: no mounts found under /fs/doom/var
   Jun 25 12:08:10 cerebro automount[1309]: attempting to mount entry /fs/doom/root
   Jun 25 12:08:10 cerebro automount[3460]: failed to mount /fs/doom/root
   Jun 25 12:08:10 cerebro automount[3460]: umount_multi: no mounts found under /fs/doom/root

As the mountpoints mentioned do not exist (/fs/doom is a mountpoint, but
not /fs/doom/something).

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE



--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--GvXjxJ+pjyke8COw--

