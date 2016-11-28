From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/7] autofs - change struct path to const in
 autofs4_expire_wait() and autofs4_wait()
Date: Mon, 28 Nov 2016 10:11:59 +0800
Message-ID: <148029911911.27779.6329959807249612394.stgit@pluto.themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=cbXsIevlf/OcFjd
        2ekohvQ3xRsk=; b=wHeo+MS73vdezG7rYXdTF4LEwFvrNsZPjzcB93b3FVlGyAF
        EOlhzo026jRnDpjA3iAcczloXo9EPEuu1jsiKE/k7/5zQcoZaf/VWd5saMzyX0WY
        XO0PGctQk8fVNpgMKVtL1a3zDEA1p7zgjNSkfH93rRbU5mpb/UF6VmKV+l2Y=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=cbXsIevlf/OcFjd2ekohvQ3xRsk=; b=UMc4+d85Br93w7gazoAu
        9ckgFtqXvk6pnumtYh6yYBkVkwXnR9VNz1P/IvtHVqLqtXc+l6C/AaQTWHrFPDla
        zIc6NuOhMR3vh8oloCFtngykVmmxTysmXJuJbHkxjxdDDi6yYjAecJHw2RIdBUbY
        ZrrjPGLdRptY/XhEXRlMIqA=
In-Reply-To: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

From: Ian Kent <ikent@redhat.com>

The functions autofs4_expire_wait() and autofs4_wait() don't modify
the passed struct path so change it to a const.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/autofs4/autofs_i.h |    5 +++--
 fs/autofs4/expire.c   |    4 ++--
 fs/autofs4/root.c     |    6 +++---
 fs/autofs4/waitq.c    |    4 ++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 14cef41..c885daa 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -145,7 +145,7 @@ void autofs4_free_ino(struct autofs_info *);
 
 /* Expiration */
 int is_autofs4_dentry(struct dentry *);
-int autofs4_expire_wait(struct path *path, int rcu_walk);
+int autofs4_expire_wait(const struct path *path, int rcu_walk);
 int autofs4_expire_run(struct super_block *, struct vfsmount *,
 		       struct autofs_sb_info *,
 		       struct autofs_packet_expire __user *);
@@ -217,7 +217,8 @@ static inline int autofs_prepare_pipe(struct file *pipe)
 
 /* Queue management functions */
 
-int autofs4_wait(struct autofs_sb_info *, struct path *, enum autofs_notify);
+int autofs4_wait(struct autofs_sb_info *,
+		 const struct path *, enum autofs_notify);
 int autofs4_wait_release(struct autofs_sb_info *, autofs_wqt_t, int);
 void autofs4_catatonic_mode(struct autofs_sb_info *);
 
diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index a37ba40..13178bf 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -495,7 +495,7 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 	return expired;
 }
 
-int autofs4_expire_wait(struct path *path, int rcu_walk)
+int autofs4_expire_wait(const struct path *path, int rcu_walk)
 {
 	struct dentry *dentry = path->dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
@@ -593,7 +593,7 @@ int autofs4_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 
 	if (dentry) {
 		struct autofs_info *ino = autofs4_dentry_ino(dentry);
-		struct path path = { .mnt = mnt, .dentry = dentry };
+		const struct path path = { .mnt = mnt, .dentry = dentry };
 
 		/* This is synchronous because it makes the daemon a
 		 * little easier
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 3e33f00..859eef9 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -272,7 +272,7 @@ static struct dentry *autofs4_lookup_expiring(struct dentry *dentry,
 	return NULL;
 }
 
-static int autofs4_mount_wait(struct path *path, bool rcu_walk)
+static int autofs4_mount_wait(const struct path *path, bool rcu_walk)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(path->dentry->d_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(path->dentry);
@@ -289,7 +289,7 @@ static int autofs4_mount_wait(struct path *path, bool rcu_walk)
 	return status;
 }
 
-static int do_expire_wait(struct path *path, bool rcu_walk)
+static int do_expire_wait(const struct path *path, bool rcu_walk)
 {
 	struct dentry *dentry = path->dentry;
 	struct dentry *expiring;
@@ -300,7 +300,7 @@ static int do_expire_wait(struct path *path, bool rcu_walk)
 	if (!expiring)
 		return autofs4_expire_wait(path, rcu_walk);
 	else {
-		struct path this = { .mnt = path->mnt, .dentry = expiring };
+		const struct path this = { .mnt = path->mnt, .dentry = expiring };
 		/*
 		 * If we are racing with expire the request might not
 		 * be quite complete, but the directory has been removed
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index e7a037f..1278335 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -250,7 +250,7 @@ autofs4_find_wait(struct autofs_sb_info *sbi, const struct qstr *qstr)
 static int validate_request(struct autofs_wait_queue **wait,
 			    struct autofs_sb_info *sbi,
 			    const struct qstr *qstr,
-			    struct path *path, enum autofs_notify notify)
+			    const struct path *path, enum autofs_notify notify)
 {
 	struct dentry *dentry = path->dentry;
 	struct autofs_wait_queue *wq;
@@ -349,7 +349,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 }
 
 int autofs4_wait(struct autofs_sb_info *sbi,
-		 struct path *path, enum autofs_notify notify)
+		 const struct path *path, enum autofs_notify notify)
 {
 	struct dentry *dentry = path->dentry;
 	struct autofs_wait_queue *wq;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
