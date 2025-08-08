Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DE17A314
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619446; cv=none; b=CIKCGQ5ul7f/btLm3YkOo5dFt/q4OUKHSmV3TSiSUwkC68QX3qMm23BO3bpRUH5H3vZ2Kvxo0Smmw4t9tYhJpMJZMc6194Xre0NxUC/uhXC5fWFv9Hbr/IPynA+DETAs15HS2cqzDoPvfg+rT8wW44vW4fn6s8v61A1aP22H9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619446; c=relaxed/simple;
	bh=v5GFo0q3NmVsDgD3ahrydtOGF8HGDDx0IpyqKjXE61I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u08F43PfjlWXiCIzy2rm7w/ikTJaBdH2NsGVTFwex3Ya9h+1TjGIBiKqyzstIA4PAXTJFAC6e+I9fOZ2HFt8UsnZPcIBNzFoMHwl6iGHI/+vA2k3WFhV3Kuo2MC9jf+nLkGe0QnKgdjkkdPMc9GYzIHTL617I7bNRQqQ1YvJJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=vw021LFR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D5diW6yZ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="vw021LFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D5diW6yZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2AA097A00C0;
	Thu,  7 Aug 2025 22:17:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 07 Aug 2025 22:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754619444; x=
	1754705844; bh=8K3n1N7577BciIiIg8XeJdoqF+cLE8GX8CFJoV1HItk=; b=v
	w021LFRFtyfC6qlPGgn4pvaof5wMIiJly1vq6LWgQNw4eMGQSkSuqrLLz5YwkpRf
	crJzCbpmzJjncLS946vz5Do5V4m46AQiSlFThfAv5fsQvX97yeyB9KVS91PoKQmc
	VivRiRcTyUWQoh0PORb8afB/CqXLATEOKackCMVotwVox4bqLe9AUBgODeNXX7/2
	djMsPtI+vsLZKNESYIGrr8mjVU88xSC3xRH2BcPIu7QX2IdLsUkVlLtecpN2UDRV
	4ucuRbb8U8IZQKjCYAyOK4n1YpgSwc+bq2D9XqPv9xiZRrA+BpOYGT2US3Rx8fc3
	KxCgA3yBT/0tx4+38ibjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754619444; x=1754705844; bh=8
	K3n1N7577BciIiIg8XeJdoqF+cLE8GX8CFJoV1HItk=; b=D5diW6yZ9NuXOIfco
	w3QfjLU0egUkOA8Fj4++okmGT2nvazElFK1y/qbcK9evGvqASuiEDKp/MosiwZ8y
	Una2AsjQF9/6u5IKxCUSg2B2XGX8IlOaO2KgSYeQH5yiMRaTdodkgcflJQeNey/g
	ftmO0VqEemKEUaZ3Bjp4iXGvsq70s/wlKADwa9AqsT7asBFRGiJLfOZEBpNaQkCS
	J8tFgBkrGPJKTE/JiTfZCHeFg7QfVZqwfD96ZSue3ydx5UEabwQmKtiIBhWCspNo
	ANWh52TD5eGexS9Mlj0PZKGoh/La74TJUn6hVO9D+NcTh+b9l+MT6QtxuPHmLdaq
	fcXEQ==
X-ME-Sender: <xms:M16VaLiZzuyWdQuDCxQPiO-_xLni9bMNC8OaEFLU2OkvDl6GG5tWRQ>
    <xme:M16VaLTLMOy8ldyw8t-1uC0fy_oDVqAIDHUyVjYvcy7zx038Ts5YHRUXV_HixDrbK
    huTXQBJTdb->
X-ME-Received: <xmr:M16VaEj3hDLZuuj2kQsnjudpF6R2XjdruFuG4hCE7laMv1FnTgSEcp-C6VrCZ8VrOZvDM5pjhqDvhy4z1aGGPSoKkoh7ltfn6jGt_AjkFJGwM8taozxwHw7DbQ>
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
X-ME-Proxy: <xmx:M16VaD51ickeMpnKjfuQ8_UUeHY2bWALeDTlVhdxydxT0tM0V_en_g>
    <xmx:M16VaJAgljKFpoE4Ple2SDmwG1iRhEBSQJukNjiFA9BkMM_5_9ZCAw>
    <xmx:M16VaCZHwL0B-TV56QSthWzGca2LyjeEfbs3ziVnKgdg1ev8j7WY5w>
    <xmx:M16VaMYvAXmZq4KUpVvNDOFreQ1RGGkBMdx4flbJxSsg5btFv_lrIw>
    <xmx:NF6VaKjBsXjnc-BNeCpnJYyif86_OGP6u9IzXm6PVhpoPqZ85OL7X2U9>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:17:22 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 4/9] autofs-5.1.9 - fix skip valid map entries on expire cleanup
Date: Fri,  8 Aug 2025 10:16:50 +0800
Message-ID: <20250808021655.12774-5-raven@themaw.net>
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

