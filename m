From: Ian Kent <raven@themaw.net>
Subject: [PATCH 33/37] autofs-5.1.2 - check for conflicting amd section
 mounts
Date: Tue, 25 Oct 2016 09:20:21 +0800
Message-ID: <20161025012021.7778.26448.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=CF530QgEGkUqkutpVoHWGUUG7i8=; b=pqGTumZLwf8gzeQy/j
        fBzTMSASr55k0nvjwTz6odmbNeXEotCz40kxPxHRu604Dh4kZ7mHbpoAEIfQ1iKF
        zrRKQhGkYxsod9v7sH3kmtKdmTWDiuKgI3bBSwb7OK7mRVx9CsO1ncLWdNpyqv5f
        NwUIpzvxnXfA7tNovgHLi6Lkg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=CF530QgEGkUqkutpVoHWGU
        UG7i8=; b=fzKwuUZry38f+48JLcUGnQGpGRd5y+cwexRmrLITkYFlLnuYXDUoW/
        EW/akGE0sip93FzJEyAZ8zSWeBg9Ex34QLHW+fNpBLVz6PHdmba+dvWbqadfWaFj
        jCNiTPlHuYJg/DMHZs7Xx6Tyag7vdIg0l5oILuolZDzusSBWX9zJA=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Allowing the addition of amd section mounts to the master mounts list
can lead to conflicting mount point paths.

Check for conflicts and skip the amd mount section mounts if a conflict
with the master map mounts is found.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG        |    1 +
 include/master.h |    1 +
 lib/master.c     |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 3a1b534..6553a40 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -30,6 +30,7 @@ xx/xx/2016 autofs-5.1.3
 - add function conf_amd_get_map_name().
 - add function conf_amd_get_mount_paths().
 - include amd mount sections mounts in master mounts list.
+- check for conflicting amd section mounts.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/master.h b/include/master.h
index 3947cd5..087ddbe 100644
--- a/include/master.h
+++ b/include/master.h
@@ -106,6 +106,7 @@ void master_source_lock_cleanup(void *);
 void master_source_current_wait(struct master_mapent *);
 void master_source_current_signal(struct master_mapent *);
 struct master_mapent *master_find_mapent(struct master *, const char *);
+unsigned int master_partial_match_mapent(struct master *, const char *);
 struct autofs_point *__master_find_submount(struct autofs_point *, const char *);
 struct autofs_point *master_find_submount(struct autofs_point *, const char *);
 struct amd_entry *__master_find_amdmount(struct autofs_point *, const char *);
diff --git a/lib/master.c b/lib/master.c
index ba48d1b..6beae87 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -711,6 +711,53 @@ struct master_mapent *master_find_mapent(struct master *master, const char *path
 	return NULL;
 }
 
+unsigned int master_partial_match_mapent(struct master *master, const char *path)
+{
+	struct list_head *head, *p;
+	size_t path_len = strlen(path);
+	int ret = 0;
+
+	head = &master->mounts;
+	list_for_each(p, head) {
+		struct master_mapent *entry;
+		size_t entry_len;
+		size_t cmp_len;
+
+		entry = list_entry(p, struct master_mapent, list);
+
+		entry_len = strlen(entry->path);
+		cmp_len = min(entry_len, path_len);
+
+		if (!strncmp(entry->path, path, cmp_len)) {
+			/* paths are equal, matching master map entry ? */
+			if (entry_len == path_len) {
+				if (entry->maps &&
+				    entry->maps->flags & MAP_FLAG_FORMAT_AMD)
+					ret = 1;
+				else
+					ret = -1;
+				break;
+			}
+
+			/* amd mount conflicts with entry mount */
+			if (entry_len > path_len &&
+			    *(entry->path + path_len) == '/') {
+				ret = -1;
+				break;
+			}
+
+			/* entry mount conflicts with amd mount */
+			if (entry_len < path_len &&
+			    *(path + entry_len) == '/') {
+				ret = -1;
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 struct autofs_point *__master_find_submount(struct autofs_point *ap, const char *path)
 {
 	struct list_head *head, *p;
@@ -937,10 +984,16 @@ static void master_add_amd_mount_section_mounts(struct master *master, time_t ag
 		char *type = NULL;
 		char *map = NULL;
 
-		entry = master_find_mapent(master, path);
-		if (entry) {
+		ret = master_partial_match_mapent(master, path);
+		if (ret) {
+			/* If this amd entry is already present in the
+			 * master map it's not a duplicate, don't issue
+			 * an error message.
+			 */
+			if (ret == 1)
+				goto next;
 			info(m_logopt,
-			     "ignoring duplicate amd section mount %s",
+			     "amd section mount path conflict, %s ignored",
 			     path);
 			goto next;
 		}

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
