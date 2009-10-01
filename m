From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/10] autofs4 - use macros for expiring list
Date: Thu, 01 Oct 2009 09:01:02 +0800
Message-ID: <20091001010102.7675.55471.stgit@zeus.themaw.net>
References: <20091001010054.7675.77673.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20091001010054.7675.77673.stgit@zeus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Al Viro <viro@ZenIV.linux.org.uk>, Andreas Dilger <adilger@sun.com>, Christoph Hellwig <hch@infradead.org>, Yehuda Saheh <yehuda@newdream.net>

Define some simple macro functions for adding and deleting entries
on the expiring dentry list.

Signed-off-by: Ian Kent <raven@themaw.net>
---

 fs/autofs4/autofs_i.h |   26 ++++++++++++++++++++++++++
 fs/autofs4/root.c     |   15 +++------------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index f3cf151..fe9fc23 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -266,5 +266,31 @@ out:
 	return ret;
 }
 
+static inline void autofs4_add_expiring(struct dentry *dentry)
+{
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	if (ino) {
+		spin_lock(&sbi->lookup_lock);
+		if (list_empty(&ino->expiring))
+			list_add(&ino->expiring, &sbi->expiring_list);
+		spin_unlock(&sbi->lookup_lock);
+	}
+	return;
+}
+
+static inline void autofs4_del_expiring(struct dentry *dentry)
+{
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	if (ino) {
+		spin_lock(&sbi->lookup_lock);
+		if (!list_empty(&ino->expiring))
+			list_del_init(&ino->expiring);
+		spin_unlock(&sbi->lookup_lock);
+	}
+	return;
+}
+
 void autofs4_dentry_release(struct dentry *);
 extern void autofs4_kill_sb(struct super_block *);
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 67d8d96..2954ac5 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -563,10 +563,7 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
 			 */
 			ino = autofs4_dentry_ino(expiring);
 			autofs4_expire_wait(expiring);
-			spin_lock(&sbi->lookup_lock);
-			if (!list_empty(&ino->expiring))
-				list_del_init(&ino->expiring);
-			spin_unlock(&sbi->lookup_lock);
+			autofs4_del_expiring(expiring);
 			dput(expiring);
 		}
 
@@ -732,10 +729,7 @@ static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
 	dir->i_mtime = CURRENT_TIME;
 
 	spin_lock(&dcache_lock);
-	spin_lock(&sbi->lookup_lock);
-	if (list_empty(&ino->expiring))
-		list_add(&ino->expiring, &sbi->expiring_list);
-	spin_unlock(&sbi->lookup_lock);
+	autofs4_add_expiring(dentry);
 	spin_lock(&dentry->d_lock);
 	__d_drop(dentry);
 	spin_unlock(&dentry->d_lock);
@@ -761,10 +755,7 @@ static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
 		spin_unlock(&dcache_lock);
 		return -ENOTEMPTY;
 	}
-	spin_lock(&sbi->lookup_lock);
-	if (list_empty(&ino->expiring))
-		list_add(&ino->expiring, &sbi->expiring_list);
-	spin_unlock(&sbi->lookup_lock);
+	autofs4_add_expiring(dentry);
 	spin_lock(&dentry->d_lock);
 	__d_drop(dentry);
 	spin_unlock(&dentry->d_lock);

