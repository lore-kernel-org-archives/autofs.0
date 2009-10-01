From: Ian Kent <raven@themaw.net>
Subject: [PATCH 07/10] autofs4 - eliminate d_unhashed in path walk checks
Date: Thu, 01 Oct 2009 09:01:41 +0800
Message-ID: <20091001010141.7675.87552.stgit@zeus.themaw.net>
References: <20091001010054.7675.77673.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755427AbZJABBp@vger.kernel.org>
In-Reply-To: <20091001010054.7675.77673.stgit@zeus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Al Viro <viro@ZenIV.linux.org.uk>, Andreas Dilger <adilger@sun.com>, Christoph Hellwig <hch@infradead.org>, Yehuda Saheh <yehuda@newdream.net>

We unhash the dentry (in a subsequent patch) in ->d_revalidate() in
order to send mount requests to ->lookup(). But then we can not rely
on d_unhased() to give reliable results because it may be called at
any time by any code path. The d_unhashed() function is used by
__simple_empty() in the path walking callbacks but autofs mount
point dentrys should have no directories at all so a list_empty()
on d_subdirs should be (and is) sufficient.

Signed-off-by: Ian Kent <raven@themaw.net>
---

 fs/autofs4/root.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 81700f4..b6530f3 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -133,7 +133,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
 	 * it.
 	 */
 	spin_lock(&dcache_lock);
-	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
+	if (!d_mountpoint(dentry) && list_empty(&dentry->d_subdirs)) {
 		spin_unlock(&dcache_lock);
 		return -ENOENT;
 	}
@@ -257,7 +257,7 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 	 * mount it again.
 	 */
 	if (ino->flags & AUTOFS_INF_PENDING ||
-	    (!d_mountpoint(dentry) && __simple_empty(dentry))) {
+	    (!d_mountpoint(dentry) && list_empty(&dentry->d_subdirs))) {
 		spin_unlock(&dcache_lock);
 		spin_unlock(&sbi->fs_lock);
 
@@ -340,8 +340,7 @@ static int autofs4_revalidate(struct dentry *dentry, struct nameidata *nd)
 	/* Check for a non-mountpoint directory with no contents */
 	spin_lock(&dcache_lock);
 	if (S_ISDIR(dentry->d_inode->i_mode) &&
-	    !d_mountpoint(dentry) && 
-	    __simple_empty(dentry)) {
+	    !d_mountpoint(dentry) && list_empty(&dentry->d_subdirs)) {
 		DPRINTK("dentry=%p %.*s, emptydir",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
