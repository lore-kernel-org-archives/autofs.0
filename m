Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931A4189DE
	for <autofs@vger.kernel.org>; Thu,  3 Sep 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423105; cv=none; b=RCSjAaQVBnFawYO8UxZM0mpoZKFyiZd6BIhVvp1LhoeVo4YgH62jI9NZPuwoT6KNBg70HGt+aNwfbqFrdACQLvzFl9CnLkqSF9sithNYPV/6xDNC4oVdt+hpHtCdQPNCIaP+sdWqQaw9y8jUtr/3zVgIhbc4td/X0AHWj0nQLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423105; c=relaxed/simple;
	bh=Xghtyt6ElU9KfeHqS2XyTMJZnCsweO3xMPanse4xLdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbR52a/LpGYe9LwIyKsUnPi7bqK6pxvkvVmcDlnR8arH9dEoWmCJB9zSkd0Oaj6PpCpyykFvDT0Y2VpEGuW9jrKsWIEmkn3FBG5EIR7z64n9uFFsr9WTzwrTg3ztXA44I94IGGFIpveXDg8nE0ZzWMruS1tuRaIhCajHzxuqTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIHvzsjV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIHvzsjV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d91ff7d9acso20166735ad.3
        for <autofs@vger.kernel.org>; Thu, 03 Sep 2026 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788423104; x=1789027904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Yz/sPhDz2lFb8/Y0OGM2xcNq9RbNJiy8D9exw5GDnk=;
        b=KIHvzsjVVGHJzw2KxZdaPTKQlhgFP0ze6y/rIyiIzoEV7ibu+o7125fKOo/V01R4Df
         xQSrtOhwFVWtnOhKHH2tYSwFool/JhxLIswxcYtAc9M25JxILIuCYtiE9ySLV0BO4WUo
         xzxdH75ckaUA8S37Rxb1Z27HPe90K+dJSTcMGNdn0VkBKPtcyCl4quj4SitdM/XhSe4t
         HbNVGuuezgPVtiYo/DFcYbunjWlS7PadLMfxBPJlqI3j6bDm3RFSA49Q07Mw7Ze2xBQy
         Zzc9V4r9tk+mLCoWzcpGCW9d/qmr+qymbFLcL0awzj7PSmrTCNiqoSyHUAjtEKFOngIm
         fgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423104; x=1789027904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Yz/sPhDz2lFb8/Y0OGM2xcNq9RbNJiy8D9exw5GDnk=;
        b=ZKBSsPxtC5R/0q34XpiOoY+cpLdzkvxSxCXpWk/As3S4I0qPvE1eF2Cmje4NAaiiDB
         eq5vtNQ+L4EFLPQAol9/GUdz2trdUiLc6uiCX7E8x3zVnziz21xKqtBc1Nb0Hdh2ub27
         GMSxFsiNnxb+EuG8rumkPU3N1LWAlA0lkdtmLLBK9epqem91CXK5HnAabU7GJJr2xwli
         vTFf2+PXuTP+5qaxbGmhZhcZTZWINngujKjiT2dLy7zH+AljayQYGlw1IcB29QuQ1+gm
         rXUDiCnZK8XzNg1+qrrvPA+RjSXSO0AGE4VbNntmATjU/MJwJmsCybr453xCoyAB6Uds
         hByQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzOq03zMlH/8IRJEYMETr7Xq9mhnW4fuTrfTcS/Org0CBmcz3FKyWy7auLe2flDN4IXe62iwc=@vger.kernel.org
X-Gm-Message-State: AFuF++m4LMfMjLkYjyRba9qD0nIBKUl6tI+Ak6iR2gsidW2YyoaaxGIV
	xuLsij1aU9f4trObJYZ0FiTNdGqyEWzdjaxnZB5pwtuqNRSki4XkEaUR
X-Gm-Gg: AYBFou04Ml1d12HQE569TygRVCUKexNLYWOcWWUN2joCY6llc/KKJII99+L5cuw5k/8
	vLHMJcLN3aZAvMWc0uJfF7eaGFsi2+jYqRum3h5E0qcBwqWKcYVrLDpfOhuPWJVHEe7+bouFa7Z
	9qlDLcB4qK3K5jmnmvqmVu4Za4x16C4SovR9KuJmA/tIp10LJ+UpkKJbQ/Z/Tkc6Q7phhgBhiuF
	0O9S/kZuHhKVGf0QEScFh8XJnfwjhYzK746MUxlXoMlb3JJSBZoXx3ijAU7vClA6jUnShZ1vWki
	CAlBJNki1GMPBZaBePyZGAqWjLM+qZgpAdJJa8uxdGOLV5ZKcj+mBrFM8sX67Y1UBBI09AbmdPh
	bpmXgVoHLkNnzY5OYCQgcTkBnXQB5HuDWxTUt4OohtGuWmGNckmiXKnf9OuhyXqsIlO0ruyqW0F
	tFsDoIdKtlMMGDOGgwwsmlDRnGlo92diyH+0ZZy7LkufSC3L1tkcQCpVPXnG/ZDQZfFw==
X-Received: by 2002:a17:90b:1dc1:b0:398:d6f4:c61a with SMTP id 98e67ed59e1d1-39aee13c22dmr16834798a91.17.1788423103692;
        Thu, 03 Sep 2026 01:11:43 -0700 (PDT)
Received: from Default ([2409:40f4:101d:c1aa:6821:531d:eb9f:2aaa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3326e39365dsm4519895eec.20.2026.09.03.01.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:11:43 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: raven@themaw.net
Cc: bodonnel@redhat.com,
	brauner@kernel.org,
	autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+df1db6e034b3953e19f5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] fs: autofs: fix memory leak in autofs_fill_super()
Date: Thu,  3 Sep 2026 13:40:48 +0530
Message-ID: <20260903081048.132524-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In autofs_fill_super(), we create a new inode using
autofs_new_ino(), however, if we fail to create root_inode,
(that is, root_inode failure path), we return -ENOMEM without
freeing the new inode(ino) that we created causing a memory leak.
Fix this by adding autofs_free_ino() to free the inode we created
in root_inode failure path before returning ENOMEM.

Reported-by: syzbot+df1db6e034b3953e19f5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=df1db6e034b3953e19f5
Fixes: 66917f85db60 ("autofs: add: new_inode check in autofs_fill_super()")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 fs/autofs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index c1e210cec436..6b15a3717ba7 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -323,8 +323,10 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 		return -ENOMEM;
 
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
-	if (!root_inode)
+	if (!root_inode) {
+		autofs_free_ino(ino);
 		return -ENOMEM;
+	}
 
 	root_inode->i_uid = ctx->uid;
 	root_inode->i_gid = ctx->gid;
-- 
2.55.0

