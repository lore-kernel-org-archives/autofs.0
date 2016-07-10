From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 2/2] autofs-5.1.2 - Change .requestor to .requester for consistency
Date: Sun, 10 Jul 2016 17:10:20 +0900
Message-ID: <1468138220-4952-2-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138220-4952-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CtwUIETFxQ66YGZWvQmyeO3tc8XbfPw4kO9u2ykTAUI=;
        b=QKOhaReKhkdr8DDXVPYkluip/tLq3Xl9gAT0DX6FVLj/SAlKplce8DGtaXszD7Qx8z
         xgEO1UmLkwIyBZCf4iKu3ppEDd89eLnj7+rRCr3SV1u06dO3ft3d9J2b6aT4Ku7VgjLQ
         SJoWBdKFbGxHu07TYb+wjrpJ36AM2L7a/Y/asrWjpRO4BV8NCYEi4nImBwkHzI/85lBI
         g6v5I5BcPQfaLUErDLbL5EXZHusyzz/nIzcSEVOKfy0KSjWzZf+sqwNjhfcTCqlCkBR3
         QJDyFZYd6VP49D2TaCutVk86+b5CscyUu4N5TzjHrXQsw90xVNRAfVeAj3TscZDAHzYW
         x86A==
In-Reply-To: <1468138220-4952-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Since the name of ioctl command is AUTOFS_DEV_IOCTL_REQUESTER,
we should use .requester for consistency, assuming autofs
userspace doesn't have intention to provide these interface
for external programs or libraries which break api compatibiliy.

Also note that kernel code of autofs uses "requester".

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 daemon/automount.c      |  2 +-
 include/automount.h     |  4 ++--
 include/dev-ioctl-lib.h |  2 +-
 lib/dev-ioctl-lib.c     | 10 +++++-----
 lib/mounts.c            |  4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index ad5cafd..fee93cc 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -238,7 +238,7 @@ int rmdir_path(struct autofs_point *ap, const char *path, dev_t dev)
 			crit(ap->logopt, "attempt to remove directory from a "
 			     "non-autofs filesystem!");
 			crit(ap->logopt,
-			     "requestor dev == %llu, \"%s\" owner dev == %llu",
+			     "requester dev == %llu, \"%s\" owner dev == %llu",
 			     dev, buf, st.st_dev);
 			return -1;
 		}
diff --git a/include/automount.h b/include/automount.h
index c0f5fbf..2029e3d 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -425,8 +425,8 @@ struct pending_args {
 	char name[PATH_MAX];		/* Name field of the request */
 	dev_t dev;			/* device number of mount */
 	unsigned int len;		/* Name field len */
-	uid_t uid;			/* uid of requestor */
-	gid_t gid;			/* gid of requestor */
+	uid_t uid;			/* uid of requester */
+	gid_t gid;			/* gid of requester */
 	unsigned long wait_queue_token;	/* Associated kernel wait token */
 };
 
diff --git a/include/dev-ioctl-lib.h b/include/dev-ioctl-lib.h
index b96e0dd..eb9075c 100644
--- a/include/dev-ioctl-lib.h
+++ b/include/dev-ioctl-lib.h
@@ -46,7 +46,7 @@ struct ioctl_ops {
 	int (*setpipefd)(unsigned int, int, int);
 	int (*catatonic)(unsigned int, int);
 	int (*timeout)(unsigned int, int, time_t);
-	int (*requestor)(unsigned int, int, const char *, uid_t *, gid_t *);
+	int (*requester)(unsigned int, int, const char *, uid_t *, gid_t *);
 	int (*expire)(unsigned int, int, const char *, unsigned int);
 	int (*askumount)(unsigned int, int, unsigned int *);
 	int (*ismountpoint)(unsigned int, int, const char *, unsigned int *);
diff --git a/lib/dev-ioctl-lib.c b/lib/dev-ioctl-lib.c
index 85b3272..e851923 100644
--- a/lib/dev-ioctl-lib.c
+++ b/lib/dev-ioctl-lib.c
@@ -56,7 +56,7 @@ static int dev_ioctl_send_fail(unsigned int, int, unsigned int, int);
 static int dev_ioctl_setpipefd(unsigned int, int, int);
 static int dev_ioctl_catatonic(unsigned int, int);
 static int dev_ioctl_timeout(unsigned int, int, time_t);
-static int dev_ioctl_requestor(unsigned int, int, const char *, uid_t *, gid_t *);
+static int dev_ioctl_requester(unsigned int, int, const char *, uid_t *, gid_t *);
 static int dev_ioctl_expire(unsigned int, int, const char *, unsigned int);
 static int dev_ioctl_askumount(unsigned int, int, unsigned int *);
 static int dev_ioctl_ismountpoint(unsigned int, int, const char *, unsigned int *);
@@ -85,7 +85,7 @@ static struct ioctl_ops dev_ioctl_ops = {
 	.setpipefd	= dev_ioctl_setpipefd,
 	.catatonic	= dev_ioctl_catatonic,
 	.timeout	= dev_ioctl_timeout,
-	.requestor	= dev_ioctl_requestor,
+	.requester	= dev_ioctl_requester,
 	.expire		= dev_ioctl_expire,
 	.askumount	= dev_ioctl_askumount,
 	.ismountpoint	= dev_ioctl_ismountpoint
@@ -103,7 +103,7 @@ static struct ioctl_ops ioctl_ops = {
 	.setpipefd	= NULL,
 	.catatonic	= ioctl_catatonic,
 	.timeout	= ioctl_timeout,
-	.requestor	= NULL,
+	.requester	= NULL,
 	.expire		= ioctl_expire,
 	.askumount	= ioctl_askumount,
 	.ismountpoint	= NULL
@@ -261,7 +261,7 @@ static void free_dev_ioctl_open(struct autofs_dev_ioctl *ioctl)
 
 /*
  * Allocate a parameter struct for misc device ioctl which includes
- * a path. This is used when getting the last mount requestor uid
+ * a path. This is used when getting the last mount requester uid
  * and gid and when checking if a path within the autofs filesystem
  * is a mount point. We add the path to the end of the struct.
  */
@@ -607,7 +607,7 @@ static int ioctl_timeout(unsigned int logopt, int ioctlfd, time_t timeout)
  * process uid and gid (or string variations of them) for mount
  * lookups within the map entry.
  */
-static int dev_ioctl_requestor(unsigned int logopt,
+static int dev_ioctl_requester(unsigned int logopt,
 			       int ioctlfd, const char *path,
 			       uid_t *uid, gid_t *gid)
 {
diff --git a/lib/mounts.c b/lib/mounts.c
index 1d1b4da..db24395 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -1602,7 +1602,7 @@ static int do_remount_direct(struct autofs_point *ap, int fd, const char *path)
 	gid_t gid;
 	int ret;
 
-	ops->requestor(ap->logopt, fd, path, &uid, &gid);
+	ops->requester(ap->logopt, fd, path, &uid, &gid);
 	if (uid != -1 && gid != -1)
 		set_tsd_user_vars(ap->logopt, uid, gid);
 
@@ -1671,7 +1671,7 @@ static int do_remount_indirect(struct autofs_point *ap, int fd, const char *path
 			}
 		}
 
-		ops->requestor(ap->logopt, fd, buf, &uid, &gid);
+		ops->requester(ap->logopt, fd, buf, &uid, &gid);
 		if (uid != -1 && gid != -1)
 			set_tsd_user_vars(ap->logopt, uid, gid);
 
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
