From: Ian Kent <raven@themaw.net>
Subject: [PATCH 16/34] autofs-5.1.2 - check for conflicting amd section
 mounts
Date: Mon, 24 Apr 2017 09:01:35 +0800
Message-ID: <149299569550.23475.4019313792305540963.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=xsHexpRSnXqQ+Ts6q7
        Z0Cyfsvnv3YEGroST6fYLBXzc=; b=U5AzaeqdvGMkt5dLrTK0DQZwqnF1w1KXWo
        sEtpz8efOHvdbaX20CvK7ayOOoBPgQvoJskOJ2Pn2P8sINXiKP8M17loSCVR+WTp
        b0eTVIa6odMi0aHcoJ1upmWj+K8rmiBbRNFZ58d9B/Ou1IZ/t936tc1BCVSTrzMw
        XeIfNCxbxoXO7OVSVOEXxuLYnkyBaFODmPpm4nHdrUwfKG5X13YDInXtFHSbkwXz
        6xH6GwdANoeYgDZcWTy8+L0aJUYNPhagrl5zSBCbQM2ItpWO+hDR230k1Q7LC/Wn
        JGun/qNxhe/45ML0HfPKJgWEDSQhSckCpjTG03Vbtw/5OAINAZ+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=xsHexpRSnXqQ+Ts6q7Z0Cyfsvnv3YEGroST6fYLBXzc=; b=FiMGSnte
        x1L7AF8LcyskKW3bwBKYlNEtH2VxgzY2sflXo/RVhfg/ONX4iPhiSgdnULCnBlhB
        bF/2dB8KYnbAWxGOy7wOIgbBVxgu/7BtvyJ4fDPRAJ9CXntk3LeNoC1VAXx0qf5Q
        z9U1+ESplMqzxD+mzLqYs/7QaiE35D7GKCG+WnC9llvkJ7Xd2GB5SJoP7gDArk97
        QVfyV/VX3A2+dF62zk3tYDxoXkYFcjIHIt2Mv3Glc/yUwvCjKEVSh3JeT4doV5kg
        DTDc35huOvD7w3RUm6qGaPXz8gdI/Dnhvj+soykhfmdgbSyJvQeWGAMvtR79Sjds
        4m2NaAV4rwJCoQ==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
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
index 4e677e2..3615de7 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -42,6 +42,7 @@ xx/xx/2016 autofs-5.1.3
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
