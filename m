Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BA212FAD
	for <autofs@vger.kernel.org>; Thu,  7 Aug 2025 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547652; cv=none; b=NcUEVjT1I84SzSBcWup6qqBlnMjQdXJzHqn+xCzRDxl/jF8191wysX9SqwwLxF/J8uuopTJej918VwBocmnitvpRt8/bMOAEyRdJO4hmb/EQzj6EZtFRwmIdE2ParhRQKCoaEVxQum3mRLuxdLGpywGpClst0LMg47pXnBLL+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547652; c=relaxed/simple;
	bh=S9ypJgf2f6hLd0177dDp55OqRCmtRlCIGAGNabeASCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHElqywdWb7JMmchYUyvYpm6gT/JKKshKZq/REmd39wcI2iWAQxJKCMO7PlIBsWvn9AasyOZxiI1+UYK6Q3TwHOQgqbdlYb946jARExTGo5qyiv5CPp1TrS2PpivC+HuMSxs0TY+PxNH658T5CcVWgwxiULmeQpwVdk8ZgB38ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=taWKk/c4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZnj0QYS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="taWKk/c4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZnj0QYS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 78CFAEC0197;
	Thu,  7 Aug 2025 02:20:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 07 Aug 2025 02:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754547650; x=
	1754634050; bh=s3AeWu+gFeywcC13MgZlZULc7/hGrjsKD+7VMY8sU8E=; b=t
	aWKk/c4cANKYKJP5TRR3jc7kFT35dSK47QAW2qb48y61YQ+46+1CQ+UVG33JuglT
	Te0+uyEJ/zoSIcP8xn0JbYtOXmAxCCLFpuJ+vIfYtOgHHLN62sl2fqkdlEU2zDNl
	eDG5b5ntfJFUM40Sv8qFy7BMOXauOzPDL6oIlxUsLAAo3VOfESogvr/WLpziqKiL
	969lzMPUp9dew0dzlyefueMD3uOb3IefCmYr5AzLTxxWsbEAEs67Ox11ppLrrK3l
	EUIZ7DrEMn49w31CSW2lu7YjGDaqGrNisyjsqChqjbXHl8YUzgmX9AaaJ+YyMi2B
	h8GI757gw1+ahpMYrheBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754547650; x=1754634050; bh=s
	3AeWu+gFeywcC13MgZlZULc7/hGrjsKD+7VMY8sU8E=; b=EZnj0QYSECurT5Zgi
	OxDJWgbYlu2TYlwbfwCwWWG1EFYBPigkPTk2hlAb1RdMjTw+l1/2yEDrtMuz6tlN
	2xliTnxwkVRDp2h0cfOfoIaemTO78gDMfqKdwM7HPsaiLimM0z4Ee63x1tpnWrqM
	cXhMVRmlYnc2HApDluozGA3EuKv6uA07mqph6h/HaTfh8uP0AsqQbPkDfgHEwS6c
	zUloYznCitU9r6+5ECmbe4KoC3wZ5TaN2yYrMbLKxbfD0Vhaz2UHgerthJ26GgmK
	+ff+HS240/v36CS20DbNTDcDPb61USIlXsGaFKPJjJgooP99prZ/XGk3s9VaUqUQ
	UJ6Tw==
X-ME-Sender: <xms:wkWUaCjCeNFUaG3NWLhd9EOXMS5qwSB43xKGlD7ewNG88OT1vGBtTQ>
    <xme:wkWUaGSjOJAuKAurbYIAjdxnjngl5lXIQtR4HZtku0llBrleag5HCWWs1HHifMQpQ
    FsebsaejIP->
X-ME-Received: <xmr:wkWUaDjt44vVTkfEFVXEGyumFvIl6EViEtLSfsLMaWteGCWMAn6K9qQ-c2UfaZ6XhBTUkDOfCJilLWn7LHsbcFAtGIKxQFalIgPG1HL8RpRlMV2wejjonND38Q>
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
X-ME-Proxy: <xmx:wkWUaG7MLQFAORG9_rtVSZlLTmNiGV1bRYu4IrWzDvn-57emQyc82Q>
    <xmx:wkWUaABgJIpKiEJi1TU8uRQI8MMe7_5htNCtN1KeJJQWtKnHgD8MJg>
    <xmx:wkWUaNbpj21OOKQ8DRz41ph0nDL-2TggohwqnProc7zutzR6VDxYrA>
    <xmx:wkWUaLaU03r1R3Ngn27Mo6yGmtz3ocIAgIhgSvCBYqoUwKhx-0qM-w>
    <xmx:wkWUaFgiM6jFajmxsWFTeQ2R23V2fLGhnSvnYfEbjSrU3DkI7OC4R0N->
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:20:48 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH 5/9] autofs-5.1.9 - remove unnecessary call to set_direct_mount_tree_catatonic()
Date: Thu,  7 Aug 2025 14:20:03 +0800
Message-ID: <20250807062007.14996-6-raven@themaw.net>
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

