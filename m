Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC797FD
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619454; cv=none; b=GbZBWLvzdqNrE7Z8L/CTRnX6X+GVl9oPjkkz33h/eD/2rQ5xDW+F+kO2z1xDVKoaE7pSRPwHCjvwcQMjmm9D2EOXvSkclX23UyR6dDWhWJo+AVsOuMzd7Vq4OvECE+4APnaAOb4/EJbCGELRdo6pklXNbblUv/oTtPkHnQfNQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619454; c=relaxed/simple;
	bh=RsxDL5h7bjgaz3S+s4GgHaev6G4idJUAM652pk0pCN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNI7WkEE/sHdOr5o6txcpbi2guPH0pbmWlDvlXCSeMcA6sGJfOj6p8xKIUElLD+xxL3yHt0OsXa8v58rudpqHeFynM4DTJLAqAZnwTNo9Q2nGHdkx6+cHuBNCSFv0mTULzwIO78u6d2gSDWChzRm2WrqgfkQ/5lnCQ//4EeiHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=wQQ5HxZj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LasR3HhM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="wQQ5HxZj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LasR3HhM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FFA81D0013A;
	Thu,  7 Aug 2025 22:17:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 Aug 2025 22:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754619452; x=
	1754705852; bh=m8WmOYIWemlOoFfz5/7Li9gpn5yFk1xDkBVSwVS6F60=; b=w
	QQ5HxZjYdeJw9y7YaHLZNEHOXXKvKCMjb7gCqJzBWao7yURsHq7+oIl7OmtQGg+q
	yo9rKqUeG9GSJC3eoerublN08d2OAvMOZIY+SokHyhwvV4k+LCiM7W8hREVVjvqg
	/TmbNpY8Lr+JqvVo4WVrMoZZ7+qSIJNwL+5MFZLr5d/JqW28YtFSOOV/yNte//ZL
	sJjpn8IiGs72uhUDk8RHiLNOuRiMBuHXdiAtHToAqdSVDmB4OfBAF8FGeO5TYl9R
	Gf7dt/MLgsIBj84Ksp2Giv4WYf7UaELgMLaQgS69zsY+/uit9Hiy4F5MuQgAajb8
	8QEwohva9GkkERuptBqhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754619452; x=1754705852; bh=m
	8WmOYIWemlOoFfz5/7Li9gpn5yFk1xDkBVSwVS6F60=; b=LasR3HhM7hfrRd31m
	A5zwRFuPYcN2XuuuWHW1ORTKg89SbYKXiO21zJ+4JptPfokPwL4eE7GzcQAmB44w
	s9JN45IXTzcjoXIXmYuGMr5g0XpMoCIJon5nCTG6kkt4xVUICbtSChDDtc1z2mbG
	rm1snYTkcD3OZTH2KKzNcYggo72fJblaXv1izNdllKxssV21BOk+m9nRWFv+jyF8
	visQ8shJRkRqBfuNU+Yp4BeNMdqTr/9QZ5SvSrlLKaeBQv6PlbW8vkMfwPxuGSVC
	S1Ow3Cw3oYNrC3sdZxpSPnuji4UhwNvFukfO/u+zI9bb83q4BQcSGxZ9jn+VTnn4
	YLMPw==
X-ME-Sender: <xms:O16VaDvzpWb9BpG1q6FfTyAKcbfTJ1HDgk1bnjACDlu6lz-JdBvWDg>
    <xme:O16VaHuaEWYh2MCjHrO0b-HEAFZquVakeoS6EHEhMoQgsnuTWr9lKJPkj0YxkCKzd
    NCTP7VOgtO0>
X-ME-Received: <xmr:O16VaAPMd0IP6owvI2wzhSUc8wZQMFQE6bAiNz97OAm68sYU8oCfBIxCSDa-KN6eUyl5FtpHax5A3Ppqw7yfjKJYAQpaTO6nRVQfzGh71lnCmURxYgvuMd7jhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhrtghpthhtohepugguihhssh
    esshhushgvrdguvgdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:O16VaN0KcgUv4v_zV-8S_DdWpRpgCkpJ25iw9uG8cYbXFg51WQ6kOA>
    <xmx:O16VaEOvnnuDCaxhohJsK1nQ522MMl4ze-7bUKqifk1G2TU1qI_45w>
    <xmx:O16VaF3bnU00WJy__M825IFiFWkWn6XKzraDUcI_gAsN65WNL_BLJw>
    <xmx:O16VaDG1NiLKCQeAd8TmMAIT3oH9N2zsH_IXDb-70nqJE6ikCSmYNg>
    <xmx:PF6VaD_dgYlcJGNcY8nPA28Bebws7BhCsP7g2EqKTCV4ZPefSTDmuWdz>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:17:30 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 6/9] autofs-5.1.9 - remove unnecessary assignment in umount_multi()
Date: Fri,  8 Aug 2025 10:16:52 +0800
Message-ID: <20250808021655.12774-7-raven@themaw.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808021655.12774-1-raven@themaw.net>
References: <20250808021655.12774-1-raven@themaw.net>
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

