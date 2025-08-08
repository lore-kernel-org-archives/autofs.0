Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0872616
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619450; cv=none; b=E3OWRqxZPaI3+LaJ9TPvmSs07q53cXpFomqCXXgxGicwd0M2ez/QIuV+Ciaw/Ic9MNVzINcISa011bQhJ2tUJesrgpiJCPgZNQ5V8hGP4o9eLQJWx5Zw1n6J9NPTb3rW+J/PvPraF+QlSo+BSyFbsC2F3QtA0BxJ+q9U8fDOl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619450; c=relaxed/simple;
	bh=S9ypJgf2f6hLd0177dDp55OqRCmtRlCIGAGNabeASCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0OGCpz89I+7QLKWJJTtZ042CrnNC7ud5OdM+glruyxZBxnsAHUePJ/6n9c5IbSbmPOrfMaVXua9XQ1PEjtlW9S/hW/ctAriWIGRIqr8/Bj71JzrHFxhc4KF7X04uEjxkm+rTD+sIDLWyX8uliKmvmeYzRpQU1o1CWPuxlBh+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=JpCngm6R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6wzqFjy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="JpCngm6R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6wzqFjy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA6917A00BD;
	Thu,  7 Aug 2025 22:17:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 07 Aug 2025 22:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754619447; x=
	1754705847; bh=s3AeWu+gFeywcC13MgZlZULc7/hGrjsKD+7VMY8sU8E=; b=J
	pCngm6RasuLiM2FVYCdIGn/Dy4PhdmKh6JU91ydQm+PS/xA1guMmtvlE4euqk6PZ
	mVGRNsSjNY1nAId85QeuL7qcFWqEo8O9dM6bRTql0LT9tkix3X1N5lmUtGxd/7qH
	kR28ok6H4K0t3TzIz4gi3YXT9SNeSdAzn14xsHsWdSjzNygTDdrjmOx+QaepcS32
	NGsiUITs+REYWuJeEff7kUfXJxasqnJaGIiu6BbbS4/w+UixxvTF55KmSeRg7PPs
	h5rS3eKDApwbMmRAQJ3hTxl60OqOyR3tbhSpg0zwe4kR8HaYTWwXYEL0zlfz/xM5
	x+4SQKizAqqwCAQPfu6xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754619447; x=1754705847; bh=s
	3AeWu+gFeywcC13MgZlZULc7/hGrjsKD+7VMY8sU8E=; b=M6wzqFjyk5B111YYX
	P00cJvoVxw7zVCnuBAxvM6X4SDPfhMFjITifCpGDLU6/HyrDtMQsrvSrRpbhrZRx
	9C4M5mGwKviU6AwH4NJpilD8Cqlh2WlefxATKDBuMaARiPxsO8bqmiZOsqBhKKc8
	8duuRDcyvCQ+9VonGEyqd0pr/auQb29+BlD7nZ1NRbHXW6sd1qLCX7OxmYNL2k0I
	WO6qfzJNLXD5VgeOwB1GXu9r0NTqPxyjNZmNlQt5ix4mrUoWAlODu2DHP6ZWOu9l
	B6JVepDQMdJfwPVAPYHmWQFPQMnVF5mLYbQ25H4QAi3K7/hcTMdNnetTUBRl2gwS
	PS9wA==
X-ME-Sender: <xms:N16VaMK0v1H8AOaCsm1S5iKakpbytiWiEaGWXitkTQyB6uFBZKXqOg>
    <xme:N16VaPZKXB7N1pzPKfwQ2qoBywYrFbOMpD5mQBgaXva2s-eNWfT2hKsN5LQ7jUiyc
    WYlFkUYz5bw>
X-ME-Received: <xmr:N16VaGJyNzBM8878MKxMEA9-vMVIbymSTf28PsBVw8jjGJFBGvsQvTqQIiZC-srLXsXXCgslSrVgCPBjgTd52URy6Xdh6K9McGhx8igcjmZqWSQzsux3unWlhw>
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
X-ME-Proxy: <xmx:N16VaFA7GTHBtggTkhr7TpxdCCUV7jwk8YRHLUwjmSv9dbjN8kvqog>
    <xmx:N16VaDqiWatwlhl2wtMJKs20-87kK0JbG_32y9xUcwqZB6hqIfl9aw>
    <xmx:N16VaIg4NcQ_suUg7-PrYJJ_N2IttBPdZIPrW9JeUl8uWyLLyTMFRw>
    <xmx:N16VaIACAswr3Gv5dsy926_PzbhRfolPEvg202cjIRug1m7v3uJ5og>
    <xmx:N16VaEo2-8EhiCE4c3Y1_FaDaYuSXmW8IE6zr9eENjF8DjqTn3k3NxUL>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:17:25 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 5/9] autofs-5.1.9 - remove unnecessary call to set_direct_mount_tree_catatonic()
Date: Fri,  8 Aug 2025 10:16:51 +0800
Message-ID: <20250808021655.12774-6-raven@themaw.net>
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

Function do_umount_autofs_direct() is called in two cases, during a
readmap and when umounting top level direct mounts.

During a readmap, mounts should not be set catatonic so the call to
set_direct_mount_tree_catatonic() is not needed. If it's called for a
top level direct mount the caller, umount_autofs_direct(), calls
set_direct_mount_tree_catatonic() itself already. So remove this
unnecessary call.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       | 1 +
 daemon/direct.c | 5 +----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index ebdfe32b7..2d312c9fc 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -36,6 +36,7 @@
 - fix devid update on reload.
 - fix cache writelock must be taken in update_map_cache().
 - fix skip valid map entries on expire cleanup.
+- remove unnecessary call to set_direct_mount_tree_catatonic().
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/direct.c b/daemon/direct.c
index 596201e94..dcd69254d 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -186,11 +186,8 @@ int do_umount_autofs_direct(struct autofs_point *ap, struct mapent *me)
 			warn(ap->logopt, "mount point %s is in use", me->key);
 			if (ap->state == ST_SHUTDOWN_FORCE)
 				goto force_umount;
-			else {
-				if (ap->state != ST_READMAP)
-					set_direct_mount_tree_catatonic(ap, me);
+			else
 				return 0;
-			}
 			break;
 		case ENOTDIR:
 			error(ap->logopt, "mount point is not a directory");
-- 
2.50.1

