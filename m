From: Ian Kent <raven@themaw.net>
Subject: [PATCH 37/37] autofs-5.1.2 - handle amd cache option all in amd
 type auto mounts
Date: Tue, 25 Oct 2016 09:20:42 +0800
Message-ID: <20161025012042.7778.35649.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=EgHM5dJlGHUBfubyejUuaI/EL3U=; b=jWNutRc+X8IlXEWZwV
        j+Vq4D4vkmiA7UB9LXV9hXcDdb8BDCHoEWUQoqeuUZKvaqQlaN7QQC8DCSjCrMgj
        bGr6G+e/fjojakrUYPRVlNwaLAlFAMJmEG0b1O+tfqVuWV3daVS20BWV4YiuJtzT
        mYF1lxJtBrLQ8p3GTMj1VkhP4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=EgHM5dJlGHUBfubyejUuaI
        /EL3U=; b=bFw5BdA+GtYzAH2j7ZIhOZf5guPo5J3ZxE9m3KihOI3DBxu6UvbMPp
        icdWByVEXW640OHYqBjQiTOdKS3LUoXFAz3nu/bxELerbnPk0NOAW60KPF2Y1pMW
        bw4rkMdhq8Uf/cnOWyY9UdDDzzbGobwZfxk/piYzidXjrlo6V1eDs=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
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
index 8f47520..0df6b31 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -34,6 +34,7 @@ xx/xx/2016 autofs-5.1.3
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
