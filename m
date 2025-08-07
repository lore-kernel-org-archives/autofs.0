Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA21D88A4
	for <autofs@vger.kernel.org>; Thu,  7 Aug 2025 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547645; cv=none; b=Z53auGND6v9aCrFmXV7wdu4pT8IFIjmOiZoy5TNyYykuHWexLFO4wP1bjfjaUntutM46HcoVwHeS1AspOl5iQPcQuI5acA0jXRTuST+u4zzjp24rdFAxKqtbbRPegU+W9Ta2e0hrUwjpUwWsLR1eMvhne+XBmDjaEF5MNBYuEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547645; c=relaxed/simple;
	bh=2J45DKXANRHqU66rbL6GDAUJIM4VvSP7wKr1I2TssSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9swaaLUqVhRCQbOBvKpzUuOah3ztabxbm1IjVzO3oOi4wJTzvXzi1ozb6K1hUsSiv9hDyujV574VIohbj4WCweM+DzUuOAcSnWbZhgVb4/LTbXHwhQRAYgQMWRmK6LBB91nXWutD5738vSaGK9Y7MgLAttSfYerBCh4ynIwwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=hxGrCbFi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b9Vso9YT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="hxGrCbFi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b9Vso9YT"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C2CD1EC0191;
	Thu,  7 Aug 2025 02:20:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 07 Aug 2025 02:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754547641; x=
	1754634041; bh=wsX0qyushtOWSKiYLFtw/URyCoeWs7jD2Zg+XGefeYU=; b=h
	xGrCbFiVfWfBhKgvH9BxfYLXV4MjGDeoO6ymF04K7zsaLrWO/z8t62wrEoiFNNBn
	zrNp++45dJckvpcgFKahl9yFrl/iJ1dmE4pmReW3UxPdOklsdp0foF7AuWp6gPWo
	N1TtrICPak75nWIWfoz3sbxUbAQfj8G3EOQx/5pqw/+s1fvDMeuTgQZF2EHwYFFI
	WdIbfw2ej89WVUaaSqmVxYLRzPNyIf/Iipivgr3Wv3bi0IZVsdq/gYj+ctvQLhAD
	dbd/bBc/aGI6H6TYNSARN3FUx7GWvdCBoyx1LYsda5q6c5I6GqtlQDTePtxamGt+
	KvydjFRFAvBNSVNDOWVZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754547641; x=1754634041; bh=w
	sX0qyushtOWSKiYLFtw/URyCoeWs7jD2Zg+XGefeYU=; b=b9Vso9YTrNJYqH21E
	vd0RSeVF4qkbPT2hXYBAuR56qaaTiKuOhyZr+0bsvlfZqgBCgI84wOte25F6bu05
	K202tqU9/qKZmPY7+YUu2pQgrIy1LW0z1kVQab7xh9RjQ4KdfavayGjIwxCV4vSO
	5Gbe4P7GqabgpLYHfnhao79PecZGtNCkPfO5ZPrwrt92DG5boOUhaYfeSR07U9CI
	faA/IxUsVHhq6w31Sy16NMKB1gOa4r85YZojNx4MkLVl0TfKp0jE+Me+4ePzhYlc
	0pr2lee0bv1tLW24z9i5S6BHzgr/GR9nMhR/7xpu5Kb2T4hGVcHyvr4Gc+aWzget
	ObPeA==
X-ME-Sender: <xms:uUWUaL1pBdVcjQSj_S89y9r5xuTvMfJAiFVppYlQUJr-GIzZSdIL8A>
    <xme:uUWUaNXbByU7i3cSrbK5FX9caKSbJ10zUHn4hmApwYmGzU9goQ3Nwqug-uh_CqQW4
    fu3gNgBRBRp>
X-ME-Received: <xmr:uUWUaFV7ABtHBheYCh3vGB16T13_Jj0oB1nj4d8wVQ_5SyErySjzSS2pLqzPTpGcZxS_a49Yu7M4EmXA3FfenHDKdUMtcHl6zQURjT1qjk9VZEeEgtl_MFwg7w>
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
X-ME-Proxy: <xmx:uUWUaMdcwMBhf4EqACboXDXyn6ShM1fCVgCMgfnrNrapAwuoFxCLNQ>
    <xmx:uUWUaOXLRwmOfNLne_ebtNKHktaL7cwTjv_ImUmn5FQxBY5nVO9Ipw>
    <xmx:uUWUaFeYsG8sbgeSTDVvhPNehaMdMYukN5MBna1i4kUeYvwUPMTGsA>
    <xmx:uUWUaKPHcXxe59edcO6I-KcLsBwQsjMWEsv5vI9-SFrRsJj9HdLGEA>
    <xmx:uUWUaHkknXmu-tRkxsc_mqzDOunrP5ZKK1vHGUSGuyD5eQPdboGLGLqb>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:20:39 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH 1/9] autofs-5.1.9 - quiet possibly noisy log message
Date: Thu,  7 Aug 2025 14:19:59 +0800
Message-ID: <20250807062007.14996-2-raven@themaw.net>
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

