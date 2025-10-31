Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F524728F
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874752; cv=none; b=lq1TqnQd9Y0MTHYZRIhSK87L5Xtia1QSTwEQEEZ1bpVwkDLfRzTCQyAE10swvPnPMCvkn7tXTbhI+IQGCOzeW79/k9vd+X3UrVk4oyUUVh4CCSF2TSGY8uPbPWNtv7N8ZTvbi/kbx1yB6AnFuelu4aP0UweSmDmJMhzXchwSK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874752; c=relaxed/simple;
	bh=YgQsWLQTE3EDLO3WhHazc23iihkjzQkqyXw3yxUkKEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MU3pZi88s0Jo/bzCpPwntMWR9vKvgqvnUC9l4Bmyo0rYgC5y65FOeHAk2HOm9Pu6XwiRI8q2m9KhW12OGfDRrv7+eHkkO/5kRxxYhxE39T2oXewIiZTwuWtA2w8/TOInP9brDSEtUc+mziGJAhgGkVnicg5rKOQBdBqVDeYU85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=o4qGprUn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UeolqUKQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="o4qGprUn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UeolqUKQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97D197A0100;
	Thu, 30 Oct 2025 21:39:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Oct 2025 21:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874748; x=
	1761961148; bh=rvPjn/HUEp1PRAFoTTEGpEVJdQ85A40IwZWQZXIYqyE=; b=o
	4qGprUnvMs1V1/uP7Iddd2MGqqRAQJXq05YceYlqnL6hDy/lTn8QkGARtKtXXNsL
	mwPEiKnkMuQDDk/fWLL7x9TffViN4SNYWbse70JlS6UHPDQYhHvNiyIf7ATUw37D
	/g07Oz60moNMwR/3mSglmUBEWooDCVyZxomT4cgcpY9pOvLgbnZ9JIxx7nqJxPKG
	Je5/uJ8mnDon9QwDXyOJg4++kGg2LzWBG/qS9+MDhMwXEQmnVBR86eKdMzvZnc9X
	LDlrrgm2T3dXJUf0TaPdPVkeOuwS/RegpFSCa3uRJ/5GhgqC7qgwq6U7RfrV156G
	6ZhYRJemCEIW0cAxwEkXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874748; x=1761961148; bh=r
	vPjn/HUEp1PRAFoTTEGpEVJdQ85A40IwZWQZXIYqyE=; b=UeolqUKQ3SbsiB+/V
	AKnjUoVe+gyCFfqsQjKHzVGLpYeL3lK5jXd8OivOkGY43ICtGIF+rDybwmjjWPyq
	lb/gVtG0in+IcElJqr3X9C+Ei0GJdu5ytaaU929IX1v9GhoY3Jy4FmfKHihh+vei
	yv67Yl3oErVP02MJQ9Yk9kxV2egLEINspNflujMMPt3MBsl0ab9nTXwLWVLrqRYZ
	JMKRfzm23F2ATY2Z2Vk0XWW4TvbxdOAhY74wbUSfRDyOCms2MsbUPDh8ifmEh4LC
	yQ5EGVTVrVv4so167CwzDuHsziuy435MLbdcYjgee93wjIUpcFs1I2+UCUHoh/ua
	PVo2w==
X-ME-Sender: <xms:PBMEaUBVV14mg2JviffvxtmA_GxOfBzdwLIpIvezKizaTzeYBwy1qA>
    <xme:PBMEad_DmGq9L3yEeJn9wNNGqpB9x7OmKLo8du8NOZmGj3EXhYiEg7Y7mwVzGnOdd
    yuajCBorUuHAk2Eh0Qbq5oJeF_FlWcNm6enmCSo3XwQa0s>
X-ME-Received: <xmr:PBMEaU_IF8vcuHRCIRIbbSyGweVy--YdTXBFWT2acfHY9E0RJ0SVDY2lsYeGbPLfnR9CMUfteM5unb_z-JAit1zWdRvC_YSZfxC7Se9t1NHxna_c1d_UM4NVAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekudelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:PBMEaUfHter0RmINUQok16ODZSHcPhF_V7f_-EGq0RbuvK3ipHYkcg>
    <xmx:PBMEadEeRfIjZGjtfbPzGfJrpN3SM4K3ZTM6AwZtVWb5FRJz9lJCiw>
    <xmx:PBMEaSdmW_Kr29mDtBOb5gCuoPk_EHJ_95ayb2n1G_20GY8mUhJ-Eg>
    <xmx:PBMEaXGSeLoMKRC6nItaYQWrE2GA1ybOMM_914hsafSmSMvRc04IJg>
    <xmx:PBMEaQmXI9DlXoc4SPIyjzyJnnTGNdsjms58YE6sZJB2KGZU4cXVo81p>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:39:06 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 03/11] autofs-5.1.9 - fix cache writelock must be taken in update_map_cache()
Date: Fri, 31 Oct 2025 09:31:31 +0800
Message-ID: <20251031013745.11150-4-raven@themaw.net>
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

In update_map_cache() the cache writelock must be taken because we need
to clean up the map entry as it will be a problem later if we don't.

It's possible that some other process has taken the lock temporarily but
when this function is called the thread does not hold any cache locks so
it should be ok to aquire it.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |  1 +
 daemon/automount.c | 12 +++++-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9308e0392..d0d040bae 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -70,6 +70,7 @@
 - add en xtra logging entry to tree_mapent_mount_offsets().
 - quiet possibly noisy log message.
 - fix devid update on reload.
+- fix cache writelock must be taken in update_map_cache().
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/automount.c b/daemon/automount.c
index e567daf82..c071e63f8 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -536,13 +536,11 @@ static void update_map_cache(struct autofs_point *ap, const char *path)
 		}
 
 		mc = map->mc;
-		/* If the lock is busy try later */
-		if (cache_try_writelock(mc)) {
-			me = cache_lookup_distinct(mc, key);
-			if (me && me->ioctlfd == -1)
-				cache_delete(mc, key);
-			cache_unlock(mc);
-		}
+		cache_writelock(mc);
+		me = cache_lookup_distinct(mc, key);
+		if (me && me->ioctlfd == -1)
+			cache_delete(mc, key);
+		cache_unlock(mc);
 
 		map = map->next;
 	}
-- 
2.51.0

