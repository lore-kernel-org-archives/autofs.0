Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9124728F
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874749; cv=none; b=q5QfxrqUCO3NrdLY2jwaMbVKv+zGb+Z18SfYJBR/cK8CHKWaLk4awywK+pQpVpjZs5Lor4oJek9MWBOBH4mm/CDkfbdCyfYCuIcGnjOjNQnUI93w0JOSIPi93qccMWbycgLLsImZbM7kOoz4o+36c60naSz9/Is9g3VPliLGgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874749; c=relaxed/simple;
	bh=URExKyWCEGnAVgRxfMdxVNBzWDZ5zKr55QaOIhnvBl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROX2h4ZMOFa6HLuwaCZ7Jke7P3P8zmtd2wdxLFn2QX4DvDvAWQJXVgTYA6sogoqbqJmHlbTo12ibbUlVJyx7xjjaN+eF+xr6JLxw1nokGOR572VyYt1peOfO5Nv7QzzlBGPZQNZLLK6jsMYGw2eu3b6DcyaoTVGFaAhGWjF4Kp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=kbOK/yYC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k2MppptT; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="kbOK/yYC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2MppptT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E72D7A00E4;
	Thu, 30 Oct 2025 21:39:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Oct 2025 21:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874746; x=
	1761961146; bh=QgzSQsQoafNckEtZixWPgKWCpB1OmaeCyqzmoDZdptc=; b=k
	bOK/yYCM5Rq608yjM2BLU5kq7hjPcxU1T3iT3I8YLlc3eo/pKfndOz0Ni4o7xxLa
	YlyI1Am2TGO+O1q1dUbU5R1gSGuFtwtBg9Hmfd42SYMEIOIHT+GVoz7Khv8B8yz+
	t5M+lngZuJZof1iuveuIqaGQAOx4BBHQ9MbcaP9JAIzukrq+5WSKsHFpFmtmUdpp
	vXczsweQEkRBDvUj4IE8SCE4UXYXo4Oo4g4ixaFRR5hF7SXWmkk1rjwZ/GhgRfpD
	HsknA5BRXE1giQWkdgVec8UtXbcG4YQb/0RvZCCgyllpif77995I2pANM68Twn9y
	iudr1Uct1EunE23fSawvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874746; x=1761961146; bh=Q
	gzSQsQoafNckEtZixWPgKWCpB1OmaeCyqzmoDZdptc=; b=k2MppptToHPkY8Edt
	J7EK2aIXT63oJPgkL5l16oDMQC2zEqeiww/vmbfiYimi2s5iyQNERTKtlbli75u2
	ipSlGkin0AEBn5qUHN4lK8zDS18ppC6Hva2lkgJCZkBRlu3pIO5CasQ9KbCGEkev
	dH0YdF60u+NR1cukxu969/zqZLI7Eguc2AojeKXEXeyFAt7vMtC+31wlD6XQT5MS
	Y4vK44+L9kEv9UEgHjrvzRgIfKQ3lFUNctSjOaXkxP1iMI8BX4v3xN992/+Q5FTm
	V2lEjM7c3VNl9zFBdbgKdKyzgQqMLPMHLu4TeDe0Wuuga1VZB21ynYNh2L2k8k8u
	tGEYg==
X-ME-Sender: <xms:ORMEaTDbyi7oqrP_eMmaCF0ImFmna-Fcxubf9WtJh5GNadx2WOAjbQ>
    <xme:ORMEaQ9rXo8-v6ur2HWki3fhjvML7feWiUxiTDL-6g3hB0meTObPu7M0ON42Fx3vz
    abLod_MQA66hoQO1E1cL1vVxQQ65ULbjFXXfmt4_WWOqKs>
X-ME-Received: <xmr:ORMEab8XtcfzrjSU9NFewuPkNPq0JMk06tooIAdICb8LlrCsV73bxxybgTrElWVkgUNn5C5pwT42eK5wVNglGl16gKLUI9mjp3UyuwGFWUtoPZI1h1x2WKCKHw>
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
X-ME-Proxy: <xmx:ORMEafc5TyoHiN1qSdq3JgyfZTsESQla1NXBUcIoH4wLIFX86Inb7g>
    <xmx:ORMEacET5T0EUHzoX2N6eeBfZoC0eTftH0xAQ8piS8lTJKOSqHIliw>
    <xmx:ORMEaVdQxsiVyFxfVHt8st17jWWeHKwJyUrg1rqfCQYhs1zGKd4ZAw>
    <xmx:ORMEaeFopZgsWO7YBIZsIXLM4LxdeCMqlojS1OnyKyk7PAm1ek5OLA>
    <xmx:OhMEaTlvwxbMT1zdDX-Ugt0w9Lcy5xFjWGKsud2THJwLjkptIm-xmUAB>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:39:04 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 02/11] autofs-5.1.9 - fix devid update on reload
Date: Fri, 31 Oct 2025 09:31:30 +0800
Message-ID: <20251031013745.11150-3-raven@themaw.net>
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

On map update if there's a direct mount in the master map it may be
associated with multiple maps.

If there's an entry that's been removed but is present in another map
and the removed entry has a real mount associated with it special case
handling is needed.

Currently the function that looks for these newly valid map entries
doesn't do it properly. It's meant to look for the first "valid" map
entry but doesn't check if the entry is valid. So if a valid entry
follows the an invalid entry it isn't found, the invalid entry is
returned instead.

Once this is fixed the handling of a removed direct mount entry that's
covered by a real mount can be done. Basically, the newly valid map
entry needs to take over the mount (which wasn't being done quite right
either) and the removed map entry deleted so that the covering mount can
expire. From this point onward the newly valid map entry will be used.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |  1 +
 daemon/lookup.c     | 38 ++++++++++++--------------------------
 daemon/state.c      | 17 +++++------------
 include/automount.h |  2 +-
 4 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 1e9d2f2b7..9308e0392 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -69,6 +69,7 @@
 - refactor mnts_get_expire_list().
 - add en xtra logging entry to tree_mapent_mount_offsets().
 - quiet possibly noisy log message.
+- fix devid update on reload.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/lookup.c b/daemon/lookup.c
index dc7794806..3791aa755 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -1348,6 +1348,7 @@ void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, ti
 
 	me = cache_enumerate(mc, NULL);
 	while (me) {
+		dev_t devid;
 		struct mapent *valid;
 		char *key = NULL, *next_key = NULL;
 
@@ -1405,6 +1406,7 @@ void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, ti
 			me = cache_enumerate(mc, me);
 			continue;
 		}
+		devid = ap->type == LKP_INDIRECT ? ap->dev : me->dev;
 
 		/*
 		 * If this key has another valid entry we want to prune it,
@@ -1412,37 +1414,20 @@ void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, ti
 		 * mount if it is a direct mount or it's just a stale indirect
 		 * cache entry.
 		 */
-		valid = lookup_source_valid_mapent(ap, key, LKP_DISTINCT);
-		if (valid && valid->mc == mc) {
-			 /*
-			  * We've found a map entry that has been removed from
-			  * the current cache so it isn't really valid. Set the
-			  * mapent negative to prevent further mount requests
-			  * using the cache entry.
-			  */
-			debug(ap->logopt, "removed map entry detected, mark negative");
-			if (valid->mapent) {
-				free(valid->mapent);
-				valid->mapent = NULL;
-			}
+		valid = lookup_source_valid_mapent(ap, key, LKP_DISTINCT, age);
+		if (valid)
 			cache_unlock(valid->mc);
-			valid = NULL;
-		}
-		if (!valid &&
-		    is_mounted(path, MNTS_REAL)) {
+		else if (is_mounted(path, MNTS_REAL)) {
 			debug(ap->logopt, "prune postponed, %s mounted", path);
 			free(key);
 			free(path);
 			me = cache_enumerate(mc, me);
 			continue;
 		}
-		if (valid)
-			cache_unlock(valid->mc);
 
 		me = cache_enumerate(mc, me);
 		if (me)
 			next_key = strdup(me->key);
-
 		cache_unlock(mc);
 
 		cache_writelock(mc);
@@ -1455,10 +1440,7 @@ void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, ti
 		if (valid)
 			cache_delete(mc, key);
 		else if (!is_mounted(path, MNTS_AUTOFS)) {
-			dev_t devid = ap->dev;
 			status = CHE_FAIL;
-			if (ap->type == LKP_DIRECT)
-				devid = this->dev;
 			if (this->ioctlfd == -1)
 				status = cache_delete(mc, key);
 			if (status != CHE_FAIL) {
@@ -1532,7 +1514,7 @@ int lookup_prune_cache(struct autofs_point *ap, time_t age)
 }
 
 /* Return with cache readlock held */
-struct mapent *lookup_source_valid_mapent(struct autofs_point *ap, const char *key, unsigned int type)
+struct mapent *lookup_source_valid_mapent(struct autofs_point *ap, const char *key, unsigned int type, time_t age)
 {
 	struct master_mapent *entry = ap->entry;
 	struct map_source *map;
@@ -1556,8 +1538,12 @@ struct mapent *lookup_source_valid_mapent(struct autofs_point *ap, const char *k
 			me = cache_lookup_distinct(mc, key);
 		else
 			me = cache_lookup(mc, key);
-		if (me)
-			break;
+		if (me) {
+			/* Valid? */
+			if (me->age >= age)
+				break;
+			me = NULL;
+		}
 		cache_unlock(mc);
 		map = map->next;
 	}
diff --git a/daemon/state.c b/daemon/state.c
index d570fce97..317b8ca95 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -344,17 +344,7 @@ static int do_readmap_mount(struct autofs_point *ap,
 		 * This is becuase of the requirement to continue running with
 		 * an empty cache awaiting a map re-load.
 		 */
-		valid = lookup_source_valid_mapent(ap, me->key, LKP_DISTINCT);
-		if (valid && valid->mc == me->mc) {
-			/*
-			 * We've found a map entry that has been removed from
-			 * the current cache so there is no need to update it.
-			 * The stale entry will be dealt with when we prune the
-			 * cache later.
-			 */
-			cache_unlock(valid->mc);
-			valid = NULL;
-		}
+		valid = lookup_source_valid_mapent(ap, me->key, LKP_DISTINCT, now);
 		if (valid) {
 			struct mapent_cache *vmc = valid->mc;
 			struct ioctl_ops *ops = get_ioctl_ops();
@@ -376,8 +366,11 @@ static int do_readmap_mount(struct autofs_point *ap,
 			/* Take over the mount if there is one */
 			valid->ioctlfd = me->ioctlfd;
 			me->ioctlfd = -1;
+			/* Same path */
+			valid->dev = me->dev;
+			valid->ino = me->ino;
 			/* Set device and inode number of the new mapent */
-			cache_set_ino_index(vmc, me);
+			cache_set_ino_index(vmc, valid);
 			cache_unlock(vmc);
 			/* Set timeout and calculate the expire run frequency */
 			timeout = get_exp_timeout(ap, map);
diff --git a/include/automount.h b/include/automount.h
index 0be7003e4..240ab3855 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -280,7 +280,7 @@ int lookup_nss_mount(struct autofs_point *ap, struct map_source *source, const c
 void lookup_close_lookup(struct autofs_point *ap);
 void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, time_t age);
 int lookup_prune_cache(struct autofs_point *ap, time_t age);
-struct mapent *lookup_source_valid_mapent(struct autofs_point *ap, const char *key, unsigned int type);
+struct mapent *lookup_source_valid_mapent(struct autofs_point *ap, const char *key, unsigned int type, time_t age);
 struct mapent *lookup_source_mapent(struct autofs_point *ap, const char *key, unsigned int type);
 int lookup_source_close_ioctlfd(struct autofs_point *ap, const char *key);
 
-- 
2.51.0

