Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C48212FAD
	for <autofs@vger.kernel.org>; Thu,  7 Aug 2025 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547659; cv=none; b=MWTyJDuEC4/qjwrG19i9GxeErMFKmdEXatRKIh4MBZEjBJAJdFIIbRxgrLcc9kbv2/A+hvsnFoovxmyyf9iIHZBr5OPRTxPbVbsXU1rK/TWz6/iDM2nGEWRFeBGkak2BSbGJZb01w5RoK2TualMMWmqJPij0Db0gFGCX0XzJVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547659; c=relaxed/simple;
	bh=3d66ZkDJtuQ/itOEtEoIsOp8ddwl0fn3Lcmm5D6v0PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrXqSLcMgSXl0y3D7zFH6EuSVTHASiAWd5obIefgvI8yR3NMpM6WOQ22pcj1Wk0+oA1TsVKc5jx43nyjnG66UfEIQuQbEOliYbPUFVd96XEtPl8Oy1lxQpSoJFimthAUuBwqxI2RCnrqFaVD6NhKZ0JjPtdfx6PvrwtKZSqjmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=v4IbtX+H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UK84MQ25; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="v4IbtX+H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UK84MQ25"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id DCDCDEC0191;
	Thu,  7 Aug 2025 02:20:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 07 Aug 2025 02:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754547656; x=
	1754634056; bh=0NOT9+SEBCC6gAkma92lg7vKli/0Hp3i+UfKi09EnEM=; b=v
	4IbtX+H4Me3iX3u56DkSf/DIdumEISEJ5nCZACjhAEC6B/6If+ucqYKIyqR/xQ0/
	DhQohzFerWCpcZbq/6TCR3tjsE1gUkm4pASbmfi1xKYEJxdNLLdl4s/U6O7YMUxV
	jSzT2W5Y5rqAIdTwlJo4jhhCn4b6F7tTBaY/TOivOLKZx1/wbwel8ZizH4W2wqPs
	7LLrHM5VoWDuSTdTgpFTz76BhlFLnHyPaXjMstIx4SFqm8zMMLHOfmSYT+UXmpx3
	g7d0NlfU39pmcxaPrNbwXPzjjYTlOCZNLSdi5j7kwm6ge1zvml97p9edjeXrMcA2
	HNXybth93CJ7YGuQUjQKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754547656; x=1754634056; bh=0
	NOT9+SEBCC6gAkma92lg7vKli/0Hp3i+UfKi09EnEM=; b=UK84MQ25h9mWKjrTn
	v+k32yS44JQh67oPTbZQX/Z5tL8uMr87DfJ073Sv25vQZkSjylKShBdS/IgOqXqc
	G9pyuZmL76nPIbZwEmrDyurdWYeL8G9A9ot/Ot0VbODXuCOraQQK2pEu4FVfuhlz
	rkszSrLFgR7irYZnFY8UOVuq+286WLqodJwKW6Mc4pH+i/c3AZ7ojfxbs0H93dWh
	MluzuIdqR0z6b/51h9LWRtJDccwh2NjunvGYHP7DHKAIBBv119bheiAgn8XkX8y2
	5UcyVzDVvIZxDN/CwvoK7tBf/KH6Co21AaB4Pjn4VcTzdtoOIeKmgdxDeoowJM/Z
	DOuQA==
X-ME-Sender: <xms:yEWUaBEIRMsMeLyDXihXFdEiZEgefQiOihLPYAV0IT_ZhaJ0dEfwsA>
    <xme:yEWUaJm9YA0DzWy7hZiI1fgh2gD4D0CzGAbd_znrlcqsjTAvkyr-MF4zTU5AM_LFk
    B0OJTt2cp1l>
X-ME-Received: <xmr:yEWUaMmzXvzkwKNg-HjkkxidKIAkgeOaFrnI1MnFYDQWuXz_lhSfO3ZnK7CHI_p7Jhw5vjjcp3yl3IGCQlqBSpyG7GD1Zj3wAMT_p2P_5dkC0M5kCg18jxguyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopegruhhtohhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghvvghnsehthhgvmhgrfidr
    nhgvth
X-ME-Proxy: <xmx:yEWUaCuehv9cTisCBgmsUE-Gpy3eukxG6bQ7qpNg34hemeLl-7JjAQ>
    <xmx:yEWUaHl7oeIw3o2Ylfp1g3J-YvMknGRIjdW9eatNfxcBN4quQnyqYw>
    <xmx:yEWUaFtSD8O5ymhKrVU7iPPn1f04-l3qFzvt23uU4_ZlfAPtKZ4RWg>
    <xmx:yEWUaFeTlgq29SGjuWASd_oOJ_gBygA51WpFNl9WxtygvXPrtYSnHQ>
    <xmx:yEWUaP0soWcy9P3NicMtbA9EiOH78sCtrMy9HHJNHEnGAoefxsxKllej>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:20:55 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH 8/9] autofs-5.1.9 - refactor do_umount_autofs_direct()
Date: Thu,  7 Aug 2025 14:20:06 +0800
Message-ID: <20250807062007.14996-9-raven@themaw.net>
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

Refactor functon do_umount_autofs_direct() so that it can be called from
do_expire_direct() to clean up stale direct mounts that couldn't be
cleaned up at map re-load.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       |   1 +
 daemon/direct.c | 106 ++++++++++++++++++++++++++----------------------
 2 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index ee1d46987..d41527cc1 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -39,6 +39,7 @@
 - remove unnecessary call to set_direct_mount_tree_catatonic().
 - remove unnecessary assignment in umount_multi().
 - fix direct mount trigger umount failure case.
+- refactor do_umount_autofs_direct().
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/direct.c b/daemon/direct.c
index 7648b301c..6562b183a 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -81,12 +81,66 @@ static void mnts_cleanup(void *arg)
 	mnts_put_expire_list(mnts);
 }
 
+static int finish_umount(struct autofs_point *ap, struct mapent *me, int rv)
+{
+	char buf[MAX_ERR_BUF];
+
+	if (rv != 0) {
+		info(ap->logopt, "forcing umount of direct mount %s", me->key);
+		rv = umount2(me->key, MNT_DETACH);
+	} else
+		info(ap->logopt, "umounted direct mount %s", me->key);
+
+	if (!rv && me->flags & MOUNT_FLAG_DIR_CREATED) {
+		if  (rmdir(me->key) == -1) {
+			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+			warn(ap->logopt, "failed to remove dir %s: %s",
+			     me->key, estr);
+		}
+	}
+	return rv;
+}
+
+static int do_umount_direct(struct autofs_point *ap, struct mapent *me)
+{
+	int rv, retries = UMOUNT_RETRIES;
+
+	while ((rv = umount(me->key)) == -1 && retries--) {
+		struct timespec tm = {0, 50000000};
+		if (errno != EBUSY)
+			break;
+		nanosleep(&tm, NULL);
+	}
+
+	if (rv == -1) {
+		switch (errno) {
+		case ENOENT:
+		case EINVAL:
+			warn(ap->logopt, "mount point %s does not exist",
+			      me->key);
+			return 0;
+		case EBUSY:
+			warn(ap->logopt, "mount point %s is in use", me->key);
+			if (ap->state == ST_SHUTDOWN_FORCE)
+				goto out;
+			else
+				return 0;
+		case ENOTDIR:
+			error(ap->logopt, "mount point is not a directory");
+			return 0;
+		}
+		return 1;
+	}
+out:
+	return finish_umount(ap, me, rv);
+}
+
 int do_umount_autofs_direct(struct autofs_point *ap, struct mapent *me)
 {
 	struct ioctl_ops *ops = get_ioctl_ops();
 	struct mapent_cache *mc = me->mc;
 	char buf[MAX_ERR_BUF];
-	int ioctlfd = -1, rv, left, retries;
+	int ioctlfd = -1, rv, left;
 	char key[PATH_MAX + 1];
 	struct mapent *tmp;
 	int opened = 0;
@@ -153,8 +207,7 @@ int do_umount_autofs_direct(struct autofs_point *ap, struct mapent *me)
 			} else {
 				me->ioctlfd = -1;
 				ops->close(ap->logopt, ioctlfd);
-				rv = -1;
-				goto force_umount;
+				return finish_umount(ap, me, -1);
 			}
 		}
 		me->ioctlfd = -1;
@@ -167,52 +220,7 @@ int do_umount_autofs_direct(struct autofs_point *ap, struct mapent *me)
 
 	sched_yield();
 
-	retries = UMOUNT_RETRIES;
-	while ((rv = umount(me->key)) == -1 && retries--) {
-		struct timespec tm = {0, 50000000};
-		if (errno != EBUSY)
-			break;
-		nanosleep(&tm, NULL);
-	}
-
-	if (rv == -1) {
-		switch (errno) {
-		case ENOENT:
-		case EINVAL:
-			warn(ap->logopt, "mount point %s does not exist",
-			      me->key);
-			return 0;
-			break;
-		case EBUSY:
-			warn(ap->logopt, "mount point %s is in use", me->key);
-			if (ap->state == ST_SHUTDOWN_FORCE)
-				goto force_umount;
-			else
-				return 0;
-			break;
-		case ENOTDIR:
-			error(ap->logopt, "mount point is not a directory");
-			return 0;
-			break;
-		}
-		return 1;
-	}
-
-force_umount:
-	if (rv != 0) {
-		info(ap->logopt, "forcing umount of direct mount %s", me->key);
-		rv = umount2(me->key, MNT_DETACH);
-	} else
-		info(ap->logopt, "umounted direct mount %s", me->key);
-
-	if (!rv && me->flags & MOUNT_FLAG_DIR_CREATED) {
-		if  (rmdir(me->key) == -1) {
-			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
-			warn(ap->logopt, "failed to remove dir %s: %s",
-			     me->key, estr);
-		}
-	}
-	return rv;
+	return do_umount_direct(ap, me);
 }
 
 int umount_autofs_direct(struct autofs_point *ap)
-- 
2.50.1

