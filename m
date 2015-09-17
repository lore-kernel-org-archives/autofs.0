From: Yu Ning <ning.yu@canonical.com>
Subject: [PATCH v4 2/3] autofs-5.1.1 - use monotonic clock for pthread cond timed wait.
Date: Thu, 17 Sep 2015 12:09:36 +0800
Message-ID: <1442462977-23547-2-git-send-email-ning.yu@ubuntu.com>
References: <CAA1QoHT7GK1Ry4-wuVUJuAEuQyaDHE-3CzxWV9xMECUM+chyyw@mail.gmail.com>
 <1442462977-23547-1-git-send-email-ning.yu@ubuntu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.9.1"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1442462977-23547-1-git-send-email-ning.yu@ubuntu.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>, Yu Ning <ning.yu@ubuntu.com>

This is a multi-part message in MIME format.
--------------1.9.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


The default PTHREAD_COND_INITIALIZER initializer uses realtime clock,
we need to switch to use the monotic clock.

Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
---
 lib/alarm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)


--------------1.9.1
Content-Type: text/x-patch; name="v4-0002-autofs-5.1.1-use-monotonic-clock-for-pthread-cond.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="v4-0002-autofs-5.1.1-use-monotonic-clock-for-pthread-cond.patch"

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
 

--------------1.9.1--


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
