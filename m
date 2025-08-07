Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD01A705C
	for <autofs@vger.kernel.org>; Thu,  7 Aug 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547647; cv=none; b=ou99DuKkRqI2vfHlWRL6dIhWvzK+iqyHioGeEalJKzTMRKBvS/V+XsnvDQw5LupYws3t2eW5qKUiPvSi1RPJSfBmqkDOS1TTo+BZvYkxmgE1qmdkGNR95H/60sUnmQ5nWEahIPm/uZHMIzhoMfUgAircqPrm96n9G695X1mG4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547647; c=relaxed/simple;
	bh=ntOzjZls/uKFfQ112W3im9Vl2EvLoNELh9iV7phBDBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkcBVotH6qsRawhtzV78Sb4yCoOTEmzuSumdEEwdXoO/S+ObABlpg76DzA/PbcJp3vcV/ShO7eF4ftiOFsLDcrILBrpqwhO2DMW1xGFWl4+jr0+AvRWKaueMO/MfECbesre+hTzBiePWTN1JO2z852EjKla6BeFGkGZEc+xkhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=wPaMEt3r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=azr+HTAx; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="wPaMEt3r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="azr+HTAx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE5E4140017C;
	Thu,  7 Aug 2025 02:20:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 07 Aug 2025 02:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754547643; x=
	1754634043; bh=f57JFS9GHqaiHjaHStuG/xNDMl3bIOCBoeRqQOwQvsw=; b=w
	PaMEt3rqMALByJGRnovvke6wxhiAOoGPqxmS/BmCmd9vyIULQux1sJf3EroniEWn
	BCZ2y17Qcp9FaTvnxkkIXdFIzFlGeN7SOqvpCudiA0BfudElYtscK0TTiSCJaHCa
	npl+pl9rZWST11sWx3DWaK3r5Fa3A5mA6gHrDn1PyWplVJ2AaFerDPh+6ldBZuv8
	NAaVpPCvfgk9vRgMZPQHEU5aXXg3UPVgDjuLNJOErzMMAxF62OsANjk9ITg8moFu
	f+OtkZtE01D8e7LCGGnSxh0qmDE8OIJMBdPBr4Ts8nriBxzIn7M/JzNVUU3LBYJ3
	jO0invzBYJ6AMwjannmyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754547643; x=1754634043; bh=f
	57JFS9GHqaiHjaHStuG/xNDMl3bIOCBoeRqQOwQvsw=; b=azr+HTAx/ZyuUFvAf
	ktslpwcZzHPXmtlrm34tbLbfKN5qsh+hcU6rsfggSViy6XNaa8N/rAumCXON31x4
	5A8NXdfhitMx95/ui3hzuQ1lXZlqswkLG/4+BLS3jCGNPzR/D+wpAKKlsIRmDjYS
	IUblu7rs47eZFFSZDDKJypM/twbq0F5tCuz2Qis1pWrscumj402uQMjHmAuqEoWl
	PoaaVyXXZ5q2rYKXY2AYtxkK7dSpWS+rq5RQmuvnAz73a1u72VpcGC8Q+MPEvwnU
	CYxROs053zQVGyQDM57BsFW6PFso6x37054jh5DRPsw2I1Isb4n7Y0dkye4LlsjF
	hGjTg==
X-ME-Sender: <xms:u0WUaH0j4mRY_52Fl7bN2EmZPVxO7v8ydrtYgR1oTd1tmF0QNvF78Q>
    <xme:u0WUaJVy5XEbA_EIXx5UFcxODpbS7QFlfIDZ5z3VYKK_qcGtJzgY7RjgSYAD5Beiu
    1mo5_i4AHqi>
X-ME-Received: <xmr:u0WUaBUrymP0x4xbsczn1LwRPqcnhZUnhENtK_h-wz9JV_MboUOBFKVcqDQrprIFgSX6KzO-lyjy1SjELoIdUDq-mJvJrkVmRNKS4YIryyk5Iqksyp7yskKG7w>
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
X-ME-Proxy: <xmx:u0WUaIexhndUKULiDdRzeXiqqgMp1AjDPXv1CZke0eQ310CqU8DrEA>
    <xmx:u0WUaKVh3qwz4ZgjPXbazFyOL7Ccvyptd9qGeI8EH1G4eNai6VZVBQ>
    <xmx:u0WUaBfbWO7xsxBHPYub3ijvyCH1hQ8Hfu7SoKElAYdZ5-JF3zWGGA>
    <xmx:u0WUaGOzDp-x5BG6Q_nzf7Dgk8ZMOkwBuk4USJh7iaJzV_zjYhafTA>
    <xmx:u0WUaDlfR6DBvDQHq6tRcO1c273AXWPuMo28mqVc76XbzltHQyECjt5_>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:20:42 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH 2/9] autofs-5.1.9 - fix devid update on reload
Date: Thu,  7 Aug 2025 14:20:00 +0800
Message-ID: <20250807062007.14996-3-raven@themaw.net>
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
 daemon/lookup.c     | 33 ++++++++++-----------------------
 daemon/state.c      | 17 +++++------------
 include/automount.h |  2 +-
 4 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 37a0d25c5..e18666399 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -33,6 +33,7 @@
 - fix handling of ignored offsets.
 - fix invalidated map entry handling in hosts module.
 - quiet possibly noisy log message.
+- fix devid update on reload.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/lookup.c b/daemon/lookup.c
index dc7794806..c7bf76273 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -1412,37 +1412,20 @@ void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, ti
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
@@ -1532,7 +1515,7 @@ int lookup_prune_cache(struct autofs_point *ap, time_t age)
 }
 
 /* Return with cache readlock held */
-struct mapent *lookup_source_valid_mapent(struct autofs_point *ap, const char *key, unsigned int type)
+struct mapent *lookup_source_valid_mapent(struct autofs_point *ap, const char *key, unsigned int type, time_t age)
 {
 	struct master_mapent *entry = ap->entry;
 	struct map_source *map;
@@ -1556,8 +1539,12 @@ struct mapent *lookup_source_valid_mapent(struct autofs_point *ap, const char *k
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
index dbd22be61..3760fef9e 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -337,17 +337,7 @@ static int do_readmap_mount(struct autofs_point *ap,
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
@@ -369,8 +359,11 @@ static int do_readmap_mount(struct autofs_point *ap,
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
index 79a375512..955f5928c 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -279,7 +279,7 @@ int lookup_nss_mount(struct autofs_point *ap, struct map_source *source, const c
 void lookup_close_lookup(struct autofs_point *ap);
 void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, time_t age);
 int lookup_prune_cache(struct autofs_point *ap, time_t age);
-struct mapent *lookup_source_valid_mapent(struct autofs_point *ap, const char *key, unsigned int type);
+struct mapent *lookup_source_valid_mapent(struct autofs_point *ap, const char *key, unsigned int type, time_t age);
 struct mapent *lookup_source_mapent(struct autofs_point *ap, const char *key, unsigned int type);
 int lookup_source_close_ioctlfd(struct autofs_point *ap, const char *key);
 
-- 
2.50.1

