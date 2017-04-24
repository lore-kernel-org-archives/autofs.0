From: Ian Kent <raven@themaw.net>
Subject: [PATCH 01/34] autofs-5.1.2 - fix included master map not found
 return
Date: Mon, 24 Apr 2017 09:00:18 +0800
Message-ID: <149299561814.23475.16968315102619391643.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=eZeu5UMgLnPTgGoTsg
        2zpv2R+70uILpcmqFbZzG6ah0=; b=BOvVaivNZnIqYQrNWF91GdX2adbRoQqE5t
        ithVAvYRo5Um8G5710AZNxuBGLyssRTawxekRNw6pFTGSDK0D5KabLAYvzOp4O02
        2dZtwarSX3I/HW3jippc7SYF12vW3Mmcxb3aZzpXWbDnLKn5zTVOtTrUDstWSjNk
        /syRVfErI4lu/+r9hxA0notqOZPGx3OgkpMNcn02my/c4Q0DE5EaGa0esdAe0ulR
        xdejHnd/2PDyGM3GA1JEzOLdksWP8midcH4hlzp6GxXP/6dkiAmBHEp4GzcE3dsW
        /pM2LrMygpmAKcsc3/zRF3erHTVsGn0DP9BRzHBpFlGiDmLg/2WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=eZeu5UMgLnPTgGoTsg2zpv2R+70uILpcmqFbZzG6ah0=; b=AgZCYe82
        44uIR3FdDjBHfiHOFrZBWFUmiMlBf9rRRux5wUsusyWPB2HjUxYBPze5DOWKvLrX
        TM5DqzPCRvyp+X+uwa2+yKyO3yjnfmtGvOmlqkX7H38nZavNVX0OsmRb11asD2Z5
        4smC0CaXgzC4FmJn9pIfiyqQY0eO4Ssm08Tw3QH09RtWzbJO40zMfAW7gKlZDBKw
        ID9HSB2/Xi+KJntV+DaShmLQHKEVD42hhsxSRJZUCnQKFwtn/euR4J1WXDDmpMZw
        U6k14gAGhLvpGKSY3qlQHqMbI+8oOEGr+PHS9saxAMS1Sq99dTydVN609+EpzKys
        eE6pmF/SGvgilA==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When retrying the master map read at startup a not found return is needed
when there is no map rather than an unknown or unavailable for the retry
logic to work.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG             |    1 +
 daemon/lookup.c       |    6 ++++--
 modules/lookup_file.c |   18 ++++++++++++------
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 38c4a2a..5822aeb 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -27,6 +27,7 @@ xx/xx/2016 autofs-5.1.3
 - work around sss startup delay.
 - add sss master map wait config option.
 - fix quoted key handling in sanitize_path().
+- fix included master map not found return.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/lookup.c b/daemon/lookup.c
index 0c2a01f..a46740e 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -241,7 +241,7 @@ int lookup_nss_read_master(struct master *master, time_t age)
 	}
 
 	/* First one gets it */
-	result = NSS_STATUS_UNKNOWN;
+	result = NSS_STATUS_SUCCESS;
 	head = &nsslist;
 	list_for_each(p, head) {
 		struct nss_source *this;
@@ -282,8 +282,10 @@ int lookup_nss_read_master(struct master *master, time_t age)
 			}
 		}
 
-		if (result == NSS_STATUS_UNKNOWN) {
+		if (result == NSS_STATUS_UNKNOWN ||
+		    result == NSS_STATUS_NOTFOUND) {
 			debug(logopt, "no map - continuing to next source");
+			result = NSS_STATUS_SUCCESS;
 			continue;
 		}
 
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index d5f8c9e..cb00ee5 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -464,6 +464,8 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 
 	f = open_fopen_r(ctxt->mapname);
 	if (!f) {
+		if (errno == ENOENT)
+			return NSS_STATUS_NOTFOUND;
 		error(logopt,
 		      MODPREFIX "could not open master map file %s",
 		      ctxt->mapname);
@@ -507,12 +509,14 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 				     MODPREFIX
 				     "failed to read included master map %s",
 				     master->name);
-				/*
-				 * If we're starting up wee need the whole
-				 * master map initially, so tell the upper
-				 * layer to retry.
-				 */
-				master->read_fail = 1;
+				if (status != NSS_STATUS_NOTFOUND) {
+					/*
+					 * If we're starting up wee need the whole
+					 * master map initially, so tell the upper
+					 * layer to retry.
+					 */
+					master->read_fail = 1;
+				}
 			}
 			master->depth--;
 			master->recurse = 0;
@@ -713,6 +717,8 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 
 	f = open_fopen_r(ctxt->mapname);
 	if (!f) {
+		if (errno == ENOENT)
+			return NSS_STATUS_NOTFOUND;
 		error(ap->logopt,
 		      MODPREFIX "could not open map file %s", ctxt->mapname);
 		return NSS_STATUS_UNAVAIL;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
