From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 13/27] fs/autofs4: Use memdup_user
Date: Sat, 22 May 2010 10:22:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005221022010.13021@ask.diku.dk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Use memdup_user when user data is immediately copied into the allocated
region.  Elimination of the variable ads, which is no longer useful.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression from,to,size,flag;
position p;
identifier l1,l2;
@@

-  to = \(kmalloc@p\|kzalloc@p\)(size,flag);
+  to = memdup_user(from,size);
   if (
-      to==NULL
+      IS_ERR(to)
                 || ...) {
   <+... when != goto l1;
-  -ENOMEM
+  PTR_ERR(to)
   ...+>
   }
-  if (copy_from_user(to, from, size) != 0) {
-    <+... when != goto l2;
-    -EFAULT
-    ...+>
-  }
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 fs/autofs4/dev-ioctl.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index d29b7f6..33d8fc6 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -95,7 +95,7 @@ static int check_dev_ioctl_version(int cmd, struct autofs_dev_ioctl *param)
  */
 static struct autofs_dev_ioctl *copy_dev_ioctl(struct autofs_dev_ioctl __user *in)
 {
-	struct autofs_dev_ioctl tmp, *ads;
+	struct autofs_dev_ioctl tmp;
 
 	if (copy_from_user(&tmp, in, sizeof(tmp)))
 		return ERR_PTR(-EFAULT);
@@ -103,16 +103,7 @@ static struct autofs_dev_ioctl *copy_dev_ioctl(struct autofs_dev_ioctl __user *i
 	if (tmp.size < sizeof(tmp))
 		return ERR_PTR(-EINVAL);
 
-	ads = kmalloc(tmp.size, GFP_KERNEL);
-	if (!ads)
-		return ERR_PTR(-ENOMEM);
-
-	if (copy_from_user(ads, in, tmp.size)) {
-		kfree(ads);
-		return ERR_PTR(-EFAULT);
-	}
-
-	return ads;
+	return memdup_user(in, tmp.size);
 }
 
 static inline void free_dev_ioctl(struct autofs_dev_ioctl *param)
