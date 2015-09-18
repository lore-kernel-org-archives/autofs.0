From: Ian Kent <raven@themaw.net>
Subject: [PATCH v5 5/8] autofs-5.1.1 - use monotonic clock for indirect
 mount condition
Date: Fri, 18 Sep 2015 17:34:56 +0800
Message-ID: <20150918093454.29311.26064.stgit@pluto.fritz.box>
References: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=U1RZFqwrP3Q31bQPDgHWkcUGoLo=; b=s4Sf/n
	DawCpLFw2HcXodzmZbBpbjY03NGTyFrveqU6A0chOryZ64oze9/1veXyXUxfSDFn
	6QGhZYhTvv0lSqubGEVTNYfpt106BBZau8KgahBcwBu7x6JxH47nolGN4X6Sp1Us
	scaaMibUembIUiCA1/oNh7DoBLRkUdP10ekWA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=U1RZFqwrP3Q31bQ
	PDgHWkcUGoLo=; b=K6sxZTa4+GQpyzilECWBGJU2A17EtnsKWeEbXuDQALcBQ5x
	D1hso7GE1IrKva3wcWq2O7VAmDEMRP8FSvyLYLJeoa2pAALWD5iHV9liYprKKcZb
	IDp8q1sDQRl1mi30bIPaOX6MYaBhjmWbKVbn4skDbv0QFnrlCFmDVghj+Jv0=
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

Change the indirect mount and expire thread creation to use a monotonic
clock source.

Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
---
 CHANGELOG         |    1 +
 daemon/indirect.c |   20 ++++++--------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 6a51fa7..63b91aa 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -22,6 +22,7 @@
 - use monotonic clock for alarm thread condition wait.
 - define pending condition init helper function.
 - use monotonic clock for direct mount condition.
+- use monotonic clock for indirect mount condition.
 
 21/04/2015 autofs-5.1.1
 =======================
diff --git a/daemon/indirect.c b/daemon/indirect.c
index bfd181d..263fff1 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -640,7 +640,6 @@ int handle_packet_expire_indirect(struct autofs_point *ap, autofs_packet_expire_
 	char buf[MAX_ERR_BUF];
 	pthread_t thid;
 	struct timespec wait;
-	struct timeval now;
 	int status, state;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
@@ -658,9 +657,7 @@ int handle_packet_expire_indirect(struct autofs_point *ap, autofs_packet_expire_
 		return 1;
 	}
 
-	status = pthread_cond_init(&mt->cond, NULL);
-	if (status)
-		fatal(status);
+	pending_cond_init(mt);
 
 	status = pthread_mutex_init(&mt->mutex, NULL);
 	if (status)
@@ -695,9 +692,8 @@ int handle_packet_expire_indirect(struct autofs_point *ap, autofs_packet_expire_
 
 	mt->signaled = 0;
 	while (!mt->signaled) {
-		gettimeofday(&now, NULL);
-		wait.tv_sec = now.tv_sec + 2;
-		wait.tv_nsec = now.tv_usec * 1000;
+		clock_gettime(CLOCK_MONOTONIC, &wait);
+		wait.tv_sec += 2;
 		status = pthread_cond_timedwait(&mt->cond, &mt->mutex, &wait);
 		if (status && status != ETIMEDOUT)
 			fatal(status);
@@ -799,7 +795,6 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 	char buf[MAX_ERR_BUF];
 	struct pending_args *mt;
 	struct timespec wait;
-	struct timeval now;
 	struct mapent *me;
 	int status, state;
 
@@ -845,9 +840,7 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 	}
 	memset(mt, 0, sizeof(struct pending_args));
 
-	status = pthread_cond_init(&mt->cond, NULL);
-	if (status)
-		fatal(status);
+	pending_cond_init(mt);
 
 	status = pthread_mutex_init(&mt->mutex, NULL);
 	if (status)
@@ -888,9 +881,8 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 
 	mt->signaled = 0;
 	while (!mt->signaled) {
-		gettimeofday(&now, NULL);
-		wait.tv_sec = now.tv_sec + 2;
-		wait.tv_nsec = now.tv_usec * 1000;
+		clock_gettime(CLOCK_MONOTONIC, &wait);
+		wait.tv_sec += 2;
 		status = pthread_cond_timedwait(&mt->cond, &mt->mutex, &wait);
 		if (status && status != ETIMEDOUT)
 			fatal(status);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
