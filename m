From: Yu Ning <ning.yu@canonical.com>
Subject: [PATCH v3 2/3] autofs-5.1.1 - use monotonic clock for pthread cond timed wait.
Date: Thu, 17 Sep 2015 11:48:52 +0800
Message-ID: <1442461733-22907-2-git-send-email-ning.yu@ubuntu.com>
References: <1442402500.2977.80.camel@themaw.net>
 <1442461733-22907-1-git-send-email-ning.yu@ubuntu.com>
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1442461733-22907-1-git-send-email-ning.yu@ubuntu.com>
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
 lib/alarm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/alarm.c b/lib/alarm.c
index 65a80ae..5b98b2d 100755
--- a/lib/alarm.c
+++ b/lib/alarm.c
@@ -23,7 +23,7 @@ struct alarm {
 };
 
 static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
-static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+static pthread_cond_t cond;
 static LIST_HEAD(alarms);
 
 #define alarm_lock() \
@@ -212,6 +212,7 @@ int alarm_start_handler(void)
 	pthread_t thid;
 	pthread_attr_t attrs;
 	pthread_attr_t *pattrs = &attrs;
+	pthread_condattr_t condattrs;
 	int status;
 
 	status = pthread_attr_init(pattrs);
@@ -224,8 +225,18 @@ int alarm_start_handler(void)
 #endif
 	}
 
+	status = pthread_condattr_init(&condattrs);
+	if (status)
+		fatal(status);
+
+	pthread_condattr_setclock(&condattrs, CLOCK_MONOTONIC);
+	pthread_cond_init(&cond, &condattrs);
+
 	status = pthread_create(&thid, pattrs, alarm_handler, NULL);
 
+	pthread_condattr_destroy(&condattrs);
+	pthread_condattr_destroy(&cond);
+
 	if (pattrs)
 		pthread_attr_destroy(pattrs);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
