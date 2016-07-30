From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 2/3] autofs-5.1.2 - Fix typos in error messages
Date: Sat, 30 Jul 2016 13:35:38 +0900
Message-ID: <1469853339-2291-2-git-send-email-kusumi.tomohiro@gmail.com>
References: <1469853339-2291-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zZNJL9VefJLc8RO7H0292maaWohEIhUyBb8aXCma16Q=;
        b=d5fCCu9XjFsnfg+1nt0NpGwxiMmSG3oN4N7w55f6UNPiv35O9oEhz9HObyAuwUbVSk
         JaSNuAEUs5nD/TddePyFBuD83K5y3dtJ45VFxpzXV8lX+gIpMyPDP7aMRqKIv4ihzGHW
         7XzMIjI71jgWQN2uq4+jdEbnej0OlNCx2WJcNqvWHAaARZPFVwg0cB+REl2ql15nrp22
         fbcwy8jfAZ+qOw5LpPlo396HXowjKXnDPAxd6YZoE+sh/oohiGoIr+JyNQBp3SqBj0My
         E3b8PVBW0zCyYiVBTYqUv+AeFTAGRyWMnWDuhyoX/accMLxpkdO9mDcD7zd8nNF35ay4
         mkIw==
In-Reply-To: <1469853339-2291-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 daemon/automount.c | 4 ++--
 daemon/state.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index 3afa860..ca5e090 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -945,7 +945,7 @@ static int set_log_priority(const char *path, int priority)
 
 	if (priority > LOG_DEBUG || priority < LOG_EMERG) {
 		fprintf(stderr, "Log priority %d is invalid.\n", priority);
-		fprintf(stderr, "Please spcify a number in the range 0-7.\n");
+		fprintf(stderr, "Please specify a number in the range 0-7.\n");
 		return -1;
 	}
 
@@ -1078,7 +1078,7 @@ int do_expire(struct autofs_point *ap, const char *name, int namelen)
 	}
 
 	if (!len) {
-		crit(ap->logopt, "path to long for buffer");
+		crit(ap->logopt, "path too long for buffer");
 		return 1;
 	}
 
diff --git a/daemon/state.c b/daemon/state.c
index ed533da..5d81438 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -575,7 +575,7 @@ static unsigned int st_readmap(struct autofs_point *ap)
 
 	ra = malloc(sizeof(struct readmap_args));
 	if (!ra) {
-		error(ap->logopt, "failed to malloc reamap cond struct");
+		error(ap->logopt, "failed to malloc readmap cond struct");
 		/* It didn't work: return to ready */
 		st_ready(ap);
 		if (!ap->submount)
@@ -600,7 +600,7 @@ static unsigned int st_readmap(struct autofs_point *ap)
 
 	status = pthread_create(&thid, &th_attr_detached, do_readmap, ra);
 	if (status) {
-		error(ap->logopt, "read map thread create failed");
+		error(ap->logopt, "readmap thread create failed");
 		st_readmap_cleanup(ra);
 		free(ra);
 		/* It didn't work: return to ready */
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
