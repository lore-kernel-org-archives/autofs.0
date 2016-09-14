From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/4] fs - add have_local_submounts()
Date: Wed, 14 Sep 2016 14:14:40 +0800
Message-ID: <20160914061440.24714.82139.stgit@pluto.themaw.net>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=42YgVngwt2IrTPlHMkufeeFEFAk=; b=PoknJD
        lhdRqBclncWOIi+jFeTQ2oHhsufGd9r24dyJ2+At4w96DeyUk00bZJ2lTXEINjBq
        6iksevPHvBYGyM/4JukHEnfrC2uMHmTfLHOsdgCKulrspy7UfPkTxH8lYooLwArO
        H5/r24nm2D0kuV9v6mTq3SO6Cfyi9FmuAj0PU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=42YgVngwt2IrTPl
        HMkufeeFEFAk=; b=mVuBguzfxTF/2zYgrRl6Myf6roQvzuycjfrm+4N0C0H3uxQ
        TnYAkETGSpaN8J/QS2qcERteb+S8syh0mlFMmP7gGpufC3AfouFshZaeJw1MnHeV
        vlUgs31fNU3kE4+31UJCcxMx3NL9Jvb4WwxqjUXuLvDNggrOC+zoUEacC0wE=
In-Reply-To: <20160914061434.24714.490.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, "Eric W. Biederman" <ebiederm@xmission.com>

The have_submounts() function checks if a dentry is a mountpoint
in any namespace but autofs needs to know if the dentry is a
mountpoint within the current namespace.

Add have_local_submounts() to to do this.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/dcache.c            |   34 ++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |    1 +
 2 files changed, 35 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5c7cc95..218166b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1307,6 +1307,40 @@ int have_submounts(struct dentry *parent)
 EXPORT_SYMBOL(have_submounts);
 
 /*
+ * Search for at least 1 mount point in the dentry's subdirs.
+ * We descend to the next level whenever the d_subdirs
+ * list is non-empty and continue searching.
+ */
+
+static enum d_walk_ret check_local_mount(void *data, struct dentry *dentry)
+{
+	int *ret = data;
+	if (is_local_mountpoint(dentry)) {
+		*ret = 1;
+		return D_WALK_QUIT;
+	}
+	return D_WALK_CONTINUE;
+}
+
+/**
+ * have_local_submounts - check for mounts over a dentry
+ * 			  in the current namespace
+ * @parent: dentry to check.
+ *
+ * Return true if the parent or its subdirectories contain
+ * a mount point
+ */
+int have_local_submounts(struct dentry *parent)
+{
+	int ret = 0;
+
+	d_walk(parent, &ret, check_local_mount, NULL);
+
+	return ret;
+}
+EXPORT_SYMBOL(have_local_submounts);
+
+/*
  * Called by mount code to set a mountpoint and check if the mountpoint is
  * reachable (e.g. NFS can unhash a directory dentry and then the complete
  * subtree can become unreachable).
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 5ff3e9a..796b358 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -255,6 +255,7 @@ extern void d_prune_aliases(struct inode *);
 
 /* test whether we have any submounts in a subdir tree */
 extern int have_submounts(struct dentry *);
+extern int have_local_submounts(struct dentry *);
 
 /*
  * This adds the entry to the hash queues.

