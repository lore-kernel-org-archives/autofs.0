From: Ian Kent <raven@themaw.net>
Subject: [RFC PATCH 8/8] vfs - remove unused have_submounts() function
Date: Mon, 03 Oct 2016 08:47:06 +0800
Message-ID: <20161003004706.4865.9466.stgit@pluto.themaw.net>
References: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=P3/HXCoY0k1WcM/6QtNm9cVwdgA=; b=MVts6r
        6SsLwwtexeY9atj8CGtNyXsf8lRutXU6rbeAMHyY3IyVKbtz/85Nxy06e3u2TQZW
        DuYBExkkPqb2bJGIFHfQ536vBlPx6HMNceFjrHcHijesDsKQag7lAl9RYm20KzXq
        NIqRfwfV6DRqI+0LpkNYM+ptUVk8+Kq0ZzH8Q=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=P3/HXCoY0k1WcM/
        6QtNm9cVwdgA=; b=bO2RWuFvykbwAKAU+7K1ttYv+4eWi4b1r8tmiEOfmi8As74
        3XG6zQN4X9vx7Nq8fyflAHTrE8bCsmhoQGFvc+5zrkTDvmmvI3ECflASd+eDAi8z
        +ll8WLlkusmHmihpw6KEDT9z66kcD9pCl5I+4agrx9pL4n4x5DnimkY0AgdA=
In-Reply-To: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>

Now that path_has_submounts() has been added have_submounts() is no
longer used so remove it.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/dcache.c            |   33 ---------------------------------
 include/linux/dcache.h |    1 -
 2 files changed, 34 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 872f04e..719d8b4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1273,39 +1273,6 @@ rename_retry:
 	goto again;
 }
 
-/*
- * Search for at least 1 mount point in the dentry's subdirs.
- * We descend to the next level whenever the d_subdirs
- * list is non-empty and continue searching.
- */
-
-static enum d_walk_ret check_mount(void *data, struct dentry *dentry)
-{
-	int *ret = data;
-	if (d_mountpoint(dentry)) {
-		*ret = 1;
-		return D_WALK_QUIT;
-	}
-	return D_WALK_CONTINUE;
-}
-
-/**
- * have_submounts - check for mounts over a dentry
- * @parent: dentry to check.
- *
- * Return true if the parent or its subdirectories contain
- * a mount point
- */
-int have_submounts(struct dentry *parent)
-{
-	int ret = 0;
-
-	d_walk(parent, &ret, check_mount, NULL);
-
-	return ret;
-}
-EXPORT_SYMBOL(have_submounts);
-
 struct check_mount {
 	struct vfsmount *mnt;
 	unsigned int mounted;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 5c5d197..384c87c 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -254,7 +254,6 @@ extern struct dentry *d_find_alias(struct inode *);
 extern void d_prune_aliases(struct inode *);
 
 /* test whether we have any submounts in a subdir tree */
-extern int have_submounts(struct dentry *);
 extern int path_has_submounts(struct path *);
 
 /*

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
