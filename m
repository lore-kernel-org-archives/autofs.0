From: Ian Kent <raven@themaw.net>
Subject: [PATCH 20/34] autofs-5.1.2 - handle amd cache option all in amd
 type auto mounts
Date: Mon, 24 Apr 2017 09:01:56 +0800
Message-ID: <149299571599.23475.15622385343697600361.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=Qe4bm1K80mQZwAzFz3
        MNIy36kUzqyJzFK45/urge8yw=; b=hlIZekEMLo0Hn+YInM7uFIQMNX/hPbblgC
        JuH8Q+c6nZ9fFHucwd59h5tU4YagtmblBFW3JSgXd7dS2UlpU1T3OVps7HsRvx/O
        V7EcqGVdMfTYFXO5tiIOTSJqhtzBD0MhBO3oBiFr1XNDU8r52VwtYib+7qaY1GMN
        1xW0cDaaVucIOdhNKQXeKq/4xrGqMq+tL1U1MGqUoE4BS3Hm8Rh0bEz6CGx0IQsL
        XfsS+B0dOXV6Lo1UOK4tIo4EEFmaetsDuBP0SCc5+RkOATVofb5pxFKXkA7Aj3g+
        CQjSSwwR/OCZASABZ36BbNiweq3Fl7s1s2lDWWTAyp8Qd0TfNGrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=Qe4bm1K80mQZwAzFz3MNIy36kUzqyJzFK45/urge8yw=; b=KPtVNTHm
        pJxp08mbMJg7WsaNfHwjE3q7UxBOacWqc0DhelSvuwQl0CRbrBHffYBRY7yQvpmF
        2Rf7vFzT7Q7cp9B1nqoVMb5omRMVZgJlZcHafxilT7/DqMG0ob/w1hVzDSD6sCc6
        AbJnAZscl/x65IK9EdCSR2y1hDJnacbb53y8pWj2wVu0nAKcba5YxQF4IOzk4usE
        X+kGad8/WKADg97Ub4dwjCrOE2xqsZnMM3Y2wgoCnkYJtTe0pN9zbfOk4PqdBPi7
        8QBGkPy+ecpngRji8CmyzMnIVIT1XrHb9Uzsv3D/16QpF6CYUnDWxxzI28/BO8Bm
        T5KvX5ALtqCJMw==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

In order to read in the map at mount time autofs submounts must be
set as browasble but amd type auto mounts that have the cache:=all
option set need to read in the map without the browse option being
set.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                |    1 +
 modules/lookup_ldap.c    |   10 ++++++----
 modules/lookup_nisplus.c |   10 ++++++----
 modules/lookup_sss.c     |   10 ++++++----
 modules/lookup_yp.c      |   10 ++++++----
 modules/mount_autofs.c   |    3 +++
 6 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 3415b18..9248bb9 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -46,6 +46,7 @@ xx/xx/2016 autofs-5.1.3
 - add function conf_get_map_options().
 - capture cache option and its settings during parsing.
 - handle map_option cache for top level mounts.
+- handle amd cache option all in amd type auto mounts.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 45100ab..98701e5 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -2797,11 +2797,13 @@ static int read_one_map(struct autofs_point *ap,
 	int rv, l;
 
 	/*
-	 * If we don't need to create directories then there's no use
-	 * reading the map. We always need to read the whole map for
-	 * direct mounts in order to mount the triggers.
+	 * If we don't need to create directories (or don't need
+	 * to read an amd cache:=all map) then there's no use
+	 * reading the map. We always need to read the whole map
+	 * for direct mounts in order to mount the triggers.
 	 */
-	if (!(ap->flags & MOUNT_FLAG_GHOST) && ap->type != LKP_DIRECT) {
+	if (ap->type != LKP_DIRECT &&
+	    !(ap->flags & (MOUNT_FLAG_GHOST|MOUNT_FLAG_AMD_CACHE_ALL))) {
 		debug(ap->logopt, "map read not needed, so not done");
 		return NSS_STATUS_SUCCESS;
 	}
diff --git a/modules/lookup_nisplus.c b/modules/lookup_nisplus.c
index c8b75e6..6430b89 100644
--- a/modules/lookup_nisplus.c
+++ b/modules/lookup_nisplus.c
@@ -239,11 +239,13 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 	master_source_current_signal(ap->entry);
 
 	/*
-	 * If we don't need to create directories then there's no use
-	 * reading the map. We always need to read the whole map for
-	 * direct mounts in order to mount the triggers.
+	 * If we don't need to create directories (or don't need
+	 * to read an amd cache:=all map) then there's no use
+	 * reading the map. We always need to read the whole map
+	 * for direct mounts in order to mount the triggers.
 	 */
-	if (!(ap->flags & MOUNT_FLAG_GHOST) && ap->type != LKP_DIRECT) {
+	if (ap->type != LKP_DIRECT &&
+	    !(ap->flags & (MOUNT_FLAG_GHOST|MOUNT_FLAG_AMD_CACHE_ALL))) {
 		debug(ap->logopt, "map read not needed, so not done");
 		return NSS_STATUS_SUCCESS;
 	}
diff --git a/modules/lookup_sss.c b/modules/lookup_sss.c
index ce4d0ed..6d924cf 100644
--- a/modules/lookup_sss.c
+++ b/modules/lookup_sss.c
@@ -402,11 +402,13 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 	mc = source->mc;
 
 	/*
-	 * If we don't need to create directories then there's no use
-	 * reading the map. We always need to read the whole map for
-	 * direct mounts in order to mount the triggers.
+	 * If we don't need to create directories (or don't need
+	 * to read an amd cache:=all map) then there's no use
+	 * reading the map. We always need to read the whole map
+	 * for direct mounts in order to mount the triggers.
 	 */
-	if (!(ap->flags & MOUNT_FLAG_GHOST) && ap->type != LKP_DIRECT) {
+	if (ap->type != LKP_DIRECT &&
+	    !(ap->flags & (MOUNT_FLAG_GHOST|MOUNT_FLAG_AMD_CACHE_ALL))) {
 		debug(ap->logopt, "map read not needed, so not done");
 		return NSS_STATUS_SUCCESS;
 	}
diff --git a/modules/lookup_yp.c b/modules/lookup_yp.c
index 0d319fd..b139b28 100644
--- a/modules/lookup_yp.c
+++ b/modules/lookup_yp.c
@@ -401,11 +401,13 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 	master_source_current_signal(ap->entry);
 
 	/*
-	 * If we don't need to create directories then there's no use
-	 * reading the map. We always need to read the whole map for
-	 * direct mounts in order to mount the triggers.
+	 * If we don't need to create directories (or don't need
+	 * to read an amd cache:=all map) then there's no use
+	 * reading the map. We always need to read the whole map
+	 * for direct mounts in order to mount the triggers.
 	 */
-	if (!(ap->flags & MOUNT_FLAG_GHOST) && ap->type != LKP_DIRECT) {
+	if (ap->type != LKP_DIRECT &&
+	    !(ap->flags & (MOUNT_FLAG_GHOST|MOUNT_FLAG_AMD_CACHE_ALL))) {
 		debug(ap->logopt, "map read not needed, so not done");
 		return NSS_STATUS_SUCCESS;
 	}
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index e404c83..20bcd11 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -289,6 +289,9 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 			nap->pref = am_entry->pref;
 			am_entry->pref = NULL;
 		}
+
+		if (am_entry->cache_opts & AMD_CACHE_OPTION_ALL)
+			nap->flags |= MOUNT_FLAG_AMD_CACHE_ALL;
 	}
 
 	if (handle_mounts_startup_cond_init(&suc)) {

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
