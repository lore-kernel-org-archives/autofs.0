Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44B7DA6A
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619462; cv=none; b=cj0QOWp8zjX69A2hiixWRLQIIP90Cs+4c+1rEQE/DAn9RPJ/PbYje+64wQVXqcAoiKkYBt0EOnNI7Nl4SArE9D6LK6srCaO31XYgxrgbRdML8vZ0K6+pp03T2Be2EM9iOBwmKuKFfaEL3mBvXbCDzID2Lulnl2hLeAm9kBTceHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619462; c=relaxed/simple;
	bh=3d66ZkDJtuQ/itOEtEoIsOp8ddwl0fn3Lcmm5D6v0PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSkSaIyGf4ECdf+I6f1qbMEkovKAkPA72bWQMH6p4nJ+mLOP6VsuM/alU70HJA1EoxpIYqQHN/q4j14VlaYUlHjd2GWhcqiPCY2K/ZVAwvQQs5wD4JlzdK56MM+j10wXEVlcoIRhlqM+6IukqlF2atF53oPd4ft6DRiSIm3Jg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=O+yy//CM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jMC8N6Re; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="O+yy//CM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jMC8N6Re"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8434E7A00C1;
	Thu,  7 Aug 2025 22:17:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 Aug 2025 22:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754619459; x=
	1754705859; bh=0NOT9+SEBCC6gAkma92lg7vKli/0Hp3i+UfKi09EnEM=; b=O
	+yy//CM28J/DETfM7oZDF+EapJ3B5hFfyqk8E8gQa97GPOmdWagth+gdzV5PUTi2
	NqjJe9CBGupqgpgGDBu9opvUDXucQSKYux3V3dhlzoVhiRpSTXhgKJzkD0TMymqj
	jQrg9PlDxoNnhmySwODrUSbWNwhYjWZwEQqSHGmbPlmnI1exkn39FeXZWciulvxy
	mYFKrddgGK1PtrEFjV+pQO3hrNpkGmk4l+D3xBuTZl9HlMaaGz1SsNDkXK6nDIVm
	sFpvp/oMF4nKp2SRiP49r+ZpjoglDZB8OqGgqbYr/LXNKd2Bhe90Pu3cMhJt4/ZW
	kDjHGW5xy9Sg5dR4XTsLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754619459; x=1754705859; bh=0
	NOT9+SEBCC6gAkma92lg7vKli/0Hp3i+UfKi09EnEM=; b=jMC8N6Regw0Sx38z4
	wRqeYgC82kJowy7XCtDCqqH4puz1I2AOPk2FsYpqWYDaaIu3KMf+sDxiTnCck+RI
	hAMS4ZmsMGC4maPRadV2NAfmbTO+J00h1G+TsODOHTwq2hIbYWILXQxad1ivZObx
	3d1WbQkUvCygwtJBB6QOGT0R5h5gZ8Ae78JZYJUik3tkRC5l3ySGUYNzOuWhtxq/
	y51imN6PBgezR1AHljylRZMmSQzjda2jGe5Suc+BRr8BPhLRBarmJJqfVzGlmGcT
	a9fXgiNk/Aqy48K9QqEH2BlGH61srnyEv58A/KJDZgh/lfdpn5pvjhbc//TQVsTl
	MXivQ==
X-ME-Sender: <xms:Q16VaNuJ4OjCQHDFTo09GSDd9bzYRzOaO-oJ-CZQUQ_Gudj2GU8IZg>
    <xme:Q16VaJt81xdwHRB8IvB6fx7-Yre4Y1xLAjPZg4Z0XbfQnFdw5ALcFDdAp0hTUSy2J
    3RHhKnsZT6j>
X-ME-Received: <xmr:Q16VaKPTYfKS6zfcaSEW88XUmPC-uQsCaSx85r32fXch-rmJZH0WBE2B_8GQrV_bWWaD1HAL4lunxaxVjj3lqgaWOS9KiWPZ7QWVMQ-WsZpwNUf7maYL-ZP90Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhrtghpthhtohepugguihhssh
    esshhushgvrdguvgdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Q16VaP0JcfbOw6VavAZXxCE5iibDyWlF2dJhf-8PdLyKLl_Wi-Cyew>
    <xmx:Q16VaOMP6CJq4UJ37H2EWmkEFJtv02U6q6UCI7RfpyfhomSivFz6zQ>
    <xmx:Q16VaH2_K0jejNb998ASQEvgFeEGPGZAjemEfVRACyPFd8KP2-aCzA>
    <xmx:Q16VaNGWFVl8FbywV3saPIq5bv0vYhlhm5zBMICUwU9uvFhu2oTGwA>
    <xmx:Q16VaF-1gq97y3-ymTRZb9VmEtdPYyx7sj85iYPduOqSoE5nde6pYnRi>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:17:37 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 8/9] autofs-5.1.9 - refactor do_umount_autofs_direct()
Date: Fri,  8 Aug 2025 10:16:54 +0800
Message-ID: <20250808021655.12774-9-raven@themaw.net>
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

