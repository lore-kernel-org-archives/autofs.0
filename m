From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH] autofs4/root.c: quiet sparse noise
Date: Fri, 9 Sep 2011 17:17:02 -0700
Message-ID: <201109091717.02975.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: autofs@linux.kernel.org, raven@themaw.net

The function autofs4_d_manage is prototyped as a static function.
Add static to the function to quiet the sparse noise:

warning: symbol 'autofs4_d_manage' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ian Kent <raven@themaw.net>

---

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index f55ae23..366a9f2 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -427,7 +427,7 @@ done:
 	return NULL;
 }
 
-int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
+static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 
