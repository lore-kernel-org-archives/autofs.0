Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587122;
	b=cj6LJUVo52EzIbu3biN85o+nng3xA0kjwZVpuMj7k+aSoMjk/EOeXSHthR3D7Bkwr6Ux
	 gyx7gW1sefsdCSgR5tb/Vh+C79dDsUcL6feMS/0jmiaDTjR9sxte+VpapbBawM78pmwgP
	 6bRUSlus1ZgcY8eSNmJHnnuKyiBb2KCLCdwn4Pb0X5/8bZZlrlwgSTZyAm1a66a7JWWi5
	 mxjHy733HIAdCwQF/FLznDiY+7/meTQ16K+HjB/OHGzQon+D2WDC7+TJ3NxKqT5LPyi5T
	 YyaTnQpNw7HvpgEpubRObp1SmbmpcxKwoD0un30CfrthCVWHr6yVIpbibpwa99JnEAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KpfC3ycXKcDQY4YCk1HOWqaHxlwyq5m57lBpzL91NVs=;
	b=RV+SlECO/AowbFCeF7GEiVALwHPYB7IYrYgAgWGAqGJJ+yQ52uAqZGHrfB7nv0yq4am6
	 WR1B/lZQInCY41g7HYC61totI9BHwKZkccYulMt+5ty9e6ofhPjpdJrGdGLCzTnvi18KX
	 5i3FAiIWZ0326HfWpn2sSbLoZMaP7BfdtisygPeaWFH2U93MP7rnnS6Q+MGnFL3xmAeYr
	 /bcWF6vM1LQGGokrwxfPWx492sJpAjDFfZ6vdk6EFiSdnzmIbiDDSYD5CWYqKPmlpPoLC
	 tFWkEii8n7P+9eRz87T7HnW+EJn1unBkEnTT/oMcnWjz93rcRUFz6jeRso1EJ23DyFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KWGA2gpR;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F52606A339
	for <autofs@vger.kernel.org>; Wed, 21 Oct 2026 12:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94F52606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KWGA2gpR
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso2459883a12.1
        for <autofs@vger.kernel.org>; Wed, 21 Oct 2026 05:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587120; x=1793191920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KpfC3ycXKcDQY4YCk1HOWqaHxlwyq5m57lBpzL91NVs=;
        b=KWGA2gpREMvYMM1CF07vH4HzUYaFCoJ3q5y3nhzAn1Y36pw6LIPljoCsjz83kfFjgq
         Pua5u/pzW5BYoq85NI6/DlWo3WUv52WnFXluqBW82qMN+9vlQ8n4gONMCD+krDlVlVcX
         r9ZS32/yndcazNNEYMF3Jfnr+KBf1MKQS+9gGXa9JApjCjWZDg89JBDrqR4pdLpl5yUR
         2QjUQzhplZz62yV9XW1vzseL7xzAAEpXoVqY6KrMoqzinFxJ2MbsszjTZnVyKvzbLuBq
         ZQsETKcJBKmG/77qKzJJWn2RQEu4IyFFhn6a1LX521fQ5bjgqZ7cwBoN/fEgaXnwV/s6
         kdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587120; x=1793191920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KpfC3ycXKcDQY4YCk1HOWqaHxlwyq5m57lBpzL91NVs=;
        b=WMrgOwG/0j1CvE0D5Ufhbi7zLZ6utUIJXw+eZP5cJbI07SHp4Yuq8rqDtV87b8nMS7
         yqqWohitDaJuFk6m+D8rN8nubn1PQPQXdS0aTPTRd3JY/elXZ91c0zsPKhiOQX9dWVt6
         0zTAzS3NSLKz3ExjxwM7SFASBSflFH5PlUxxcMvO5lV40Nl6H7UTcxUmsFtd35P0pa7y
         H3LXAOZfDWk0wONMuT1qBQdBQCAYwNYUxsXq5VVWERqlpVG0wxyC9E6mw6Z55GpJnwtV
         BJDNZSY1pG7ukz5buOyuej2ercSWGNszG65YAvFf5KCL5nHwbD2PJ8crHsv+7XcplNcS
         l74w==
X-Forwarded-Encrypted: i=1; AKwUvByISUj+HMGCVsNqf55mwsK8++xv1nyeGEHfNySSpudBTRS8RF89S9u5HJ37+wGWE6kqOjCI7wA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdMCJdxgScfjXyZ+jPdbexCaj8yJtAOd/ypKckvGwZ1l2H9gt/
	XdQlNQyo1BNdkqrhq0dnr7jr1Cd9hRNw4YXxxl35lbLVrRfHYWIvFVw+
X-Gm-Gg: AYBFou1cW1kXAVq8mW1GwzcVeH7acQVauvgeo4V8pDBQN27Ak0u/dYDCOhTN9jKasjl
	IWgFkD9vW3hjmSnVSz41wsvxda1sQU+jWr5Gbb+RnLtz27DK5qCJJtQRp9wPmj0zSDa6aPHhXFa
	1AFNFtPmKjIUFd8v2cU+QQL6FONMKHWTyTnSMg2959sVpB45JI+tfTZEaWZr7YkNSlwuvPUkRYC
	0vkEyO1P4lQWSEZ/2dhEPxZLGtv8K5IOapTPsx8fxPMgHdeMhKFjCkPiVDJBkmJRn6BOWys3zi2
	b4K4FIGWAEwWNQnrrR52EFwuzozBPbJU3ZsutMQlN62Ha4z1Ias8g11vTh/AQLowojezUderio6
	ANS11AKmZZVEEUKwYOhvIqpTgivHPh0IjBdelOPAx3Dof+Mwg7aki0DZHee9eFdrVGSpY9y4SPn
	L9Q4IRvtypQjSSj/y9PKCK2nrhMqSaQga8bkxuvQp6E5v9EDdiZr9h7ZhColUad7S0oRf2XWqaM
	j2YGaFac0bB87TBWwzXfQSJeo4+5dWvlBoVoB/loKKBJ80HiSgD/zUHpKB+1Wol48/vss5jYKgV
	HRyceoplUw8HLLWbYKuflCKKxiTMSqJx7DIDx2rCb2N+0p8+tTCagCVqWjF/udeV21tIFUSxMLL
	S+9kZyimCwFg/wlbGSrUn1S5R9PJq6g1VqCWNjAjpL9s5HNnCPHSNS2qf/zWNLv5w1JbJAdl3+d
	eQEOdVQJeOKoITl4sWH9BYVenL
X-Received: by 2002:a17:907:97c9:b0:c42:4557:452c with SMTP id a640c23a62f3a-c460370cce2mr427858366b.8.1792587119735;
        Wed, 21 Oct 2026 05:51:59 -0700 (PDT)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4679004464sm73128366b.67.2026.10.21.05.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:51:59 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Kent <raven@themaw.net>
Cc: Tejun Heo <tj@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	driver-core@lists.linux.dev,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH 1/2] kernfs: do not hold of->mutex across sysfs ->store()
Date: Wed, 21 Oct 2026 14:51:49 +0200
Message-ID: <cd417f2b7f3a978603853d5b0b85439fbbba4c15.1792577179.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792577179.git.krystianmkaniewski@gmail.com>
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com> <cover.1792577179.git.krystianmkaniewski@gmail.com>
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

Lockdep reports a circular dependency &pipe->mutex --> &of->mutex -->
&sbi->pipe_mutex. A splice between a pipe and a kernfs file calls
->write_iter() or ->read_iter() of the file with the pipe locked, and
kernfs takes of->mutex there. A write to /sys/power/resume runs
resume_store() under of->mutex, and its lookup_bdev() can trigger an
autofs mount request, whose autofs_write() takes sbi->pipe_mutex and then
the mutex of the daemon pipe.

of->mutex only has to keep the callbacks of one open file apart.
sysfs_kf_write() does not pass the open file to ->store(), and two opens
of the same attribute already run ->store() concurrently. Add a
write_unlocked flag to struct kernfs_ops, cache it in struct
kernfs_open_file next to atomic_write_len, and take of->mutex around
->write() only when the flag is clear. Set it for the regular sysfs
attributes. The preallocated buffer stays protected by
of->prealloc_mutex, and the other kernfs users keep of->mutex.

This does not remove every report through the autofs daemon pipe. A pipe
spliced straight into such an attribute stays locked while ->store()
looks up the path, and a ->store() that takes its own lock around a
lookup keeps that dependency.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Assisted-by: Gemini:gemini-3.8-flash syzbot
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Link: https://syzkaller.appspot.com/ai_job?id=74fbf9ab-54e4-46c2-b9e9-7867573ff823
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
 fs/kernfs/file.c       | 52 +++++++++++++++++++++++++++---------------
 fs/sysfs/file.c        | 18 ++++++++++++++-
 include/linux/kernfs.h | 11 +++++++++
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8e0e90c933720..c954543c1a583 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -291,6 +291,26 @@ static ssize_t kernfs_fop_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return kernfs_file_read_iter(iocb, iter);
 }
 
+/* Call the ->write() operation of @of under an active reference. */
+static ssize_t kernfs_write_active(struct kernfs_open_file *of, char *buf,
+				   size_t len, loff_t pos)
+{
+	const struct kernfs_ops *ops;
+	ssize_t ret;
+
+	if (!kernfs_get_active_of(of))
+		return -ENODEV;
+
+	ops = kernfs_ops(of->kn);
+	if (ops->write)
+		ret = ops->write(of, buf, len, pos);
+	else
+		ret = -EINVAL;
+
+	kernfs_put_active_of(of);
+	return ret;
+}
+
 /*
  * Copy data in from userland and pass it to the matching kernfs write
  * operation.
@@ -305,7 +325,6 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
 	ssize_t len = iov_iter_count(iter);
-	const struct kernfs_ops *ops;
 	char *buf;
 
 	if (of->atomic_write_len) {
@@ -330,25 +349,18 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	buf[len] = '\0';	/* guarantee string termination */
 
 	/*
-	 * @of->mutex nests outside active ref and is used both to ensure that
-	 * the ops aren't called concurrently for the same open file.
+	 * @of->mutex nests outside active ref and keeps the ops of one open
+	 * file from running concurrently.  ->write() of files with
+	 * ->write_unlocked set does not need that and runs without it.
 	 */
-	mutex_lock(&of->mutex);
-	if (!kernfs_get_active_of(of)) {
+	if (of->write_unlocked) {
+		len = kernfs_write_active(of, buf, len, iocb->ki_pos);
+	} else {
+		mutex_lock(&of->mutex);
+		len = kernfs_write_active(of, buf, len, iocb->ki_pos);
 		mutex_unlock(&of->mutex);
-		len = -ENODEV;
-		goto out_free;
 	}
 
-	ops = kernfs_ops(of->kn);
-	if (ops->write)
-		len = ops->write(of, buf, len, iocb->ki_pos);
-	else
-		len = -EINVAL;
-
-	kernfs_put_active_of(of);
-	mutex_unlock(&of->mutex);
-
 	if (len > 0)
 		iocb->ki_pos += len;
 
@@ -651,6 +663,8 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	 * lockdep key, because the writable file /sys/power/resume may call vfs
 	 * lookup helpers for arbitrary paths and readonly files can be read by
 	 * overlayfs from vfs helpers when sysfs is a lower layer of overalyfs.
+	 * (Note that regular sysfs attributes no longer run ->store() under
+	 * @of->mutex, but other kernfs users still do.)
 	 *
 	 * All three cases look the same.  They're supposed to
 	 * look that way and give @of->mutex different static lockdep keys.
@@ -666,10 +680,12 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	of->file = file;
 
 	/*
-	 * Write path needs to atomic_write_len outside active reference.
-	 * Cache it in open_file.  See kernfs_fop_write_iter() for details.
+	 * Write path needs atomic_write_len and write_unlocked outside
+	 * active reference.  Cache them in open_file.  See
+	 * kernfs_fop_write_iter() for details.
 	 */
 	of->atomic_write_len = ops->atomic_write_len;
+	of->write_unlocked = ops->write_unlocked;
 
 	error = -EINVAL;
 	/*
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index cd5bb0f9fee6d..71a7faf434073 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -132,7 +132,19 @@ static ssize_t sysfs_kf_read(struct kernfs_open_file *of, char *buf,
 	return min_t(ssize_t, count, len);
 }
 
-/* kernfs write callback for regular sysfs files */
+/*
+ * kernfs write callback for regular sysfs files.
+ *
+ * Regular sysfs files set .write_unlocked = true and are called without
+ * holding of->mutex. Sysfs ->store() maintains no per-open-file state, and
+ * concurrent opens already execute ->store() concurrently without
+ * serialization. Calling ->store() without of->mutex avoids circular
+ * locking dependencies when ->store() performs operations like path
+ * lookups or automounts while a generic VFS lock is held (such as a pipe
+ * lock during splice). Preallocated attributes still serialize buffer
+ * access via of->prealloc_mutex. Existing autofs and callback-owned lock
+ * dependencies remain outside this narrow change.
+ */
 static ssize_t sysfs_kf_write(struct kernfs_open_file *of, char *buf,
 			      size_t count, loff_t pos)
 {
@@ -229,11 +241,13 @@ static const struct kernfs_ops sysfs_file_kfops_ro = {
 
 static const struct kernfs_ops sysfs_file_kfops_wo = {
 	.write		= sysfs_kf_write,
+	.write_unlocked	= true,
 };
 
 static const struct kernfs_ops sysfs_file_kfops_rw = {
 	.seq_show	= sysfs_kf_seq_show,
 	.write		= sysfs_kf_write,
+	.write_unlocked	= true,
 };
 
 static const struct kernfs_ops sysfs_prealloc_kfops_ro = {
@@ -244,12 +258,14 @@ static const struct kernfs_ops sysfs_prealloc_kfops_ro = {
 static const struct kernfs_ops sysfs_prealloc_kfops_wo = {
 	.write		= sysfs_kf_write,
 	.prealloc	= true,
+	.write_unlocked	= true,
 };
 
 static const struct kernfs_ops sysfs_prealloc_kfops_rw = {
 	.read		= sysfs_kf_read,
 	.write		= sysfs_kf_write,
 	.prealloc	= true,
+	.write_unlocked	= true,
 };
 
 static const struct kernfs_ops sysfs_bin_kfops_ro = {
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 351a5101c8628..cbb09f9533e72 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -272,6 +272,7 @@ struct kernfs_open_file {
 	char			*prealloc_buf;
 
 	size_t			atomic_write_len;
+	bool			write_unlocked;
 	bool			mmapped:1;
 	bool			released:1;
 	const struct vm_operations_struct *vm_ops;
@@ -320,6 +321,16 @@ struct kernfs_ops {
 	 * ->prealloc.  Provide ->read and ->write with ->prealloc.
 	 */
 	bool prealloc;
+	/*
+	 * "write_unlocked" indicates that ->write() does not require
+	 * per-open-file serialization with of->mutex and can be called
+	 * concurrently for the same open file. Callbacks must handle
+	 * concurrent execution. Buffer access for preallocated attributes
+	 * is still protected by of->prealloc_mutex. Lock dependencies from
+	 * callers (such as pipe locks during splice) or within callbacks
+	 * remain outside this scope.
+	 */
+	bool write_unlocked;
 	ssize_t (*write)(struct kernfs_open_file *of, char *buf, size_t bytes,
 			 loff_t off);
 
-- 
2.53.0

