Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA701A0BD6
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874766; cv=none; b=qQQJ2vfrRIDkA7PVApijnZqnmYjxGs5meMIxR04ahJz8O0GLKLljNj8d3qQwUT2wJqNcV7CL4Ac2Qjrvri+CtUDhNUYcI5/RyaAWDn4cKlwJvdkaSxrp2a88iO1a/BtYtYTGXxAFwIZHI6eT1832HyELEqosMjGH07/XrTh1FfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874766; c=relaxed/simple;
	bh=eT0nlddRn9Jnz+gY8Awtb78iJy3TZS5+1vYyt+/7Erw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK1URWj7UDgN0zR7+V+v4xg0QXulFXt8kozPjrZ65Qipk2Y/TeT9ErAu5Np5ddxGikEKunwj2TL/XpIi/7NCI8rNUV2KQCkqbIloHB37JybyvPFP+n6KLxLLDac7kqZ9HyCO1ZJQo4ng9P5vTvBAoFgb0IcbJ821X1luUaN8SCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=MI2aMip0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C6BUgX36; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="MI2aMip0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C6BUgX36"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E8A707A0101;
	Thu, 30 Oct 2025 21:39:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 21:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874763; x=
	1761961163; bh=30N9y51VO+fXEDftcilkMN1iponrQb0bYiaCIn4ebGk=; b=M
	I2aMip0wCYi0PIWSEJIQMN0Z1Qwhx2LyQ8crni4vRBmjtwMAB2ugztRq5dIT6sxS
	wkHmfjSPipNCWPNz42ucZwBpPPdozinF66qKjK8HSN/xx2x3gZV1LE4K2i/CJl0m
	XPRSooqUUGeARmh3luQbKbRwoonXhxMZ+owwE3Zpc4OnUWaXgRG6O5KF5jBq3kfO
	5JGOK6Q/t+g5r1d78/r1oEWVtO2TGrYIRSPrDmjKzKssIjCWY1JWaWK6JznWbW5P
	6qfkHu2gvVfd8dzIzw4eTNvCG3CCqyS1Yq1Qs/QA4yFcvjPnn8eX93puY0NI3K4M
	7p1PIdoRmkRP4Z1+1nRmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874763; x=1761961163; bh=3
	0N9y51VO+fXEDftcilkMN1iponrQb0bYiaCIn4ebGk=; b=C6BUgX364t8BtsOj+
	h5ImnnwcyVAUI8dE2EESxpNfKH+7orGB5xLOj/prD4R2fKLGn4pvLUAL+G6Xst2q
	IAb5t+Rkkt+t28R6UCdCXgmqMmTB4x4M+0v+SV/6MsaoRYUWqKssnZF6RGHTaHUx
	sA7qYUOg2K5mdbom5SpSvSjJUxmvxmLwLWilFE+WjoistCteCwjywG9QasyGhLss
	vSlgA6PoXAQP884J0YPwOfwi6vXTml7GAqYIquNAxy48I1gdiCwcwf/Up7mlzM7A
	KGJp27CSYz5/aXiVtiwR8pUxPiOGfpV+gBPDDnb4fSE0EaNrSjA1SkCgQApMTjFF
	WDVPA==
X-ME-Sender: <xms:SxMEaZn_hYOsbHnelDqieQODW6_A43mPRQctrehmXU4KXeYbMhzAvg>
    <xme:SxMEacRBj2RwbT0cgNU5QBlSnHdo6xKEmdsQdtyDA4TIvdKT2lJYktJa2MyYFAAzd
    9BxjsqMagyymorkm5N3hUSuIM_xsFYugybsvMCcUq_BiRgd>
X-ME-Received: <xmr:SxMEadAgQ1OBRBLb2GQzf6Aq9ybfvLWUQkYAjCUIJpwapt3EtPBYEhQbFE-BtO3ou_GONkuWebgWI9vyS2NiooZ1yboYPpBao4mTHABJqP4Sp4ptQmt5gS_ZXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopehrrghvvghnsehthh
    gvmhgrfidrnhgvthdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:SxMEaTRcmkumu1by0YdPWTeU9uB3YXu31MYqERtLLWFuuGiurQfgLg>
    <xmx:SxMEabp14WGSqFHrXAz4xZUEm9KQiR-bM7FZjW5xKKUDZKtG32sQNg>
    <xmx:SxMEaVy9zRryNcKyKAYV4C_tAEQeJVlaX8b1WbeaCjyH2oAV1czDuQ>
    <xmx:SxMEaQJSXQhyeM8lQTN6p3jKdonn9976Z20fuaXAGjlxn0qo0ljrEg>
    <xmx:SxMEaV7OKfvbO-FBPXzem_mf5ArQZCxFS1EgcGXzH8UfCO4bVMm2epQl>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:39:21 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 09/11] autofs-5.1.9 - fix stale direct mount trigger not umounted on expire
Date: Fri, 31 Oct 2025 09:31:37 +0800
Message-ID: <20251031013745.11150-10-raven@themaw.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031013745.11150-1-raven@themaw.net>
References: <20251031013745.11150-1-raven@themaw.net>
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
index b9c655b7e..630a6d3d2 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -76,6 +76,7 @@
 - remove unnecessary assignment in umount_multi().
 - fix direct mount trigger umount failure case.
 - refactor do_umount_autofs_direct().
+- fix stale direct mount trigger not umounted on expire.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/automount.c b/daemon/automount.c
index afd3bfd0e..517764119 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -721,10 +721,14 @@ int umount_multi(struct autofs_point *ap, const char *path, int incl)
 
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
index 3517e72e6..b8e5bb6ec 100644
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
2.51.0

