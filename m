From: Ian Kent <raven@themaw.net>
Subject: [PATCH 08/10] autofs4 - rename dentry to active in
	autofs4_lookup_active()
Date: Thu, 01 Oct 2009 09:01:48 +0800
Message-ID: <20091001010148.7675.92564.stgit@zeus.themaw.net>
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

In autofs4_lookup_active() a declaration within the list traversal
loop uses a declaration that has the same name as the function
parameter.

Signed-off-by: Ian Kent <raven@themaw.net>
---

 fs/autofs4/root.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index b6530f3..e8a8881 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -419,23 +419,23 @@ static struct dentry *autofs4_lookup_active(struct dentry *dentry)
 	head = &sbi->active_list;
 	list_for_each(p, head) {
 		struct autofs_info *ino;
-		struct dentry *dentry;
+		struct dentry *active;
 		struct qstr *qstr;
 
 		ino = list_entry(p, struct autofs_info, active);
-		dentry = ino->dentry;
+		active = ino->dentry;
 
-		spin_lock(&dentry->d_lock);
+		spin_lock(&active->d_lock);
 
 		/* Already gone? */
-		if (atomic_read(&dentry->d_count) == 0)
+		if (atomic_read(&active->d_count) == 0)
 			goto next;
 
-		qstr = &dentry->d_name;
+		qstr = &active->d_name;
 
-		if (dentry->d_name.hash != hash)
+		if (active->d_name.hash != hash)
 			goto next;
-		if (dentry->d_parent != parent)
+		if (active->d_parent != parent)
 			goto next;
 
 		if (qstr->len != len)
@@ -443,15 +443,15 @@ static struct dentry *autofs4_lookup_active(struct dentry *dentry)
 		if (memcmp(qstr->name, str, len))
 			goto next;
 
-		if (d_unhashed(dentry)) {
-			dget(dentry);
-			spin_unlock(&dentry->d_lock);
+		if (d_unhashed(active)) {
+			dget(active);
+			spin_unlock(&active->d_lock);
 			spin_unlock(&sbi->lookup_lock);
 			spin_unlock(&dcache_lock);
-			return dentry;
+			return active;
 		}
 next:
-		spin_unlock(&dentry->d_lock);
+		spin_unlock(&active->d_lock);
 	}
 	spin_unlock(&sbi->lookup_lock);
 	spin_unlock(&dcache_lock);

