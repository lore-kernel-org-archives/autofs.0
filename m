Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2512512DE
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874753; cv=none; b=BBVE9L42QIjI2mecrpVKVVxZBmKbQDLAFRjYVN8HKLTU8NDhKbQonPxEARHTJye3ubw7bjvwkYaKWWVYkPgWyQPw8KDQ8aU4PXZvL2afHWWMrv0GnUeFiNjwPP+ftJOT9bzWUccc6kzYCl1MXzitku1Beh1DCyaZiwNY99P2MZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874753; c=relaxed/simple;
	bh=SgMXLY9bhHYFiRFa64U/IaOtfHsxLBf2wwQuEzbNypw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCkdUdesJAldwsTU/qT929+vA5D/RC5kqtFjxdegkpR+0ULShnNicR7pUPdU82w0+XM16cRhRI65uVfRAS8s0VMQWNVJt8qOn4KPRMtQKFRrthvn8e/w4eQVX/IqBDpdQIFCUbqU+YjSa2Fgr8zUrMRLcyUE2xiT2gIJ/PNw7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=x0nqjdTe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDsWwDSZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="x0nqjdTe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDsWwDSZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 223637A00FC;
	Thu, 30 Oct 2025 21:39:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 21:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874750; x=
	1761961150; bh=Tbc4uQmjVl7jniZFmCHd0dCsvcY0yoisfHP1ai7mLzU=; b=x
	0nqjdTeud1wGZB8xy18kJaHzIEgVmscl45z+FojBvsORtCVekLk2RKt9YSl7O/z8
	4r/hOnX7M3oO+YhVnsi5mZMbuqpVcNkFpaIzrn4IWsrW0MiZJe7BDNOaA1y+/DQD
	ZgyVV7g1oxThmQjYkazoHCwpKz6adzIZ83sBgjIoPrJTllqcVDTc9rqpUzkPddlb
	661qAn+27INFE9OH+IlRB58qjtx4PWCiOASd735UXMJ6cYqovVCc97rL4m8t7n9/
	BwwewDmdvLnOhPuUPAN2O1HgHdrLWeVtpctueqQ4J8aT0GzSrCyvySH9rgWaNBUl
	TPC0eJ3TjyVB8djqInCxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874750; x=1761961150; bh=T
	bc4uQmjVl7jniZFmCHd0dCsvcY0yoisfHP1ai7mLzU=; b=EDsWwDSZCF9VYMHvA
	tU+0o7RvoxXuFOeH6HtiwnWVzJ1Ut+lLFDqjC2fZXZBGpXrLwrxxyhdawbEPjnMV
	hkEirjatldXAJC8EDtSA3Unvp2HnrFqPwH0bc5zGDRy6652W9YEPL9HaBfsWWxB7
	Opqh8SQz8NchC6CfbBTwDv83JAKreg6vb7d9ALkXlz+Yv/Fm6wyJb0BwghoEZ61k
	bkTTnVXILldBi7qAyqT2S1tjUMr8ceH4W2cRtG9i38ItGMlImzrTdjhiGCDqnPDM
	SzNCC0yq/ClWfgr4fTRK5gJFjXm9u6IXqqcGHa8HtKOPZfJLB4PDH/bsGm9KrJzs
	ugUKA==
X-ME-Sender: <xms:PhMEacxInDS4I5cF4MGsidEjeTxCyoqNIl83OzlXQ8KAGuL9vtRF2g>
    <xme:PhMEaXs-1IVKMNbt39lQXPjh3hfxML4eSasJ1cT5tpQ7_qfmMum8NQvgwQOTPlXNX
    nQDi31B5yeaYfzuo4kWBLedRGY_0nQ8XfhFIsu4c8UEOwzCDg>
X-ME-Received: <xmr:PhMEabskYyNPRom8IlQzk68meJgYuD8fKrQMZ0XIhC5z9Yx156tuowUeqb7JeHPxOhb51DYsJ4iDh95aysLKfCI7ArA2aro7rXZD7Z3wNZkzjF30CUR_01j7Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekudekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:PhMEaUMpZROtltCbQxNqbUzxKr2IGaj5WQas3uYsfNlY9bO5UPzbrQ>
    <xmx:PhMEaR0_SrPtViMPNBuczjsYGsNgV8IcNL4gkmDJxvsZkFotbTp1Vw>
    <xmx:PhMEaYNunmou-PdpXIp8NOcA1AmLzSibF4F-ob9C1scvIosJx_8NkA>
    <xmx:PhMEaZ3JVaXS1VBs9vTayYQ5Sjtw_09CUlWV_P4yPGwO3ffmjQi2cw>
    <xmx:PhMEaeXs6UNpbUnDZ03TEYA-uIo9fgWmVYTXW__9NMNNlJyHsBtIrrs3>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:39:09 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 04/11] autofs-5.1.9 - fix skip valid map entries on expire cleanup
Date: Fri, 31 Oct 2025 09:31:32 +0800
Message-ID: <20251031013745.11150-5-raven@themaw.net>
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

After an expire if the current map entry is stale because it could not
be cleaned up during the map entry prune (due to the presence of a real
mount) it needs to be cleaned up after a successful expire.

Currently this is done by update_map_cache() if the entry is contained
in an invalid map but it should be doing it if the entry is no longer
valid. In addition, if update_map_cache() gets called the umount has
been successful so the ioctlfd does not need to be checked (and is in
fact updated later in the expire process).

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          | 1 +
 daemon/automount.c | 9 ++-------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index d0d040bae..6537f075b 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -71,6 +71,7 @@
 - quiet possibly noisy log message.
 - fix devid update on reload.
 - fix cache writelock must be taken in update_map_cache().
+- fix skip valid map entries on expire cleanup.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/automount.c b/daemon/automount.c
index c071e63f8..75399ac9b 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -529,16 +529,11 @@ static void update_map_cache(struct autofs_point *ap, const char *path)
 	while (map) {
 		struct mapent *me = NULL;
 
-		/* Skip current, in-use cache */
-		if (ap->entry->age <= map->age) {
-			map = map->next;
-			continue;
-		}
-
 		mc = map->mc;
 		cache_writelock(mc);
 		me = cache_lookup_distinct(mc, key);
-		if (me && me->ioctlfd == -1)
+		/* Only for invalid map entries */
+		if (me && map->age > me->age)
 			cache_delete(mc, key);
 		cache_unlock(mc);
 
-- 
2.51.0

