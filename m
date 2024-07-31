Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF9F1B1425;
	Wed, 31 Jul 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431484; cv=none; b=M17WVeejz15RhGh88M/Qq6hyxIJ4yO1kJk4tr9Kx8trrr40pjLrXgz6IFMqyhbeccHUgo5E+klqQzTSQf8JEU+l2v4OQ9g7Cq0RS53sbGg2+fnIY06Xpf7aihIZpweVFW5O5EXM7jeU/lC3GYZgqEZYj0Jra5JeQgkzj4oFQmFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431484; c=relaxed/simple;
	bh=nwwox7wiK60TjQf4dnqdHdDLigJoZ2vLTf1McgQxlUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWwfL2zrDJRwvhpGDv5FZnfQZr12hVlAOsR2WF0P1ld2S95tlxgrvromoYmQB7UwkpF7ymCUkRpejAtmFkPvRkG2IMeKMMGDgpX5GYqI05azksoaun6v5mTGTIppZzRer3S04yltJ6eQMrqfjrUAbY6ClYwNDrADm/Lug25gmvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=wi3lp5NS; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="wi3lp5NS"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WYst83HGXz9sbh;
	Wed, 31 Jul 2024 15:11:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722431472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ64E/5nYDkIveNsG21KEe7BJushDixGGpF55h3Bonk=;
	b=wi3lp5NSpCLCDDduDAlP6r5I00LJflSASHMSR2aqTReEs24dzJNh2t1dF5Pf3TiW4G7IsL
	R7dcXwiVTh/24sOyUUTihJDOr52Sl7ZJmthd7S9kIQxujRHVKzK7C8kT4PfA5FOwKdupU+
	vk+lkSkYAGWN27x/knFWfEiF/2t+NwcjViPD1kaTOwF4jCDg8gBs8UkT54nFyy0gWUg6qc
	+uc1wQC7R3Tz7CRL+J+9bfZPVnV6nWif0waspS0as9nSAIuTJx8ImYM1t9BWvQ08M1DYpo
	CvR64xRGX0n7jACdxctZRo+sodLqZoMd0mgXCH9k72RAq7WZxlbR6scfOZEheg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 31 Jul 2024 23:10:28 +1000
Subject: [PATCH v2 2/2] coda: use param->file for FSCONFIG_SET_FD
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-fsconfig-fsparam_fd-fixes-v2-2-e7c472224417@cyphar.com>
References: <20240731-fsconfig-fsparam_fd-fixes-v2-0-e7c472224417@cyphar.com>
In-Reply-To: <20240731-fsconfig-fsparam_fd-fixes-v2-0-e7c472224417@cyphar.com>
To: Ian Kent <raven@themaw.net>, Bill O'Donnell <bodonnel@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>, 
 coda@cs.cmu.edu, Eric Sandeen <sandeen@redhat.com>, 
 David Howells <dhowells@redhat.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 codalist@coda.cs.cmu.edu, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2629; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=nwwox7wiK60TjQf4dnqdHdDLigJoZ2vLTf1McgQxlUk=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaStMr/NMrdn2aTmilCz9wvy+Lm/p8Yyzdie9257pCPTb
 ZZ7pxzLO0pZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBE7p5h+MPx+Ufhr7e7gx3c
 Wd1m5BtMWBJm823/rNWZcryNdXsONBUy/K/gOGSzJbTmw09Nh2XiV1yZWmeIbc15JxTdVmZ6Si5
 LlAkA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4WYst83HGXz9sbh

While the old code did support FSCONFIG_SET_FD, there's no need to
re-get the file the fs_context infrastructure already grabbed for us.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/coda/inode.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 6898dc621011..6896fce122e1 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -119,31 +119,43 @@ static const struct fs_parameter_spec coda_param_specs[] = {
 	{}
 };
 
-static int coda_parse_fd(struct fs_context *fc, int fd)
+static int coda_set_idx(struct fs_context *fc, struct file *file)
 {
 	struct coda_fs_context *ctx = fc->fs_private;
-	struct fd f;
 	struct inode *inode;
 	int idx;
 
-	f = fdget(fd);
-	if (!f.file)
-		return -EBADF;
-	inode = file_inode(f.file);
+	inode = file_inode(file);
 	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
-		fdput(f);
-		return invalf(fc, "code: Not coda psdev");
+		return invalf(fc, "coda: Not coda psdev");
 	}
-
 	idx = iminor(inode);
-	fdput(f);
-
 	if (idx < 0 || idx >= MAX_CODADEVS)
 		return invalf(fc, "coda: Bad minor number");
 	ctx->idx = idx;
 	return 0;
 }
 
+static int coda_parse_fd(struct fs_context *fc, struct fs_parameter *param,
+			 struct fs_parse_result *result)
+{
+	struct file *file;
+	int err;
+
+	if (param->type == fs_value_is_file) {
+		file = param->file;
+		param->file = NULL;
+	} else {
+		file = fget(result->uint_32);
+	}
+	if (!file)
+		return -EBADF;
+
+	err = coda_set_idx(fc, file);
+	fput(file);
+	return err;
+}
+
 static int coda_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct fs_parse_result result;
@@ -155,7 +167,7 @@ static int coda_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	switch (opt) {
 	case Opt_fd:
-		return coda_parse_fd(fc, result.uint_32);
+		return coda_parse_fd(fc, param, &result);
 	}
 
 	return 0;
@@ -167,6 +179,7 @@ static int coda_parse_param(struct fs_context *fc, struct fs_parameter *param)
  */
 static int coda_parse_monolithic(struct fs_context *fc, void *_data)
 {
+	struct file *file;
 	struct coda_mount_data *data = _data;
 
 	if (!data)
@@ -175,7 +188,11 @@ static int coda_parse_monolithic(struct fs_context *fc, void *_data)
 	if (data->version != CODA_MOUNT_VERSION)
 		return invalf(fc, "coda: Bad mount version");
 
-	coda_parse_fd(fc, data->fd);
+	file = fget(data->fd);
+	if (file) {
+		coda_set_idx(fc, file);
+		fput(file);
+	}
 	return 0;
 }
 

-- 
2.45.2

