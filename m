From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [laurichj@bioinfo.ucr.edu: Bug#310452: autofs: ghosting
	doesn't work]
Date: Mon, 23 May 2005 19:26:11 +0200
Message-ID: <20050523172611.GA19077@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
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
Cc: 310452@bugs.debian.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Forwarding this upstream.

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--yrj/dFKFPuw6o+aM
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <debbugs@bugs.debian.org>
Envelope-to: root@trofast.sesse.net
Delivery-date: Mon, 23 May 2005 19:23:39 +0200
Received: from cassarossa.samfundet.no ([129.241.93.19])
	by trofast.sesse.net with esmtp (Exim 3.36 #1 (Debian))
	id 1DaGeR-0004ts-00
	for <root@trofast.sesse.net>; Mon, 23 May 2005 19:23:39 +0200
Received: from mail-kr.bigfoot.com ([211.115.216.226])
	by cassarossa.samfundet.no with smtp (Exim 4.34) id 1DaGeO-00036j-U4
	for sesse@samfundet.no; Mon, 23 May 2005 19:23:38 +0200
Received: from spohr.debian.org ([140.211.166.43])
	by BFLITEMAIL-KR3.bigfoot.com (LiteMail v3.03(BFLITEMAIL-KR3)) with
	SMTP id 0505231315_BFLITEMAIL-KR3_434432_99825702; 
	Mon, 23 May 2005 13:29:27 -0400 EST
Received: from debbugs by spohr.debian.org with local (Exim 3.35 1 (Debian))
	id 1DaGZ1-0002Wx-00; Mon, 23 May 2005 10:18:03 -0700
X-Loop: owner@bugs.debian.org
Subject: Bug#310452: autofs: ghosting doesn't work
Reply-To: Josh Lauricha <laurichj@bioinfo.ucr.edu>, 310452@bugs.debian.org
Resent-From: Josh Lauricha <laurichj@bioinfo.ucr.edu>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: sesse@debian.org (Steinar H. Gunderson)
Resent-Date: Mon, 23 May 2005 17:18:02 UTC
Resent-Message-ID: <handler.310452.B.111686799630597@bugs.debian.org>
X-Debian-PR-Message: report 310452
X-Debian-PR-Package: autofs
X-Debian-PR-Keywords: 
Received: via spool by submit@bugs.debian.org id=B.111686799630597
	(code B ref -1); Mon, 23 May 2005 17:18:02 UTC
Received: (at submit) by bugs.debian.org; 23 May 2005 17:06:36 +0000
Received: from bioinfo.ucr.edu [138.23.191.227] 
	by spohr.debian.org with esmtp (Exim 3.35 1 (Debian))
	id 1DaGNw-0007jz-00; Mon, 23 May 2005 10:06:36 -0700
Received: from batch107a.ucr.edu ([138.23.191.244])
	by bioinfo.ucr.edu with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1DaGNR-0005SL-J8
	for submit@bugs.debian.org; Mon, 23 May 2005 10:06:05 -0700
Received: from laurichj by batch107a.ucr.edu with local (Exim 4.50)
	id 1DaGNR-0002dG-1W
	for submit@bugs.debian.org; Mon, 23 May 2005 10:06:05 -0700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Josh Lauricha <laurichj@bioinfo.ucr.edu>
To: Debian Bug Tracking System <submit@bugs.debian.org>
X-Mailer: reportbug 3.8
Date: Mon, 23 May 2005 10:06:04 -0700
Message-Id: <E1DaGNR-0002dG-1W@batch107a.ucr.edu>
Delivered-To: submit@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02 
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Status: No, hits=-8.0 required=4.0 tests=BAYES_00,HAS_PACKAGE 
	autolearn=no version=2.60-bugs.debian.org_2005_01_02
X-Spam-Level: 
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
X-Spam-Score: 2.3 (++)
X-Spam-Report: Status=No hits=2.3 required=5.0 tests=INVALID_TZ_EST
	version=3.0.3
X-CRM114-Version: 20050415.BlameTheIRS ( TRE 0.7.2 (GPL) ) MF-DAE15AAC [pR:
	119.8109]
X-CRM114-Status: Good  ( pR: 119.8109 )

Package: autofs
Version: 4.1.3+4.1.4beta2-7
Severity: normal

When ghosting a directory, autofs fails to mount an unmounted mount
unless the directory itself is accessed. For instance, when
/usr/local is a map, and bin/ is unmounted, a ghosting autofs will not
mount bin/ if you access bin/foo. 

I've worked around this in two ways, first an ls /usr/local/bin will fix
it temporarily, causing bin to be mounted. Second, removing ghosting
fixes it.  However, I'd really like to have ghosting available.

-- System Information:
Debian Release: 3.1
  APT prefers testing
  APT policy: (500, 'testing')
Architecture: powerpc (ppc)
Kernel: Linux 2.6.8-reiser4
Locale: LANG=C, LC_CTYPE=C (charmap=ANSI_X3.4-1968) (ignored: LC_ALL set to POSIX)

Versions of packages autofs depends on:
ii  debconf                     1.4.30.13    Debian configuration management sy
ii  libc6                       2.3.2.ds1-21 GNU C Library: Shared libraries an

-- debconf information excluded


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--yrj/dFKFPuw6o+aM--

