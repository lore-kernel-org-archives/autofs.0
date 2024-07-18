Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C261422AD;
	Thu, 18 Jul 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313313; cv=none; b=qfwUURNKqUvANqxIMEZLNcMrIBKrQxU/jH9VH61kqPBm09cutI9guQzYbepQooUo6s2ohqcKU0lN3w/LOxusmzax6FVaXUgUPYa8qMmBcv0Nhz/Horh1+WkMyp28sVjYAi2JNNZ17QQEH7UthDaKYT3z7v6vrItO48zT9pH5LdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313313; c=relaxed/simple;
	bh=Jr28ONTGEGZ3llmBJFJ08PD+m7WITrYvPmt5Q25QSjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0wGyvkls1jipqzCz/uyCONQAUeAS4LZxABVfVU/aFT/zryBYNtLTtCLY0ChaDxEnlxGtLAe5fQiSHlkofVcmEtK1CaMo6QSESsCHVqFdgPHiG/KYhNWsm9VOFL6b2mCyfjE2vt5C8mQprjli0wteQ6g7cSHfzpbbxmE7ijrcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=VnGYqHbU; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="VnGYqHbU"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WPwM00pWwz9sTY;
	Thu, 18 Jul 2024 16:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1721313308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8TGL2R+w47tHxEFLpwjFBSwDP9Gz+5DRz2BodXc/7w=;
	b=VnGYqHbUrwfjP50NAyDvmrSbDzhAvXdSNgOOTcMKw1VO1zdPqHUOYVM5veajyQP4n4zLnH
	25jKaMWDxUEwBO6DGQBLDaEpPukqAps23Sw87RnJuGT5tfVeYlcsdm3C+rO7T9KBpZkScT
	FSPbMAzbjpAb8HeqrlsebwTdaVOchayoEceNiRR5v4MhZvnRYKVAxJXX2V64OGQvE5NxtJ
	653+YLvb95USyLZ3iTFkKbpfOGtf2dCR+AZ0FcHAlgqQu76H7Hv1OBYDsiJg8IDPF0Mgvc
	bIyAX6QvmoUFlWSa17kRQ4XnhEv8VsaDO2opp3pA/HUznSPR4hSbqWUvKDg0jg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 19 Jul 2024 00:34:23 +1000
Subject: [PATCH 2/2] coda: support FSCONFIG_SET_FD for fd mount flag
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-fsconfig-fsparam_fd-fixes-v1-2-7ccd315c2ad4@cyphar.com>
References: <20240719-fsconfig-fsparam_fd-fixes-v1-0-7ccd315c2ad4@cyphar.com>
In-Reply-To: <20240719-fsconfig-fsparam_fd-fixes-v1-0-7ccd315c2ad4@cyphar.com>
To: Ian Kent <raven@themaw.net>, Bill O'Donnell <bodonnel@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>, 
 coda@cs.cmu.edu, Eric Sandeen <sandeen@redhat.com>, 
 David Howells <dhowells@redhat.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 codalist@coda.cs.cmu.edu, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Jr28ONTGEGZ3llmBJFJ08PD+m7WITrYvPmt5Q25QSjI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTN1GD+OUWzb6v3ig13jtrrtyzN3/lyx/VpaXtW71y+w
 KFqluavFx2lLAxiXAyyYoos2/w8QzfNX3wl+dNKNpg5rEwgQxi4OAVgIjksjAzzNsffMjn35qK3
 gNSWHh5PQ3PfYxN4zF8ZTRV/3rHdwImB4Z9Ww4UXE6wzvH8fns6h7LHG9drTZxP0H0x6kjzpYdT
 c2TbsAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4WPwM00pWwz9sTY

It's possible for users to pass file descriptors directly using
FSCONFIG_SET_FD, but the old version only supported the string-based
passing of file descriptors.

Fixes: 5916f439f2eb ("Convert coda to use the new mount API")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/coda/inode.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 6898dc621011..df477a7218a2 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -122,21 +122,27 @@ static const struct fs_parameter_spec coda_param_specs[] = {
 static int coda_parse_fd(struct fs_context *fc, int fd)
 {
 	struct coda_fs_context *ctx = fc->fs_private;
-	struct fd f;
+	struct file *file;
 	struct inode *inode;
 	int idx;
 
-	f = fdget(fd);
-	if (!f.file)
+	if (param->type == fs_value_is_file) {
+		file = param->file;
+		param->file = NULL;
+	} else {
+		file = fget(result->uint_32);
+	}
+	if (!file)
 		return -EBADF;
-	inode = file_inode(f.file);
+
+	inode = file_inode(file);
 	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
-		fdput(f);
+		fput(file);
 		return invalf(fc, "code: Not coda psdev");
 	}
 
 	idx = iminor(inode);
-	fdput(f);
+	fput(file);
 
 	if (idx < 0 || idx >= MAX_CODADEVS)
 		return invalf(fc, "coda: Bad minor number");

-- 
2.45.2

