From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [mirko.kohns@gmail.com: Bug#315465: lookup(ldap): got
	answer, but no first entry for (&(objectclass=nisObject)]
Date: Wed, 22 Jun 2005 22:55:40 +0200
Message-ID: <20050622205540.GA26670@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
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


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Ian,

Do you have any good ideas about this?

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--fdj2RfSjLxBAspz7
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <debbugs@bugs.debian.org>
Envelope-to: root@trofast.sesse.net
Delivery-date: Wed, 22 Jun 2005 22:53:43 +0200
Received: from cassarossa.samfundet.no ([129.241.93.19])
	by trofast.sesse.net with esmtp (Exim 3.36 #1 (Debian))
	id 1DlCEB-0006ue-00
	for <root@trofast.sesse.net>; Wed, 22 Jun 2005 22:53:43 +0200
Received: from mail-kr.bigfoot.com ([211.115.216.228])
	by cassarossa.samfundet.no with smtp (Exim 4.50) id 1DlCE8-0000Xp-Ag
	for sesse@samfundet.no; Wed, 22 Jun 2005 22:53:42 +0200
Received: from spohr.debian.org ([140.211.166.43])
	by BFLITEMAIL-KR4.bigfoot.com (LiteMail v3.03(BFLITEMAIL-KR4)) with
	SMTP id 0506221937_BFLITEMAIL-KR4_429208_113353780; 
	Wed, 22 Jun 2005 19:41:58 -0400 EST
Received: from debbugs by spohr.debian.org with local (Exim 3.35 1 (Debian))
	id 1DlC8j-000770-00; Wed, 22 Jun 2005 13:48:05 -0700
X-Loop: owner@bugs.debian.org
Subject: Bug#315465: lookup(ldap): got answer,
	but no first entry for (&(objectclass=nisObject)
Reply-To: Mirko Kohns <mirko.kohns@gmail.com>, 315465@bugs.debian.org
Resent-From: Mirko Kohns <mirko.kohns@gmail.com>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: mirko.kohns@gmail.com, sesse@debian.org (Steinar H. Gunderson)
Resent-Date: Wed, 22 Jun 2005 20:48:03 UTC
Resent-Message-ID: <handler.315465.B.111947257816408@bugs.debian.org>
X-Debian-PR-Message: report 315465
X-Debian-PR-Package: autofs-ldap
X-Debian-PR-Keywords: 
Received: via spool by submit@bugs.debian.org id=B.111947257816408
	(code B ref -1); Wed, 22 Jun 2005 20:48:03 UTC
Received: (at submit) by bugs.debian.org; 22 Jun 2005 20:36:18 +0000
Received: from quecksilber.informatik.rwth-aachen.de [137.226.36.126] 
	by spohr.debian.org with esmtp (Exim 3.35 1 (Debian))
	id 1DlBx4-0004BE-00; Wed, 22 Jun 2005 13:36:02 -0700
Received: from i6 (cadmium.informatik.rwth-aachen.de [137.226.36.108])
	by quecksilber.informatik.rwth-aachen.de (8.13.4/8.13.4/Debian-3) with
	SMTP id j5MKa1hv026364
	for <submit@bugs.debian.org>; Wed, 22 Jun 2005 22:36:01 +0200
Received: (nullmailer pid 31879 invoked by uid 2245);
	Wed, 22 Jun 2005 20:36:01 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Mirko Kohns <mirko.kohns@gmail.com>
To: Debian Bug Tracking System <submit@bugs.debian.org>
X-Mailer: reportbug 3.8
Date: Wed, 22 Jun 2005 22:36:00 +0200
Message-Id: <1119472560.980283.31878.nullmailer@i6>
Delivered-To: submit@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02 
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Status: No, hits=-11.0 required=4.0 tests=BAYES_00,HAS_PACKAGE,
	X_DEBBUGS_CC autolearn=ham version=2.60-bugs.debian.org_2005_01_02
X-Spam-Level: 
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
X-Spam-Score: 2.3 (++)
X-Spam-Report: Status=No hits=2.3 required=5.0 tests=INVALID_TZ_EST
	version=3.0.3
X-CRM114-Version: 20050415.BlameTheIRS ( TRE 0.7.2 (GPL) ) MF-DAE15AAC [pR:
	152.4426]
X-CRM114-Status: Good  ( pR: 152.4426 )

Package: autofs-ldap
Version: 4.1.3+4.1.4beta2-10
Severity: normal

When updating from autofs-ldap_4.1.3-4_i386 to
autofs-ldap_4.1.3+4.1.4beta2-10_i386.deb

I get following syslog error/warnings

Jun 22 22:25:20 zirconium automount[12443]: lookup(ldap): got answer,
but no first entry for (&(objectclass=nisObject)(cn=kohns))

for every mount request.
Mounting works fine - but all my nodes are crying to my syslogserver

my auto.master is

/user ldap:ou=auto.user,ou=automount,dc=Mitarbeiter,dc=xx,dc=xxxxxxx,dc=de
/work ldap:ou=auto.work,ou=automount,dc=Mitarbeiter,dc=xx,dc=xxxxxxx,dc=de

my ldif looks like

dn:
cn=kohns,ou=auto.work,ou=automount,dc=Mitarbeiter,dc=xx,dc=xxxxxxxxx,dc=de
objectclass: top
objectclass: automount
automountinformation: -rw,intr raidxx:/volume/work/kohns
cn: kohns

MIRKO

-- System Information:
Debian Release: 3.1
Architecture: i386 (i686)
Kernel: Linux 2.6.11.7-intel
Locale: LANG=en_US, LC_CTYPE=en_US (charmap=ISO-8859-1)

Versions of packages autofs-ldap depends on:
hi  autofs               4.1.3+4.1.4beta2-10 kernel-based automounter for Linux
hi  ldap-utils           2.2.23-8            OpenLDAP utilities
hi  libc6                2.3.2.ds1-22        GNU C Library: Shared libraries an
ii  libldap2             2.1.30-8            OpenLDAP libraries

-- no debconf information


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--fdj2RfSjLxBAspz7--

