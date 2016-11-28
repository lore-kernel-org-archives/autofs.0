From: Ian Kent <raven@themaw.net>
Subject: [PATCH 5/7] vfs - constify path parameter of path_has_submounts()
Date: Mon, 28 Nov 2016 10:12:09 +0800
Message-ID: <148029912941.27779.3775940087450770440.stgit@pluto.themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=K0E2o37ySprtJQN
        8IJU7MNiwtKk=; b=siKtNzVHDefQAyGfsj7Wprm/P4NdVNUxu1vZcD+/1Ffr0tr
        UH9IsMS4Ais9lqOFcLuJ41ijjnfYOD8oahgW60LNTyWZKM4YTp53l8sO85sH/b4G
        Lqvf5hc0K3yJGeiFuFs7zsTova3M9mgS/z81rCKu1Fz+JxaO0AEHsyz0croI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=K0E2o37ySprtJQN8IJU7MNiwtKk=; b=qFY3Jpd8D/mHFgYcZG9O
        GhlWCm2jAzrbtCMeyiAm72uKUzcAbfrNu2rk5e6iLv/80Mn5Nalq6JWal97p9dOV
        h75ZgTKjAOz9HpvR9Md/79lMHqa9AKjG5GzWV4Hg67Oqb0tucPzO5AIVjG0xtClm
        UNwHdSzI8HuWGXmNbJ/HDxo=
In-Reply-To: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

From: Ian Kent <ikent@redhat.com>

path_has_submounts() doesn't modify the passed in path parameter,
and shouldn't need to, make that usage explicit.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/dcache.c            |    2 +-
 include/linux/dcache.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 719d8b4..29bc910 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1298,7 +1298,7 @@ static enum d_walk_ret path_check_mount(void *data, struct dentry *dentry)
  * Return true if the parent or its subdirectories contain
  * a mount point in the current namespace.
  */
-int path_has_submounts(struct path *parent)
+int path_has_submounts(const struct path *parent)
 {
 	struct check_mount data = { .mnt = parent->mnt, .mounted = 0 };
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f835bd4..c965e44 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -254,7 +254,7 @@ extern struct dentry *d_find_alias(struct inode *);
 extern void d_prune_aliases(struct inode *);
 
 /* test whether we have any submounts in a subdir tree */
-extern int path_has_submounts(struct path *);
+extern int path_has_submounts(const struct path *);
 
 /*
  * This adds the entry to the hash queues.

