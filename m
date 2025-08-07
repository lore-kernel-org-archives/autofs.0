Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8A2147E6
	for <autofs@vger.kernel.org>; Thu,  7 Aug 2025 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547661; cv=none; b=lZy3V/6dJqwOi9WIKQ3SxsqfcdbgjEd9HlxjHzPWYaTSW0BjQxjMJIc7XztV56iMtujGwTfSSQa4BU3pmOFbNc19KfGZj+8XGleS4TxBqm/SxSDkd0p7OkTyE4BKo+jBR44oCJm5qW5XVwfoA3H6l8p5wjpGDaDCayL2HxcPZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547661; c=relaxed/simple;
	bh=JY/zKVD8uGJXiNupiLPfgzkp9MwsIMkvW6sB6gBQtzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkkSLL8AiCKHfNfjkCxyiaity/QYlVQYTCdDvTwhRvkYjT3EUqOFI5NrSrzmaYCvmFbkRHDiH/4kb4NBdeCE+STUrB2C2wUJFXdrvIuRS5Q/37ikAG+HsL6kPgCfpZ7URC2byxMzKfc8KM2nO+vqteq4g19YNII0xxW8Jg8GkCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=K2tAk+2Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nkwRmlX7; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="K2tAk+2Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nkwRmlX7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B2FF1400185;
	Thu,  7 Aug 2025 02:20:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 07 Aug 2025 02:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754547659; x=
	1754634059; bh=4eVNC4DsaXBc2GC6InYAM0v9l3cFtFRV96Nt01exS44=; b=K
	2tAk+2QMg4VkeDu1a2wm1Zv6pucC6NVGJiIvMrRyNi+qjVWUli/k1vnN7vrrFPu6
	kZCTlmxCaH/EaayQjHV0kgPVGgHBJTuEjh5dw2GnQhyh6nDSr7lG7h/N1rU53SsO
	Wrpce6lATAS5KxKbcWD+kOUZ+LJEfwaVA3my9xU+h1mrFiMdmv+Oie00PKa3Ak7f
	TvnK4Ko4y7xRsE2EhF3PU/vKW65DxQ5u00ZN4G4H5k3krqnSGmuQVo2sRpMnh9W3
	4VeCgUAgQGiDWoiojRKABB6DLwCkb8rChMul+WJTlklsDv/nBQvC3YZcoG8tak+U
	UBZX6/ILYzsWW+GahtHWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754547659; x=1754634059; bh=4
	eVNC4DsaXBc2GC6InYAM0v9l3cFtFRV96Nt01exS44=; b=nkwRmlX7w7loGvRyq
	wV1ASb5maR2d3pKROSfmNm/KJEa9zan4cB2rPuASOFuQCKRJUkLqYI2+Lqjy8rI4
	+b0IHkVMzjkDL5nohIdZJ2rNagtwQuout5rVIhAYlmUyfoV+M6CX7ISyVI6NmU//
	WVaQdx5D/wkIktzWOPSXZrgBhhXXY8wPS5ALW3QDfDeYqcFvsAAAJ99BMm4uAfqo
	hwr1ob8tXHm3xgjRVyRXN1zZZw27FQiRKDBQfieoOSYixEd+HoRr8Hx+hn9FojM+
	HTZhEezOey/eirBm+yiOYl6VuK5/VIte4cdDOaSd+XadCZJfCoRDj7UVRM7j44/+
	Iv7Kw==
X-ME-Sender: <xms:ykWUaBFo3Q5C7SXQjF-YA1hdJfnl9nKPn9tvbGXD2HB1KXXEDTbVow>
    <xme:ykWUaJmd7iGo9EbnH5UYlMXQDs-N2usIWE-qFvvpXwJ5GQsoLD2DC05XuhP-QEs3K
    EQcMZCNXtRx>
X-ME-Received: <xmr:ykWUaMkTB7TN-_wj8f1K6r_p4BPiTUnFXeDatg7ulKDV7Jxn7n10xVPCuDKYq6WI6W9_rStrxNZ60rzLpUuSAZ2WsPUFfNznPAd8OlVRRa9taCNu4yDmsOMJYw>
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
X-ME-Proxy: <xmx:ykWUaCt-d_gNTP_Uz36bQuNXFVsp8zO5kS1WBN7cKpR5GoXU-Vgmrw>
    <xmx:ykWUaHnbcMpCoWlPxRPspNPjC56EkLkd4-xzo8vjl2wRC80TYocZrg>
    <xmx:ykWUaFsym0b1Zs0MKOPmwvj4ifb0Clu0CRx5SrnA-8SlLWRdPWOyRw>
    <xmx:ykWUaFfzZDgkh3FRFcz7RGapbRudSOueCr1lrNwHAhG64rb2td9CXQ>
    <xmx:y0WUaP0MOa4kqgFMq_tXN8zq1v7GG2eY_2CxF9brNJh_o6KI8zDWu6at>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:20:57 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH 9/9] autofs-5.1.9 - fix stale direct mount trigger not umounted on expire
Date: Thu,  7 Aug 2025 14:20:07 +0800
Message-ID: <20250807062007.14996-10-raven@themaw.net>
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

If a direct mount map entry is removed but has an active real mount the
mount trigger needs to be unmounted during the expire cleanup.

If the direct mount map entry has been re-added the map entry age will
have been updated so the entry won't be seen as stale so the umount
won't be done.

Also in function umount_multi() update_map_cache() and check_rm_dirs()
are not called for direct mounts because count_mounts() always returns
1 or more for top level direct mounts. Make this clear by using ap->type
in the logical check and rely on the left == 0 check to verify there are
no remaining mounts for indirect mounts since count_mounts() will be
more expensive.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |  1 +
 daemon/automount.c | 12 ++++++++----
 daemon/direct.c    | 22 +++++++++++++++++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index d41527cc1..663ceee8f 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -40,6 +40,7 @@
 - remove unnecessary assignment in umount_multi().
 - fix direct mount trigger umount failure case.
 - refactor do_umount_autofs_direct().
+- fix stale direct mount trigger not umounted on expire.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/automount.c b/daemon/automount.c
index c2c8d8f00..f523a3df9 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -712,10 +712,14 @@ int umount_multi(struct autofs_point *ap, const char *path, int incl)
 
 	left = umount_subtree_mounts(ap, path, is_autofs_fs);
 
-	/* Delete detritus like unwanted mountpoints and symlinks */
-	if (left == 0 &&
-	    ap->state != ST_READMAP &&
-	    !count_mounts(ap, path, ap->dev)) {
+	/* Delete detritus like unwanted mountpoints and symlinks
+	 * for indirect mounts. This can't be done for direct mounts
+	 * here because there's an ioctl file handle open on the
+	 * autofs trigger mount for them so it must be done after
+	 * the expire.
+	 */
+	if (ap->type == LKP_INDIRECT &&
+	    ap->state != ST_READMAP && left == 0) {
 		update_map_cache(ap, path);
 		check_rm_dirs(ap, path, incl);
 	}
diff --git a/daemon/direct.c b/daemon/direct.c
index 6562b183a..90e1a8092 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1005,10 +1005,30 @@ static void *do_expire_direct(void *arg)
 			       mt.ioctlfd, mt.wait_queue_token, -ENOENT);
 	else {
 		struct mapent *me;
+
 		cache_writelock(mt.mc);
 		me = cache_lookup_distinct(mt.mc, mt.name);
-		if (me)
+		if (me) {
+			/* If the direct mount map entry is no longer
+			 * valid but there is an autofs mount trigger
+			 * for the mount the mount trigger needs to be
+			 * umounted, the map entry deleted and the mount
+			 * point directory removed (if it was created by
+			 * us).
+			 */
 			me->ioctlfd = -1;
+			if (me->mc->map->age > me->age &&
+			    is_mounted(mt.name, MNTS_AUTOFS)) {
+				/* We must detach the mount becuase the
+				 * umount must be completed before
+				 * notifying status to the kernel but
+				 * there's an ioctlfd open on the
+				 * trigger.
+				 */
+				if (!finish_umount(ap, me, -1))
+					cache_delete(me->mc, me->key);
+			}
+		}
 		cache_unlock(mt.mc);
 		ops->send_ready(ap->logopt, mt.ioctlfd, mt.wait_queue_token);
 		ops->close(ap->logopt, mt.ioctlfd);
-- 
2.50.1

