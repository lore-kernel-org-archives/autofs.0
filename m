From: Ian Kent <raven@themaw.net>
Subject: [PATCH 8/8] vfs - remove unused have_submounts() function
Date: Tue, 11 Oct 2016 13:34:28 +0800
Message-ID: <20161011053428.27645.12310.stgit@pluto.themaw.net>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=pFB6EBdS08y+BFMAH+wDszktdM4=; b=ghG8FG
        cIK8lL//ymvwPg4VsXJ2yPNBztvtGADYHb2mqsarv3XF0huG/e3fUtTKuG2HbExn
        dYA+hrFpVFjwoiY7y6RS52eTsbY/7LcCCV71t2ssz/607MFMDj+6xkk0BzvGdJUB
        dpnkZeVhhgMAc1P2PxcRHZMYIg0F8F+glC8us=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=pFB6EBdS08y+BFM
        AH+wDszktdM4=; b=dGG+r+aAlUZgwg7EjC6AQYlPGffHA8oVILwUhcfYlrmRiMH
        cEc4pRunv3IkMBlkr4mAxzaP2FM6OxAATmxsnz+V61jBCnvkM+VHKHNgbhrzdy9e
        yfYVfUzOsRPipwSu+25D/2AGjHHmegqf12r/VV+Lt6GDKR+cOoz1SfAT/nf0=
In-Reply-To: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

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
@@ -1273,39 +1273,6 @@ static void d_walk(struct dentry *parent, void *data,
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
index e351646..44a9a9b 100644
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
