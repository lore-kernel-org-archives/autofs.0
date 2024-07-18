Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C10413F45F;
	Thu, 18 Jul 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313312; cv=none; b=rsBdSynrOZAXcBiBrQuAiZuYeQ2A5i+ZdAk/Xi9fQzTKNyDfySqGQVskiImPK+MUr2CQv0Y6vKzo/eyXUETLsekM5X5QDVKdMD/zAcaBR3ce9rYbYqDu+IFC4ROXvZgjM2tSZcSRF1miaojU72iZ0A8w79SClgtKdeXzIBpfR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313312; c=relaxed/simple;
	bh=Og2rH2Ec5QXj9Xm/LggRpPHnBxddnkJm4+HqYoQ+8a0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmu30GVCMejBcmiNFlapX8EoQWhqOAK5bUpx9oz6Z5uG5jhXWcHi43jLWbckBRBEmNUuDrVCwkNOeiprM8IaUBvv4pwmBxwS32anHf41IIzodV80/pSGnMurIQ8i4XiLwMy2ft74jJzbJx9w1iwZDXOkAbGFzLOgiMugTCY5zuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=V27LSiby; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="V27LSiby"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WPwLs4NpFz9sWS;
	Thu, 18 Jul 2024 16:35:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1721313301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJITjEONjT5NzvI1GMVH0WcRq8I792PPdUUYc5oImlk=;
	b=V27LSibyIC9G7tIBuej90Nw+29H4U4fVy5rwjwKJ7pAUu83l9PyCP6cKgJ+YNorIEAaKHr
	5HLlmL6gwBvaNQqwt/nzbaCvCsGkM/SNjbOi2OP+svh+IBt8ulLX+wuAfqr7hgL1dq5VWP
	Xb+nZidh8NPRL5Ighmub2tCTu7piVy3EoIIV5bmvcH19S+tTnYFKwNEwHJGheCCNafpMU9
	hwiTfr6Hapluamrp8XbeqSY3wXkGBhhNafM0vR6QDuud1uhwcWZGNLn0nd/etLytU5mKwB
	SHGB0mYZo961sG4E1eVHlJh8OWlGaLdQ8Pym6Jb3Xhp5cGbe0iP8ZYxoXi3eLw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 19 Jul 2024 00:34:22 +1000
Subject: [PATCH 1/2] autofs: fix missing fput for FSCONFIG_SET_FD
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-fsconfig-fsparam_fd-fixes-v1-1-7ccd315c2ad4@cyphar.com>
References: <20240719-fsconfig-fsparam_fd-fixes-v1-0-7ccd315c2ad4@cyphar.com>
In-Reply-To: <20240719-fsconfig-fsparam_fd-fixes-v1-0-7ccd315c2ad4@cyphar.com>
To: Ian Kent <raven@themaw.net>, Bill O'Donnell <bodonnel@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>, 
 coda@cs.cmu.edu, Eric Sandeen <sandeen@redhat.com>, 
 David Howells <dhowells@redhat.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 codalist@coda.cs.cmu.edu, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Og2rH2Ec5QXj9Xm/LggRpPHnBxddnkJm4+HqYoQ+8a0=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTN1GAyTJjPNlHnSOa07L5zvO1H9hrskvBX3KVp4ado9
 c855kVFRykLgxgXg6yYIss2P8/QTfMXX0n+tJINZg4rE8gQBi5OAZjIns8Mf/iPVmYuyWG22eEw
 y020Wt64rn7NeZeSroBf6d+vPBK4Jc3wV25aR2xLYlSilNDmX09y/t5vPskft3CbP4uj+aKVk25
 9ZgAA
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
index 1f5db6863663..bb404bfce036 100644
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

