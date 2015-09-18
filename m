From: Ian Kent <raven@themaw.net>
Subject: [PATCH v5 6/8] autofs-5.1.1 - change remaining gettimeofday() to
 use clock_gettime()
Date: Fri, 18 Sep 2015 17:35:03 +0800
Message-ID: <20150918093502.29311.4825.stgit@pluto.fritz.box>
References: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Uee2o6Md66QZC8yMJEfkaxYXLRk=; b=rKLSjl
	qWDYpvIczoo22vOEcfkMhbprb7xVgSVbD7XYzNBG8mFp3ggc1UJhtbblb1JlJo3R
	xu8yZpY2hPYwtotSz6fghrbSYHlgZhETggzbUSkdelV8iAutOpQYOglGd+3HvQJB
	uV/+kH7fZe9lsdktQgs0NJIgn/ZvTHM/uiMK0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Uee2o6Md66QZC8y
	MJEfkaxYXLRk=; b=MdTHpw+6+nEPw4WodR6qMrRMGtcpao6hsywfL6aKVcpecgh
	CVeiW7XUHDzV29XZ4x9Dv3EFet44LS+bAtT4b8FMpVVC9/vJg3VtE6f1otrzIuKe
	n4c+cztYfE/LWFJ0cdAIkV9xK17ROX7zL3w1i/b58f18bgQuduOtwp6aEt3M=
In-Reply-To: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Yu Ning <ning.yu@ubuntu.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

From: Yu Ning <ning.yu@ubuntu.com>

The time returned by gettimeofday() is affected by discontinuous jumps
in the system time, so it causes an issue that autofs may not auto
unmount a mount point if system time is manually changed by the system
administrator.

To fix the issue we need to convert to using a monotonic clock source
instead of the clock source used by gettimeofday().

Change the reamining gettimeofday() function calls to clock_gettime()
calls.

Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
---
 CHANGELOG            |    1 +
 lib/rpc_subs.c       |    9 ++++-----
 modules/replicated.c |   30 ++++++++++++++----------------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 63b91aa..276bd1b 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -23,6 +23,7 @@
 - define pending condition init helper function.
 - use monotonic clock for direct mount condition.
 - use monotonic clock for indirect mount condition.
+- change remaining gettimeofday() to use clock_gettime().
 
 21/04/2015 autofs-5.1.1
 =======================
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 14e5f94..2364744 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -1103,19 +1103,18 @@ int rpc_time(const char *host,
 {
 	int status;
 	double taken;
-	struct timeval start, end;
-	struct timezone tz;
+	struct timespec start, end;
 	int proto = (ping_proto & RPC_PING_UDP) ? IPPROTO_UDP : IPPROTO_TCP;
 	unsigned long vers = ping_vers;
 
-	gettimeofday(&start, &tz);
+	clock_gettime(CLOCK_MONOTONIC, &start);
 	status = __rpc_ping(host, vers, proto, seconds, micros, option);
-	gettimeofday(&end, &tz);
+	clock_gettime(CLOCK_MONOTONIC, &end);
 
 	if (status == RPC_PING_FAIL || status < 0)
 		return status;
 
-	taken = elapsed(start, end);
+	taken = monotonic_elapsed(start, end);
 
 	if (result != NULL)
 		*result = taken;
diff --git a/modules/replicated.c b/modules/replicated.c
index 8437f5f..f4cae3e 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -231,8 +231,7 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
 	socklen_t len = INET6_ADDRSTRLEN;
 	char buf[len + 1];
 	struct pmap parms;
-	struct timeval start, end;
-	struct timezone tz;
+	struct timespec start, end;
 	unsigned int supported = 0;
 	double taken = 0;
 	int status, count = 0;
@@ -292,9 +291,9 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
 		supported = status;
 		goto done_ver;
 	} else if (!status) {
-		gettimeofday(&start, &tz);
+		clock_gettime(CLOCK_MONOTONIC, &start);
 		status = rpc_ping_proto(rpc_info);
-		gettimeofday(&end, &tz);
+		clock_gettime(CLOCK_MONOTONIC, &end);
 		if (status == -ETIMEDOUT) {
 			supported = status;
 			goto done_ver;
@@ -306,7 +305,7 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
 				debug(logopt,
 				      "nfs v4 random selection time: %f", reply);
 			} else {
-				reply = elapsed(start, end);
+				reply = monotonic_elapsed(start, end);
 				debug(logopt, "nfs v4 rpc ping time: %f", reply);
 			}
 			taken += reply;
@@ -351,9 +350,9 @@ v3_ver:
 		supported = status;
 		goto done_ver;
 	} else if (!status) {
-		gettimeofday(&start, &tz);
+		clock_gettime(CLOCK_MONOTONIC, &start);
 		status = rpc_ping_proto(rpc_info);
-		gettimeofday(&end, &tz);
+		clock_gettime(CLOCK_MONOTONIC, &end);
 		if (status == -ETIMEDOUT) {
 			supported = status;
 			goto done_ver;
@@ -365,7 +364,7 @@ v3_ver:
 				debug(logopt,
 				      "nfs v3 random selection time: %f", reply);
 			} else {
-				reply = elapsed(start, end);
+				reply = monotonic_elapsed(start, end);
 				debug(logopt, "nfs v3 rpc ping time: %f", reply);
 			}
 			taken += reply;
@@ -407,9 +406,9 @@ v2_ver:
 		supported = status;
 		goto done_ver;
 	} else if (!status) {
-		gettimeofday(&start, &tz);
+		clock_gettime(CLOCK_MONOTONIC, &start);
 		status = rpc_ping_proto(rpc_info);
-		gettimeofday(&end, &tz);
+		clock_gettime(CLOCK_MONOTONIC, &end);
 		if (status == -ETIMEDOUT)
 			supported = status;
 		else if (status > 0) {
@@ -420,7 +419,7 @@ v2_ver:
 				debug(logopt,
 				      "nfs v2 random selection time: %f", reply);
 			} else {
-				reply = elapsed(start, end);;
+				reply = monotonic_elapsed(start, end);;
 				debug(logopt, "nfs v2 rpc ping time: %f", reply);
 			}
 			taken += reply;
@@ -523,8 +522,7 @@ static int get_supported_ver_and_cost(unsigned logopt, struct host *host,
 	struct conn_info pm_info, rpc_info;
 	int proto;
 	unsigned int vers;
-	struct timeval start, end;
-	struct timezone tz;
+	struct timespec start, end;
 	double taken = 0;
 	time_t timeout = RPC_TIMEOUT;
 	int status = 0;
@@ -610,16 +608,16 @@ static int get_supported_ver_and_cost(unsigned logopt, struct host *host,
 	if (status == -EHOSTUNREACH)
 		goto done;
 	else if (!status) {
-		gettimeofday(&start, &tz);
+		clock_gettime(CLOCK_MONOTONIC, &start);
 		status = rpc_ping_proto(&rpc_info);
-		gettimeofday(&end, &tz);
+		clock_gettime(CLOCK_MONOTONIC, &end);
 		if (status > 0) {
 			if (random_selection) {
 				/* Random value between 0 and 1 */
 				taken = ((float) random())/((float) RAND_MAX+1);
 				debug(logopt, "random selection time %f", taken);
 			} else {
-				taken = elapsed(start, end);
+				taken = monotonic_elapsed(start, end);
 				debug(logopt, "rpc ping time %f", taken);
 			}
 		}

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
