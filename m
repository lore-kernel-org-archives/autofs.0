From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [weasel@debian.org: Bug#296238: autofs breaks nis
	auto.master when there is a tab in nsswitch]
Date: Mon, 21 Feb 2005 12:22:43 +0100
Message-ID: <20050221112243.GA18164@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
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


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI: Looks like the change done in the init script for 4.1.4beta2 broke this
again; I'll revert to the 4.1.3 version and upload.

BTW, there's also multiple people complaining about the new auto.* scripts
(see the Debian BTS), but I haven't had time to look into it yet.

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--cNdxnHkX5QqsyA0e
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <debbugs@bugs.debian.org>
Envelope-to: root@trofast.sesse.net
Delivery-date: Mon, 21 Feb 2005 11:09:19 +0100
Received: from cassarossa.samfundet.no ([129.241.93.19])
	by trofast.sesse.net with esmtp (Exim 3.36 #1 (Debian))
	id 1D3AVD-0002Rd-00
	for <root@trofast.sesse.net>; Mon, 21 Feb 2005 11:09:19 +0100
Received: from mail-kr.bigfoot.com ([211.115.216.228])
	by cassarossa.samfundet.no with smtp (Exim 4.34) id 1D3AVB-0004F6-HC
	for sesse@samfundet.no; Mon, 21 Feb 2005 11:09:19 +0100
Received: from spohr.debian.org ([128.193.0.4])
	by BFLITEMAIL-KR4.bigfoot.com (LiteMail v3.03(BFLITEMAIL-KR4)) with
	SMTP id 0502210504_BFLITEMAIL-KR4_392287_52461102; 
	Mon, 21 Feb 2005 05:08:04 -0500 EST
Received: from debbugs by spohr.debian.org with local (Exim 3.35 1 (Debian))
	id 1D3APH-0008P2-00; Mon, 21 Feb 2005 02:03:11 -0800
X-Loop: owner@bugs.debian.org
Subject: Bug#296238: autofs breaks nis auto.master when there is a tab in
	nsswitch
Reply-To: Peter Palfrader <weasel@debian.org>, 296238@bugs.debian.org
Resent-From: Peter Palfrader <weasel@debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: sesse@debian.org (Steinar H. Gunderson)
Resent-Date: Mon, 21 Feb 2005 10:03:09 UTC
Resent-Message-ID: <handler.296238.B.110897979928181@bugs.debian.org>
X-Debian-PR-Message: report 296238
X-Debian-PR-Package: autofs
X-Debian-PR-Keywords: 
Received: via spool by submit@bugs.debian.org id=B.110897979928181
	(code B ref -1); Mon, 21 Feb 2005 10:03:09 UTC
Received: (at submit) by bugs.debian.org; 21 Feb 2005 09:56:39 +0000
Received: from opium.multi24.com [213.239.202.166] 
	by spohr.debian.org with esmtp (Exim 3.35 1 (Debian))
	id 1D3AIx-0007KJ-00; Mon, 21 Feb 2005 01:56:39 -0800
Received: by opium.multi24.com (Postfix, from userid 1000)
	id 45B52400187; Mon, 21 Feb 2005 10:56:38 +0100 (CET)
Date: Mon, 21 Feb 2005 10:56:38 +0100
From: Peter Palfrader <weasel@debian.org>
To: submit@bugs.debian.org
Message-ID: <20050221095638.GA1754@opium.palfrader.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-PGP: 1024D/94C09C7F 5B00 C96D 5D54 AEE1 206B  AF84 DE7A AF6E 94C0 9C7F
X-Request-PGP: http://www.palfrader.org/keys/94C09C7F.asc
X-Accept-Language: de, en
User-Agent: Mutt/1.5.6+20040907i
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
X-CRM114-Status: Good  ( pR: 40.2189 )

Package: autofs
Version: 4.1.3+4.1.4beta2-2
Severity: grave

The diff for etc/init.d/autofs includes:
 #
 # Check for all maps that are to be loaded
 #
 function getschemes()
 {
-    if grep -q ^automount: /etc/nsswitch.conf; then
+    if grep -q '^automount:[ \t]' /etc/nsswitch.conf; then
         grep ^automount: /etc/nsswitch.conf | \
                 sed -e 's/^.*://' -e 's/\[.*\]/ /g'
     else
         echo files
     fi
 }

However, the new grep is broken:

| weasel@olga:~$ grep '^automount:[ \t]' /etc/nsswitch.conf
| weasel@olga:~$ grep '^automount:[ 	]' /etc/nsswitch.conf
                                    ^^^^ < that's a tab
| automount:	files nis


-- 
Peter


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--cNdxnHkX5QqsyA0e--

