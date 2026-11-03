Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717874;
	b=mP3ilyXi+FUytXGGr3WlLzQ/7INhBUbhjFSJmJFSosrMB3m6AH+Esje28Q91VnyAlz0p
	 SK4FKaJm/zwKNSVNaZaaDLL/cKvkvlFF1PIMt7hlObu8lOROUjHR9oA4w47khVszM23g3
	 Xaj+WHrqehxu8wmT538/65IkuZ9WTTKgq8nvSLQ5Xqxf3RZGFaKdouupX5NDnGRBH2D+H
	 titNsOouCXlPhFCR0g+bbXuA5srWJnEOhG+PFCYXZ1BgVJZeCQM0mP4JfHcPTZikU1fOJ
	 +8eh6lexuAo07p3rnr4OkmowuIgM01LNZDmc/UGtPCh7n2rCo2JJolqmt/69Lq4nRTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LwdbQhqCBt1cMRRxXVL4IPYjSgGmqDJIiXLG4fZ/Ljc=;
	b=CR1I1zWeC9p1Ei/qH6fimCYHW2TtLLueUHJSQUThRZ3Rrnw+ZpxTF4xdQ8G3jcvTNVnx
	 E9MpNzAgXFU/mpcwVmke0nIWX8AW8psntrCVu1YzuAr48ju/w8+KN0TRUm0bTpvOfDCSR
	 6FB8pq1+uANbd69tVeuaD1NVWhTOHPIGDj4wQp9pZwzRuOmGFMziflEiIymgdDFzAgUav
	 iy8CrD04hjLAwU1b6SnXk1RudBCtTfHOlaY56756S509ta8xiLncjjkzKiIB/u3pEaX2C
	 Lqf3DgrT5UKpBfL6+imYJiWXQbpsnhVMxTG5IyYwXnWpz8nKOjGpMyjZ04X0Lk5ML6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxlk5gZ7;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA27606BA00
	for <autofs@vger.kernel.org>; Tue,  3 Nov 2026 14:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA27606BA00
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxlk5gZ7
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1d8944cb0so7173487a12.3
        for <autofs@vger.kernel.org>; Tue, 03 Nov 2026 06:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717872; x=1794322672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LwdbQhqCBt1cMRRxXVL4IPYjSgGmqDJIiXLG4fZ/Ljc=;
        b=bxlk5gZ7j2wDbY2FpqTSBrqzWjsbr8APFVbSWw0I+JmsrO/oaxoaV6TjN/lTWgOe+P
         d8ChztYi6dUw9BiZ6pcRrkHzG5zXx0+NALuiUaG33WeDIziBUDN4OpnxPDIF2LXGm8SH
         /Zyq2hQ3RfC633AYYQLLImNbeGZz4LJBNEgc/Qg+xxMsqola5g/A7zOMEkrm/sbu/qOe
         +WVS8hhsI7uQqf82foUwbHkWatd7ppOQy1repnnNtrlj5b68Sj+GXOCdEZGKZzAt9vp3
         jYq8XDqp5HFIf7L7S4Ne3fQjPkwvUxkR/Fh739261X7HcuOWnkxhyZE3nFv28AQejhag
         FCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717872; x=1794322672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LwdbQhqCBt1cMRRxXVL4IPYjSgGmqDJIiXLG4fZ/Ljc=;
        b=f8htGr8iLpy/i79K2EwS5C/hMtJTFYnvYADlYMSU+s1lDQSXZQARz5POOwq8bhp6eY
         NsOeG7djmO7SxWDPUK7FZl+LwOzH+rL/Gml6aB9Uh0rYmw0mUMHzzJW7wb6L+oI9+LwD
         +xEsUla7lZG6Pif76p2YuTeEEz2T7eJOK92Xo88hPwxprSypxaye0m4jwA0gbajuu7IG
         7tieX70MvqUBmSb7+3s4iAMeEt+xpWBBMzWkNszyLyIs34zSgS6D3URsBOJD4C9v6CH/
         yaDHPvBXQw28SjsvmuUemaulpq8hbwC1La0kaWNdp6OQ+5zQ1AxnSUlhzPMzscqpnqDQ
         fDdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwusGz84n2fOl+0xYR5IYQLjEUfE32cdI+jQP0HDskrQ/imbVh+R1kinRomq/7gYjTWcQ1Uk9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bQx0Goyb71gQpRlBUa9cl90Msq8HlSYsEy4uixF/zJx7AZqfd
	cyPOhJMU+aPkuf15NHNVMz8FDDaC16pQjjxvaCarkZ5hHEInFJxIgx28
X-Gm-Gg: AYBFou2S2T7ljKHlwLOBCvgeHNc6GuQyy/n1lfTerDXGmNlTYgGZwzL2bKZfNa+OwFj
	KuQdepcnoT34/YOkjL5DKG4y/mq5fRtvqg23F1zwAOMC461gFqrRby+GVQ9IgdjcuO9NhphiusW
	ZhsPSywndUuz3Y6YQi5cmNMb1kR3K4ZpzOl/XZ2pWkUiktRHBsP0kUEl+R1lW1nQSCWHTlaQn2r
	odnD5xU9Y/jch1cfqB/SORRcWUxVtRwf7SmbayKWS6FqnsaOKnKvGlTvRfEpQPa3+M1cg4D+tZ8
	1hO8iXrl6OLmXjpqyTfNFYuA3oINuvq/Uutoxdz9pNQH7zRxrJsnIyUM7167UHBmDyIfFX6DbrN
	DQ2fyQfIS6CwaTFJqI3Cwc4bGdSc6s+4f4s0elFvvAUx5gT8GJw518J9dSIiK2IYydUnX2y+oRP
	0srGQkTaC1lAKWMYYir+kKp0yLWwRPUAHMl9sQza5IIvt9FbT9BqxFkiDEoDxdAqqileFkP2mH8
	ELdmZYN4T0BqM3Nj5fAMIJVNXixqQ/tJt5pFS0VPAW6s3dSpGhsioqvRU6hskysdEKSxpn2JfGr
	e9fcLh9ipecZQpmgKO1k78CdmkIcMpjrbzo72zCLPmjSwcLYLUP6roPrO1Gbh+M0X33hKUuzodr
	/hseonNMJ4aC4bHFU4CmXvcv67eEHrzoOGG2GLNMDkli5hIjjfoDUNP/tdpz394Saa3qtdGhHDa
	TMYm/XGZXAZ2TpeObMqNFbZooj0IZIRBU2L5fkP41k9rM7nXalPw==
X-Received: by 2002:a17:906:ef0b:b0:c46:b9b0:8e8f with SMTP id a640c23a62f3a-c4ca7a9d96emr1201972166b.41.1793717871769;
        Tue, 03 Nov 2026 06:57:51 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebec78f3sm93656366b.23.2026.11.03.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:57:51 -0800 (PST)
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
Subject: [PATCH v2 1/2] kernfs, sysfs: refuse splice on writable files that look up paths
Date: Tue,  3 Nov 2026 15:57:42 +0100
Message-ID: <1efd95857d40da812ea564f1abff8d65360609a4.1793715774.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793715774.git.krystianmkaniewski@gmail.com>
References: <cover.1793715774.git.krystianmkaniewski@gmail.com>
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

A splice into any of these files can add the first edge. A splice from
the autofs daemon pipe into a file whose store looks up the path is a
real deadlock. When the path triggers a mount request, autofs waits for
the mutex of the pipe that the splice holds.

Refuse splice on writable opens of files whose ->write() may look up
arbitrary paths. Give both of->mutex and the seq_file lock of those
opens separate lockdep classes. The seq_file class must also be split
because a splice from another seq_file can put its shared class below a
pipe mutex.

Cache the decision in of->no_splice while the kernfs node is active.
Both splice directions return -EINVAL before entering the file callback.
Read-only opens retain splice support because they cannot invoke the
path-looking store callback.

Reject may_lookup together with mmap or preallocated buffers at file
creation. Those paths place of->mutex or another shared lock around it
in a shared class. Sysfs also rejects SYSFS_LOOKUP together with
SYSFS_PREALLOC instead of silently discarding the lookup property.

Binary attributes have no operations table with may_lookup. Reject
SYSFS_LOOKUP in both direct and attribute-group binary creation paths
instead of creating a binary file without the requested protection.

Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

 fs/kernfs/file.c       | 54 +++++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c        | 29 +++++++++++++++++++++++
 fs/sysfs/group.c       | 12 ++++++++--
 include/linux/kernfs.h | 10 ++++++++
 include/linux/sysfs.h  | 22 ++++++++++++-----
 5 files changed, 116 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index cca9f83fc9b5a9..926898af7b3be1 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -649,6 +649,12 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	if (!of)
 		goto err_out;
 
+	/*
+	 * Splice callbacks need this before the iter paths acquire an active
+	 * reference, so cache it while @kn is active.
+	 */
+	of->no_splice = (file->f_mode & FMODE_WRITE) && ops->may_lookup;
+
 	/*
 	 * The following is done to give a different lockdep key to
 	 * @of->mutex for files which implement mmap.  This is a rather
@@ -666,11 +672,17 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	 * lookup helpers for arbitrary paths and readonly files can be read by
 	 * overlayfs from vfs helpers when sysfs is a lower layer of overalyfs.
 	 *
-	 * All three cases look the same.  They're supposed to
+	 * Writable opens of ->may_lookup files get a fourth key.  Their
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
+		static struct lock_class_key seq_lookup_key;
+
+		lockdep_set_class(&of->seq_file->lock, &seq_lookup_key);
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
@@ -1066,6 +1106,14 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 	unsigned flags;
 	int rc;
 
+	/*
+	 * ->may_lookup needs dedicated lockdep classes. ->mmap selects the
+	 * shared mmap class, while ->prealloc adds a shared mutex around
+	 * of->mutex.
+	 */
+	if (WARN_ON_ONCE(ops->may_lookup && (ops->mmap || ops->prealloc)))
+		return ERR_PTR(-EINVAL);
+
 	flags = KERNFS_FILE;
 
 	kn = kernfs_new_node(parent, name, (mode & S_IALLUGO) | S_IFREG,
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index cd5bb0f9fee6dd..fd1f870ca554a1 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -252,6 +252,17 @@ static const struct kernfs_ops sysfs_prealloc_kfops_rw = {
 	.prealloc	= true,
 };
 
+static const struct kernfs_ops sysfs_lookup_kfops_wo = {
+	.write		= sysfs_kf_write,
+	.may_lookup	= true,
+};
+
+static const struct kernfs_ops sysfs_lookup_kfops_rw = {
+	.seq_show	= sysfs_kf_seq_show,
+	.write		= sysfs_kf_write,
+	.may_lookup	= true,
+};
+
 static const struct kernfs_ops sysfs_bin_kfops_ro = {
 	.read		= sysfs_kf_bin_read,
 };
@@ -288,6 +299,11 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 			"missing sysfs attribute operations for kobject: %s\n",
 			kobject_name(kobj)))
 		return -EINVAL;
+	/* the prealloc ops would silently drop ->may_lookup */
+	if (WARN((mode & SYSFS_PREALLOC) && (mode & SYSFS_LOOKUP),
+		 "Attribute %s: SYSFS_LOOKUP cannot be combined with SYSFS_PREALLOC\n",
+		 attr->name))
+		return -EINVAL;
 
 	if (mode & SYSFS_PREALLOC) {
 		if (sysfs_ops->show && sysfs_ops->store)
@@ -296,6 +312,13 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 			ops = &sysfs_prealloc_kfops_ro;
 		else if (sysfs_ops->store)
 			ops = &sysfs_prealloc_kfops_wo;
+	} else if (mode & SYSFS_LOOKUP) {
+		if (sysfs_ops->show && sysfs_ops->store)
+			ops = &sysfs_lookup_kfops_rw;
+		else if (sysfs_ops->show)
+			ops = &sysfs_file_kfops_ro;
+		else if (sysfs_ops->store)
+			ops = &sysfs_lookup_kfops_wo;
 	} else {
 		if (sysfs_ops->show && sysfs_ops->store)
 			ops = &sysfs_file_kfops_rw;
@@ -332,6 +355,12 @@ int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
 	const struct kernfs_ops *ops;
 	struct kernfs_node *kn;
 
+	/* there are no binary ops with ->may_lookup */
+	if (WARN(mode & SYSFS_LOOKUP,
+		 "Attribute %s: SYSFS_LOOKUP is not supported for binary attributes\n",
+		 attr->name))
+		return -EINVAL;
+
 	if (battr->mmap)
 		ops = &sysfs_bin_kfops_mmap;
 	else if (battr->read && battr->write)
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 4e1e4f18a16692..eaaccf16158d09 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -74,11 +74,11 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 					continue;
 			}
 
-			WARN(mode & ~(SYSFS_PREALLOC | 0664),
+			WARN(mode & ~(SYSFS_PREALLOC | SYSFS_LOOKUP | 0664),
 			     "Attribute %s: Invalid permissions 0%o\n",
 			     (*attr)->name, mode);
 
-			mode &= SYSFS_PREALLOC | 0664;
+			mode &= SYSFS_PREALLOC | SYSFS_LOOKUP | 0664;
 			error = sysfs_add_file_mode_ns(parent, *attr, mode, uid,
 						       gid, NULL);
 			if (unlikely(error))
@@ -107,6 +107,14 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 			if (grp->bin_size)
 				size = grp->bin_size(kobj, *bin_attr, i);
 
+			/* Do not let the mode mask below discard SYSFS_LOOKUP. */
+			if (WARN(mode & SYSFS_LOOKUP,
+				 "Attribute %s: SYSFS_LOOKUP is not supported for binary attributes\n",
+				 (*bin_attr)->attr.name)) {
+				error = -EINVAL;
+				break;
+			}
+
 			WARN(mode & ~(SYSFS_PREALLOC | 0664),
 			     "Attribute %s: Invalid permissions 0%o\n",
 			     (*bin_attr)->attr.name, mode);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73786b567ccd8e..8597b2b80caf36 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -272,6 +272,7 @@ struct kernfs_open_file {
 	char			*prealloc_buf;
 
 	size_t			atomic_write_len;
+	bool			no_splice;
 	bool			mmapped:1;
 	bool			released:1;
 	const struct vm_operations_struct *vm_ops;
@@ -320,6 +321,15 @@ struct kernfs_ops {
 	 * ->prealloc.  Provide ->read and ->write with ->prealloc.
 	 */
 	bool prealloc;
+	/*
+	 * "may_lookup" marks a ->write() which may look up arbitrary
+	 * paths and so wait for userspace, e.g. for an autofs daemon.
+	 * Writable opens refuse splice and get their own lockdep
+	 * classes.  File creation rejects ->mmap or ->prealloc together
+	 * with this flag because either would leave of->mutex or the lock
+	 * around it in a shared class.
+	 */
+	bool may_lookup;
 	ssize_t (*write)(struct kernfs_open_file *of, char *buf, size_t bytes,
 			 loff_t off);
 
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b1a3a1e6ad09cc..c2f89899af921c 100644
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
+ *		permissions as well as SYSFS_PREALLOC and SYSFS_LOOKUP
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
+/* Regular ->store() may look up paths, not valid with SYSFS_PREALLOC. */
+#define SYSFS_LOOKUP		040000
 
 /*
  * DEFINE_SYSFS_GROUP_VISIBLE(name):
@@ -251,6 +254,13 @@ struct attribute_group {
 	.store	= _store,						\
 }
 
+#define __ATTR_LOOKUP(_name, _mode, _show, _store) {			\
+	.attr = {.name = __stringify(_name),				\
+		 .mode = SYSFS_LOOKUP | VERIFY_OCTAL_PERMISSIONS(_mode) },\
+	.show	= _show,						\
+	.store	= _store,						\
+}
+
 #define __ATTR_RO_MODE(_name, _mode) {					\
 	.attr	= { .name = __stringify(_name),				\
 		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
-- 
2.53.0


