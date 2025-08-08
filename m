Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646D645
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619443; cv=none; b=cXDYY1Cz8EyvVmAynPsGTqjgyiGFgmOAtQv6Yh2Gjyz4n1LH0a2mETaeHxUMW68W8IbCt5AWtHIG+yZlXIVBxKnhk/smOsE6l35JV0QHWj3KN/ZcufrvPDSL5DCB/zrKNaZB2aJgBi1GS+4EEZ45HEPcEr5eudtfMQkKbTONpA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619443; c=relaxed/simple;
	bh=/bDt3+4D16UCPdEyj28utmaSATFXhu0Q/tc9+/+NZf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/xDpvSOdqh4ykolEGswEVHPba1HVnIp9Ee4UFtKnmpDkijVhcD1JCptE1qe2Yfg0VcTn+6I/v+NgTe03WFm5vqbXUUyI7EVekVT4swV9aSuAYFrUJZUuJ1UDG7G/F9UZgRWNtcRw/igu/6Dq0f+Wwum7vT1XTrfTc3cflWRBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=lcxeM7sy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aTpsz7IA; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="lcxeM7sy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aTpsz7IA"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4ED327A00BD;
	Thu,  7 Aug 2025 22:17:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 07 Aug 2025 22:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754619440; x=
	1754705840; bh=CNzFRwFprV91mhZlXOiuJy74IuZiLmQhwNQnukGF+ik=; b=l
	cxeM7syESQ0moS39bGjSk28DgdkCKCFX0qttGrXOcB2aYwVMTuGH5laRFwgfPv9z
	mH61bZkGInEKfip74Ctre+DVHWpJs7kcGSqbTvZXT4DLt97+6K9hosOf4Nu0o+na
	G75zwedCGL5eNSrU7APgWLoKCrWAUoycjKr3YqDvvhM/ID0dNbGUVSI7/LuvhYZO
	A/atRehUz9TyTEJIybKZdsLBFVT2RhQmrXSl/riQ10CFY2Wu6ZdrJ6a/xoPQTPYH
	XS8jpbU3UG5a2PeGMRdjG1tL0J+ynJRjifcIx7f7TImY1L8wviVO7JnV68A9UwhG
	1Wzv9t9gsVvE6Q+sc6WgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754619440; x=1754705840; bh=C
	NzFRwFprV91mhZlXOiuJy74IuZiLmQhwNQnukGF+ik=; b=aTpsz7IAnFirIs1eV
	zYJ85PEYJgHQdU3tF3mURisw5Afawz89sSDB6RKi7r1+j9ok6cewHL9HGGW3hnUl
	cjGq9+ifpuJCwsEMrEM+G2xH40Xc/6TbRmDSm4K0u+HeMgrbsaLOmgTDNPuuytl9
	0qPhzVAN77S2ib2XYcTwsjEbpjydb5BH/ohIxIvGL5bcnG7xpnhIT0hcmfvBBWz1
	YMsnB0RacQZevaSscnCJF0LZ5N3F2VrKgc4NTz7PGeAndqPplhuuuIgUH5qLZLxr
	I684lAMRSXtuTHmWxosbE4C4y8OAg9cXYD0WDR4uwEmsckV2FPLJ5WEjVkEQCjL3
	I8PRA==
X-ME-Sender: <xms:L16VaJ-Wqu8ihuFYQI8Ro3JIeY5t9e2MF1KPGQLqvLM5maG64L95Aw>
    <xme:L16VaA8EB0BVPdla2iouf0d9at7s66d_nrrfn-aoSP6E3nAaZzteVxcFci6h59Inh
    5FHAIAG2med>
X-ME-Received: <xmr:L16VaAe4QDm9oSRaCJBov6rjDsQTQxHl8ybhCbS8kuVTzNdz-pXHlQ8z3OgEUjUGxDR0WCdi-LrBHVBD0XO8B6S3CswCobb9HEvnv5s7Re9a1YHeQ4BRAPXL8A>
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
X-ME-Proxy: <xmx:L16VaJEguqgNvgQLteIdXj1QQkBvc2xK-GI2J0bviUG6PBO6DGBzGA>
    <xmx:L16VaOekv97_liL3GYCdZlk5KwLBaaGFStwUJ0JjhovKPB7PJhp6DQ>
    <xmx:L16VaDHKh8oGKd9jGlN2huoZbavBtOutvtQIaf9EtcOG2W6BJSwbEw>
    <xmx:L16VaHXd04GMo5HFCcIE3wH8b1mHS3qPjHXiaZzbfw0PFffFuw6Vtg>
    <xmx:MF6VaJOMTLSuU5L24RZDSeVwWNiK-0R5t43ne8zil-eUKojV-nKfok-S>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:17:18 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 3/9] autofs-5.1.9 - fix cache writelock must be taken in update_map_cache()
Date: Fri,  8 Aug 2025 10:16:49 +0800
Message-ID: <20250808021655.12774-4-raven@themaw.net>
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
index e18666399..d9daf1e2e 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -34,6 +34,7 @@
 - fix invalidated map entry handling in hosts module.
 - quiet possibly noisy log message.
 - fix devid update on reload.
+- fix cache writelock must be taken in update_map_cache().
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/automount.c b/daemon/automount.c
index 22994defe..5476e84ba 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -526,13 +526,11 @@ static void update_map_cache(struct autofs_point *ap, const char *path)
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
2.50.1

