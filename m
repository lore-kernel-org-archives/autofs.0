From: kusumi.tomohiro@gmail.com
Subject: [PATCH 3/3] autofs: use AUTOFS_DEV_IOCTL_SIZE
Date: Mon, 27 Mar 2017 03:00:37 +0300
Message-ID: <20170327000037.2179-3-tkusumi@tuxera.com>
References: <20170327000037.2179-1-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJQaokFygokDii1GQKuBv9d+tw1utOHE8F/poEcIZJY=;
        b=nsQqx9wSbytkPQ4FUlViVDMPnfDP90sarP4NJWsBTvN8blHDTjSzR+k1i+J2M84iQC
         I5xpjJuRs4bzAuP5gNhVAUx6x/2lDcvvtPwAi2sKgSYnMec1MrykrET4V7mPrl1P7yK/
         PZ5k+/KicDuRMR5iw7pKt9C3Cft5kCVTzjayTm/Ez4mlZyt3lr2UrdOKuq4UqCl6DSt8
         rlyBGQlOXuPdrb7iJjtKfB34+5d+rZ+lu8PwXdEgojtVvdKI6X0gjpDPyGUUkUVTpwMX
         5dzEqvR8FUY10aJzuwHU5Qmyhmsvk5Kz67iq1gHemTDk57tWHLP6YEfFVuWLOegv13nz
         1j7g==
In-Reply-To: <20170327000037.2179-1-tkusumi@tuxera.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Use a macro which defines misc-dev ioctl parameter size (excluding
a path beyond &path[0]) since it's been used to initialize and copy
this structure ever since it first appeared in 8d7b48e0 in 2008.

(or simply get rid of this if this is just unnecessary abstraction
when all it needs is sizeof(struct autofs_dev_ioctl))

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 fs/autofs4/dev-ioctl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 734cbf8..6180a40 100644
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
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
