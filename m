From: Ning Yu <ning.yu@canonical.com>
Subject: Re: Mount point not auto unmounted after system date/time change
Date: Wed, 16 Sep 2015 18:30:31 +0800
Message-ID: <CAA1QoHRBYtSWBCTYBiugQOC-mUjE67rxvqFKapaPvPHRXnkthg@mail.gmail.com>
References: <CAA1QoHSyMHh9LoPwAM_Nto0iTVbvaVAFH2s-gCSrpYUX1zuPuQ@mail.gmail.com>
 <CAA1QoHQBJhORCZZY8cS27TWsa=Tk6WJDCwCXXNSQJ5=R6ZtWNw@mail.gmail.com> <1442395019.2977.60.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1442395019.2977.60.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>

From 72434f142926540ec63e8ee772936172731dec72 Mon Sep 17 00:00:00 2001
From: Yu Ning <ning.yu@ubuntu.com>
Date: Wed, 16 Sep 2015 18:12:50 +0800
Subject: [PATCH 2/3] Use monotonic clock for pthread cond timed wait.

The default PTHREAD_COND_INITIALIZER initializer uses realtime clock,
we need to switch to use the monotic clock.
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
+ pthread_condattr_t condattrs;
  int status;

  status = pthread_attr_init(pattrs);
@@ -224,8 +225,18 @@ int alarm_start_handler(void)
 #endif
  }

+ status = pthread_condattr_init(&condattrs);
+ if (status)
+ fatal(status);
+
+ pthread_condattr_setclock(&condattrs, CLOCK_MONOTONIC);
+ pthread_cond_init(&cond, &condattrs);
+
  status = pthread_create(&thid, pattrs, alarm_handler, NULL);

+ pthread_condattr_destroy(&condattrs);
+ pthread_condattr_destroy(&cond);
+
  if (pattrs)
  pthread_attr_destroy(pattrs);

-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
