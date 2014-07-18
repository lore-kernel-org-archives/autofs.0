From: NeilBrown <neilb@suse.de>
Subject: [PATCH 3/5] autofs4: don't take spinlock when not needed in
 autofs4_lookup_expiring
Date: Fri, 18 Jul 2014 10:48:28 +1000
Message-ID: <20140718004828.19389.67320.stgit@notabene.brown>
References: <20140718004353.19389.48104.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140718004353.19389.48104.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

If the expiring_list is empty, we can avoid a costly spinlock
in the rcu-walk path through autofs4_d_manage (once the rest
of the path becomes rcu-walk friendly).

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/root.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index cc87c1abac97..fb202cadd4b3 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -166,8 +166,10 @@ static struct dentry *autofs4_lookup_active(struct dentry *dentry)
 	const unsigned char *str = name->name;
 	struct list_head *p, *head;
 
-	spin_lock(&sbi->lookup_lock);
 	head = &sbi->active_list;
+	if (list_empty(head))
+		return NULL;
+	spin_lock(&sbi->lookup_lock);
 	list_for_each(p, head) {
 		struct autofs_info *ino;
 		struct dentry *active;
@@ -218,8 +220,10 @@ static struct dentry *autofs4_lookup_expiring(struct dentry *dentry)
 	const unsigned char *str = name->name;
 	struct list_head *p, *head;
 
-	spin_lock(&sbi->lookup_lock);
 	head = &sbi->expiring_list;
+	if (list_empty(head))
+		return NULL;
+	spin_lock(&sbi->lookup_lock);
 	list_for_each(p, head) {
 		struct autofs_info *ino;
 		struct dentry *expiring;

