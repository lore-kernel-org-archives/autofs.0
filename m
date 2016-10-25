From: Ian Kent <raven@themaw.net>
Subject: [PATCH 11/37] autofs-5.1.2 - Fix typos in error messages
Date: Tue, 25 Oct 2016 09:18:24 +0800
Message-ID: <20161025011824.7778.27461.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=8PuCH0BrWHj7TLEEKNdAmdxxjsI=; b=a+J/T1gaSr3lvtxA6M
        9sK8LHkk4KoMGPyJ6eUF3mtSd942OK+roYOpZ8qJ4J7kk7OBfcIWN9a687rYkivp
        b6TS2QBzY+q6gKjgb3zKM3zgrP4N3b7Vyzpg7KfFLwyzgLtR7YZ7OvLjTWTVp+bN
        87/J16c9ffu36AQZWHMv5XFsg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=8PuCH0BrWHj7TLEEKNdAmd
        xxjsI=; b=rFYRmdiCzrHWU8VQrL5KecTBbJEqc3PtDmU9GRM5Ei3vvBUUqh1XvC
        7uCK1BMuyhIoyq8KYbJun/7aQacW4JYykPsddgyDPnf4Yo4jirWS3enxfzWZpcIB
        P7doJLtjw4TVZvfsBVooRlCv8aljwQyoW2Zc76qMj4ptaOAb41Edc=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 daemon/automount.c |    4 ++--
 daemon/state.c     |    4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 7aa7b4a..a0a2c46 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -10,6 +10,7 @@ xx/xx/2016 autofs-5.1.3
 - Change .requestor to .requester for consistency.
 - fix file map changed check.
 - Remove unused local 2KB buffer.
+- Fix typos in error messages.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 1bdc3aa..e51909c 100644
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
To unsubscribe from this list: send the line "unsubscribe autofs" in
