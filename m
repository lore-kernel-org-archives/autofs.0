Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6BEAE7;
	Thu, 18 Sep 2025 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197016; cv=none; b=sqGOZywK+DPXURUIh6EwgXjF48I+poNPQukzxYf6MG9r/QxFzaRIG8iWTQRHCLXOIreaoBQvqk3cNa2gMb1hTyftKJG3cjqk0htpedWMOp2diXFNooC8g2K/VF0bMWw0qH6ou4WQ+V7/VMkIoHq3Pp02+Xhqa7wtkstKE0T8AuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197016; c=relaxed/simple;
	bh=djZwhXTXO1j+sAGYbYim9XwDU0iMuG04gix6QwDmWrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jp2oMYoJNhWmb7cMvV2xX5HXWV8ij2q39hVGq1gp7pRO4lqFKYLOkkfZ6Lz5oOuz2vbmixOmjuL+bKav5KkJwHmQY5QA/k8lFR4vt0h7eP5NBO5o5rlcPEMKfq5oe9yOzc0+3nqN/3DTesjYSAlFz5L/aM007nrraCnnNij2Lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gut1Ae6f; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gut1Ae6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DG
	nrH6XXEa39c8eaC4+tK2QhtJ3JlgbwfT2F0PLB2sE=; b=Gut1Ae6fhg7PVI/iF1
	SCLalvk/kNIJ9H7MxvXpgHNBjLu4V1H4rcVhVE9oT+fYPCdT69VxlsxVvOPGsGwP
	fuXUjjehSPA4Syzk+rdngLkGBYcAubgMpDo3BwQP8USmYOWoaSkjyHXNGFu3+75k
	e7cp56HKz//nG5FkSfOGB/1S4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnRxL69MtozWWPDQ--.64389S2;
	Thu, 18 Sep 2025 20:03:08 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: raven@themaw.net,
	brauner@kernel.org
Cc: autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhou Yuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH] autofs: avoid memleak when autofs_fill_super() fails
Date: Thu, 18 Sep 2025 20:03:04 +0800
Message-Id: <20250918120304.1578406-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnRxL69MtozWWPDQ--.64389S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyUAr48uw48Aw43Xr4xJFb_yoWrKFWrpF
	43AFy8C3ykJr1UGFs7tFs0qr1fKas3CFy7Gr93W348Ary5Gr4DtF47Jr13XFWxArWkJFyS
	qrsFyrWYkr9Fy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j01v3UUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiEQDMJmjL8uxRjAAAsb

From: Zhou Yuhang <zhouyuhang@kylinos.cn>

When autofs_fill_super() fails, kmemleak may detect memleak
with output similar to the following:

unreferenced object 0xffff8c3e83e1abe0 (size 616):
  comm "a.out", pid 1451, jiffies 4294715113
  hex dump (first 32 bytes):
    80 11 04 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace (crc f623388e):
    kmem_cache_alloc_lru_noprof+0x32c/0x440
    alloc_inode+0x84/0x110
    create_pipe_files+0x2b/0x290
    do_pipe2+0x56/0x110
    __x64_sys_pipe2+0x18/0x20
    do_syscall_64+0x7f/0x2c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8c3e8cf5e000 (size 72):
  comm "a.out", pid 1451, jiffies 4294715113
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 494f173f):
    kmem_cache_alloc_noprof+0x31f/0x410
    security_inode_alloc+0x45/0x140
    inode_init_always_gfp+0x20a/0x240
    alloc_inode+0x42/0x110
    create_pipe_files+0x2b/0x290
    do_pipe2+0x56/0x110
    __x64_sys_pipe2+0x18/0x20
    do_syscall_64+0x7f/0x2c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

The memleak occurs because when autofs_fill_super() fails,
the AUTOFS_SBI_CATATONIC flag is not cleared, which prevents
autofs_kill_sb()->autofs_catatonic_mode() from cleaning up
the pipe resources. Additionally, fc->s_fs_info has already been
set to NULL in sget_fc(), so autofs_free_fc() cannot clean up the
pipe resources either. Therefore, add explicit cleanup of pipe
resources in the error paths of autofs_fill_super() to prevent memleak.

Signed-off-by: Zhou Yuhang <zhouyuhang@kylinos.cn>
---
The following test code can reproduce the issue:

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

int main() {
    int pipefd[2];
    if (pipe(pipefd) == -1) {
        perror("pipe creation failed");
        return 1;
    }
    printf("Created anonymous pipe: read fd=%d, write fd=%d\n", pipefd[0], pipefd[1]);

    int dup_write_fd = dup(pipefd[1]);
    if (dup_write_fd == -1) {
        perror("dup write fd failed");
        close(pipefd[0]);
        close(pipefd[1]);
        return 1;
    }
    printf("Duplicated write fd: %d\n", dup_write_fd);

    const char *mount_point = "/mnt/autofs_test";
    if (mkdir(mount_point, 0755) == -1 && errno != EEXIST) {
        perror("mkdir mount point failed");
        close(pipefd[0]);
        close(pipefd[1]);
        close(dup_write_fd);
        return 1;
    }

    char opts[128];
    snprintf(opts, sizeof(opts), "fd=%d,pgrp=99999", dup_write_fd);
    printf("Mount options: %s\n", opts);

    int ret = mount("none", mount_point, "autofs", 0, opts);
    if (ret == -1) {
        perror("mount system call failed");
    } else {
        printf("Mount succeeded (unexpected)\n");
        umount(mount_point);
    }

    close(dup_write_fd);
    close(pipefd[1]);
    close(pipefd[0]);
    printf("Closed all fds\n");

    return ret;
}
---
 fs/autofs/inode.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index f5c16ffba013..7a2ae9d33096 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -303,6 +303,7 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 	struct autofs_sb_info *sbi = s->s_fs_info;
 	struct inode *root_inode;
 	struct autofs_info *ino;
+	int ret = -ENOMEM;
 
 	pr_debug("starting up, sbi = %p\n", sbi);
 
@@ -319,11 +320,11 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 	 */
 	ino = autofs_new_ino(sbi);
 	if (!ino)
-		return -ENOMEM;
+		goto out;
 
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
 	if (!root_inode)
-		return -ENOMEM;
+		goto out_free_ino;
 
 	root_inode->i_uid = ctx->uid;
 	root_inode->i_gid = ctx->gid;
@@ -332,16 +333,17 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 
 	s->s_root = d_make_root(root_inode);
 	if (unlikely(!s->s_root)) {
-		autofs_free_ino(ino);
-		return -ENOMEM;
+		goto out_free_ino;
 	}
 	s->s_root->d_fsdata = ino;
 
 	if (ctx->pgrp_set) {
 		sbi->oz_pgrp = find_get_pid(ctx->pgrp);
-		if (!sbi->oz_pgrp)
-			return invalf(fc, "Could not find process group %d",
+		if (!sbi->oz_pgrp) {
+			ret = invalf(fc, "Could not find process group %d",
 				      ctx->pgrp);
+			goto out;
+		}
 	} else
 		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
 
@@ -357,6 +359,16 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 
 	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 	return 0;
+
+out_free_ino:
+	autofs_free_ino(ino);
+out:
+	if (sbi->pipe) {
+		fput(sbi->pipe);
+		sbi->pipe = NULL;
+		sbi->pipefd = -1;
+	}
+	return ret;
 }
 
 /*
-- 
2.27.0

