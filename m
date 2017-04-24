From: Ian Kent <raven@themaw.net>
Subject: [PATCH 08/34] autofs-5.1.2 - set autofs mounts catatonic at exit
Date: Mon, 24 Apr 2017 09:00:54 +0800
Message-ID: <149299565441.23475.9620706883107301793.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=nAGb0uDYLzFrEL4c81
        vxmYbg4n/CjhKNmVIpEeHU4SY=; b=cYqs32LiNNZV3z6Y+Wiuae3x88KRxDbZtp
        9x9RQp3klD8cUBG1G72HpeXUsO7jeQx/UnHU0SUXm/DgZeNR18qS6pBXsp/slDWz
        9iXoidYKYVNucCJTmLt7ciyuYZ+6Ju+9mS1WOOR5HBWcRmtThdM2k7mafxdDdvyX
        iZW845lxvce8egtfe4AAuZ2HIZnZ8of6UdMrpr8Yq6mmpmfbdmRlnal9Ak2OKoVh
        RLcvi8n0Js8z16GEVw6Ky6mLCHUmpXvBGrB4iEhlTgv3vPG5net8kwjHfWtokx45
        Pql/7/XU9c0l3f11X8II2adnPj+GEku/p0A939/uFVkeccE0gZvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=nAGb0uDYLzFrEL4c81vxmYbg4n/CjhKNmVIpEeHU4SY=; b=ErHEehfs
        MyaTxJPR6B2Yz0oz1LBNVRmdzMJlBg4NopyvOLo25l8Hx84GlLNTFV+Nrj/rsaxC
        aQpP3NIYtewZXXY5CIcd5MRnU4BMAqgolbEESqTPAi4aw23msklulrJrxBYDKcKj
        Hp/v4Gr/zejjkpxJWckFoF3RqhNWSiuJzKDEp+6fJYTowvMeLgtUvaZRbLFAdhgr
        shsYKvLpQKlr0r/IGk1Z4sh4R+40P4nZYy2rsyJV+RSWlStq4493SFc21EOY7Gx5
        dF04Q9saFzRX4vkpZ9bRlMhqizuqpVkbscSHDtYlMlY0kizyP1UeQvfpC7vS7Wuq
        rY5fpuTX60UOAw==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Setting direct mounts catatonic at exit doesn't go far enough.

To avoid possible hang on access of automount managed paths when
the daemon has exited all mounted autofs file systems must be set
catatonic when the daemon exits.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 daemon/automount.c |    1 +
 daemon/direct.c    |   17 +++++--------
 daemon/indirect.c  |    3 --
 include/mounts.h   |    3 ++
 lib/mounts.c       |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 8b7de5f..8eedad3 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -34,6 +34,7 @@ xx/xx/2016 autofs-5.1.3
 - make lookup_nss_read_master() return nss status.
 - check NFS server availability on local mount fallback.
 - make set_direct_mount_catatonic() more general.
+- set autofs mounts catatonic at exit.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 15dadb5..6ebe885 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1756,6 +1756,7 @@ int handle_mounts_exit(struct autofs_point *ap)
 	 */
 	ret = umount_autofs(ap, NULL, 1);
 	if (!ret) {
+		set_indirect_mount_tree_catatonic(ap);
 		handle_mounts_cleanup(ap);
 		return 1;
 	}
diff --git a/daemon/direct.c b/daemon/direct.c
index 81f6e67..7a8d309 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -130,20 +130,16 @@ int do_umount_autofs_direct(struct autofs_point *ap, struct mnt_list *mnts, stru
 				error(ap->logopt,
 				      "ask umount returned busy for %s",
 				      me->key);
-				if (ap->state != ST_READMAP)
-					set_mount_catatonic(ap, me, ioctlfd);
 				if (opened)
 					ops->close(ap->logopt, ioctlfd);
 				return 1;
 			} else {
 				me->ioctlfd = -1;
-				set_mount_catatonic(ap, me, ioctlfd);
 				ops->close(ap->logopt, ioctlfd);
 				goto force_umount;
 			}
 		}
 		me->ioctlfd = -1;
-		set_mount_catatonic(ap, me, ioctlfd);
 		ops->close(ap->logopt, ioctlfd);
 	} else {
 		error(ap->logopt,
@@ -173,8 +169,11 @@ int do_umount_autofs_direct(struct autofs_point *ap, struct mnt_list *mnts, stru
 			warn(ap->logopt, "mount point %s is in use", me->key);
 			if (ap->state == ST_SHUTDOWN_FORCE)
 				goto force_umount;
-			else
+			else {
+				if (ap->state != ST_READMAP)
+					set_direct_mount_tree_catatonic(ap, me);
 				return 0;
+			}
 			break;
 		case ENOTDIR:
 			error(ap->logopt, "mount point is not a directory");
@@ -238,12 +237,8 @@ int umount_autofs_direct(struct autofs_point *ap)
 			if (!error)
 				goto done;
 
-			error = set_mount_catatonic(ap, me, me->ioctlfd);
-			if (!error)
-				goto done;
-
-			/* We really need to set this, last ditch attempt */
-			set_mount_catatonic(ap, me, -1);
+			if (ap->state != ST_READMAP)
+				set_direct_mount_tree_catatonic(ap, me);
 done:
 			me = cache_enumerate(mc, me);
 		}
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 4c32bdb..8171fb0 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -290,9 +290,6 @@ int umount_autofs_indirect(struct autofs_point *ap, const char *root)
 #endif
 	}
 
-	if (ap->shutdown)
-		ops->catatonic(ap->logopt, ap->ioctlfd);
-
 	ops->close(ap->logopt, ap->ioctlfd);
 	ap->ioctlfd = -1;
 	sched_yield();
diff --git a/include/mounts.h b/include/mounts.h
index 9ec6bd9..8425818 100644
--- a/include/mounts.h
+++ b/include/mounts.h
@@ -113,7 +113,8 @@ void set_tsd_user_vars(unsigned int, uid_t, gid_t);
 const char *mount_type_str(unsigned int);
 void notify_mount_result(struct autofs_point *, const char *, time_t, const char *);
 int try_remount(struct autofs_point *, struct mapent *, unsigned int);
-int set_mount_catatonic(struct autofs_point *, struct mapent *, int);
+void set_indirect_mount_tree_catatonic(struct autofs_point *);
+void set_direct_mount_tree_catatonic(struct autofs_point *, struct mapent *);
 int umount_ent(struct autofs_point *, const char *);
 int mount_multi_triggers(struct autofs_point *, struct mapent *, const char *, unsigned int, const char *);
 int umount_multi_triggers(struct autofs_point *, struct mapent *, char *, const char *);
diff --git a/lib/mounts.c b/lib/mounts.c
index 44c907e..a9be906 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -1860,7 +1860,7 @@ int try_remount(struct autofs_point *ap, struct mapent *me, unsigned int type)
  * are busy on not, to avoid a hang on access once the daemon has gone
  * away.
  */
-int set_mount_catatonic(struct autofs_point *ap, struct mapent *me, int ioctlfd)
+static int set_mount_catatonic(struct autofs_point *ap, struct mapent *me, int ioctlfd)
 {
 	struct ioctl_ops *ops = get_ioctl_ops();
 	unsigned int opened = 0;
@@ -1887,6 +1887,9 @@ int set_mount_catatonic(struct autofs_point *ap, struct mapent *me, int ioctlfd)
 			int err = errno;
 			char *estr;
 
+			if (errno == ENOENT)
+				return 0;
+
 			estr = strerror_r(errno, buf, MAX_ERR_BUF);
 			error(ap->logopt,
 			      "failed to open ioctlfd for %s, error: %s",
@@ -1919,6 +1922,70 @@ int set_mount_catatonic(struct autofs_point *ap, struct mapent *me, int ioctlfd)
 	return 0;
 }
 
+static void set_multi_mount_tree_catatonic(struct autofs_point *ap, struct mapent *me)
+{
+	if (!list_empty(&me->multi_list)) {
+		struct list_head *head = &me->multi_list;
+		struct list_head *p;
+
+		list_for_each(p, head) {
+			struct mapent *this;
+
+			this = list_entry(p, struct mapent, multi_list);
+			set_mount_catatonic(ap, this, this->ioctlfd);
+		}
+	}
+}
+
+void set_indirect_mount_tree_catatonic(struct autofs_point *ap)
+{
+	struct master_mapent *entry = ap->entry;
+	struct map_source *map;
+	struct mapent_cache *mc;
+	struct mapent *me;
+
+	if (!is_mounted(_PROC_MOUNTS, ap->path, MNTS_AUTOFS))
+		return;
+
+	map = entry->maps;
+	while (map) {
+		mc = map->mc;
+		cache_readlock(mc);
+		me = cache_enumerate(mc, NULL);
+		while (me) {
+			/* Skip negative map entries and wildcard entries */
+			if (!me->mapent)
+				goto next;
+
+			if (!strcmp(me->key, "*"))
+				goto next;
+
+			/* Only need to set offset mounts catatonic */
+			if (me->multi && me->multi == me)
+				set_multi_mount_tree_catatonic(ap, me);
+next:
+			me = cache_enumerate(mc, me);
+		}
+		cache_unlock(mc);
+		map = map->next;
+	}
+
+	/* By the time this function is called ap->ioctlfd will have
+	 * been closed so don't try and use it.
+	 */
+	set_mount_catatonic(ap, NULL, -1);
+
+	return;
+}
+
+void set_direct_mount_tree_catatonic(struct autofs_point *ap, struct mapent *me)
+{
+	/* Set offset mounts catatonic for this mapent */
+	if (me->multi && me->multi == me)
+		set_multi_mount_tree_catatonic(ap, me);
+	set_mount_catatonic(ap, me, me->ioctlfd);
+}
+
 int umount_ent(struct autofs_point *ap, const char *path)
 {
 	int rv;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
