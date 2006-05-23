From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [dubtsov@iis.nsk.su: Bug#319904: autofs: workaround]
Date: Tue, 23 May 2006 12:45:44 +0200
Message-ID: <20060523104544.GA3982@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
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


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I'm forwarding this here; I hope it's useful somehow. :-) For those not
following context, it's the "does not umount after timeout" problem, which
I'm not sure is related to the cache problems etc. or not.

The entire bug log can be seen at http://bugs.debian.org/319904 .

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--MGYHOYXEY6WxJCY8
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <sesse=root=trofast.ipv6.sesse.net=kxteebrj@samfundet.no>
Envelope-to: root@trofast.ipv6.sesse.net
Delivery-date: Tue, 23 May 2006 12:35:07 +0200
Received: from cassarossa.samfundet.no ([2001:700:300:dc0f::1919])
	by trofast.sesse.net with esmtp (Exim 3.36 #1 (Debian))
	id 1FiUEE-00011n-00
	for <root@trofast.ipv6.sesse.net>; Tue, 23 May 2006 12:35:06 +0200
Received: from sesse by cassarossa.samfundet.no with local (Exim 4.50)
	id 1FiUEE-0008Mu-MD
	for root@trofast.ipv6.sesse.net; Tue, 23 May 2006 12:35:06 +0200
Received: from mail-kr1.bigfoot.com ([210.109.98.21])
	by cassarossa.samfundet.no with smtp (Exim 4.50) id 1FiUED-0008D4-Q6
	for sesse@samfundet.no; Tue, 23 May 2006 12:35:06 +0200
Received: from mail-kr.bigfoot.com ([211.115.216.225])
	by BFLITEMAIL-KR1.bigfoot.com (LiteMail v3.03(BFLITEMAIL-KR1)) with
	SMTP id 0605230627_BFLITEMAIL-KR1_464215_57423139; 
	Tue, 23 May 2006 06:35:02 -0400 EST
Received: from spohr.debian.org ([140.211.166.43])
	by BFLITEMAIL-KR2.bigfoot.com (LiteMail v3.03(BFLITEMAIL-KR2)) with
	SMTP id 0605230634_BFLITEMAIL-KR2_633654_11147555; 
	Tue, 23 May 2006 06:35:00 -0400 EST
Received: from debbugs by spohr.debian.org with local (Exim 4.50)
	id 1FiUCY-0001Am-PR; Tue, 23 May 2006 03:33:22 -0700
X-Loop: owner@bugs.debian.org
Subject: Bug#319904: autofs: workaround
Reply-To: Roman Dubtsov <dubtsov@iis.nsk.su>, 319904@bugs.debian.org
Resent-From: Roman Dubtsov <dubtsov@iis.nsk.su>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: sesse@debian.org (Steinar H. Gunderson)
Resent-Date: Tue, 23 May 2006 10:33:20 UTC
Resent-Message-ID: <handler.319904.B319904.114837852825449@bugs.debian.org>
X-Debian-PR-Message: report 319904
X-Debian-PR-Package: autofs
X-Debian-PR-Keywords: 
X-Debian-Pr-Source: autofs
Received: via spool by 319904-submit@bugs.debian.org id=B319904.114837852825449
	(code B ref 319904); Tue, 23 May 2006 10:33:20 UTC
Received: (at 319904) by bugs.debian.org; 23 May 2006 10:02:08 +0000
Received: from pepsy.iis.nsk.su ([194.226.177.118])
	by spohr.debian.org with esmtp (Exim 4.50) id 1FiTiI-0005yw-6x
	for 319904@bugs.debian.org; Tue, 23 May 2006 03:02:06 -0700
Received: from busa by pepsy.iis.nsk.su with local (Exim 4.62)
	(envelope-from <dubtsov@iis.nsk.su>)
	id 1FiTht-0002PP-5b; Tue, 23 May 2006 17:01:41 +0700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Roman Dubtsov <dubtsov@iis.nsk.su>
To: Debian Bug Tracking System <319904@bugs.debian.org>
Message-ID: <20060523100141.8872.6541.reportbug@pepsy.iis.nsk.su>
X-Mailer: reportbug 3.20
Date: Tue, 23 May 2006 17:01:41 +0700
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02 
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Level: 
X-Spam-Status: No, hits=-8.0 required=4.0 tests=BAYES_00,HAS_PACKAGE 
	autolearn=no version=2.60-bugs.debian.org_2005_01_02
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
Resent-Date: Tue, 23 May 2006 03:33:22 -0700
X-CRM114-Version: 20060118-BlameTheReavers ( TRE 0.7.3 (LGPL) ) MF-53A4E894
	[pR: 115.7068]
X-CRM114-Status: Good  ( pR: 115.7068 )

Package: autofs
Version: 4.1.4-10
Followup-For: Bug #319904


This bug can be worked around by using autofs module instead of autofs4.
Autofs will complain on boot, but it works for me...

Also, I would like to note that this bug was introduced somewhere after
2.6.13.

-- System Information:
Debian Release: testing/unstable
  APT prefers unstable
  APT policy: (990, 'unstable'), (500, 'testing'), (500, 'stable'), (1, 'experimental')
Architecture: i386 (i686)
Shell:  /bin/sh linked to /bin/dash
Kernel: Linux 2.6.16-1-k7
Locale: LANG=ru_RU.KOI8-R, LC_CTYPE=ru_RU.KOI8-R (charmap=KOI8-R)

Versions of packages autofs depends on:
ii  libc6                         2.3.6-9    GNU C Library: Shared libraries
ii  ucf                           2.0010     Update Configuration File: preserv

Versions of packages autofs recommends:
pn  nfs-common                    <none>     (no description available)

-- debconf information:
  autofs/upgrade-from-broken-version:



--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--MGYHOYXEY6WxJCY8--

