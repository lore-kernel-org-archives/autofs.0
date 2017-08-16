From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/5] autofs: use AUTOFS_DEV_IOCTL_SIZE
Date: Wed, 16 Aug 2017 10:31:25 +0800
Message-ID: <150285068577.4670.2599968823770600622.stgit@pluto.themaw.net>
References: <150285067347.4670.11494624644273072003.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150285067347.4670.11494624644273072003.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Use a macro which defines misc-dev ioctl parameter size (excluding
a path beyond &path[0]) since it's been used to initialize and copy
this structure ever since it first appeared in 8d7b48e0 in 2008.

(or simply get rid of this if this is just unnecessary abstraction
when all it needs is sizeof(struct autofs_dev_ioctl))

Edit: imk
That's a good point but I'd prefer to keep the macro define.
End edit: imk

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/dev-ioctl.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index ea8b3a1cddd2..b8b66d55266d 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -97,13 +97,13 @@ static struct autofs_dev_ioctl *
 {
 	struct autofs_dev_ioctl tmp, *res;
 
-	if (copy_from_user(&tmp, in, sizeof(tmp)))
+	if (copy_from_user(&tmp, in, AUTOFS_DEV_IOCTL_SIZE))
 		return ERR_PTR(-EFAULT);
 
-	if (tmp.size < sizeof(tmp))
+	if (tmp.size < AUTOFS_DEV_IOCTL_SIZE)
 		return ERR_PTR(-EINVAL);
 
-	if (tmp.size > (PATH_MAX + sizeof(tmp)))
+	if (tmp.size > AUTOFS_DEV_IOCTL_SIZE + PATH_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	res = memdup_user(in, tmp.size);
@@ -133,8 +133,8 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 		goto out;
 	}
 
-	if (param->size > sizeof(*param)) {
-		err = invalid_str(param->path, param->size - sizeof(*param));
+	if (param->size > AUTOFS_DEV_IOCTL_SIZE) {
+		err = invalid_str(param->path, param->size - AUTOFS_DEV_IOCTL_SIZE);
 		if (err) {
 			pr_warn(
 			  "path string terminator missing for cmd(0x%08x)\n",
@@ -451,7 +451,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
 	dev_t devid;
 	int err = -ENOENT;
 
-	if (param->size <= sizeof(*param)) {
+	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -539,7 +539,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 	unsigned int devid, magic;
 	int err = -ENOENT;
 
-	if (param->size <= sizeof(*param)) {
+	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
 		err = -EINVAL;
 		goto out;
 	}

