Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587123;
	b=ZjCx6bdTNWTZVlwOrYqv2JJoEEbnKfW4XHWECr2bbqHDqDD9g3EwaN4ySBx9xXrqzP8b
	 COLq4F7Y4uya6AYJLZ+LRlKiNBzbl33oohB8tL/RqnfwKBWuqQPg4o/7QlkgMtOpdOrer
	 LB2unt4F8/3HZmVP5lbvUgQv+GvaNnOYh6gTzasZSTIBSMjh9DxVHmxfox1Yvn6uBQL7t
	 +Xt0o8QR+xh2u2pXpfB9MSEEnyzv4IHiULf5WKDStbLeCN0gysCFePpEQHVLdLYHMuayV
	 PXEyD1vI2xv+VwJ1v2TUmFOVrjW0F5e+UzW9J0Xgd1ctBdcvAAIJwXiQz+wLPDEJdTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NqgNTIU8DzhUyVmfZ9IEslpzXfUEbYHbQzea+4YWsnA=;
	b=d78rnsOsdJT31S12DlkixmLUw3//bGyBDRdoG8xPWGN4VRRVaPPdv6DHyRinQwLQ83go
	 MolB2K/qLVu7e5E1RXcjqWzBkVFgAkzw/RPkXOgnjynqp8BZsEJMJpOz92YJeRsDEF+m6
	 hGvCLYJy/sV/XkzFUCwdqSLBld0ZPIkGncR42eomAB3FdCdu4n0p5jrB9eUKYRO9qhAll
	 v69UyTHHnJNeHg7u+QdEKArYCxCctaucx52E34x04mA5cxSjd6CJbNYG1klMP7xAuG7io
	 PrLbCcruqXDGx30XVwoiYpIFwgkIsdmKOaHbL5emjBrYdJ64haCdS7FRCXut1wRxp3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dsgd3ogS;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7C60A2601
	for <autofs@vger.kernel.org>; Wed, 21 Oct 2026 12:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA7C60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dsgd3ogS
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4322d310e7so89291766b.0
        for <autofs@vger.kernel.org>; Wed, 21 Oct 2026 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587122; x=1793191922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NqgNTIU8DzhUyVmfZ9IEslpzXfUEbYHbQzea+4YWsnA=;
        b=Dsgd3ogSlQcPBJBCZ31wb+xZztOMjZNuOOUcbagbQ8lgOSc/ZuMB0N+wT4pScjpfUl
         xyD4PivUQIXT6h8CaM2YqN8J4DrZaqBvZztxzIqIor1S5L96bi2FuWFpHhkAXZ76ItCk
         3Xh83I9s+Mar1lz5AUysvz0JrW21TslJ8PiJQVYWhYjjGCU8LFzEfOPs5qvX0FJ9aX4q
         s/83ztYY93krzbrXDYVgOEDc+qo//tw3EeVxdBxxvLU4WM4y41I8oTzxlW9lbeO3Mttr
         LgQRzm9rH/yOiGWqheyWUPMdlZyHkZW36wA27d+z/A+dXH7u76rYgTyZYXTjE7Aj/o5K
         5ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587122; x=1793191922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NqgNTIU8DzhUyVmfZ9IEslpzXfUEbYHbQzea+4YWsnA=;
        b=zZH2tmCXamXizmTNKzGPTPvH0hSDxC8/6S6Fsp0ve+i9KCH6gEuIi3DsBG2wU0vtxo
         cyMLYyBKF6/f7yxk/p38PjK5YpqtfXHJYuJUdrkS9Tw3Q91Q+J0U+4beBim3QqN7JtyJ
         2jW0nHFHgEE5HYTR7fcGGi6XGv2MbKpwJpYxCfSU+w3krpCGJIO2itTJ2pES4m5w/+kG
         yBLcitjObOYxtZPethu+YXnCcbvvAd1xWq7pZHtoS/i3LauticQWLdiTPCvHiXYq/n77
         nDnO268VPnA6KDJAMjI9ozgCJ29Ck0BJ82jUlp6JQTqnk3SgSIwh10+rA5D3dtpBjIUS
         a0bQ==
X-Forwarded-Encrypted: i=1; AKwUvBx09jivXo48saBs2Pp2rS4QeIBcJfOvJnjBufatoPzEMXPqVa5LH0ujqRkhSr6WdhhBRYlrRG8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZxbFmwWM3cX7zBxpQFOpqznROF0DR02JMtwZoHnbMiMa88GSl
	2hp36X7IZdrfl9UiMR0DtD7yKezjLflyoyged5df71Wd4UFQL32pMmG2
X-Gm-Gg: AYBFou2B79mQRKKNDjAyuzzB4savpUGK+Dk+UsvFSqsrU7NEuNusBybaDnGLFNPTlaH
	0WjIePKb6v26QskzSCAo8wISzfySgQ9F8X6vNxEj2UADLYdkxniSZ3N8Sm4jza6YXQYpV9FgjKb
	smaZQFy942INz7OWGUrAJlKRae0q4iWlopgBrfD4grJ45/puWnNMgPMu9MRzXnPzI/Ht9T5JXjE
	ByfEq0tvlT8FzsXeXIpoSFo+2hXtAKuj97ewqWfaE+q2ryFffmKviXiS1EBpXOSIQwoC7x7lWm5
	k4+mGGQnGXsPX0h0NZgXZm1hl1OXUrTdW1dfFWfhYJfxiGnpUD03fAXLxxbWnG9NLXj4pSfOQAa
	mGcdKKyj02d58kmTrF7LjyaWgDBomThn3ENNzYGoEww9KLuAZToV8PTCFxk3al5Sda6Y9kWSnpW
	BXzK/rujQZvgjFn5f4UvK/bD/m7qHL6fEEQfrPvbPQDzqamyTypKYv2rQlCQXXaLbBIfirliLKP
	vXe6LR04wACwqFJjVan6VGWjfs0XXSn+7HZoCUEtC/RdcHnsW9/QmjYbxXcZv5WTD8x+is/gAyq
	Hh8qVasQ1yip+EnLqcQ/SUPBZDtQRvznLhGyuzvHThp0pMAcq3LmOIw8pJzkdhWJTWKGsq1/faN
	O2B4LmKM15AGw+vbKC9rPyGfk8ASlTVj5AoncPoEQT6aad1DQ+UhwFG08l0+UBobZdL6zMc5Piu
	kR4aeIhKdt5t7sRYupoX7HTRI+
X-Received: by 2002:a17:907:9d1a:b0:c46:7462:6332 with SMTP id a640c23a62f3a-c46797a6203mr156125566b.37.1792587121409;
        Wed, 21 Oct 2026 05:52:01 -0700 (PDT)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4679004464sm73128366b.67.2026.10.21.05.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:52:00 -0700 (PDT)
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
Subject: [PATCH 2/2] autofs: do not wait for the daemon while splice holds a pipe
Date: Wed, 21 Oct 2026 14:51:50 +0200
Message-ID: <fec81a3d24a29d4db2b165e95425330e41a68d98.1792577179.git.krystianmkaniewski@gmail.com>
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

splice holds the mutex of a pipe while it calls ->write_iter() of the
target file in iter_file_splice_write() or ->splice_read() of the source
file in splice_file_to_pipe(). When such a callback looks up a path in an
autofs mount, autofs sends a request through its daemon pipe and waits
for the daemon. A write to /sys/power/resume that comes from splice() does
this, so lockdep still reports &pipe->mutex --> &sbi->pipe_mutex -->
&pipe->mutex after of->mutex is gone from the sysfs store path. When the
spliced pipe is the daemon pipe itself, the task can wait for the mutex
that it already holds, which SIGKILL does not end, or wait for a daemon
that cannot read its pipe.

Mark the task while splice runs such a callback with a pipe really locked
(pipe->files set, as in pipe_lock()), and make autofs return -EAGAIN in
that context instead of sending a mount request or waiting for a pending
mount or expire. A new mount is refused before AUTOFS_INF_PENDING is set,
because another lookup that sees the flag would send the request instead.
The short wait for expire selection does not depend on the daemon and is
kept. RCU walks, lookups that need no request and all other callers keep
their behavior, and a child does not inherit the mark.

A lookup from such a callback that needs an automount now fails with
-EAGAIN instead of waiting for the daemon. This affects splice() from a
pipe into a file whose write handler looks up a path under an autofs
mount that is not mounted yet, for example /sys/power/resume. sendfile()
into a file goes through the private pipe of the task, which is never
locked, and keeps its behavior.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
 fs/autofs/expire.c    |  6 ++++++
 fs/autofs/root.c      | 28 ++++++++++++++++++++++++++--
 fs/splice.c           | 13 ++++++++++++-
 include/linux/sched.h |  2 ++
 kernel/fork.c         |  1 +
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 5c2d459e1e484..9f3bf1473acd4 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -514,6 +514,12 @@ int autofs_expire_wait(const struct path *path, int rcu_walk)
 	}
 	if (state & AUTOFS_INF_EXPIRING) {
 		spin_unlock(&sbi->fs_lock);
+		/*
+		 * The expire waits for the daemon, which may need a pipe that
+		 * the splice of this task holds. Refuse instead of waiting.
+		 */
+		if (unlikely(current->in_splice_pipe_callback))
+			return -EAGAIN;
 
 		pr_debug("waiting for expire %p name=%pd\n", dentry, dentry);
 
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index b36439f4521eb..c4e04998a2345 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -252,6 +252,8 @@ static int autofs_mount_wait(const struct path *path, bool rcu_walk)
 	if (ino->flags & AUTOFS_INF_PENDING) {
 		if (rcu_walk)
 			return -ECHILD;
+		if (unlikely(current->in_splice_pipe_callback))
+			return -EAGAIN;
 		pr_debug("waiting for mount name=%pd\n", path->dentry);
 		status = autofs_wait(sbi, path, NFY_MOUNT);
 		pr_debug("mount wait done status=%d\n", status);
@@ -263,10 +265,18 @@ static int autofs_mount_wait(const struct path *path, bool rcu_walk)
 	return status;
 }
 
+static bool autofs_expire_wait_blocked(int status)
+{
+	/* A marked caller is refused before a daemon can return a status. */
+	return status == -EAGAIN &&
+	       unlikely(current->in_splice_pipe_callback);
+}
+
 static int do_expire_wait(const struct path *path, bool rcu_walk)
 {
 	struct dentry *dentry = path->dentry;
 	struct dentry *expiring;
+	int status;
 
 	expiring = autofs_lookup_expiring(dentry, rcu_walk);
 	if (IS_ERR(expiring))
@@ -280,7 +290,11 @@ static int do_expire_wait(const struct path *path, bool rcu_walk)
 		 * be quite complete, but the directory has been removed
 		 * so it must have been successful, just wait for it.
 		 */
-		autofs_expire_wait(&this, 0);
+		status = autofs_expire_wait(&this, 0);
+		if (autofs_expire_wait_blocked(status)) {
+			dput(expiring);
+			return status;
+		}
 		autofs_del_expiring(expiring);
 		dput(expiring);
 	}
@@ -359,6 +373,8 @@ static struct vfsmount *autofs_d_automount(struct path *path)
 	 * the mount.
 	 */
 	status = do_expire_wait(path, 0);
+	if (autofs_expire_wait_blocked(status))
+		return ERR_PTR(-EAGAIN);
 	if (status && status != -EAGAIN)
 		return NULL;
 
@@ -405,6 +421,11 @@ static struct vfsmount *autofs_d_automount(struct path *path)
 				goto done;
 			}
 		}
+		/* Do not publish PENDING without issuing its mount request. */
+		if (unlikely(current->in_splice_pipe_callback)) {
+			spin_unlock(&sbi->fs_lock);
+			return ERR_PTR(-EAGAIN);
+		}
 		ino->flags |= AUTOFS_INF_PENDING;
 		spin_unlock(&sbi->fs_lock);
 		status = autofs_mount_wait(path, 0);
@@ -442,8 +463,11 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 	}
 
 	/* Wait for pending expires */
-	if (do_expire_wait(path, rcu_walk) == -ECHILD)
+	status = do_expire_wait(path, rcu_walk);
+	if (status == -ECHILD)
 		return -ECHILD;
+	if (autofs_expire_wait_blocked(status))
+		return -EAGAIN;
 
 	/*
 	 * This dentry may be under construction so wait on mount
diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1ab..1756a8579776f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -686,6 +686,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		struct kiocb kiocb;
 		struct iov_iter from;
 		unsigned int head, tail;
+		bool was_in_splice_pipe_callback;
 		size_t left;
 		int n;
 
@@ -733,7 +734,11 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
 		init_sync_kiocb(&kiocb, out);
 		kiocb.ki_pos = sd.pos;
+		was_in_splice_pipe_callback = current->in_splice_pipe_callback;
+		if (pipe->files)
+			current->in_splice_pipe_callback = true;
 		ret = out->f_op->write_iter(&kiocb, &from);
+		current->in_splice_pipe_callback = was_in_splice_pipe_callback;
 		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
@@ -1282,12 +1287,18 @@ ssize_t splice_file_to_pipe(struct file *in,
 			    loff_t *offset,
 			    size_t len, unsigned int flags)
 {
+	bool was_in_splice_pipe_callback;
 	ssize_t ret;
 
 	pipe_lock(opipe);
 	ret = wait_for_space(opipe, flags);
-	if (!ret)
+	if (!ret) {
+		was_in_splice_pipe_callback = current->in_splice_pipe_callback;
+		if (opipe->files)
+			current->in_splice_pipe_callback = true;
 		ret = do_splice_read(in, offset, opipe, len, flags);
+		current->in_splice_pipe_callback = was_in_splice_pipe_callback;
+	}
 	pipe_unlock(opipe);
 	if (ret > 0)
 		wakeup_pipe_readers(opipe);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 705970d07614f..3ffa284976cc6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1025,6 +1025,8 @@ struct task_struct {
 	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
+	/* A file callback is running while splice holds a pipe mutex. */
+	unsigned			in_splice_pipe_callback:1;
 #ifndef TIF_RESTORE_SIGMASK
 	unsigned			restore_sigmask:1;
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 5ef413368912e..d774e5092766c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2133,6 +2133,7 @@ __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
+	p->in_splice_pipe_callback = 0;
 	/*
 	 * Must run before the first fallible op, so error paths never
 	 * free the parent's ret_stack.
-- 
2.53.0

