Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861182512DE
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874756; cv=none; b=pnMNHOMHY22f17qEsDqAwUD6UURdJNss2ICQxtez5s4kgmAKlCQ0NA/jew8kGFTXKpvORwoCbtwA01al/mgRm1RfSzKb/r+6Pt/6VdfQFtBsygjNSyOCGJNWnvwM2gMAj8ipfPyDH1n6SyqMW/2bXwUkYn6jcm6TfGjxOMkYWT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874756; c=relaxed/simple;
	bh=+e5GYPx+TK0ODB1xtVD3RGhp+/DvRWvO3JwlLAijYj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSZ0Ny1aMMAHun0eACJNqa13haIHz4Dyk8kAejTTNBMHf2qcujBgyRskG7rKZM0RS1KFqPlA9w9vvSFp0tsljESU+eOaNKN62SWCIv1Qy5BwM7Ghn5O7Y8w3ykQPrCYPuA/4A19mDH0BFLnZwgV2DeOJefAiNSsA9mfjmA0QcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=zOt7UNOi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fcy9/rsC; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="zOt7UNOi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fcy9/rsC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B581C1D0015F;
	Thu, 30 Oct 2025 21:39:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 21:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874753; x=
	1761961153; bh=wIwanL8mH5IvF09TS9Y6Uv7s6MTsGw3MQyAa2f8VIa4=; b=z
	Ot7UNOi1WDPIDNzMYLLUrN70K5YC9mRyjuY+d70I4/azlZKuv8vy6T9xC31Z0SH5
	mk+7CVgY+qpY0XBN3E9MBlMafcyrc6wxqGoqf6gt1Gc7L+FOYDss4EgaaiJLsrb/
	XsGfI1rp+SZjkpOfDKN8aweI+dicPdvaj9TGMHWIDZKHZA+VgaQHGNd0hM0XzfQ8
	iQifFGxu6WRtHrNaI8oLJXzGTZVHKyDZtKqBFXJ4ajBpYWdUv34kiuomQLvUpTWs
	ebYMKcm2Sqf/YOg848mtGHiqfEGdsnNDJM25fEz4kaXcGgLqWWNcpUVFFScF+yVx
	OnshXb+Tu6qmWNq0NkwTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874753; x=1761961153; bh=w
	IwanL8mH5IvF09TS9Y6Uv7s6MTsGw3MQyAa2f8VIa4=; b=Fcy9/rsCn4s64ByE6
	td5u7GG9wex60k2wd+NlOBmx0cdXVU2mef5KTu0/dT0FIhsc75kvQlxjEplypwch
	0r72OUf2ezjt+csv8payLzMXx5TSnhtTiu+b7j9rqYllZd9pyElJrurbjCL7ljKv
	LXC6/vtZA7+282xYb/oGmTSZP2tHBpcR07UsQXbAIeQnrbJ5gdmFyTB9wvTlaEGX
	kOItzMUCgqSf0KU1geY06Yr1oDLLUhGSIlBdE+5H9Wyt5CV3IFXmy9petg7AmaDS
	epHmQyChPzPyX/dU4o2WSGh15ubjHi9+Ose81WCkGtzRC2OaUxqd6gQMlG5MunOd
	d9VUQ==
X-ME-Sender: <xms:QRMEaRMIdOryo7SPjgXZ5kSc8_7xwWq1b7tqucyFxDWpHY6FUw2qNw>
    <xme:QRMEabZ5_q-haHcsHTgFXh7hRhYF2vXgzDMvOZ1TU2xfaFtouwS8qjt6DHxWn9dk7
    zsztOEqQ1N9RN6NFASe6HTApW6ANEPJsrDB96xY0PT7CbSO>
X-ME-Received: <xmr:QRMEadpe-czWKotja6dzS0ybgRKmUM7SAiG1Cghzf2RIIurHUPHQcC7blB-e1QfOXGHm-zi1P07Hb6h2uH-e_tFs1dEfGGBV0HkWi6LfehQV1LBRGWpv8ytP2w>
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
X-ME-Proxy: <xmx:QRMEaXbCJ7dB46kchndVxKyOTtja7mMLaioL5eoVyLUNqCaLDSFhNg>
    <xmx:QRMEadRLzbcKCKNIIaPObX0JyVex-hWQg3eLwn-u1RwNKpC3L26ylA>
    <xmx:QRMEaW5Ci36EZ8jmVcV3WhmElPb5C7k9wqPKlaFH00C7FrmlqvYkkw>
    <xmx:QRMEaawmNQ6TN4oxQTRZwXHoN3L0-WWOflanpwcPOK6lHyflkwQsoQ>
    <xmx:QRMEabA0l5x06UeZpq4XooabV_KhDZLa81epOm2th4HyK6ub-GYZhVyP>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:39:11 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 05/11] autofs-5.1.9 - remove unnecessary call to set_direct_mount_tree_catatonic()
Date: Fri, 31 Oct 2025 09:31:33 +0800
Message-ID: <20251031013745.11150-6-raven@themaw.net>
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

Function do_umount_autofs_direct() is called in two cases, during a
readmap and when umounting top level direct mounts.

During a readmap, mounts should not be set catatonic so the call to
set_direct_mount_tree_catatonic() is not needed. If it's called for a
top level direct mount the caller, umount_autofs_direct(), calls
set_direct_mount_tree_catatonic() itself already. So remove this
unnecessary call.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       | 1 +
 daemon/direct.c | 5 +----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 6537f075b..c1f8073dc 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -72,6 +72,7 @@
 - fix devid update on reload.
 - fix cache writelock must be taken in update_map_cache().
 - fix skip valid map entries on expire cleanup.
+- remove unnecessary call to set_direct_mount_tree_catatonic().
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/direct.c b/daemon/direct.c
index 9566ee71c..a97d18348 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -186,11 +186,8 @@ int do_umount_autofs_direct(struct autofs_point *ap, struct mapent *me)
 			warn(ap->logopt, "mount point %s is in use", me->key);
 			if (ap->state == ST_SHUTDOWN_FORCE)
 				goto force_umount;
-			else {
-				if (ap->state != ST_READMAP)
-					set_direct_mount_tree_catatonic(ap, me);
+			else
 				return 0;
-			}
 			break;
 		case ENOTDIR:
 			error(ap->logopt, "mount point is not a directory");
-- 
2.51.0

