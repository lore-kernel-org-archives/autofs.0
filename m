From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [carlst@u.washington.edu: Bug#298649: autofs: Last line of
	auto.master ignored]
Date: Wed, 9 Mar 2005 02:58:22 +0100
Message-ID: <20050309015822.GA18749@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Forwarding another bug here -- wasn't this supposed to be fixed in beta2?

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--OXfL5xGRrasGEqWY
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <debbugs@bugs.debian.org>
Envelope-to: root@trofast.sesse.net
Delivery-date: Wed, 09 Mar 2005 02:54:32 +0100
Received: from cassarossa.samfundet.no ([129.241.93.19])
	by trofast.sesse.net with esmtp (Exim 3.36 #1 (Debian))
	id 1D8qPA-0004pU-00
	for <root@trofast.sesse.net>; Wed, 09 Mar 2005 02:54:32 +0100
Received: from mail-kr.bigfoot.com ([211.115.216.225])
	by cassarossa.samfundet.no with smtp (Exim 4.34) id 1D8qP8-0004R7-QB
	for sesse@samfundet.no; Wed, 09 Mar 2005 02:54:32 +0100
Received: from spohr.debian.org ([128.193.0.4])
	by BFLITEMAIL-KR2.bigfoot.com (LiteMail v3.03(BFLITEMAIL-KR2)) with
	SMTP id 0503082047_BFLITEMAIL-KR2_423618_44374024; 
	Tue, 08 Mar 2005 20:54:38 -0500 EST
Received: from debbugs by spohr.debian.org with local (Exim 3.35 1 (Debian))
	id 1D8qIv-0005yX-00; Tue, 08 Mar 2005 17:48:05 -0800
X-Loop: owner@bugs.debian.org
Subject: Bug#298649: autofs: Last line of auto.master ignored
Reply-To: Trevor Carlson <carlst@u.washington.edu>, 298649@bugs.debian.org
Resent-From: Trevor Carlson <carlst@u.washington.edu>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: carlst@u.washington.edu, sesse@debian.org (Steinar H. Gunderson)
Resent-Date: Wed, 09 Mar 2005 01:48:04 UTC
Resent-Message-ID: <handler.298649.B.111033269617150@bugs.debian.org>
X-Debian-PR-Message: report 298649
X-Debian-PR-Package: autofs
X-Debian-PR-Keywords: 
Received: via spool by submit@bugs.debian.org id=B.111033269617150
	(code B ref -1); Wed, 09 Mar 2005 01:48:04 UTC
Received: (at submit) by bugs.debian.org; 9 Mar 2005 01:44:56 +0000
Received: from master.debian.org [146.82.138.7] 
	by spohr.debian.org with esmtp (Exim 3.35 1 (Debian))
	id 1D8qFs-0004SQ-00; Tue, 08 Mar 2005 17:44:56 -0800
Received: from c-67-160-110-85.client.comcast.net ([127.0.0.1])
	[67.160.110.85] 
	by master.debian.org with esmtp (Exim 3.35 1 (Debian))
	id 1D8qFr-0006HR-00; Tue, 08 Mar 2005 19:44:55 -0600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Trevor Carlson <carlst@u.washington.edu>
To: Debian Bug Tracking System <submit@bugs.debian.org>
X-Mailer: reportbug 3.8
Date: Tue, 08 Mar 2005 17:48:26 -0800
Message-Id: <E1D8qFr-0006HR-00@master.debian.org>
Delivered-To: submit@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02 
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Status: No, hits=-9.0 required=4.0 tests=BAYES_00,HAS_PACKAGE,
	OUR_MTA_MSGID,X_DEBBUGS_CC autolearn=ham 
	version=2.60-bugs.debian.org_2005_01_02
X-Spam-Level: 
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Status=No hits=0.0 required=5.0 tests=none version=3.0.2
X-CRM114-Version: 20040816.BlameClockworkOrange-auto.3 (regex: TRE TRE 0.7.2
	(GPL)) MF-A10FFB4C 
X-CRM114-Status: Good  ( pR: 50.7632 )

Package: autofs
Version: 4.1.3+4.1.4beta2-3
Severity: important



-- System Information:
Debian Release: 3.1
  APT prefers testing
  APT policy: (990, 'testing'), (500, 'unstable')
Architecture: i386 (i686)
Kernel: Linux 2.4.22-xfs
Locale: LANG=C, LC_CTYPE=C (charmap=ANSI_X3.4-1968)

Versions of packages autofs depends on:
ii  debconf                     1.4.30.11    Debian configuration management sy
ii  libc6                       2.3.2.ds1-20 GNU C Library: Shared libraries an

-- debconf information:
* autofs/upgrade-from-broken-version:

This bug occurs in both Testing and Unstable as of March 8.

An auto.master file of:
/mnt/auto	/etc/auto.misc
does not work, while a file of:
/mnt/auto	/etc/auto.misc

does. The only difference between the two is that the first does not
include a newline at the end, while the second does. The first file
causes /etc/init.d/autofs to output:
Starting automounter: no automount maps defined.


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--OXfL5xGRrasGEqWY--

