From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [jadevree@mtu.edu: Bug#297359: autofs: replicated server
	not working]
Date: Mon, 28 Feb 2005 20:37:20 +0100
Message-ID: <20050228193720.GA22513@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
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


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Ian,

Would you mind taking a look at this? I don't really have any idea what he's
talking about, but I haven't touched this :-P

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--oyUTqETQ0mS9luUI
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <debbugs@bugs.debian.org>
Envelope-to: root@trofast.sesse.net
Delivery-date: Mon, 28 Feb 2005 19:53:32 +0100
Received: from cassarossa.samfundet.no ([129.241.93.19])
	by trofast.sesse.net with esmtp (Exim 3.36 #1 (Debian))
	id 1D5q1L-0004TP-00
	for <root@trofast.sesse.net>; Mon, 28 Feb 2005 19:53:32 +0100
Received: from mail-kr.bigfoot.com ([211.115.216.228])
	by cassarossa.samfundet.no with smtp (Exim 4.34) id 1D5q1J-0000sp-LJ
	for sesse@samfundet.no; Mon, 28 Feb 2005 19:53:31 +0100
Received: from spohr.debian.org ([128.193.0.4])
	by BFLITEMAIL-KR4.bigfoot.com (LiteMail v3.03(BFLITEMAIL-KR4)) with
	SMTP id 0502281344_BFLITEMAIL-KR4_393411_74210844; 
	Mon, 28 Feb 2005 13:52:19 -0500 EST
Received: from debbugs by spohr.debian.org with local (Exim 3.35 1 (Debian))
	id 1D5pwh-0006bQ-00; Mon, 28 Feb 2005 10:48:43 -0800
X-Loop: owner@bugs.debian.org
Subject: Bug#297359: autofs: replicated server not working
Reply-To: Jon <jadevree@mtu.edu>, 297359@bugs.debian.org
Resent-From: Jon <jadevree@mtu.edu>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: sesse@debian.org (Steinar H. Gunderson)
Resent-Date: Mon, 28 Feb 2005 18:48:40 UTC
Resent-Message-ID: <handler.297359.B.110961586915044@bugs.debian.org>
X-Debian-PR-Message: report 297359
X-Debian-PR-Package: autofs
X-Debian-PR-Keywords: 
Received: via spool by submit@bugs.debian.org id=B.110961586915044
	(code B ref -1); Mon, 28 Feb 2005 18:48:40 UTC
Received: (at submit) by bugs.debian.org; 28 Feb 2005 18:37:49 +0000
Received: from mailoff.mtu.edu [141.219.70.111] 
	by spohr.debian.org with esmtp (Exim 3.35 1 (Debian))
	id 1D5pm9-0003uR-00; Mon, 28 Feb 2005 10:37:49 -0800
Received: from node5.edge.dcsint.mtu.edu (node5.mtu.edu [141.219.69.5])
	by mailoff.mtu.edu (8.11.7p1+Sun/8.11.4) with ESMTP id j1SIbiB20612
	for <submit@bugs.debian.org>; Mon, 28 Feb 2005 13:37:44 -0500 (EST)
Received: from node34.edge.dcsint.mtu.edu (node34.mtu.edu [141.219.69.34])
	by node5.edge.dcsint.mtu.edu (8.12.10/8.12.8) with ESMTP id
	j1SIbiwH007705
	for <submit@bugs.debian.org>; Mon, 28 Feb 2005 13:37:44 -0500
Received: from mail.mtu.edu (campus4.mtu.edu [141.219.70.7])
	by node34.edge.dcsint.mtu.edu (8.12.11/8.12.11) with ESMTP id
	j1SIbhan001275
	for <submit@bugs.debian.org>; Mon, 28 Feb 2005 13:37:43 -0500
	(envelope-from jadevree@mtu.edu)
Received: from node5.edge.dcsint.mtu.edu (node5.mtu.edu [141.219.69.5])
	by mail.mtu.edu (8.11.7p1+Sun/8.11.6) with ESMTP id j1SIbh403322
	for <submit@bugs.debian.org>; Mon, 28 Feb 2005 13:37:43 -0500 (EST)
Received: from tesla (tesla.resnet.mtu.edu [141.219.72.128])
	by node5.edge.dcsint.mtu.edu (8.12.10/8.12.3/auth_ssl.mc v1.0) with
	ESMTP id j1SIbgng007696
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <submit@bugs.debian.org>; Mon, 28 Feb 2005 13:37:43 -0500
Received: from root by tesla with local (Exim 4.50) id 1D5pm2-0000Ro-KM
	for submit@bugs.debian.org; Mon, 28 Feb 2005 13:37:42 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Jon <jadevree@mtu.edu>
To: Debian Bug Tracking System <submit@bugs.debian.org>
X-Mailer: reportbug 3.8
Date: Mon, 28 Feb 2005 13:37:42 -0500
Message-Id: <E1D5pm2-0000Ro-KM@tesla>
X-PMX-Version: 4.7.0.111621, Antispam-Engine: 2.0.2.0,
	Antispam-Data: 2005.2.28.9
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
	__CTYPE_CHARSET_QUOTED 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0,
	__HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
Delivered-To: submit@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02 
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Status: No, hits=-8.0 required=4.0 tests=BAYES_00,HAS_PACKAGE 
	autolearn=no version=2.60-bugs.debian.org_2005_01_02
X-Spam-Level: 
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Status=No hits=0.0 required=5.0 tests=none version=3.0.2
X-CRM114-Version: 20040816.BlameClockworkOrange-auto.3 (regex: TRE TRE 0.7.2
	(GPL)) MF-A10FFB4C 
X-CRM114-Status: Good  ( pR: 68.7589 )

Package: autofs
Version: 4.1.3+4.1.4beta2-3
Severity: normal

The replicated hosts feature of autofs isn't working right on Debian.
The automounter that comes with Debian will only use the first server in
the list and never falls back to the others.

/etc/auto.master:
/srv/autofs     /etc/auto.global

/etc/auto.global:
jon787  -hard,intr,nodev,nosuid         junkers(1):/home/jon787
tesla(2):/home/setec/jon787

This should first try to mount from junkers and then fallback to tesla
if junkers is unavailable according to README.replicated-server
Actual behavior is it tries to talk to junkers and then just fails after
awhile, never trying to contact tesla.

root@tesla:~(0)# ls -l /srv/autofs/jon787/
ls: /srv/autofs/jon787/: No such file or directory

daemon.log:
Feb 28 13:31:50 tesla automount[1660]: failed to mount
/srv/autofs/jon787

I use the exact same configuration on a Gentoo system running autofs
4.1.3 and it is falling back to tesla properly.

-- System Information:
Debian Release: 3.1
  APT prefers unstable
  APT policy: (500, 'unstable')
Architecture: i386 (i686)
Kernel: Linux 2.6.10-1-686
Locale: LANG=C, LC_CTYPE=C (charmap=ANSI_X3.4-1968)

Versions of packages autofs depends on:
ii  debconf                     1.4.46       Debian configuration management sy
ii  libc6                       2.3.2.ds1-20 GNU C Library: Shared libraries an

-- debconf information:
  autofs/upgrade-from-broken-version:


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--oyUTqETQ0mS9luUI--

