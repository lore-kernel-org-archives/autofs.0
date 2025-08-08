Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0310E7FD
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619465; cv=none; b=deRztV4uNO5G5WAj9sb/40UfeV4IWZWcOSbUwAIzA6zAUy5er7p/2bqp7+F3yU/7eT+EYRMQpCvKvpl2lnwABRuYIOcuvsOeQejX5wnZstZ3MXdYzXgzS+yqWhtDxZwRy+ZOLah4Zqc03XEa/zg1wzryxZU1kgGT6tn7dKrFIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619465; c=relaxed/simple;
	bh=JY/zKVD8uGJXiNupiLPfgzkp9MwsIMkvW6sB6gBQtzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EA3QAOiM/G7ObyaCCcKPaIwAsPOQZYvvRtMzBjwXOElcLFWvGqZV9Jv3AgSeF+bM9KPDtGsBnvRZOPoL/UYNp8bCF05Sz8pop89dA4ON6faLHXbotm0/wZbpcKjLu0X0MAXuG7H0z0hzZ30J+aiZ7/2Z52uG0UTEqxxRWvyZ96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=M7BAdiNZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SrCnmZ7g; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="M7BAdiNZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SrCnmZ7g"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 091A71D00136;
	Thu,  7 Aug 2025 22:17:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 Aug 2025 22:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754619462; x=
	1754705862; bh=4eVNC4DsaXBc2GC6InYAM0v9l3cFtFRV96Nt01exS44=; b=M
	7BAdiNZhciI2u1AXV24avTDe6egvvlNhO0jMlain+z0cn+pvo3RW2ni+97bM5hih
	UISp1ZaiZZDIuWOodI7dHWn8U3TlHMuyFzDw6WBn/T28ePGdyZiRAkB7IAth8MBA
	rEuWu/QCmed0Tj6XoxvCc/SeNhd+FtXuotTtxvvhDZK2MEexGuSNHDUYUKA+hTB3
	J9wzxYFOtZ/LSGGcwg3FiIJlLropuZ5LP0VFtS03KVWTIZDhmPkdJi7eA0XBYjjN
	VATdv+QKTPqjm61V5i7YZilURbRfuBpTjvLGH16DMas9tEJ0JelB4WaxlIIELs/X
	u1nsVrtAABqO1ZXTfq9cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754619462; x=1754705862; bh=4
	eVNC4DsaXBc2GC6InYAM0v9l3cFtFRV96Nt01exS44=; b=SrCnmZ7grGvpgxmP3
	sGcw19ZhLeTFn2hxnHmJ2TtA2n20PfHvzJ/4mHxSwjCvq/25VzD4zQ2dra2GeM3F
	5bnYS4ISOn2tMK1Tf6aE6Ur1Ifrb8vYnyV8J1OF+MJ6P6/T1nMoQC/Bwe1dUK5NH
	vbb6eVvMItpCEqHKepUrrf/ap7xMYfjGfsPGxio409DCdgTeLGGnW4m2D2O7/MMx
	vDpL3ar1VPXZRGAcJ0MNzrGQpAtSlBoCV2FmPUlp+WQ57024Eo7jlZBzL2AK+whW
	sOd+PAVvWoZTvEtNknrE6Ugqo4xp9zGXU4B8lGy4HXHxgG8EdINtPmYe9HPLdmof
	M4pnw==
X-ME-Sender: <xms:Rl6VaJt5hfOVNOLS-R_q4XecNtPyHJAbqdvdXHAJdPdQNlFB7Z9KHg>
    <xme:Rl6VaFsReFSkxIkS5WkULNyQU62EEUZ96KfNPkvVx4PIoNqiL7sX71LvPj_L5lpbg
    R-1bGn-WPT7>
X-ME-Received: <xmr:Rl6VaGOpZammmH7xdff6jr9FJRtvCgm1gb0Av-2XFHS0CHZymFss_TVRShnDWDCAp4up-JMdw9KnZyQAvYkyg9UCxXn_JFLSL0LcPh268RuzJMbSdDKSK6abyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhrtghpthhtohepugguihhssh
    esshhushgvrdguvgdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Rl6VaL2MHeJHwKpQLHd4kELo1i4UTvu-jiDvN-PI2PBC6oZcO8Hzmw>
    <xmx:Rl6VaKM71IGgO4JvLZJTDJiXb-7b47eGb0jJAl5yPaOTreir2m5bTg>
    <xmx:Rl6VaD3gCLcW-5poRDjJafm7KGVubJ5mPPOCwrRCk0fSTMvJJR5UEg>
    <xmx:Rl6VaJEIqekRl2WClSq7lyKOJUGcca_VVpUwl4hh-xZulDRLnnk6AA>
    <xmx:Rl6VaB-OhkzZCcrTzDJWnA07WtBl4vkAMjSUdJtGE_WlPydwuVPwWEyr>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:17:41 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 9/9] autofs-5.1.9 - fix stale direct mount trigger not umounted on expire
Date: Fri,  8 Aug 2025 10:16:55 +0800
Message-ID: <20250808021655.12774-10-raven@themaw.net>
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

