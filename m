From: Yu Ning <ning.yu@canonical.com>
Subject: [PATCH v4 1/3] autofs-5.1.1 - use clock_gettime() instead of gettimeofday().
Date: Thu, 17 Sep 2015 12:09:35 +0800
Message-ID: <1442462977-23547-1-git-send-email-ning.yu@ubuntu.com>
References: <CAA1QoHT7GK1Ry4-wuVUJuAEuQyaDHE-3CzxWV9xMECUM+chyyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.9.1"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <CAA1QoHT7GK1Ry4-wuVUJuAEuQyaDHE-3CzxWV9xMECUM+chyyw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>, Yu Ning <ning.yu@ubuntu.com>

This is a multi-part message in MIME format.
--------------1.9.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


The time returned by gettimeofday() is affected by discontinuous jumps
in the system time, so it causes an issue that autofs may not auto
unmount a mount point if system time is manually changed by the system
administrator.

To fix the issue we can use clock_gettime(CLOCK_MONOTONIC) instead of
gettimeofday().

A new function monotonic_elapsed() is introduced in rpc_subs.h as a
timespec version of elapsed().

Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
---
 daemon/direct.c      | 12 ++++++------
 daemon/indirect.c    | 12 ++++++------
 include/rpc_subs.h   |  1 +
 lib/alarm.c          |  6 +++---
 lib/rpc_subs.c       | 17 ++++++++++++-----
 modules/replicated.c | 30 ++++++++++++++----------------
 6 files changed, 42 insertions(+), 36 deletions(-)


--------------1.9.1
Content-Type: text/x-patch; name="v4-0001-autofs-5.1.1-use-clock_gettime-instead-of-gettime.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="v4-0001-autofs-5.1.1-use-clock_gettime-instead-of-gettime.patch"

diff --git a/daemon/direct.c b/daemon/direct.c
index 5569299..cdd7f49 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1041,7 +1041,7 @@ int handle_packet_expire_direct(struct autofs_point *ap, autofs_packet_expire_di
 	char buf[MAX_ERR_BUF];
 	pthread_t thid;
 	struct timespec wait;
-	struct timeval now;
+	struct timespec now;
 	int status, state;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
@@ -1159,9 +1159,9 @@ int handle_packet_expire_direct(struct autofs_point *ap, autofs_packet_expire_di
 
 	mt->signaled = 0;
 	while (!mt->signaled) {
-		gettimeofday(&now, NULL);
+		clock_gettime(CLOCK_MONOTONIC, &now);
 		wait.tv_sec = now.tv_sec + 2;
-		wait.tv_nsec = now.tv_usec * 1000;
+		wait.tv_nsec = now.tv_nsec;
 		status = pthread_cond_timedwait(&mt->cond, &mt->mutex, &wait);
 		if (status && status != ETIMEDOUT)
 			fatal(status);
@@ -1296,7 +1296,7 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 	char buf[MAX_ERR_BUF];
 	int status = 0;
 	struct timespec wait;
-	struct timeval now;
+	struct timespec now;
 	int ioctlfd, len, state;
 	unsigned int kver_major = get_kver_major();
 	unsigned int kver_minor = get_kver_minor();
@@ -1478,9 +1478,9 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 
 	mt->signaled = 0;
 	while (!mt->signaled) {
-		gettimeofday(&now, NULL);
+		clock_gettime(CLOCK_MONOTONIC, &now);
 		wait.tv_sec = now.tv_sec + 2;
-		wait.tv_nsec = now.tv_usec * 1000;
+		wait.tv_nsec = now.tv_nsec;
 		status = pthread_cond_timedwait(&mt->cond, &mt->mutex, &wait);
 		if (status && status != ETIMEDOUT)
 			fatal(status);
diff --git a/daemon/indirect.c b/daemon/indirect.c
index a04a624..0ea9b19 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -636,7 +636,7 @@ int handle_packet_expire_indirect(struct autofs_point *ap, autofs_packet_expire_
 	char buf[MAX_ERR_BUF];
 	pthread_t thid;
 	struct timespec wait;
-	struct timeval now;
+	struct timespec now;
 	int status, state;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
@@ -691,9 +691,9 @@ int handle_packet_expire_indirect(struct autofs_point *ap, autofs_packet_expire_
 
 	mt->signaled = 0;
 	while (!mt->signaled) {
-		gettimeofday(&now, NULL);
+		clock_gettime(CLOCK_MONOTONIC, &now);
 		wait.tv_sec = now.tv_sec + 2;
-		wait.tv_nsec = now.tv_usec * 1000;
+		wait.tv_nsec = now.tv_nsec;
 		status = pthread_cond_timedwait(&mt->cond, &mt->mutex, &wait);
 		if (status && status != ETIMEDOUT)
 			fatal(status);
@@ -795,7 +795,7 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 	char buf[MAX_ERR_BUF];
 	struct pending_args *mt;
 	struct timespec wait;
-	struct timeval now;
+	struct timespec now;
 	struct mapent *me;
 	int status, state;
 
@@ -884,9 +884,9 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 
 	mt->signaled = 0;
 	while (!mt->signaled) {
-		gettimeofday(&now, NULL);
+		clock_gettime(CLOCK_MONOTONIC, &now);
 		wait.tv_sec = now.tv_sec + 2;
-		wait.tv_nsec = now.tv_usec * 1000;
+		wait.tv_nsec = now.tv_nsec;
 		status = pthread_cond_timedwait(&mt->cond, &mt->mutex, &wait);
 		if (status && status != ETIMEDOUT)
 			fatal(status);
diff --git a/include/rpc_subs.h b/include/rpc_subs.h
index b6d59f9..e329224 100644
--- a/include/rpc_subs.h
+++ b/include/rpc_subs.h
@@ -71,6 +71,7 @@ int rpc_portmap_getport(struct conn_info *, struct pmap *, unsigned short *);
 int rpc_ping_proto(struct conn_info *);
 int rpc_ping(const char *, long, long, unsigned int);
 double elapsed(struct timeval, struct timeval);
+double monotonic_elapsed(struct timespec, struct timespec);
 int rpc_time(const char *, unsigned int, unsigned int, long, long, unsigned int, double *);
 const char *get_addr_string(struct sockaddr *, char *, socklen_t);
 
diff --git a/lib/alarm.c b/lib/alarm.c
index 0f04ef8..65a80ae 100755
--- a/lib/alarm.c
+++ b/lib/alarm.c
@@ -178,14 +178,14 @@ static void *alarm_handler(void *arg)
 		now = time(NULL);
 
 		if (first->time > now) {
-			struct timeval usecs;
+			struct timespec nsecs;
 			/* 
 			 * Wait for alarm to trigger or a new alarm 
 			 * to be added.
 			 */
-			gettimeofday(&usecs, NULL);
+			clock_gettime(CLOCK_MONOTONIC, &nsecs);
 			expire.tv_sec = first->time;
-			expire.tv_nsec = usecs.tv_usec * 1000;
+			expire.tv_nsec = nsecs.tv_nsec;
 
 			status = pthread_cond_timedwait(&cond, &mutex, &expire);
 			if (status && status != ETIMEDOUT)
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 846c40e..e8c0ca5 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -1086,25 +1086,32 @@ double elapsed(struct timeval start, struct timeval end)
 	return t2-t1;
 }
 
+double monotonic_elapsed(struct timespec start, struct timespec end)
+{
+	double t1, t2;
+	t1 =  (double)start.tv_sec + (double)start.tv_nsec/(1000*1000*1000);
+	t2 =  (double)end.tv_sec + (double)end.tv_nsec/(1000*1000*1000);
+	return t2-t1;
+}
+
 int rpc_time(const char *host,
 	     unsigned int ping_vers, unsigned int ping_proto,
 	     long seconds, long micros, unsigned int option, double *result)
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
index 32860d5..0f0cc51 100644
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

--------------1.9.1--


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
