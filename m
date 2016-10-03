From: Ian Kent <raven@themaw.net>
Subject: [RFC PATCH 3/8] vfs - add path_has_submounts()
Date: Mon, 03 Oct 2016 08:46:38 +0800
Message-ID: <20161003004638.4865.71341.stgit@pluto.themaw.net>
References: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=U5Sm4sM1RAiKd+/Yb8u0SkJ3izo=; b=IynNV8
        835e6BR/v6hNQ2G9N7+qv3MCZZNPAL2NQpnOegNIM4cGPW59L8CwkYiVycGwQ4qe
        H0O1eLYw5JV1zTrFOrDCDRaqYtPCOG47rGob8ijZMrsRZEgO5C9ViNXLriJ+ntsC
        /TstK2A2qwm9IHAt1EbyQ029/05Aec2ref1/o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=U5Sm4sM1RAiKd+/
        Yb8u0SkJ3izo=; b=Wy23KRfpGaUBkw+KJSgBN4AON4fTHXx57RODm04G02QsBPg
        55/NxWXdXtfRQ9OAGuNbdnyCaBbCa1L9JGzrK1jRsnWzOTJjndIbUBwJuwisoMaW
        ox9Y9Ee0HdNmoi2nFl3iIZ6s27ZbGidyJSzPNY0joetlgFfCHpIvoR97Z/nY=
In-Reply-To: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>

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
index ad2df92..5c5d197 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -255,6 +255,7 @@ extern void d_prune_aliases(struct inode *);
 
 /* test whether we have any submounts in a subdir tree */
 extern int have_submounts(struct dentry *);
+extern int path_has_submounts(struct path *);
 
 /*
  * This adds the entry to the hash queues.

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
