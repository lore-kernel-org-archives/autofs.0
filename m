Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51874645
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619439; cv=none; b=XegqwxyYuUm5BzI7Js58YDEXAPW/tTRjeCrrD2QCtcYyYcCtWy0GIBUIhs18t8nw/l0boD7vq+3EYolIMc7JMVBCw0/5mdne4/sU/l/P9WMZIt2kaXPT/i7CMArvAdGKJSQi8FO2/Q0zoTGjqjEuw2ru3qj4jlVAR2KgJg+AgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619439; c=relaxed/simple;
	bh=ntOzjZls/uKFfQ112W3im9Vl2EvLoNELh9iV7phBDBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEag/884wdVvZ1KH5/5S3jAja5VtKQBq602+ZMNc3FKYxcMyqjMpDgkzK7AwySOZr5VIXn2Uad7EIyOGZTBbnjQiQD0rNeUiDw+iy4kIrlr16EskJ9M80jCylv/vKBzkfvlajJfbJam02r1C3Squ5B3v046Buq8bExRecyHxRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=Rown3dfv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JTo+xtRg; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Rown3dfv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JTo+xtRg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 49BD31D0013F;
	Thu,  7 Aug 2025 22:17:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 07 Aug 2025 22:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754619436; x=
	1754705836; bh=f57JFS9GHqaiHjaHStuG/xNDMl3bIOCBoeRqQOwQvsw=; b=R
	own3dfvTa+DgmW6/ta7+WKh4VeQdX5mWqPhLmGqS7OKZ6Ex12b4FhTRwDJFrqaRG
	HKvUuPbyYTnB2Q8eK8DWU2/4N2qTMH+pbgRzEe581wGm+jneKwwduxPnHmE5Sp7n
	QoAmOY1E1F6UX5uWcDUo2oyuVlp8g0DYE1qbCY26Pz33QCFpsVZVCyndlAANDgOA
	S19zz3a90lmSQpDjLGd5IQXYfmC8RYRim7zKxmBG7U1QXxJlobRxQRcf6PD9IdiZ
	X+2gUleNpU/6unpU5avuRlj3qWyGzzV6AIQfjCLzue5DKE+lAYj9jxHj3iiBaEnb
	aAa9OSkg6YUEDQHM3grow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754619436; x=1754705836; bh=f
	57JFS9GHqaiHjaHStuG/xNDMl3bIOCBoeRqQOwQvsw=; b=JTo+xtRgums0Z00fq
	dDNmV3EmPQW8ye+6bqe/9u/dPf87/9kq1fP2iL3dDd45stP2GthYXspDfDT18mJg
	/vW/V+8FTlmmhO2T9uvCBfurYlRii9MF/NSrKQnezPhMeKzs//JSERnwRVOrcLLA
	Dssq6KcFLdSHp4FT9ZbdjBH8s9Uts6doyvycXV6uloo0xj17HtSTQsZ5EI+f9OQz
	CKZVO/x78eBajsEXCBciUxpHXqPnB8NMKWbVcIalwPxnGJw4bNfj4NEpHRcbHxUf
	wxJGvES+F++EHNk1IWYaQ3qeb/WZjYK/HSxlm9bIFmf+E2gmDo0KLcO7knmQDPdL
	yweqQ==
X-ME-Sender: <xms:K16VaCJ7o_GKUJBWjvyBSfKWRLF-1JarWdXy8vaFbngfsiOMx6Y43w>
    <xme:K16VaNYBEvfs3IfXg9ajW2EbAKaInZqzMjYdgTRZ4BWlppeLwFS3PuQSOd8OrokdC
    ZN0YgI-ZJLg>
X-ME-Received: <xmr:K16VaMKPY47uIAS1Rggmnii_wEoCtjGY1XAmb7rXYci2kul2tiIH3d1f0jAPxWUeGBeQQQ9CAzE-d8i_5iiloIQN1xJGBGK_eCZlKhoTL8ehRvzcFDoV2fAIPw>
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
X-ME-Proxy: <xmx:K16VaDD9xUAst9-yDNvIdtK1YzaA2lwE33-gzQ4_WjLlXr1vzqaCKQ>
    <xmx:K16VaJpul4gmFHEoY7wmF_sREnntnYkE0_6kHPiHnF7Rwy0d1P3l4Q>
    <xmx:K16VaGh9oyXfeHTyoGfo66f5Fh2fw9IT4M-NC5qE52Pe7FQFpADQsA>
    <xmx:K16VaOCVVhjuWDbryaoCtGrYhyNJu7KrGt5KlDm5iLbHjq3wvDl3_g>
    <xmx:LF6VaCony_g-o5adF9jB57PjlE4KaWPLNVc4v1Hl8xETEmhvC6eGcZAY>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:17:14 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 2/9] autofs-5.1.9 - fix devid update on reload
Date: Fri,  8 Aug 2025 10:16:48 +0800
Message-ID: <20250808021655.12774-3-raven@themaw.net>
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

