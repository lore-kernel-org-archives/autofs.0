From: Omar Sandoval <osandov@osandov.com>
Subject: Autofs and mount namespaces
Date: Thu, 7 Apr 2016 11:19:11 -0700
Message-ID: <20160407181911.GA9018@vader>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=baeSNHFZvFP0LQxfa7KFWQU6WbPBb3UynWX2IWpYy3A=;
        b=OTpBPoxdSj1qpelN0ph/qs/C7YaPC//95EePCVAn38pJZTgkMwqgQqXisDuijdfdsE
         H/7v7Tu05zIHAP3brMEo3h7McqV/BqmjyM4Y4RGKG2cITC28TwZCbvOGWkQjN/tS0LDj
         m25pjFE22bJ6qwfv3kInlNUm51S4GG3VbDBvBc41TRl5lGSJi4Jr5Gy8AgEBH9d37fQR
         Up7r7osQc/bTxmJhI1nnflScvFElJCqq0pzsBP4FJ6qz1w5f51K0IP4bskM3eGx+ibZQ
         7saUy/kqlMf8N6ax18OGmWTfPIMKXoqxOx5KI37SA5MNndrkDmxCrw1PCanzucUrYep4
         16zw==
Content-Disposition: inline
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com

Hi, Ian,

I wanted to bring up the issue of autofs and mount namespaces again,
which recently resurfaced in the thread here [1]. In that thread, you
mentioned that you had some patches to make autofs namespace-aware that
you were holding on to. Do you think you could put those up so we can
all work out the issues you mentioned?

For some background, we've also been bitten by the lack of
namespace-awareness in autofs many times. The simple case that breaks
can be reproduced as follows, assuming that /mnt/foo is an indirect
mount:

ls /mnt/foo            # do the initial automount
unshare -m sleep 10 &  # hold the automount in a new namespace
umount /mnt/foo        # pretend the mount timed out
ls /mnt/foo            # try to access it again
ls: cannot open directory '/mnt/foo': Too many levels of symbolic links

For us, the unshare step is actually setting up a container. Our
workaround was to make sure that we clean up all of the base system's
mounts when setting up the container, but in the general case this is
still broken.

In this particular case, I believe the problem is that we're using
`d_mountpoint()` (or `have_submounts()`) in several places to check
whether something is already mounted, and that's not namespace-aware.
This hack mitigates the problem I saw above, although it probably
ignores edge cases that the old code was handling:

----
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 7ab923940d18..a620822342c8 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -378,39 +378,29 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 		goto done;
 	}
 
-	if (!d_mountpoint(dentry)) {
-		/*
-		 * It's possible that user space hasn't removed directories
-		 * after umounting a rootless multi-mount, although it
-		 * should. For v5 have_submounts() is sufficient to handle
-		 * this because the leaves of the directory tree under the
-		 * mount never trigger mounts themselves (they have an autofs
-		 * trigger mount mounted on them). But v4 pseudo direct mounts
-		 * do need the leaves to trigger mounts. In this case we
-		 * have no choice but to use the list_empty() check and
-		 * require user space behave.
-		 */
-		if (sbi->version > 4) {
-			if (have_submounts(dentry)) {
-				spin_unlock(&sbi->fs_lock);
-				goto done;
-			}
-		} else {
-			if (!simple_empty(dentry)) {
-				spin_unlock(&sbi->fs_lock);
-				goto done;
-			}
-		}
-		ino->flags |= AUTOFS_INF_PENDING;
-		spin_unlock(&sbi->fs_lock);
-		status = autofs4_mount_wait(dentry, 0);
-		spin_lock(&sbi->fs_lock);
-		ino->flags &= ~AUTOFS_INF_PENDING;
-		if (status) {
+	if (d_mountpoint(dentry)) {
+		/* Make sure this is a mountpoint in this namespace. */
+		struct vfsmount *mounted = lookup_mnt(path);
+		if (mounted) {
+			mntput(mounted);
 			spin_unlock(&sbi->fs_lock);
-			return ERR_PTR(status);
+			goto done;
 		}
 	}
+
+	if (!simple_empty(dentry)) {
+		spin_unlock(&sbi->fs_lock);
+		goto done;
+	}
+	ino->flags |= AUTOFS_INF_PENDING;
+	spin_unlock(&sbi->fs_lock);
+	status = autofs4_mount_wait(dentry, 0);
+	spin_lock(&sbi->fs_lock);
+	ino->flags &= ~AUTOFS_INF_PENDING;
+	if (status) {
+		spin_unlock(&sbi->fs_lock);
+		return ERR_PTR(status);
+	}
 	spin_unlock(&sbi->fs_lock);
 done:
 	/* Mount succeeded, check if we ended up with a new dentry */
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 0146d911f468..b4e901d2aa6b 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -332,8 +332,6 @@ static int validate_request(struct autofs_wait_queue **wait,
 					dentry = new;
 			}
 		}
-		if (have_submounts(dentry))
-			valid = 0;
 
 		if (new)
 			dput(new);
diff --git a/fs/internal.h b/fs/internal.h
index b71deeecea17..c26ba59eec1b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -58,7 +58,6 @@ extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 extern void *copy_mount_options(const void __user *);
 extern char *copy_mount_string(const void __user *);
 
-extern struct vfsmount *lookup_mnt(struct path *);
 extern int finish_automount(struct vfsmount *, struct path *);
 
 extern int sb_prepare_remount_readonly(struct super_block *);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index f822c3c11377..ff971448152f 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -72,6 +72,7 @@ struct vfsmount {
 struct file; /* forward dec */
 struct path;
 
+extern struct vfsmount *lookup_mnt(struct path *);
 extern int mnt_want_write(struct vfsmount *mnt);
 extern int mnt_want_write_file(struct file *file);
 extern int mnt_clone_write(struct vfsmount *mnt);
----

Thanks.

1: http://thread.gmane.org/gmane.linux.kernel.autofs/6868/focus=7260
2: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/autofs4/root.c?h=v4.6-rc2#n381

--
Omar
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
