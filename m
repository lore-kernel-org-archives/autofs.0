From: Ian Kent <raven@themaw.net>
Subject: [PATCH 07/34] autofs-5.1.2 - make set_direct_mount_catatonic() more
 general
Date: Mon, 24 Apr 2017 09:00:49 +0800
Message-ID: <149299564929.23475.1779708203895937564.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=IggG0tXAtdjl1M2ULR
        QDasb2kCIRZYv9UIrpKloZh2U=; b=MXO/uumEsiPzmXHYLFs5GUEHuyajqKBn63
        yIfovIMHW+L5ElaoIIajmNKeM4M/vMf2qKkXtx/5XKpBKngEcSgze0Y6Gv/DYukA
        voGG/0XFUprUnownnV4f1T/OG1MoLgvvRGMci5PjVHH7eLdET17gEWEbTHihKeAv
        bKkJbmdJS/1wLfO/0cigeGeWkC8b0KX+QPQLgu60qSrozbkWZ9SIZttrYDUr3IyF
        ivNDZzDftNi5pnVT+UdWSn7i5HJcBHS9SGSulR8CnUcW4vN5Y1SKJhv/HYiwW0Tu
        xjcaNlQ9ZD1/jkQMu33wc+czUzXI3VO7894O8lghboTBwGrrckLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=IggG0tXAtdjl1M2ULRQDasb2kCIRZYv9UIrpKloZh2U=; b=nUIJ33R1
        OLFYdbx5aTGkylPJ/wCkdtzz6JP1476YcqVTjH77xco2WZrmOChb4OiiFRg/wIzk
        P03i/XQqlj4/q6sH0S+uYKtnyksg5VGAWqarCqj0rnzRjU2CNqP7XtONecTLQd8T
        Ei8qoi0D0GRJ5OmteOZbuYLYs7qywS3bBc6L/UzRbhbpf3zNQdlabRhIYyUbAYIV
        t1kjLiVTkh4Kir262lPDWJkXAf710RlaEzPGzbN3TER2gk0/NvBB67kY3QRpj2nb
        iPrbCYtWJhkamzuJNfvUDGSiK6sMsOs/ChUvvUNAgFJllQE4/vNrznj49O//sRA4
        qLc167dBtvhlaw==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Setting direct mounts catatonic at exit doesn't go far enough.

To avoid possible hang on access of automount managed paths when
the daemon has exited all mounted autofs file systems must be set
catatonic when the daemon exits.

Start by making set_direct_mount_catatonic() able to handle the
different types of autofs mounts and move it to the mounts function
library.
---
 CHANGELOG        |    1 +
 daemon/direct.c  |   69 ++++--------------------------------------------------
 include/mounts.h |    1 +
 lib/mounts.c     |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 64 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index c43ebc9..8b7de5f 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -33,6 +33,7 @@ xx/xx/2016 autofs-5.1.3
 - don't return until after master map retry read.
 - make lookup_nss_read_master() return nss status.
 - check NFS server availability on local mount fallback.
+- make set_direct_mount_catatonic() more general.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/direct.c b/daemon/direct.c
index 3cce0db..81f6e67 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -82,65 +82,6 @@ static void mnts_cleanup(void *arg)
 	return;
 }
 
-/* When exiting direct mount triggers must be set catatonic, regardless
- * of whether they are busy on not, to avoid a hang on access once the
- * daemon has gone away.
- */
-static int set_direct_mount_catatonic(struct autofs_point *ap, struct mapent *me, int ioctlfd)
-{
-	struct ioctl_ops *ops = get_ioctl_ops();
-	unsigned int opened = 0;
-	char buf[MAX_ERR_BUF];
-	int fd = -1;
-	int error;
-
-	/* In case the miscellaneous device isn't being used try
-	 * and use an existing ioctl control fd. In this case if
-	 * we don't already have an ioctl fd the mount can't be
-	 * set catatonic if it's covered.
-	 */
-	if (ioctlfd >= 0)
-		fd = ioctlfd;
-	else if (me->ioctlfd >= 0)
-		fd = me->ioctlfd;
-	else {
-		error = ops->open(ap->logopt, &fd, me->dev, me->key);
-		if (error == -1) {
-			int err = errno;
-			char *estr;
-
-			estr = strerror_r(errno, buf, MAX_ERR_BUF);
-			error(ap->logopt,
-			      "failed to open ioctlfd for %s, error: %s",
-			      me->key, estr);
-			return err;
-		}
-		opened = 1;
-	}
-
-	if (fd >= 0) {
-		error = ops->catatonic(ap->logopt, fd);
-		if (error == -1) {
-			int err = errno;
-			char *estr;
-
-			estr = strerror_r(errno, buf, MAX_ERR_BUF);
-			error(ap->logopt,
-			      "failed to set %s catatonic, error: %s",
-			      me->key, estr);
-			if (opened)
-				ops->close(ap->logopt, fd);
-			return err;
-		}
-		if (opened)
-			ops->close(ap->logopt, fd);
-	}
-
-	debug(ap->logopt, "set %s catatonic", me->key);
-
-	return 0;
-}
-
 int do_umount_autofs_direct(struct autofs_point *ap, struct mnt_list *mnts, struct mapent *me)
 {
 	struct ioctl_ops *ops = get_ioctl_ops();
@@ -190,19 +131,19 @@ int do_umount_autofs_direct(struct autofs_point *ap, struct mnt_list *mnts, stru
 				      "ask umount returned busy for %s",
 				      me->key);
 				if (ap->state != ST_READMAP)
-					set_direct_mount_catatonic(ap, me, ioctlfd);
+					set_mount_catatonic(ap, me, ioctlfd);
 				if (opened)
 					ops->close(ap->logopt, ioctlfd);
 				return 1;
 			} else {
 				me->ioctlfd = -1;
-				set_direct_mount_catatonic(ap, me, ioctlfd);
+				set_mount_catatonic(ap, me, ioctlfd);
 				ops->close(ap->logopt, ioctlfd);
 				goto force_umount;
 			}
 		}
 		me->ioctlfd = -1;
-		set_direct_mount_catatonic(ap, me, ioctlfd);
+		set_mount_catatonic(ap, me, ioctlfd);
 		ops->close(ap->logopt, ioctlfd);
 	} else {
 		error(ap->logopt,
@@ -297,12 +238,12 @@ int umount_autofs_direct(struct autofs_point *ap)
 			if (!error)
 				goto done;
 
-			error = set_direct_mount_catatonic(ap, me, me->ioctlfd);
+			error = set_mount_catatonic(ap, me, me->ioctlfd);
 			if (!error)
 				goto done;
 
 			/* We really need to set this, last ditch attempt */
-			set_direct_mount_catatonic(ap, me, -1);
+			set_mount_catatonic(ap, me, -1);
 done:
 			me = cache_enumerate(mc, me);
 		}
diff --git a/include/mounts.h b/include/mounts.h
index 489025c..9ec6bd9 100644
--- a/include/mounts.h
+++ b/include/mounts.h
@@ -113,6 +113,7 @@ void set_tsd_user_vars(unsigned int, uid_t, gid_t);
 const char *mount_type_str(unsigned int);
 void notify_mount_result(struct autofs_point *, const char *, time_t, const char *);
 int try_remount(struct autofs_point *, struct mapent *, unsigned int);
+int set_mount_catatonic(struct autofs_point *, struct mapent *, int);
 int umount_ent(struct autofs_point *, const char *);
 int mount_multi_triggers(struct autofs_point *, struct mapent *, const char *, unsigned int, const char *);
 int umount_multi_triggers(struct autofs_point *, struct mapent *, char *, const char *);
diff --git a/lib/mounts.c b/lib/mounts.c
index d3d7345..44c907e 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -1855,6 +1855,70 @@ int try_remount(struct autofs_point *ap, struct mapent *me, unsigned int type)
 	return 0;
 }
 
+/*
+ * When exiting mounts need be set catatonic, regardless of whether they
+ * are busy on not, to avoid a hang on access once the daemon has gone
+ * away.
+ */
+int set_mount_catatonic(struct autofs_point *ap, struct mapent *me, int ioctlfd)
+{
+	struct ioctl_ops *ops = get_ioctl_ops();
+	unsigned int opened = 0;
+	char buf[MAX_ERR_BUF];
+	char *path;
+	int fd = -1;
+	int error;
+	dev_t dev;
+
+	path = ap->path;
+	dev = ap->dev;
+	if (me && (ap->type == LKP_DIRECT || *me->key == '/')) {
+		path = me->key;
+		dev = me->dev;
+	}
+
+	if (ioctlfd >= 0)
+		fd = ioctlfd;
+	else if (me && me->ioctlfd >= 0)
+		fd = me->ioctlfd;
+	else {
+		error = ops->open(ap->logopt, &fd, dev, path);
+		if (error == -1) {
+			int err = errno;
+			char *estr;
+
+			estr = strerror_r(errno, buf, MAX_ERR_BUF);
+			error(ap->logopt,
+			      "failed to open ioctlfd for %s, error: %s",
+			      path, estr);
+			return err;
+		}
+		opened = 1;
+	}
+
+	if (fd >= 0) {
+		error = ops->catatonic(ap->logopt, fd);
+		if (error == -1) {
+			int err = errno;
+			char *estr;
+
+			estr = strerror_r(errno, buf, MAX_ERR_BUF);
+			error(ap->logopt,
+			      "failed to set %s catatonic, error: %s",
+			      path, estr);
+			if (opened)
+				ops->close(ap->logopt, fd);
+			return err;
+		}
+		if (opened)
+			ops->close(ap->logopt, fd);
+	}
+
+	debug(ap->logopt, "set %s catatonic", path);
+
+	return 0;
+}
+
 int umount_ent(struct autofs_point *ap, const char *path)
 {
 	int rv;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
