From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [daniel@vision.ime.usp.br: Bug#304245: patch - NFS mounts
	occasionally fail]
Date: Sun, 17 Apr 2005 17:42:40 +0200
Message-ID: <20050417154240.GA17232@uio.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Return-path: <autofs-bounces@linux.kernel.org>
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
Cc: daniel@vision.ime.usp.br, 304245@bugs.debian.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Thanks for the patch; sending upstream for evaluation.

/* Steinar */
-- 
Homepage: http://www.sesse.net/

--MGYHOYXEY6WxJCY8
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <debbugs@bugs.debian.org>
Envelope-to: root@trofast.sesse.net
Delivery-date: Sun, 17 Apr 2005 04:53:44 +0200
Received: from cassarossa.samfundet.no ([129.241.93.19])
	by trofast.sesse.net with esmtp (Exim 3.36 #1 (Debian))
	id 1DMzuq-0004IJ-00
	for <root@trofast.sesse.net>; Sun, 17 Apr 2005 04:53:44 +0200
Received: from mail-kr.bigfoot.com ([211.115.216.226])
	by cassarossa.samfundet.no with smtp (Exim 4.34) id 1DMzun-0001AU-Hw
	for sesse@samfundet.no; Sun, 17 Apr 2005 04:53:44 +0200
Received: from spohr.debian.org ([140.211.166.43])
	by BFLITEMAIL-KR3.bigfoot.com (LiteMail v3.03(BFLITEMAIL-KR3)) with
	SMTP id 0504162239_BFLITEMAIL-KR3_429127_30186218; 
	Sat, 16 Apr 2005 22:58:20 -0400 EST
Received: from debbugs by spohr.debian.org with local (Exim 3.35 1 (Debian))
	id 1DMzpM-00059V-00; Sat, 16 Apr 2005 19:48:04 -0700
X-Loop: owner@bugs.debian.org
Subject: Bug#304245: patch - NFS mounts occasionally fail
Reply-To: Daniel Andre Vaquero <daniel@vision.ime.usp.br>,
	304245@bugs.debian.org
Resent-From: Daniel Andre Vaquero <daniel@vision.ime.usp.br>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: sesse@debian.org (Steinar H. Gunderson)
Resent-Date: Sun, 17 Apr 2005 02:48:03 UTC
Resent-Message-ID: <handler.304245.B304245.111370553717113@bugs.debian.org>
X-Debian-PR-Message: report 304245
X-Debian-PR-Package: autofs
X-Debian-PR-Keywords: 
Received: via spool by 304245-submit@bugs.debian.org id=B304245.111370553717113
	(code B ref 304245); Sun, 17 Apr 2005 02:48:03 UTC
Received: (at 304245) by bugs.debian.org; 17 Apr 2005 02:38:57 +0000
Received: from pizza.ime.usp.br [143.107.44.18] 
	by spohr.debian.org with smtp (Exim 3.35 1 (Debian))
	id 1DMzgX-0004QQ-00; Sat, 16 Apr 2005 19:38:57 -0700
Received: (qmail 12766 invoked from network); 17 Apr 2005 02:38:18 -0000
Received: from unknown (HELO pogo.vision.ime.usp.br) (192.168.231.11)
	by gateway.vision.ime.usp.br with SMTP; 17 Apr 2005 02:38:18 -0000
Received: (qmail 28596 invoked from network); 17 Apr 2005 02:38:25 -0000
Received: from unknown (192.168.231.70)
	by pogo.vision.ime.usp.br with QMQP; 17 Apr 2005 02:38:25 -0000
Date: Sat, 16 Apr 2005 23:38:26 -0300
From: Daniel Andre Vaquero <daniel@vision.ime.usp.br>
To: 304245@bugs.debian.org
Message-ID: <20050417023826.GA4527@vision.ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Delivered-To: 304245@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02 
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Status: No, hits=-3.0 required=4.0 tests=BAYES_00 autolearn=no 
	version=2.60-bugs.debian.org_2005_01_02
X-Spam-Level: 
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
X-Spam-Score: 2.3 (++)
X-Spam-Report: Status=No hits=2.3 required=5.0 tests=INVALID_TZ_EST
	version=3.0.2
X-CRM114-Version: 20040816.BlameClockworkOrange-auto.3 (regex: TRE TRE 0.7.2
	(GPL)) MF-A10FFB4C 
X-CRM114-Status: Good  ( pR: 146.7843 )

Hi,

After some days of testing with upstream version 4.1.4, I noticed that it
is also broken (although mount failures occur less frequently). My scenario
consists of a single server, with no replicated mounts. Debugging the code,
I found that the problem happens in the function get_best_mount()
of mount_nfs.c. If the server don't respond to rpc_ping() within 0.1 seconds,
winner remains NULL and the function is not called again with the longer
timeout (10 sec), leading to a mount failure because no winner is elected.
Another thing I noticed is that the behavior when there are replicated hosts
is not the described in README.replicated-server. If all pings fail, winner
should be set to the first host in the list, but the current code will return
winner = NULL.

I have made a patch that should solve these problems, and included it below
(maybe this fixes the problem of #297359 too).
It must be applied over upstream version 4.1.4. I'll be testing it for the 
single server scenario in the next few days.

$ diff -upr autofs-4.1.4.orig/modules/mount_nfs.c autofs-4.1.4/modules/mount_nfs.c

--- autofs-4.1.4.orig/modules/mount_nfs.c 2005-04-05 09:42:42.000000000 -0300
+++ autofs-4.1.4/modules/mount_nfs.c   2005-04-16 22:59:05.000000000 -0300
@@ -251,33 +251,28 @@ int get_best_mount(char *what, const cha
 
   debug(MODPREFIX "winner = %s local = %d", winner, local);
 
-  /*
-   * We didn't find a weighted winner or local
-   */
-  if (!local && winner_weight == INT_MAX) {
-     /* We had more than one contender and none responded in time */
-     if (winner_time != 0 && winner_time > 500) {
-        /* We've already tried a longer timeout */
-        if (!longtimeout) {
-           /* Reset string and try again */
-           strcpy(what, original);
-
-           debug(MODPREFIX 
-                 "all hosts timed out for '%s', "
-                 "retrying with longer timeout",
-                 original);
-
-           return get_best_mount(what, original, 1, 1);
-        }
+  /* No winner found */
+  if (!local && !winner) {
+     
+     /* Retry with a longer timeout */
+     if (!longtimeout) {
+        /* Reset string and try again */
+        strcpy(what, original);
+      
+        debug(MODPREFIX 
+              "all hosts timed out for '%s', "
+              "retrying with longer timeout",
+              original);
+        
+        return get_best_mount(what, original, 1, 1);
+     }
+     else {
+        /* No hosts responded, winner = first host */
+        winner = what;
      }
+     
   }
-
-  /* No winner found so bail */
-  if (!winner) {
-     *what = '\0';
-     return 0;
-  }
-
+  
   /*
    * We now have our winner, copy it to the front of the string,
    * followed by the next :string<delim>



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

