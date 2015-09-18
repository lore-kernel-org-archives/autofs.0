From: Ian Kent <raven@themaw.net>
Subject: [PATCH v5 4/8] autofs-5.1.1 - use monotonic clock for direct mount
 condition
Date: Fri, 18 Sep 2015 17:34:48 +0800
Message-ID: <20150918093447.29311.7789.stgit@pluto.fritz.box>
References: <20150918092704.29311.84246.stgit@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=KVeuiMfDWn5Ha9eG0Js6NOG5f2M=; b=MI8qd+
	n733FD00KrJ3SLsD0upE4zelw7QmitcfsGj8vbihFq4NbxcAXO4Lk68Cklbazgq3
	7XSd7UsebSF7UbSOLBp3nitXxMrEvNRxOT3ncdWYFkonnkXsJXnaeC/HBOjZKBKq
	py94I0TURo8eIrDxu2H6mrwD5N8VoC3g9A+pE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=KVeuiMfDWn5Ha9e
	G0Js6NOG5f2M=; b=ahk971V05niTX04WQU9ib+78UplaxKh4mG0fS9SFIzwtbtW
	wk743r8qVqiGZdFzQ1goF5vjZ5K2e6p0dZNdTxzEe1r+s3NvLpLr8E3ayWdPLmme
	uif1QWqJ/ByjshfvwsDeNfW83PKzPeY5SyMBcRXbhwlsZS2OngFCbAJr82hc=
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

Change the direct mount and expire thread creation to use a monotonic
clock source.

Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
---
 CHANGELOG       |    1 +
 daemon/direct.c |   20 ++++++--------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index fd0f7cd..6a51fa7 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -21,6 +21,7 @@
 - define monotonic clock helper functions.
 - use monotonic clock for alarm thread condition wait.
 - define pending condition init helper function.
+- use monotonic clock for direct mount condition.
 
 21/04/2015 autofs-5.1.1
 =======================
diff --git a/daemon/direct.c b/daemon/direct.c
index 1962a58..9b7fd76 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1045,7 +1045,6 @@ int handle_packet_expire_direct(struct autofs_point *ap, autofs_packet_expire_di
 	char buf[MAX_ERR_BUF];
 	pthread_t thid;
 	struct timespec wait;
-	struct timeval now;
 	int status, state;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
@@ -1115,9 +1114,7 @@ int handle_packet_expire_direct(struct autofs_point *ap, autofs_packet_expire_di
 		return 1;
 	}
 
-	status = pthread_cond_init(&mt->cond, NULL);
-	if (status)
-		fatal(status);
+	pending_cond_init(mt);
 
 	status = pthread_mutex_init(&mt->mutex, NULL);
 	if (status)
@@ -1163,9 +1160,8 @@ int handle_packet_expire_direct(struct autofs_point *ap, autofs_packet_expire_di
 
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
@@ -1300,7 +1296,6 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 	char buf[MAX_ERR_BUF];
 	int status = 0;
 	struct timespec wait;
-	struct timeval now;
 	int ioctlfd, len, state;
 	unsigned int kver_major = get_kver_major();
 	unsigned int kver_minor = get_kver_minor();
@@ -1431,9 +1426,7 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 	}
 	memset(mt, 0, sizeof(struct pending_args));
 
-	status = pthread_cond_init(&mt->cond, NULL);
-	if (status)
-		fatal(status);
+	pending_cond_init(mt);
 
 	status = pthread_mutex_init(&mt->mutex, NULL);
 	if (status)
@@ -1482,9 +1475,8 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 
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
