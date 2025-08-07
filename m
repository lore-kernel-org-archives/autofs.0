Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A61D88A4
	for <autofs@vger.kernel.org>; Thu,  7 Aug 2025 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547648; cv=none; b=DREYmAdWczDkKmc29hc6QmGArWJqIoK54T3VxPgpZ4jWDaptFji5xGdWJFLapoHTwPsbXj2FblOfjNdxTyzgF+IVP8HS9GdTeaWWGYrwTnKQUa3TnYFCb3/vsYkXyjDSdZlA/ZHxS+11QWwwcqiFXeMmQsUhKwnPuuT2iff8R5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547648; c=relaxed/simple;
	bh=/bDt3+4D16UCPdEyj28utmaSATFXhu0Q/tc9+/+NZf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+KsM19ZKwbkQfs5SNQZ0bIHnuhd0ezgXfZwKJ3Igx7gHvIpvdzDAQ9EbhW+hpJO6xAyGBoBeLmqezj8NFSEqCSOQBUQcjzoUYbLau7fuqsVV5/oNak57/jmR+tVYB1U/kAY/pWVNC5CQMJVcbGmmwCGmLEE1lRVfVC6SfEC2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=dd3nbC+e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kVTgIjmZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="dd3nbC+e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kVTgIjmZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F0F01400186;
	Thu,  7 Aug 2025 02:20:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 07 Aug 2025 02:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754547646; x=
	1754634046; bh=CNzFRwFprV91mhZlXOiuJy74IuZiLmQhwNQnukGF+ik=; b=d
	d3nbC+ePt5zCicTMXzy1r2PRgtnLbI5+ptwomvfS/mnEL0ozo4kdXpGhUgzIIe29
	RaQGsmMrZK43QcYgZ3dNDPru1aZIe+YlBm3YNdnVlqtd6JxJCxIgPrQpf39/MhUs
	6fRXtWdCqWWZBZk/hw7Ro76Tt72mXn+n9qzZDTdv224Nj85+IVpfC0KAV8RWk3zp
	UOQqQZv8G/9AKoY0zojVglOuYo/N+YDkUrBfrGFqhuMF94NHs8C1wKlDBWWoyomO
	vmIcjhduiTdNM+G/s+X3AtoDbZu4uaVX49hiIBXwyGWHwb+3sAjcxXpZ4brs/usJ
	AommA+3iFZ7gNSEg/DKEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754547646; x=1754634046; bh=C
	NzFRwFprV91mhZlXOiuJy74IuZiLmQhwNQnukGF+ik=; b=kVTgIjmZsqueJMiYZ
	VfW13nfyGG8S/2Z8UoAtUJYiXpfdxCDsXD2yykN6KWAO6wnfBq6YVjmb8VZy2w01
	iIcXPZArMltmGshcwXlJ14rqAibCQ1CJrsfnnluP1M0pSGbVakI8KfFjUMgD/YOv
	PDq7QARmj6xxtgu/YrLS3dVwZvo0X52+lYDKwajhduhnN+L5Ta8tGJQAp1BbQgEN
	nVFUBkysqybLZCjWE68m3opy3ULIkgfkQsVJg6I52ysLrk5QSndkzbGm3J1vcwQe
	UzIf5PHVaOOCy+V8Hx8xBfwPtnVUi9cAq2Xz3ZFWzWFqc/iLkiZBxhaZe7aPaPlS
	guiMw==
X-ME-Sender: <xms:vUWUaEBTFarfFVwBuGIYA7ss9nhbEy2Xu938Noz7SFRehSLhib7IgQ>
    <xme:vUWUaJz6XQcsZ08HwW-1kUT7YoTKsRLBzJtfkpDGteEeDtz-cF2OPM1MgQwGmisa2
    cH_F18pmVET>
X-ME-Received: <xmr:vUWUaBBgxsqRbQBu8T4dU0b10EWln_USAHQUMs2yuVwexwSt7-3sbEnqzl8CDMSLHN4sbzFctxnKEbZAu91rYMoGJYw2QvP7lpPS98lpICdY0LYv7Z2AdurG-g>
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
X-ME-Proxy: <xmx:vUWUaGbC5mnXmA5NyV1SAv_naD1gZA9S1Ch7q7FD8QPbueK_9pcfFg>
    <xmx:vkWUaJjqgR65ZDoPvmPQ5EbAYW6JMBFwjvXmEsnVbusPolDEmXzrww>
    <xmx:vkWUaI58CDgHfNbCy9BjaNh5YBlT7HV2uliWPvxndxEI9msPCI2O-w>
    <xmx:vkWUaA5dm9XWadOdwkG96nPdUTllJfDxKQ8KwdX5Y0eZt4tKV8F1_w>
    <xmx:vkWUaBCQSTqVAfzsFYbLZft--4X7yYYDuyQGzrDvyI6n-5nLuU2ntxpO>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:20:44 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH 3/9] autofs-5.1.9 - fix cache writelock must be taken in update_map_cache()
Date: Thu,  7 Aug 2025 14:20:01 +0800
Message-ID: <20250807062007.14996-4-raven@themaw.net>
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

