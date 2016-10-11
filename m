From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/8] vfs - add path_has_submounts()
Date: Tue, 11 Oct 2016 13:34:03 +0800
Message-ID: <20161011053403.27645.55242.stgit@pluto.themaw.net>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=yQaQmb2ZvqS2cPb3Ps8+otMivlk=; b=AmekM7
        J9F0ksbv1wNzipijRUz1TzPa7gv8xFcxRicWvYy6CdXUehv1QbBz5gPQ80nuajHw
        rVv+OFIYrARKBQ7tD+zeIpCpDLVFJTxqjQ94ff1GIM4m5FzOWQogQmd8saabFLN8
        mPub9SZJv9RiNHduNuugmagx3fJ4cesEqUWXM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=yQaQmb2ZvqS2cPb
        3Ps8+otMivlk=; b=HeCpOcUZosnvlcL7dCyJdA6HK9edziJfuz3atl82SqkDW41
        4I1us7TCwu+sjVX1WwU2A1AcIG1XQjpuRyhI3uCK5h4wu/7+wSplYXP+vMO1y1dl
        VwxY5Tapxh2xuGyuI8wFcS+hUF8J8XVido6d6DQkVRPxSmZwl0qeL4GPONYQ=
In-Reply-To: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

From: Ian Kent <ikent@redhat.com>

d_mountpoint() can only be used reliably to establish if a dentry is
not mounted in any namespace. It isn't aware of the possibility there
may be multiple mounts using the given dentry, possibly in a different
namespace.

Add function, path_has_submounts(), that checks is a struct path contains
mounts (or is a mountpoint itself) to handle this case.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/dcache.c            |   35 +++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |    1 +
 2 files changed, 36 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5c7cc95..872f04e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1306,6 +1306,41 @@ int have_submounts(struct dentry *parent)
 }
 EXPORT_SYMBOL(have_submounts);
 
+struct check_mount {
+	struct vfsmount *mnt;
+	unsigned int mounted;
+};
+
+static enum d_walk_ret path_check_mount(void *data, struct dentry *dentry)
+{
+	struct check_mount *info = data;
+	struct path path = { .mnt = info->mnt, .dentry = dentry };
+
+	if (path_is_mountpoint(&path)) {
+		info->mounted = 1;
+		return D_WALK_QUIT;
+	}
+	return D_WALK_CONTINUE;
+}
+
+/**
+ * path_has_submounts - check for mounts over a dentry in the
+ *                      current namespace.
+ * @parent: path to check.
+ *
+ * Return true if the parent or its subdirectories contain
+ * a mount point in the current namespace.
+ */
+int path_has_submounts(struct path *parent)
+{
+	struct check_mount data = { .mnt = parent->mnt, .mounted = 0 };
+
+	d_walk(parent->dentry, &data, path_check_mount, NULL);
+
+	return data.mounted;
+}
+EXPORT_SYMBOL(path_has_submounts);
+
 /*
  * Called by mount code to set a mountpoint and check if the mountpoint is
  * reachable (e.g. NFS can unhash a directory dentry and then the complete
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 798bc04..e351646 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -255,6 +255,7 @@ extern void d_prune_aliases(struct inode *);
 
 /* test whether we have any submounts in a subdir tree */
 extern int have_submounts(struct dentry *);
+extern int path_has_submounts(struct path *);
 
 /*
  * This adds the entry to the hash queues.

