Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6724DD09
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874764; cv=none; b=mFlEuH65IfqEw5OJGOUeFloYHdPCYzjKdwSew5ohywJWhorVkS3jBHUKWBTiS3BqS4nUnOM4GV7KEq9xaSUgd/yz3FCQFfijO7xOwR3+ZDjzdm2k63IV0/PmK7bfRV9vcD5BiBYu3lJjipT5qQgg/RAvLFTDES0YfeOOzLlkQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874764; c=relaxed/simple;
	bh=cLnLpmsdJEXPeC/9UVRu/k1CcUb0F/fgbysQg1forTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQGQTrbYx2Mfh9ZCnfMmhk2mUq14ccMS347Id05GCpb3thYkSHbtjQWP+B32LQZhZBu22zE1tguCwDcULIgM24ecRx5voRNdTmXCCEtd83cA6ypzgxJjPJThtZvrB9AtNuS1zy9X4J8rMzqysGEHVGVoLb4eZv/GpndISEC6lGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=uLd/n+4P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RYqeat6+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="uLd/n+4P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RYqeat6+"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 78A267A00EF;
	Thu, 30 Oct 2025 21:39:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 21:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874761; x=
	1761961161; bh=nLq7ijcJRT/P5Ehm0bdW6qXoJs+Wgg+yaQi9/jsNkZw=; b=u
	Ld/n+4PNjsHfbn2Dlxcd/HvgmImEVSDd1jzyWO3C5yxo4zxxNmVAUSl/PmOm+szd
	lguzAi5+dp8722142BLp6LF6idwlM4bKVAn1GzocjGSgtwa9smmITZqYrRoA3kWE
	dy9mCeUfDxn/eAKfgFIsNqLk8Km9GXKAfoOd8afuThZDezP9VPAbfqOd6UP2d+gn
	etym3S17cNaBcWxjr9yz13KtHHHOHfcirLjkMTJZtF92G4G6i6i1tkV539qwPICJ
	1mastto74CfhPaaOXfJ8p9AdlYDw5c1Rku8Gj1r+psgeybpSMhJo9VpaPvfd01Sx
	CyYofiCO7QZTrQQ5rs3EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874761; x=1761961161; bh=n
	Lq7ijcJRT/P5Ehm0bdW6qXoJs+Wgg+yaQi9/jsNkZw=; b=RYqeat6+9SyIrDn7a
	Tu8f5oA6FkIVSx6BGQpRuJ/MrbjG9wvrkAzM5VpSRNiOmuZTN8uG8xllVaMLy6Ao
	FOBwZpQ0a/2t9fkRMYvuihbTGFC8eLDJfHwt/JuG+7e/BIJnuoV2pe3gkR4VVGgb
	DgPTVJAgUHbMzFj0wyKtgGJu/Q3P5mMc8daEhtl2LA/yqOHAUwAe90SNDbXAcTiX
	5gzfaDLJoKL0+rVW+mB6N7OpMgZcezL7+zfowIW59j/mtGyPduC0rO848gvezFw6
	+jKv9ORSlw7AR2wEx5vUBAqK6a5WbE48uRsj9g/7wNn+0clA4d02cGIAznwStTw9
	577kw==
X-ME-Sender: <xms:SRMEaaQpktPpc95WVjgN9VB6wAmdbAWrlYMsUONauKnym8q8UaeCFw>
    <xme:SRMEaXMKp7Me6vS4tiNI9g0TIMtl8EABrT4yXHV5UmmVf6EE1gBgZEcmYpaiiVpPb
    hR9Odco5lBNbYoEKg9PCxf7Oh8deb0Mqyo_1PSRepoakk9E>
X-ME-Received: <xmr:SRMEaVPNBCJr-xBtG33vCWDVNhRrQEv17Z7mhr8hiwDDP4CVqdfUhGihizLkz4r6oCzciRXQzfG_C04a_nWhmuQQLGeFZky_tOQAA4LLHXSDxmy3v8Z98qmMFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepugguihhsshesshhushgvrdguvgdprhgtphhtthhopehrrghvvghnsehthh
    gvmhgrfidrnhgvthdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:SRMEafuB0vdEkPoGCU88ZJjr9B8_KSpxeapMw2QvldNykJrz7tWuHg>
    <xmx:SRMEaXVVLo1fR-PL72fSZ7rRsq2y9m49leBdv_HyOOwe0hIbrwvhyA>
    <xmx:SRMEafsB7wVddH_5TQMDD5PGTrg_PnzI3uaurlNISzk27f0LVQY8qg>
    <xmx:SRMEabVjwi3HmCLh03q6pM5y4ULjTbVZrtJ4df0CT9LlK519Vnv4pQ>
    <xmx:SRMEaV0TayoU_6wfgTQ-9SvBvH3UEF2abhFA0epitPWPy9Whp2GBL5-Q>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:39:19 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 08/11] autofs-5.1.9 - refactor do_umount_autofs_direct()
Date: Fri, 31 Oct 2025 09:31:36 +0800
Message-ID: <20251031013745.11150-9-raven@themaw.net>
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

Refactor functon do_umount_autofs_direct() so that it can be called from
do_expire_direct() to clean up stale direct mounts that couldn't be
cleaned up at map re-load.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       |   1 +
 daemon/direct.c | 106 ++++++++++++++++++++++++++----------------------
 2 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 60fd2554c..b9c655b7e 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -75,6 +75,7 @@
 - remove unnecessary call to set_direct_mount_tree_catatonic().
 - remove unnecessary assignment in umount_multi().
 - fix direct mount trigger umount failure case.
+- refactor do_umount_autofs_direct().
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/direct.c b/daemon/direct.c
index 97d64bc69..3517e72e6 100644
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
2.51.0

