From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - add missing kfree
Date: Fri, 20 Jun 2008 15:09:25 +0800
Message-ID: <20080620070923.17224.33149.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

It see that the patch tittled "autofs4 - fix pending mount race" is
missing a change that I had recently made.

It's missing a kfree for the case mutex_lock_interruptible() fails
to aquire the wait queue mutex.

My appologies for this mistake.

Ian

Signed-off-by: Ian Kent <raven@themaw.net>

---

 fs/autofs4/waitq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)


diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index ae637d9..d291b07 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -328,8 +328,10 @@ int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
 	qstr.name = name;
 	qstr.hash = full_name_hash(name, qstr.len);
 
-	if (mutex_lock_interruptible(&sbi->wq_mutex))
+	if (mutex_lock_interruptible(&sbi->wq_mutex)) {
+		kfree(qstr.name);
 		return -EINTR;
+	}
 
 	ret = validate_request(&wq, sbi, &qstr, dentry, notify);
 	if (ret <= 0) {
