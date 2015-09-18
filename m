From: Yu Ning <ning.yu@canonical.com>
Subject: [PATCH v5 2/3] autofs-5.1.1 - use monotonic clock for pthread cond timed wait.
Date: Fri, 18 Sep 2015 15:16:03 +0800
Message-ID: <1442560564-6453-2-git-send-email-ning.yu@ubuntu.com>
References: <1442540212.2947.43.camel@themaw.net>
 <1442560564-6453-1-git-send-email-ning.yu@ubuntu.com>
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1442560564-6453-1-git-send-email-ning.yu@ubuntu.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>, Yu Ning <ning.yu@ubuntu.com>

The default PTHREAD_COND_INITIALIZER initializer uses realtime clock,
we need to switch to use the monotic clock.

Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
---
 lib/alarm.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/lib/alarm.c b/lib/alarm.c
index 65a80ae..10ad4ab 100755
--- a/lib/alarm.c
+++ b/lib/alarm.c
@@ -23,7 +23,7 @@ struct alarm {
 };
 
 static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
-static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+static pthread_cond_t cond;
 static LIST_HEAD(alarms);
 
 #define alarm_lock() \
@@ -212,20 +212,40 @@ int alarm_start_handler(void)
 	pthread_t thid;
 	pthread_attr_t attrs;
 	pthread_attr_t *pattrs = &attrs;
+	pthread_condattr_t condattrs;
 	int status;
 
 	status = pthread_attr_init(pattrs);
 	if (status)
 		pattrs = NULL;
 	else {
-		pthread_attr_setdetachstate(pattrs, PTHREAD_CREATE_DETACHED);
+		status = pthread_attr_setdetachstate(pattrs, PTHREAD_CREATE_DETACHED);
+		if (status)
+			fatal(status);
 #ifdef _POSIX_THREAD_ATTR_STACKSIZE
-		pthread_attr_setstacksize(pattrs, PTHREAD_STACK_MIN*4);
+		status = pthread_attr_setstacksize(pattrs, PTHREAD_STACK_MIN*4);
+		if (status)
+			fatal(status);
 #endif
 	}
 
+	status = pthread_condattr_init(&condattrs);
+	if (status)
+		fatal(status);
+	status = pthread_condattr_setclock(&condattrs, CLOCK_MONOTONIC);
+	if (status)
+		fatal(status);
+	status = pthread_cond_init(&cond, &condattrs);
+	if (status)
+		fatal(status);
+
 	status = pthread_create(&thid, pattrs, alarm_handler, NULL);
 
+	if (status) {
+		pthread_condattr_destroy(&condattrs);
+		pthread_cond_destroy(&cond);
+	}
+
 	if (pattrs)
 		pthread_attr_destroy(pattrs);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
