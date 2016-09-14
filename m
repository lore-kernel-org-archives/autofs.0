From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/4] fs - remove unused have_submounts() function
Date: Wed, 14 Sep 2016 14:14:50 +0800
Message-ID: <20160914061450.24714.99912.stgit@pluto.themaw.net>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=1EwFhspeI8c0Y2Xz2rqoW4eAkQs=; b=vkLj4B
        sgPK/Vp/ba5GRWjwvIyIdTgISKV05gcFJ+lKEQtjXnP7JedFa3T8ynwcezdMbFaw
        ygwRyYCeQH/rBlyVoZn9CIpUCFksjVdeoIJXxG52oSSsV5iHcl2BxtCP+W3Co/AS
        WTvr9V9RcTEwBsu0hDtfZIWALjPuLmGkvb1Lc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=1EwFhspeI8c0Y2X
        z2rqoW4eAkQs=; b=Fwu6OhhM70ulT0/sfmtu0rzoyiGLHin/6DM4jlb8FjKsdq0
        sGS82DLus0CvEsN16czmVngU1Bm8m9uObaUHCY1qIw3aDQAoh9JZKKstOhhg708k
        DLv1E414GqJtc0KVsxI3M8xOHjvUUf7r8RNfJQsDcFee4ZxoJB6L+a3xKgB4=
In-Reply-To: <20160914061434.24714.490.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Having added the have_local_submounts() function there are no
remaining users of have_submounts() so remove it.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/dcache.c            |   33 ---------------------------------
 include/linux/dcache.h |    1 -
 2 files changed, 34 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 218166b..ad36f23 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1279,39 +1279,6 @@ rename_retry:
  * list is non-empty and continue searching.
  */
 
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
-/*
- * Search for at least 1 mount point in the dentry's subdirs.
- * We descend to the next level whenever the d_subdirs
- * list is non-empty and continue searching.
- */
-
 static enum d_walk_ret check_local_mount(void *data, struct dentry *dentry)
 {
 	int *ret = data;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 796b358..7220683 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -254,7 +254,6 @@ extern struct dentry *d_find_alias(struct inode *);
 extern void d_prune_aliases(struct inode *);
 
 /* test whether we have any submounts in a subdir tree */
-extern int have_submounts(struct dentry *);
 extern int have_local_submounts(struct dentry *);
 
 /*

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
