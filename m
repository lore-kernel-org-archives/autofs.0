From: Ian Kent <raven@themaw.net>
Subject: [PATCH v5 2/8] autofs-5.1.1 - use monotonic clock for alarm thread
 condition wait
Date: Fri, 18 Sep 2015 17:34:34 +0800
Message-ID: <20150918093433.29311.80065.stgit@pluto.fritz.box>
References: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=rNYTni3okd38dmivy66DRY3oS5E=; b=Fs53DP
	/Axe56kRgiQhdIibx9wi3cX7olhodwwsdJI/ftPncFWW7sMcyiMIXU/6gf0N0xJN
	f7XDbDKkg+5AXqnzVZtJ6FfaTKBuZinX29vm483yMAtvc+FSaMsEJGIM1V/ah4d/
	Kg8jrn5hnHgDu+GZM97yH/M2GuwSKHx07H/m8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=rNYTni3okd38dmi
	vy66DRY3oS5E=; b=VnfmD4sq/3F6AV9RBNV2AgbRYk5eJ8ulGvMDTN/H/YMXFAJ
	wfi3lbicRIcNA0ybUmd7OW9HSwl/jHSd3Li2wKaLOmAUwYgryV2zdsWKlE6Czynw
	zmJ6+tAlMgZoq5Fz7o4OgJZE1AACYPuqSKrNRg0fVcbrXihOTNjk1DBHoqUI=
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

Convert the alarm_handler() to use a monotonic clock source.

Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
---
 CHANGELOG   |    1 +
 lib/alarm.c |   28 ++++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 6eb4daf..c7cbc0f 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -19,6 +19,7 @@
 - fix error handling of is_mounted().
 - Add a mode option for master map entries.
 - define monotonic clock helper functions.
+- use monotonic clock for alarm thread condition wait.
 
 21/04/2015 autofs-5.1.1
 =======================
diff --git a/lib/alarm.c b/lib/alarm.c
index 0f04ef8..e6a880b 100755
--- a/lib/alarm.c
+++ b/lib/alarm.c
@@ -23,7 +23,7 @@ struct alarm {
 };
 
 static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
-static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+static pthread_cond_t cond;
 static LIST_HEAD(alarms);
 
 #define alarm_lock() \
@@ -46,7 +46,7 @@ int alarm_add(struct autofs_point *ap, time_t seconds)
 	struct list_head *head;
 	struct list_head *p;
 	struct alarm *new;
-	time_t now = time(NULL);
+	time_t now = monotonic_time(NULL);
 	time_t next_alarm = 0;
 	unsigned int empty = 1;
 	int status;
@@ -175,17 +175,18 @@ static void *alarm_handler(void *arg)
 
 		first = list_entry(head->next, struct alarm, list);
 
-		now = time(NULL);
+		now = monotonic_time(NULL);
 
 		if (first->time > now) {
-			struct timeval usecs;
+			struct timespec nsecs;
+
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
@@ -212,6 +213,7 @@ int alarm_start_handler(void)
 	pthread_t thid;
 	pthread_attr_t attrs;
 	pthread_attr_t *pattrs = &attrs;
+	pthread_condattr_t condattrs;
 	int status;
 
 	status = pthread_attr_init(pattrs);
@@ -224,8 +226,22 @@ int alarm_start_handler(void)
 #endif
 	}
 
+	status = pthread_condattr_init(&condattrs);
+	if (status)
+		fatal(status);
+
+	status = pthread_condattr_setclock(&condattrs, CLOCK_MONOTONIC);
+	if (status)
+		fatal(status);
+
+	status = pthread_cond_init(&cond, &condattrs);
+	if (status)
+		fatal(status);
+
 	status = pthread_create(&thid, pattrs, alarm_handler, NULL);
 
+	pthread_condattr_destroy(&condattrs);
+
 	if (pattrs)
 		pthread_attr_destroy(pattrs);
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
