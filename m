Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493029;
	b=X/FZJPfknCAhi+gDErQbBLt2Vg8uV5g+YX8Os/9e+qvDF6b2z9BdX0ySgfSp305tLbdW
	 3+PNd8qY8q9XCaoI4Wy/6EfXBCcY0ZKYazb8I8TQmwPWEZthsQ7vbCYTyGL3T4uTvuXQd
	 aN2FwNF0dqIyZUISwWAq16pagagnPbDfo/HSgChOPi5L8ERdiaDgTZH/sClmppijgJBMS
	 Pg4GdZD43DSwb+UEh2d3Dm0RrFDgTu8ue6Llu//1lwSpaNxehhtITZdTCe6y6/2d6TJU7
	 GtBYw3qhW+WvFBJ2c4raoH2mrkOrC0GqlVHBs/G52I/MPdNWqQjUx9SWgOfSlN+6Lsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=boCA2daOQ+TyIVh3xMJHgQmUEAwZI0O8OGy6/w/qqJ8=;
	b=paxwP0c1wWPykm25iy7EN01gXMETyhHt4zF9fQW8u3N7MTfPLE87/cI2Bp7Tb1PhPbz6
	 85Rh9y4HSxoERjF8aqylZQ5b0ZTrvpWKcTu885BnifvIFWHZfLMubCeKExxMteGQ7XaLN
	 7TOoMk74OtHh1fiobn/z2QL1Hd5cchRN2wQL3ue7FyTQ305whT9jrevKvV0LJ+XKUJL5X
	 O+9v9WW3fOuBfIoLd97D+HNuLGmuvNqgnh7tILwW+R99rialoIml/2VZ4vH7hqpxMyXJU
	 T5UDSTUUrkYkkIXE0+HGMYoN9BfDW8kJTWjJ4qAYlEfiNY/XlPRPWgqQ2/936xCHopA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USExnjSi;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBE60A3806
	for <autofs@vger.kernel.org>; Thu, 12 Nov 2026 14:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86EBE60A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USExnjSi
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4682977f9aso569452466b.1
        for <autofs@vger.kernel.org>; Thu, 12 Nov 2026 06:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493028; x=1795097828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boCA2daOQ+TyIVh3xMJHgQmUEAwZI0O8OGy6/w/qqJ8=;
        b=USExnjSiP/LTXN4Mt0h9lqHmxkDGOpsgry4uJJB7H7Rl5Mcd1T3KPBqKk3281yt2eq
         JXeRr0zki2fSCez7P2ri3rEL29LwYqkX6HkoIPZkASWMXEoxLRUTQfeIthgiTv49AZV8
         Ah1joV/H7aFPgltphfY+AYFA2Wmp/6umx26g45hrF0Ju3OFm7ZyuEO/IUYuXnY9MiLYT
         03+GQWvPfbP24a0hkt9l8c+MdABB1hQcasxA5nL79OrsvYgLbJUfyDEmqBGV3hzIg45X
         HfKw6yLnkuWOhN4qrZvFb42FcjQHZaZ1yCaHCG1lI4C/smvEXOx+m23BPcePep/zVofr
         0dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493028; x=1795097828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=boCA2daOQ+TyIVh3xMJHgQmUEAwZI0O8OGy6/w/qqJ8=;
        b=by8QvpurYgB+13UDz8h/m6R8ni3yy/CjROuxkainwozOTAbDuBge03yeaG8YFpVp4B
         58HCl6vwvlswD4TgxiGRFRW1o/MrhYS2O0W30YJd5YTCsqEmdM9C8GFlFrlgniByJF8j
         hRuG/vVfWUuISnF3s1GeFNnUGgtYcHMzjx01Y+FHqXW0BN0QGKIrEudSV9Aqn+OabnIz
         ZHM47m+nkYUv4VTnyrIm6kN+LzS/4yq0VK9JGSAvFWWaVN62aq5VZtMFlzZk8J0jobaH
         FXqNO7HNuNU3ZvhUHUEBlZDJ0u4oWVIm/ql7dpUeyDCUSPI9317JuStWLt3t694bbBvd
         RlXw==
X-Forwarded-Encrypted: i=1; AL+hErHbh7i/O3cUEFxLMWkCBOo73ljbkJPjwwmDR4fXS7I5DgVwPVz1c94AQG/ZhJ5YJqI5GJRlgtY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CdREyg9V1S2pnFRRj7aPnZ0/I2L4fdKNGazxM6kkVolFthJeC
	aCacfZ7JCw8SsQIDMf6RtVBTPuKqVPZhzoM4w9jwr6b08//2/gaEB2al
X-Gm-Gg: AYBFou3zOX9cdYcUY5plPiramIvYRsJidI5NOVxlHirIWb2X3vvtVEq/iBFSE2jT9P9
	rfV/VplKtQYUkI33Yk9nQfOHq6CAnqzHeus2TEOyIMeDsubPZddUo3lTLVCd9msBMuXbPZ7F8vT
	P6Awomf9cVvfar8tKzdPQlYRwEUzGuqWzqlbFbK5d/T14x5unuq0OtBMk9ocih9DnXa63Owsdp1
	FL6GzHULZTHi3SdBh0wLWJayFVZe4saOUEJeFfseS44zZWU+xSFpfywwhY+Zveq1YoVrWR4hWaW
	b+XuWx7PYWlLnbvAaKo50B50Nt3mpQ3MXnByqHlgdRz7s1VyINyKl+e6ZH1TtjytdvS6+B2y4Fs
	R7TfZxF9V2kWm71ltnPpET7uTrJYcaNWI2NncdiO3Fvv7jwclWzdsm6FhV1EPKdfAnr1g3WtH3h
	qlxwubDw2g2M3pjBEzlNr3a3JByAc7cyhADC8kKyB06KfDGM7WdoodjGwoSZO1aQ1BjqClseadN
	kPmGO1TnBYwSBoQv70AYGlDWuJp4HoULqJ4NniNE5mfPxZTCHwKPl6K22iV5f6ZwQb5rQZ6Ri5x
	2nNwfP2RqET7ud9hQhpoQMRp0t6jUbAwBKZj6NqIJuwtKuU3XoVZMEMvjxiHxiKmhlIUUjZDgeL
	kC9trx9gxKpvkKJ9nJ6KGXYNLayBaYOiXGkK0o6PLlgpIGdlde2kvO6pWJKmbSn9v817uYUxfgP
	WXSqXM1xTW+R/WZJLvwrGAuXIuEdTGMDFB4T6nvSXk/+KYpw5a8/k=
X-Received: by 2002:a17:907:f816:b0:c49:b952:5425 with SMTP id a640c23a62f3a-c5066ce8350mr454392466b.45.1794493027762;
        Thu, 12 Nov 2026 06:17:07 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm360156466b.16.2026.11.12.06.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:17:07 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ian Kent <raven@themaw.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH v3 1/2] kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice on writable opens
Date: Thu, 12 Nov 2026 15:17:01 +0100
Message-ID: <f9f3df7a60ecbbacc3186b700deb947d7dc23e9f.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794479968.git.krystianmkaniewski@gmail.com>
References: <cover.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some sysfs stores look up a path written by the user, for example
/sys/power/resume through lookup_bdev(). When the path reaches an
autofs mount, autofs writes a mount request to its daemon pipe while
kernfs holds of->mutex. splice() enters kernfs files with a pipe mutex
held, and writable opens of all kernfs files without mmap share one
lockdep class for of->mutex, so lockdep sees

  &pipe->mutex --> &of->mutex --> &sbi->pipe_mutex --> &pipe->mutex

A splice into any writable kernfs file can add the first edge. A splice
from the autofs daemon pipe into a file whose store looks up the path
is a real deadlock, because autofs then waits for the mutex of the pipe
that the splice holds.

Add kernfs_ops->no_splice and SYSFS_NO_SPLICE for such files. Writable
opens of a marked file refuse both splice directions with -EINVAL
before the file callback runs, and their of->mutex and seq_file lock
get lockdep classes of their own. The seq_file lock needs its own class
as well, because a read through such an open takes of->mutex under it,
while a splice from any other seq_file takes the shared seq_file class
under a pipe mutex. Read-only opens keep splice support because they
cannot reach ->write().

Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v3:
- Rename SYSFS_LOOKUP and ->may_lookup to SYSFS_NO_SPLICE and
  ->no_splice (Tejun).
- Drop the mmap, prealloc and binary attribute checks, document the
  limits in comments instead (Tejun).

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

 fs/kernfs/file.c       | 46 +++++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c        | 18 +++++++++++++++++
 fs/sysfs/group.c       |  4 ++--
 include/linux/kernfs.h |  9 +++++++++
 include/linux/sysfs.h  | 22 ++++++++++++++------
 5 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index cca9f83fc9b5..9a0640fb2959 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -649,6 +649,12 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	if (!of)
 		goto err_out;
 
+	/*
+	 * Splice callbacks need this before the iter paths acquire an active
+	 * reference, so cache it while @kn is active.
+	 */
+	of->no_splice = (file->f_mode & FMODE_WRITE) && ops->no_splice;
+
 	/*
 	 * The following is done to give a different lockdep key to
 	 * @of->mutex for files which implement mmap.  This is a rather
@@ -666,11 +672,17 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	 * lookup helpers for arbitrary paths and readonly files can be read by
 	 * overlayfs from vfs helpers when sysfs is a lower layer of overalyfs.
 	 *
-	 * All three cases look the same.  They're supposed to
+	 * Writable opens of ->no_splice files get a fourth key.  Their
+	 * ->write() may wait for userspace through a pipe, so splice, which
+	 * takes @of->mutex under a pipe mutex, is refused for them.
+	 *
+	 * All four cases look the same.  They're supposed to
 	 * look that way and give @of->mutex different static lockdep keys.
 	 */
 	if (has_mmap)
 		mutex_init(&of->mutex);
+	else if (of->no_splice)
+		mutex_init(&of->mutex);
 	else if (file->f_mode & FMODE_WRITE)
 		mutex_init(&of->mutex);
 	else
@@ -717,6 +729,16 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	of->seq_file = file->private_data;
 	of->seq_file->private = of;
 
+	/*
+	 * seq_read_iter() takes @of->mutex under the seq_file lock, whose key
+	 * is shared with seq_files that can be spliced. Separate it too.
+	 */
+	if (of->no_splice) {
+		static struct lock_class_key seq_no_splice_key;
+
+		lockdep_set_class(&of->seq_file->lock, &seq_no_splice_key);
+	}
+
 	/* seq_file clears PWRITE unconditionally, restore it if WRITE */
 	if (file->f_mode & FMODE_WRITE)
 		file->f_mode |= FMODE_PWRITE;
@@ -889,6 +911,24 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
 	return ret;
 }
 
+static ssize_t kernfs_fop_splice_read(struct file *in, loff_t *ppos,
+				      struct pipe_inode_info *pipe, size_t len,
+				      unsigned int flags)
+{
+	if (kernfs_of(in)->no_splice)
+		return -EINVAL;
+	return copy_splice_read(in, ppos, pipe, len, flags);
+}
+
+static ssize_t kernfs_fop_splice_write(struct pipe_inode_info *pipe,
+				       struct file *out, loff_t *ppos,
+				       size_t len, unsigned int flags)
+{
+	if (kernfs_of(out)->no_splice)
+		return -EINVAL;
+	return iter_file_splice_write(pipe, out, ppos, len, flags);
+}
+
 static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct kernfs_open_file *of = kernfs_of(file);
@@ -1035,8 +1075,8 @@ const struct file_operations kernfs_file_fops = {
 	.release	= kernfs_fop_release,
 	.poll		= kernfs_fop_poll,
 	.fsync		= noop_fsync,
-	.splice_read	= copy_splice_read,
-	.splice_write	= iter_file_splice_write,
+	.splice_read	= kernfs_fop_splice_read,
+	.splice_write	= kernfs_fop_splice_write,
 };
 
 /**
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index cd5bb0f9fee6..54f715fe57a8 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -252,6 +252,17 @@ static const struct kernfs_ops sysfs_prealloc_kfops_rw = {
 	.prealloc	= true,
 };
 
+static const struct kernfs_ops sysfs_no_splice_kfops_wo = {
+	.write		= sysfs_kf_write,
+	.no_splice	= true,
+};
+
+static const struct kernfs_ops sysfs_no_splice_kfops_rw = {
+	.seq_show	= sysfs_kf_seq_show,
+	.write		= sysfs_kf_write,
+	.no_splice	= true,
+};
+
 static const struct kernfs_ops sysfs_bin_kfops_ro = {
 	.read		= sysfs_kf_bin_read,
 };
@@ -296,6 +307,13 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 			ops = &sysfs_prealloc_kfops_ro;
 		else if (sysfs_ops->store)
 			ops = &sysfs_prealloc_kfops_wo;
+	} else if (mode & SYSFS_NO_SPLICE) {
+		if (sysfs_ops->show && sysfs_ops->store)
+			ops = &sysfs_no_splice_kfops_rw;
+		else if (sysfs_ops->show)
+			ops = &sysfs_file_kfops_ro;
+		else if (sysfs_ops->store)
+			ops = &sysfs_no_splice_kfops_wo;
 	} else {
 		if (sysfs_ops->show && sysfs_ops->store)
 			ops = &sysfs_file_kfops_rw;
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 4e1e4f18a166..ef4cd632ace2 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -74,11 +74,11 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 					continue;
 			}
 
-			WARN(mode & ~(SYSFS_PREALLOC | 0664),
+			WARN(mode & ~(SYSFS_PREALLOC | SYSFS_NO_SPLICE | 0664),
 			     "Attribute %s: Invalid permissions 0%o\n",
 			     (*attr)->name, mode);
 
-			mode &= SYSFS_PREALLOC | 0664;
+			mode &= SYSFS_PREALLOC | SYSFS_NO_SPLICE | 0664;
 			error = sysfs_add_file_mode_ns(parent, *attr, mode, uid,
 						       gid, NULL);
 			if (unlikely(error))
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73786b567ccd..2e8466d2c314 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -272,6 +272,7 @@ struct kernfs_open_file {
 	char			*prealloc_buf;
 
 	size_t			atomic_write_len;
+	bool			no_splice;
 	bool			mmapped:1;
 	bool			released:1;
 	const struct vm_operations_struct *vm_ops;
@@ -320,6 +321,14 @@ struct kernfs_ops {
 	 * ->prealloc.  Provide ->read and ->write with ->prealloc.
 	 */
 	bool prealloc;
+	/*
+	 * "no_splice" makes writable opens refuse splice and gives their
+	 * @of->mutex and seq_file lock separate lockdep classes.  Set it
+	 * for a ->write() that may wait for userspace, e.g. through a path
+	 * lookup that triggers an automount, so that the write never runs
+	 * under a pipe mutex.  Not supported with ->mmap or ->prealloc.
+	 */
+	bool no_splice;
 	ssize_t (*write)(struct kernfs_open_file *of, char *buf, size_t bytes,
 			 loff_t off);
 
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b1a3a1e6ad09..574424760c23 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -75,12 +75,13 @@ do {							\
  * @is_visible:	Optional: Function to return permissions associated with an
  *		attribute of the group. Will be called repeatedly for
  *		each non-binary attribute in the group. Only read/write
- *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if an attribute is not visible. The returned
- *		value will replace static permissions defined in struct
- *		attribute. Use SYSFS_GROUP_VISIBLE() when assigning this
- *		callback to specify separate _group_visible() and
- *		_attr_visible() handlers.
+ *		permissions as well as SYSFS_PREALLOC and SYSFS_NO_SPLICE
+ *		are accepted. Must return 0 if an attribute is not
+ *		visible. The returned value will replace static
+ *		permissions defined in struct attribute. Use
+ *		SYSFS_GROUP_VISIBLE() when assigning this callback to
+ *		specify separate _group_visible() and _attr_visible()
+ *		handlers.
  * @is_bin_visible:
  *		Optional: Function to return permissions associated with a
  *		binary attribute of the group. Will be called repeatedly
@@ -124,6 +125,8 @@ struct attribute_group {
 
 #define SYSFS_PREALLOC		010000
 #define SYSFS_GROUP_INVISIBLE	020000
+/* Writable opens refuse splice, not for prealloc or binary attributes */
+#define SYSFS_NO_SPLICE		040000
 
 /*
  * DEFINE_SYSFS_GROUP_VISIBLE(name):
@@ -251,6 +254,13 @@ struct attribute_group {
 	.store	= _store,						\
 }
 
+#define __ATTR_NO_SPLICE(_name, _mode, _show, _store) {			\
+	.attr = {.name = __stringify(_name),				\
+		 .mode = SYSFS_NO_SPLICE | VERIFY_OCTAL_PERMISSIONS(_mode) },\
+	.show	= _show,						\
+	.store	= _store,						\
+}
+
 #define __ATTR_RO_MODE(_name, _mode) {					\
 	.attr	= { .name = __stringify(_name),				\
 		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
-- 
2.53.0

