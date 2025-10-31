Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997E253F2B
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874731; cv=none; b=Kswbje4jIpff4Atg02e0L3ftsGihzz0BE9ye4v0UYNb5KQ/6KuB9vahPjYxA0cFEGyC76lZNm2iTg6Z00IxpGokda1rTVewBgI10s9Qo510gkAtVoeUFCxxqe5PlexbNVHLxPQO3oofnK2b1BL81sQmu/fB/vCFBt+kUaI9Mdjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874731; c=relaxed/simple;
	bh=OsfMSgJYn1oZ+Drw4pZa1v2p3YCRodI7cmLCVrdpnt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COxU7BzYZWAyQd92dRyyy3QQLSfK7PXKHNldVajDDckPFaYVS+dtx3Jti0sXsBUzDqoEB4PWKGI2y8hbUObonoDt1HXOrkvcr4faRMuqQretD3MKW1OZTmBJOxCfUlvZ0gl6FYz/JjLLg+4f33bdhiparIV+QDW3anhLm7L45zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=nbm8Oqil; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UnacMega; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="nbm8Oqil";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UnacMega"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 665247A00E1;
	Thu, 30 Oct 2025 21:38:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Oct 2025 21:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874728; x=
	1761961128; bh=x76O/wfd5Hav89qGNLSz6Jy57xJ2RhakVNfn+/JhVRc=; b=n
	bm8OqilEbgiCd8mx+rQSTybZhZwHukgOpXU4onq4QmMel30AesPJFs8NF9+sL9ZM
	K+pQRissWewpB612kzSSchBZT+Gl5gHTjgPP3qLZjelKgnkYqgtfyBsgljkGER+C
	qAEjFKRr8K6z1srHl1D+frBRNaIxyd53potHB5y/Xgd8SfPn2IMgaHo4fTGqBf40
	k/k/DH2UxfkEd4me4j8Zm49xO03CMdKbGNymZ1+nrFxEES4S2siXl9pgw/wQUlU2
	je9cr9oWIx7d1+xEtyTo0lKyJmZ3cBXjrRlzFS/1oVun1/QkaROBXxJtkFwtCKxc
	YRWSjVGL+Xdz0wmCpBcTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874728; x=1761961128; bh=x
	76O/wfd5Hav89qGNLSz6Jy57xJ2RhakVNfn+/JhVRc=; b=UnacMega5cNtINoQ6
	YSlpRQHDF1WchHevbjvqYPInUabjR0LvVKF3n9yh8n9TwytE+M4RARUiCRfLG/rp
	veNDFAm9mWbsix6lxazLKIe446EMBkT4UT0saYcewY7ddgDFiPS5MX915FNCLAkE
	mWY8M1A7w+ERHnaMJOyyYqerQrDTsgrtC8XKQZNwIVyU0cAgwm7o88ETPKYBq7ce
	GHyzz30n9FcfgEuMkgpDxaxEzOqdeHqepUPhpiZXH+RE4isCCIc0ZJ4imT/oIEUY
	ZKRADQC4QYFEC+hgzJPI4nPU+ofB1MVX2yJM/ZG/DLLAWIyrpbj08fdIm4pkZue2
	26/8Q==
X-ME-Sender: <xms:JxMEaRoWltWLsH95yYLLAEenSOaDoo9_KfafDrrAnfbgiJ6-Sikt_Q>
    <xme:JxMEabG8jGbMmT800ZgGMufFzByUjPnz4bnMHT1vFO7DnS_MyzXUiUy3agh5eIPFz
    DBjq7lJVf5W9vh1RKfnX6khgCYoIE4xutvjIgGXUAQ52yymog>
X-ME-Received: <xmr:JxMEabllHcE1hQDdQDXJTo58WJ4XvVN_x0n13ScHg8P87-1R-gF7WdopBKgGOe3l-alSLBWBjjIkzIIVI4zFDxF8VKewly5y8sWwZeGsbLmfQscOzVx8rGCQag>
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
X-ME-Proxy: <xmx:KBMEaWkJP8AYiSEnlgjVmifYWtQzNgCkxRAVKAUbufD4moX2rNiXSg>
    <xmx:KBMEaUvTeKJXTs19cavHaI_7owcJb1ikotHflQ6Ij48dCqKt6uJg1w>
    <xmx:KBMEaRna_Jhl-oPOAXdY4UhfOb-8R-GiJ3t2Ee39LiGlMHzXhEyY5w>
    <xmx:KBMEaXtcenonSVZrjcBMNucRBRarktcsPqrNTc1BJIIpTX9BuWz5lg>
    <xmx:KBMEaTvY3nOOHTKeQH1p-c3efLedYASuFzNJN9GZxkonCG3O7c9qpWmq>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:38:46 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 01/11] autofs-5.1.9 - quiet possibly noisy log message
Date: Fri, 31 Oct 2025 09:31:29 +0800
Message-ID: <20251031013745.11150-2-raven@themaw.net>
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

The message that logs when a mount is already mounted and only the
timeout will be updated on map re-read can create a lot of noise in
the log for direct mount maps. But this is normal operation and is of
limited value for both direct and indirect maps, so remove it.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG    | 1 +
 lib/mounts.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 090206346..1e9d2f2b7 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -68,6 +68,7 @@
 - fix state queue not processing state changes.
 - refactor mnts_get_expire_list().
 - add en xtra logging entry to tree_mapent_mount_offsets().
+- quiet possibly noisy log message.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/lib/mounts.c b/lib/mounts.c
index 7aae5bb01..009e11447 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -2900,7 +2900,6 @@ static int remount_active_mount(struct autofs_point *ap,
 
 	/* Re-reading the map, set timeout and return */
 	if (ap->state == ST_READMAP) {
-		debug(ap->logopt, "already mounted, update timeout");
 		ops->timeout(ap->logopt, fd, NULL, timeout);
 		ops->close(ap->logopt, fd);
 		return REMOUNT_READ_MAP;
-- 
2.51.0

