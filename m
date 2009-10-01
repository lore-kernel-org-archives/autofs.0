From: Ian Kent <raven@themaw.net>
Subject: [PATCH 03/10] autofs4 - use macro for need mount check
Date: Thu, 01 Oct 2009 09:01:14 +0800
Message-ID: <20091001010114.7675.89191.stgit@zeus.themaw.net>
References: <20091001010054.7675.77673.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755369AbZJABBR@vger.kernel.org>
In-Reply-To: <20091001010054.7675.77673.stgit@zeus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Al Viro <viro@ZenIV.linux.org.uk>, Andreas Dilger <adilger@sun.com>, Christoph Hellwig <hch@infradead.org>, Yehuda Saheh <yehuda@newdream.net>

Define simple macro function for checking if we need to trigger
a mount.

Signed-off-by: Ian Kent <raven@themaw.net>
---

 fs/autofs4/root.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 2954ac5..f6e8ca9 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -104,6 +104,14 @@ static void autofs4_del_active(struct dentry *dentry)
 	return;
 }
 
+static unsigned int autofs4_need_mount(unsigned int flags)
+{
+	unsigned int res = 0;
+	if (flags & (TRIGGER_FLAGS | TRIGGER_INTENTS))
+		res = 1;
+	return res;
+}
+
 static int autofs4_dir_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry;
@@ -168,7 +176,7 @@ static int try_to_fill_dentry(struct dentry *dentry, int flags)
 		}
 	/* Trigger mount for path component or follow link */
 	} else if (dentry->d_flags & DCACHE_AUTOFS_PENDING ||
-			flags & (TRIGGER_FLAGS | TRIGGER_INTENTS) ||
+			autofs4_need_mount(flags) ||
 			current->link_count) {
 		DPRINTK("waiting for mount name=%.*s",
 			dentry->d_name.len, dentry->d_name.name);
@@ -234,7 +242,7 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 	autofs4_expire_wait(dentry);
 
 	/* We trigger a mount for almost all flags */
-	lookup_type = nd->flags & (TRIGGER_FLAGS | TRIGGER_INTENTS);
+	lookup_type = autofs4_need_mount(nd->flags);
 	if (!(lookup_type || dentry->d_flags & DCACHE_AUTOFS_PENDING))
 		goto follow;
 
