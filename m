Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620732;
	b=5nJ3l/k54PIxdLz2SU0xmSfO6Gw9lnbgqVzC+CFpS6DPG1mFfVluxIwdViBf59fYwg8e
	 JP9WIQqSk2HVY9fmhzumAKBGs4ncHh6sxNhoJvyK05JUA0krA9V+s6FlHFL6aA2kBUrko
	 lumb9t/AyezaEASMtYFdwEfK8nlj0Uz3PcPy457bTP5ff5MqocDPWm4f1u3IhD9/7l5lm
	 bIXNIKbCMb0/dPBN1wadacEH8edldv6YQY0aB7Kt3V6KgkxNvEQ3ncnDRvSGLOrQwtYPd
	 pSTg1DEYZRkSrd6T4iAxiUzWbx160BgFFFL2OdX4CQ0gHlQTquIzwlHkQQ9nfwbhz8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620732;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=/pLmJVDdGbo+4BMfe8VnGi7WrHLoSLGiOnENBxiAZuQ=;
	b=dS2ZmhtGhWlBqXTakfhG3Otp2VwvLNNiEJM+3zDbZhjITwccAKbCgXolTItoAoqIg4yG
	 BxiYnVNdUd+OP82rIJJHQG3hFlOLi2h1beNKDPcSZ7Nv1y6zvp6ei+fLpwMc3mr/lyFfG
	 FwVlNFcN5QhSvakDgxO5vnSpP1H9X90WC0qYZir4il0aD6SyOTKqAXlDefcgmMAlpWrYg
	 Gzqh0b/5uIYblXdNLZadBPSoHG2xL5zWIOTAkyRdT65IZYGGSJbA7QYbOo2naQygBWF4B
	 8AS8YJHk2n8qHJ4Aafz5IExdLWLRhbyPF6mMDAxEnXhzzHdfw1juRxo6WqLVoMWfe+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=Hi5rosUO;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65160A2609;
	Mon,  2 Nov 2026 11:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A65160A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=Hi5rosUO
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b2356;
	Mon, 2 Nov 2026 19:58:48 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org
Cc: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071772.29269.3108893293689933954@stu.pku.edu.cn>
Subject: [PATCH] autofs: pin the pipe while showing mount options
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c205bc503a2kunmab045f0fe84f5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSEhLVh0dHx5PHxhOQhhLSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=Hi5rosUOjnTUUmzeqZhDHZrkvHEK7MRs6ZQaBCvSZ9Ndfxp8bZiAzMRf1IlwlmIuKBpISY56jMku37Uy6LWQ7qW01MWpNjCgKjIYycavLe9sAvMpSubWu+PsS8zyAH70phLLkAM1tNzWjMy1oNjb0pBSyTzdSiDweaiHA6uRKx4=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=/pLmJVDdGbo+4BMfe8VnGi7WrHLoSLGiOnENBxiAZuQ=;
	h=date:mime-version:subject:message-id:from;

With CONFIG_CHECKPOINT_RESTORE enabled, autofs_show_options() checks
sbi->pipe and dereferences it without wq_mutex or a file reference.  A
concurrent AUTOFS_IOC_CATATONIC can drop the final pipe reference and
clear sbi->pipe between the check and file_inode(), leaving show_options()
to read a freed pipe inode.

KASAN reports:

  BUG: KASAN: slab-use-after-free in autofs_show_options
  Read of size 8
  autofs_show_options
  statmount_string
  __do_sys_statmount

Take a file reference while holding wq_mutex and use that reference when
printing pipe_ino.

The patched kernel completed 500,000 teardown-versus-statmount cycles on
each of two boots without a KASAN report.

Fixes: c83aa55d0bb7 ("autofs: show pipe inode in mount options")
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 fs/autofs/inode.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 066c16f2ea569..8d8551b07b48e 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -68,6 +68,9 @@ static int autofs_show_options(struct seq_file *m, struct d=
entry *root)
 {
 	struct autofs_sb_info *sbi =3D autofs_sbi(root->d_sb);
 	struct inode *root_inode =3D d_inode(root->d_sb->s_root);
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	struct file *pipe;
+#endif
=20
 	if (!sbi)
 		return 0;
@@ -95,10 +98,17 @@ static int autofs_show_options(struct seq_file *m, struct=
 dentry *root)
 	if (sbi->flags & AUTOFS_SBI_IGNORE)
 		seq_puts(m, ",ignore");
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	if (sbi->pipe)
-		seq_printf(m, ",pipe_ino=3D%llu", file_inode(sbi->pipe)->i_ino);
-	else
+	mutex_lock(&sbi->wq_mutex);
+	pipe =3D sbi->pipe;
+	if (pipe)
+		get_file(pipe);
+	mutex_unlock(&sbi->wq_mutex);
+	if (pipe) {
+		seq_printf(m, ",pipe_ino=3D%llu", file_inode(pipe)->i_ino);
+		fput(pipe);
+	} else {
 		seq_puts(m, ",pipe_ino=3D-1");
+	}
 #endif
 	return 0;
 }
--=20
2.39.5 (Apple Git-154)
