Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223347FD
	for <autofs@vger.kernel.org>; Fri,  8 Aug 2025 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619433; cv=none; b=ui/6qG/pMIkRM3fzAdnCZ3L38jtqcw02GASVJ74EVy06A9JEwJMoD4Q2zUjUfzByYy865eE+KsbjAqjQxozzdag+J+m9WOVH5wY4ahw09vtlXTEh1LBfoNIWH29te3nBO/RGbekP8rGuPCEq3FNil5l9JULtCGtzlsr+ZBYSrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619433; c=relaxed/simple;
	bh=2J45DKXANRHqU66rbL6GDAUJIM4VvSP7wKr1I2TssSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFg16kF49gKVeYk+qgnoXgaJh2D5Qsq1MldFhoZ/R56+xT2IZ/G3N03cmFwQrHfry3Ng+wQxBB59vcDpqwysZenIFPZOzYp8nQlVn30QeD+CUfIgdT9dkfw+Juaxn1gEJLLQ3dhqt4or2X76S8l4sVd8yZFV8rK94BHwIbvzPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=gQqNTEBR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UGFu1vs+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="gQqNTEBR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGFu1vs+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3AC3C7A00BD;
	Thu,  7 Aug 2025 22:17:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 07 Aug 2025 22:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754619431; x=
	1754705831; bh=wsX0qyushtOWSKiYLFtw/URyCoeWs7jD2Zg+XGefeYU=; b=g
	QqNTEBR7kfargZLcx8kQZBXNJFHa5ha3/fu83QVY7k/KHPbpe1ajZ8aKu8SLaDjw
	IeUYUMD6z3Watcb+/7zYSePdKfhjaMWrQv4dFihq7UHNg4SzPLHtto2Ww7dkekvP
	xboNZwRedPth/cQK+w1Cv61VTCyCmppQjNnTHORBw7nUujueQCUOp1YSThoaaI1j
	SxFE6/kJwHpORbN3fOg9rkVJwHODL/KJEq+hC3Y/Vl4YpJYbjHN7po3Y+THXTa1e
	ATrznU1sg2mKJvTA0bKegfiGbAZg+N9bkufDFNRqf+IlX/hDKLKT00lca+Jvts9S
	Lv7dz1SoOCEVGr6JpFxKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754619431; x=1754705831; bh=w
	sX0qyushtOWSKiYLFtw/URyCoeWs7jD2Zg+XGefeYU=; b=UGFu1vs+utu7ngahW
	3hvksd6K+odnDvCR36O9mViKybq1hwMDRwyhA+WxoJSaKlzq/rBsg2YkKyZKISoT
	Q0XFV/M64Zmtphu7D5YB2QtYGB33rVUryzAz+wHSXwTPe6eGGw1G6eSwUhE4E6kA
	q8gCPAbkQyXXyYHak2jh6ZkvMy8NBPUMVJUR67xmockMvx3Iy4poIcP0Qd0mIRGf
	L9vbBlHwSipwMJN8VWy8UvdomZsqKPzUSG3OumgA0UvAadWH+hkGTP41hgBIy8tW
	Jeasif3uoGaiokcTda1OVjsda1Qjwn9kD7EaBBXkhChxqsh/kAMwJYULRgdGm1iN
	xrxSQ==
X-ME-Sender: <xms:Jl6VaMQf4fK486QvyEsa4QTsmX_YqvQr1otcAAXMUo3i_ylQbidMGw>
    <xme:Jl6VaNCmkiEU9_R8PnW4fuucUtHEoPBrkS4qgYKUWi3Uh5OKkTesUiRsaA9YoGwDH
    4TkQfQaIBrR>
X-ME-Received: <xmr:Jl6VaDRq2h1xgIUuNjcAecQn1bQGuLl4CMkVSybGC5CBfpMCW_kwRm4Pf69vwoSIjb5w2430u39cYWYDgDi_Hh5c4RXE1nAj-Sk9uyjB9iOT_f1Mlxqy51wkaw>
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
X-ME-Proxy: <xmx:Jl6VaLpru1scUk9FuPotbhTfzYNlH8B_5eIPhcuO8CL-zBzJnI83DQ>
    <xmx:Jl6VaFx7nxeTi5orD-ddy4LE90QEq63t6_5VzZHgwTZCeS00Ot-gmQ>
    <xmx:Jl6VaAI4X0ZFs0s6PCw_9mrmAIhO5LG9Iva_2Nh8xIZqBmR4vBWryQ>
    <xmx:Jl6VaHJl40M4TIcwLuE6hsQnwMQJRstkX0vXlD8_uSa3PjJa7khJhQ>
    <xmx:J16VaATQXrDanQPW897YFeLMWLoT9pjbimQLlm1RKWiax8oxUA5Jm35R>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:17:08 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Ian Kent <raven@themaw.net>,
	David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 1/9] autofs-5.1.9 - quiet possibly noisy log message
Date: Fri,  8 Aug 2025 10:16:47 +0800
Message-ID: <20250808021655.12774-2-raven@themaw.net>
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
index 2e4f05cb7..37a0d25c5 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -32,6 +32,7 @@
 - fix lock ordering deadlock in expire_cleanup().
 - fix handling of ignored offsets.
 - fix invalidated map entry handling in hosts module.
+- quiet possibly noisy log message.
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/lib/mounts.c b/lib/mounts.c
index ab16252c7..dd295f4b3 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -2880,7 +2880,6 @@ static int remount_active_mount(struct autofs_point *ap,
 
 	/* Re-reading the map, set timeout and return */
 	if (ap->state == ST_READMAP) {
-		debug(ap->logopt, "already mounted, update timeout");
 		ops->timeout(ap->logopt, fd, NULL, timeout);
 		ops->close(ap->logopt, fd);
 		return REMOUNT_READ_MAP;
-- 
2.50.1

