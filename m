From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs4 - fix device ioctl mount lookup
Date: Sun, 08 Sep 2013 16:47:23 +0800
Message-ID: <20130908084722.14798.24320.stgit@perseus.fritz.box>
References: <20130908084714.14798.32490.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=cAPxwd6+Vx1LfVtW1WZq++PZYYY=; b=ZnXuGZ85u2tq6cCzEtfuTY/CrZNn
	bVKQGbxQNF02vGf14VLrmTFPmoVEKBGA5se+5HJpAnbGD+OhxethPJZddVXImRPL
	KDQD6xwqfexWHd09hojjbn3nNBBz2ANbTnacCXop6ucSIkeIiI/hYjd3ex+H3xwO
	J10mlSjdMLBhjxM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=cAPxwd6+Vx1LfVtW1WZq++
	PZYYY=; b=uu04oiTQFc1qW6PmqF8+0N3iuYEdfdl1+XmI+j9nirSuxUqQQgUPey
	D5SJugKogtVHReo42kstNjwn4N01XeEjH1S9A7Ckkjh8+vrJZMMUDIseSa7kkYcn
	efMSMhs8LEpIoTispTi3vnpHGZGx5Yb/H81olbs8oIQVzFLuM+DaU=
In-Reply-To: <20130908084714.14798.32490.stgit@perseus.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Jeff Layton <jlayton@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>

When reconnecting to automounts at startup an autofs ioctl is used
to find the device and inode of existing mounts so they can be used
to open a file descriptor of possibly covered mounts.

At this time the the caller might not yet "own" the mount so it can
trigger calling ->d_automount(). This causes automount to hang when
trying to reconnect to direct or offset mount types.

Consequently kern_path() can't be used but path_mntpointat() can be.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Jeff Layton <jlayton@redhat.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
---
 fs/autofs4/dev-ioctl.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 9183821..228866f 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -183,13 +183,14 @@ static int autofs_dev_ioctl_protosubver(struct file *fp,
 	return 0;
 }
 
+/* Find the topmost mount satisfying test() */
 static int find_autofs_mount(const char *pathname,
 			     struct path *res,
 			     int test(struct path *path, void *data),
 			     void *data)
 {
 	struct path path;
-	int err = kern_path(pathname, 0, &path);
+	int err = user_path_mntpointat(AT_FDCWD, pathname, 0, &path);
 	if (err)
 		return err;
 	err = -ENOENT;
@@ -197,10 +198,9 @@ static int find_autofs_mount(const char *pathname,
 		if (path.dentry->d_sb->s_magic == AUTOFS_SUPER_MAGIC) {
 			if (test(&path, data)) {
 				path_get(&path);
-				if (!err) /* already found some */
-					path_put(res);
 				*res = path;
 				err = 0;
+				break;
 			}
 		}
 		if (!follow_up(&path))
@@ -498,12 +498,11 @@ static int autofs_dev_ioctl_askumount(struct file *fp,
  * mount if there is one or 0 if it isn't a mountpoint.
  *
  * If we aren't supplied with a file descriptor then we
- * lookup the nameidata of the path and check if it is the
- * root of a mount. If a type is given we are looking for
- * a particular autofs mount and if we don't find a match
- * we return fail. If the located nameidata path is the
- * root of a mount we return 1 along with the super magic
- * of the mount or 0 otherwise.
+ * lookup the path and check if it is the root of a mount.
+ * If a type is given we are looking for a particular autofs
+ * mount and if we don't find a match we return fail. If the
+ * located path is the root of a mount we return 1 along with
+ * the super magic of the mount or 0 otherwise.
  *
  * In both cases the the device number (as returned by
  * new_encode_dev()) is also returned.
@@ -531,9 +530,11 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 
 	if (!fp || param->ioctlfd == -1) {
 		if (autofs_type_any(type))
-			err = kern_path(name, LOOKUP_FOLLOW, &path);
+			err = user_path_mntpointat(AT_FDCWD,
+						   name, LOOKUP_FOLLOW, &path);
 		else
-			err = find_autofs_mount(name, &path, test_by_type, &type);
+			err = find_autofs_mount(name, &path,
+						test_by_type, &type);
 		if (err)
 			goto out;
 		devid = new_encode_dev(path.dentry->d_sb->s_dev);
