From: NeilBrown <neilb@suse.de>
Subject: [PATCH 6/6] autofs4: don't take spinlock when not needed in
 autofs4_lookup_expiring
Date: Thu, 10 Jul 2014 09:41:14 +1000
Message-ID: <20140709234114.4525.70534.stgit@notabene.brown>
References: <20140709233541.4525.25151.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140709233541.4525.25151.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

If the expiring_list is empty, we can avoid a costly spinlock
in the rcu-walk path through authfs4_d_manage.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/autofs4/root.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 1ad119407e2f..774c2dab331b 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -219,6 +219,8 @@ static struct dentry *autofs4_lookup_expiring(struct dentry *dentry,
 	const unsigned char *str = name->name;
 	struct list_head *p, *head;
 
+	if (list_empty(&sbi->expiring_list))
+		return NULL;
 	spin_lock(&sbi->lookup_lock);
 	head = &sbi->expiring_list;
 	list_for_each(p, head) {

