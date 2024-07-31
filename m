Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC532233B;
	Wed, 31 Jul 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431912; cv=none; b=d7T6871mJrI35rEE4Vh7m+6tXeV4xwVBTpX9LCau8XWm4g3L7fgqy621H2iMBR/9vfqMJKzQviaJ57K55oFRm9lpPfioS6q2rwCMBicb+L6R2I+eZOY0eZ++l5Vn7YJeA0GwE8TWAqUehV3ld/k0rNl07NNAmiWwSdFjAqcBKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431912; c=relaxed/simple;
	bh=/VEJGnSWOSqDnDdrzEuu/8iETN3Z7ba7UQDPiaLQA8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBRyk2o4KC4A7FrpIDA9O+ppCOMWKd7A7JtXRyWsvjWFvhCyRYlHw5hZefrQR1WkdDtCoLt/Ib2ZvwOR8GkhT6iHhQtDTlGkj2wVOtLpYNL0AvsQNBEEV7p3JmnZmuPLECy4fJA4GMfv3Ya6FsPtr+FDh6d6qj7H+zEyis1++RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ih7psWOs; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ih7psWOs"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WYst339Njz9sdW;
	Wed, 31 Jul 2024 15:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722431467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoyUMOZouuzF91cuExshplUZTqo7hVxyZamaN+f7aVY=;
	b=ih7psWOsbTyFlQ5ybfru88YNQybHXeRobEAMQOWOYxZ8P4FYmozGNu+K6vPx3H/PxBFksy
	j83mo7cl8rfQ90vZcl2WESDe/uUqOLQhIVGZBBcV0ajpkUydoUU8pn0fnevwyrkJ6MXFg/
	ovbNCmF78tsbtgwsCki9DTIvi1RK5s1DAKTXKsuDtJZA7hxg9iFtWq8gsiEmbBSA4BfeZA
	A0OtYsHyvEFRZ5KbO8ddXr+3xxaLWwEKOZOALYjevekqJ9Yf8Lh5DL9K8HEXihucyE4gF/
	GtjFTFpxZ46aYqNiI4NqunLV6FgWpjS2GEiwbBrUoUqr/ywQYh9N46aPNddwhA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 31 Jul 2024 23:10:27 +1000
Subject: [PATCH v2 1/2] autofs: fix missing fput for FSCONFIG_SET_FD
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-fsconfig-fsparam_fd-fixes-v2-1-e7c472224417@cyphar.com>
References: <20240731-fsconfig-fsparam_fd-fixes-v2-0-e7c472224417@cyphar.com>
In-Reply-To: <20240731-fsconfig-fsparam_fd-fixes-v2-0-e7c472224417@cyphar.com>
To: Ian Kent <raven@themaw.net>, Bill O'Donnell <bodonnel@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>, 
 coda@cs.cmu.edu, Eric Sandeen <sandeen@redhat.com>, 
 David Howells <dhowells@redhat.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 codalist@coda.cs.cmu.edu, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=/VEJGnSWOSqDnDdrzEuu/8iETN3Z7ba7UQDPiaLQA8E=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaStMr/94vuiyZM363xQ7bwUsDxywRnGV95PQz5I+U14J
 T3XX81wZkcpC4MYF4OsmCLLNj/P0E3zF19J/rSSDWYOKxPIEAYuTgGYiIckI8OkBc6HDomlc6VJ
 OaaI7Wb3+RZ3a8uF1g7J3m12IdfbcgIZGQ59kbGL5fKJOaFZUvbga/6JJcl+W63mevVMCZ93XvG
 KBh8A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

If you pass an fd using FSCONFIG_SET_FD, autofs_parse_fd() "steals" the
param->file and so the fs_context infrastructure will not do fput() for
us.

Fixes: e6ec453bd0f0 ("autofs: convert autofs to use the new mount api")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/autofs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index cf792d4de4f1..64faa6c51f60 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -172,8 +172,7 @@ static int autofs_parse_fd(struct fs_context *fc, struct autofs_sb_info *sbi,
 	ret = autofs_check_pipe(pipe);
 	if (ret < 0) {
 		errorf(fc, "Invalid/unusable pipe");
-		if (param->type != fs_value_is_file)
-			fput(pipe);
+		fput(pipe);
 		return -EBADF;
 	}
 

-- 
2.45.2

