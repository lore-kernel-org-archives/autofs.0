Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FE1D88A4
	for <autofs@vger.kernel.org>; Thu,  7 Aug 2025 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547651; cv=none; b=Kr6tRO5leLmto9nxpMSy8l90VdlRZZMGrENHLITYgG6sDixzG/R/mCbmxoOiXnbOggrFCwM2nZW8vjPbL4lOMC5ns5a27C9zmuoyDnRMaBJzWScquEkDK3AFCxWraFb2Q7vRg5It9D6ZxqcCwYWz+c48N1C3Rf1GqyzHyFRChos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547651; c=relaxed/simple;
	bh=v5GFo0q3NmVsDgD3ahrydtOGF8HGDDx0IpyqKjXE61I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eu9zOwFEtCN9Gt6arTSG5AT4Ea8Wse9IbcjBCS4szowrG5/0eTaqwe9MwFwjxj30Htv7qYg6B99Xl58CnitE6EMffCby+K8BcE/GsjtfIqANTT1lm8SFBTTTijLYWyZOARYWekGexVdVeoN2lseJg7bp1P9jtqHXLEcx3kEYIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=TGY8XuKI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n0dvjtS9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="TGY8XuKI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n0dvjtS9"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 598E1EC0198;
	Thu,  7 Aug 2025 02:20:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 07 Aug 2025 02:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754547648; x=
	1754634048; bh=8K3n1N7577BciIiIg8XeJdoqF+cLE8GX8CFJoV1HItk=; b=T
	GY8XuKIrboRV7R0d56Y6UDDVkIZYiD4Vt7TxmkZjsVo8r36nnCRDzarAaNFz4Ezc
	epRkqAlqLjks1gzUFuGdTWvdAoxyooxBHF437jmUdXpWpbvcdWPCOzz2PuOcoxEB
	OOmOhhqzJtGi4hZtCdV2/asqahc5n9xDdcnKUFN55ioS7s+74XSa5QscHh2oPn/2
	XZl8W+g83ScBCdB4GLZsmhldyiRrvjBVtUhdjdvqCyUmc5taImD13iuFIHB/iWVk
	gQib+oeRpUKchLGepbMYsV1MfQM6fmlkUZ5AncDWpA29ZQuCh/u9O1MA/8+NUq1m
	2ZNokzhALVsgnn0Zjk+rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754547648; x=1754634048; bh=8
	K3n1N7577BciIiIg8XeJdoqF+cLE8GX8CFJoV1HItk=; b=n0dvjtS9YBA4U+ETr
	ElbQXiUXS2cM+GoCePdoFTSsm9nYXRcvx2I+O8LkHEnBChjLkYZUvbWZ6qNjXQ7O
	tSlASXzPFwYOkOFLKLMTU4AvCsN8Bgc1T0QUWfKy8vNq1039Nww1C63zeKLh3SMg
	wtoT7vbxAG07UtUUEIK9t1Bo/bQaRIolR092Zt1MEPhCF1HAChCdd9+bBToodCEe
	o9TBtgFEz48UfG1GFcODFbjS+FaFO1ZWRd84Y1Yx70Poyckw23v1ZqqmZYAQCx1U
	mQI8CehbwR/kblWQ29QLe98LEWcONUTklhP8AG+UVKrEMNrB1O4a8jeucheGSK6L
	s8CMw==
X-ME-Sender: <xms:wEWUaN7bzHu4sVdvkOB3rMeNECGU815C6Z1EZOsTmWJy3UjOoSlT4w>
    <xme:wEWUaOIZ6SzFlY-VaGM8g6cWdgCAFuc2dBXFPgmMeC_n6tvunoo5uPqfgU9oUJsVU
    ZL91T3T22NS>
X-ME-Received: <xmr:wEWUaN6Uo00Gehg6_xY-gFMPmmLI0O6az00ap3XSqPJEqkq40_SQIWagVrHUJksverYyS9VruHLui6EgNAhhy7i7imd6ma33Nb2UYamr7fYVz4-PbnPNB8wulw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtudelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:wEWUaBxSbzH1z6qmjQ3X656g8garCoWCbfffTzmzOy1t7vhGhJAnkg>
    <xmx:wEWUaBafjBT7LTuBrBDAmKnhYELYzTdT7hMzYQGVioleMxvP2SVd-w>
    <xmx:wEWUaDSK6ED29OxDzi3xvdl3FVtL55M9BHqF472FtkYlWU2gLJ92KQ>
    <xmx:wEWUaLxQTHKktabxizcAL4OrAR4w0J7mwlBQnLjBY--Mx_mkVHmjVw>
    <xmx:wEWUaHaXN1OpkJVAzk74y-RfJ2sjR1oO-bR2f1aWye2KlyPqdDD7xj5b>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:20:46 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH 4/9] autofs-5.1.9 - fix skip valid map entries on expire cleanup
Date: Thu,  7 Aug 2025 14:20:02 +0800
Message-ID: <20250807062007.14996-5-raven@themaw.net>
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
index d9daf1e2e..ebdfe32b7 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -35,6 +35,7 @@
 - quiet possibly noisy log message.
 - fix devid update on reload.
 - fix cache writelock must be taken in update_map_cache().
+- fix skip valid map entries on expire cleanup.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/automount.c b/daemon/automount.c
index 5476e84ba..5578a965b 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -519,16 +519,11 @@ static void update_map_cache(struct autofs_point *ap, const char *path)
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
2.50.1

