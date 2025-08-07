Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7A212FAD
	for <autofs@vger.kernel.org>; Thu,  7 Aug 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547655; cv=none; b=nu+vzq7UEycqu2xoZMxnWi0eSU2a61UgyvoQWJl7TtbGmY9vSXs0QsadYpmqhTNLUkbMlfzPhwvFthtl3rgLHJ53SmKVy3NUvUHLu77eIbNCNH7ZcH79RUWqUoSQTC384GVQAksyoxXqB+9qkmd1JLDEN6ZrUkod/vo4vFsWKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547655; c=relaxed/simple;
	bh=RsxDL5h7bjgaz3S+s4GgHaev6G4idJUAM652pk0pCN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utCHRTyt93LQpRmx5PEPbY/QNVn6hvK1/MT4uL1U5+dsbLxIMG9SROwg83uH55ObiK/3jcWR7gqisY/9E0M+wTYEwnLiOvp8rc3jtniH2Z77cai39o/3Q+SqUIBo2dhMx0rkJi//e8Md0zQpBPW9j6O8d2euXQ1APSyIhJ+MpLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=h2IZG+jm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KNZ4eruz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="h2IZG+jm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KNZ4eruz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 997001400188;
	Thu,  7 Aug 2025 02:20:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 07 Aug 2025 02:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754547652; x=
	1754634052; bh=m8WmOYIWemlOoFfz5/7Li9gpn5yFk1xDkBVSwVS6F60=; b=h
	2IZG+jmeyuFR3zZrQg+SS+OPQgJxyWlwZwNyNEretAAy4eYhxy6gCdGaZUhrT2Ny
	Bq27cklG3yhRwc1dJEO9JJTNQWr0Cmk3DGNy4sxFds1jr/R+6ntvAa/YVMOBDaKr
	RnnFMK33LkJZqiIY+cHcYstA2oWXJKB3FRCRBekPshslQ660kB8A9MxXGwnBkHys
	8kLs4u6rXxXuI8xGULaPy93G0CEQxO1hSLkD2kb1WXZFZB/tMW6i986e33zdC93W
	cNNd7d8icq6azxEqWMt84uBYfLYWmglCCcoa0U2W03FY5ubp3izBzsUiAuY20eX9
	K1zTQmqmiiD3szd9DklLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754547652; x=1754634052; bh=m
	8WmOYIWemlOoFfz5/7Li9gpn5yFk1xDkBVSwVS6F60=; b=KNZ4eruzdViTGbVSj
	n86QfX/AIA7N6iPp5h9T9ehutJizHcG37Bp7a/6xmbKxM9KwuhlvUMRmCB7sKwvj
	8v0iCZJEAV/KHSwYFpbdAHPTcoBhg1q1DPNZl84xNvJ/rLBoO1K85xWJZIOmmh+r
	4h+iUcoxRM+GeYXtl6OT8mH2MK6rbZS0YY196rVUMe8BB07+ZWnnJ18pqT8mVOPC
	LJ7RIJgzKrxye7w2sV8DfPgb5uBu33z1tqMMNt2LwFYp2m87B9w5Gp/5gRrGdAQK
	rDIFZzJHfrWm417GDHu+bs9UoBMBJOooEqqsmD/Mb1lWMRruEfRMhawwWdWSQoTh
	TxRtg==
X-ME-Sender: <xms:xEWUaHudSWmP4idACIIaKt2_JkrdXZEDCzyY_OFVdNy8Fa2c8nXVGg>
    <xme:xEWUaLuXtgMog41lr6LSJMOKXzFSkF2p2DZ2rN9f92MtcpvWodbkMEwD-eCPBYkfH
    Xoy8boKLqcS>
X-ME-Received: <xmr:xEWUaEMgP5Rqgd_L15-T2oDxD71kR9_K96_wpaBJGXmRYE30MMYG6kW2aUlHZE-guskH0nRlGmWKeduD0lqtzaAiGEkbFS2YBCnsviEZuQBeLKupep-fbQ-PdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopegruhhtohhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghvvghnsehthhgvmhgrfidr
    nhgvth
X-ME-Proxy: <xmx:xEWUaB1qAhjkELMw9PY-rQmHVJi-yfMv5zsXN5p8VkSnX_WUYHYvSA>
    <xmx:xEWUaIO9qmdSn_g_GDVmkmJW8C63o1X-1-OwU1gYGV8ytOcJtF7_Bg>
    <xmx:xEWUaJ1sjUYpi-nmdYONkwmaxI3B2aqfB78_c3DQYlrfETs8Y6LvpA>
    <xmx:xEWUaHENt8MbLuqX5Fq2XkYjnXZ4pc6-W9OCxg9vHR0PedGrKWjKqA>
    <xmx:xEWUaH_2z_8NnDtL2DzedbYVYYhEzyxTzHYI8e385GHYiGmtbZpeJECX>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:20:50 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH 6/9] autofs-5.1.9 - remove unnecessary assignment in umount_multi()
Date: Thu,  7 Aug 2025 14:20:04 +0800
Message-ID: <20250807062007.14996-7-raven@themaw.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807062007.14996-1-raven@themaw.net>
References: <20250807062007.14996-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the leftover initialisation of left from when there were multiple
calls to umount_subtree_mounts().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          | 1 +
 daemon/automount.c | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 2d312c9fc..f92d01b07 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -37,6 +37,7 @@
 - fix cache writelock must be taken in update_map_cache().
 - fix skip valid map entries on expire cleanup.
 - remove unnecessary call to set_direct_mount_tree_catatonic().
+- remove unnecessary assignment in umount_multi().
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/automount.c b/daemon/automount.c
index 5578a965b..c2c8d8f00 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -710,9 +710,7 @@ int umount_multi(struct autofs_point *ap, const char *path, int incl)
 		mnts_put_mount(sbmnt);
 	}
 
-	left = 0;
-
-	left += umount_subtree_mounts(ap, path, is_autofs_fs);
+	left = umount_subtree_mounts(ap, path, is_autofs_fs);
 
 	/* Delete detritus like unwanted mountpoints and symlinks */
 	if (left == 0 &&
-- 
2.50.1

