Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7124DD09
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874759; cv=none; b=HeASmBHzRf6m3uqLjN5Vz52DI0wo+V1tGTAJH7EAaqBVScwUnd/GgdaXRSMSsrucN8KqhIrNfFMMdnMg2MiHMhLpWuf9dxP8RVVb1pbjG37T/C7LXMf3EWH4f33pXkJByRnMGq4GLUlCfqiilmfmU+2iYocMrFIFbjL6N3ODYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874759; c=relaxed/simple;
	bh=Gyp8HZefDIMiqXWa0Iny5NaVG+oMGhjgtieBvgmyQvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahrTx1bSK1QMJCr7Y4D4PHSTSx9LFVA2l8oCGi8xYh0PK3b9IcDzB9szOtUqYqHTpiuFfofct7CkCkA2dnMcs/EdHPUsFJsskcgEomYtfXHLN4ZKiZfLoQvxrMl3fSRDk7sbGRz/crwAXBoHleHh5fmfljI7c0TwYCaLbbSU1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=oCJzAO6A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qdcO0c3V; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="oCJzAO6A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qdcO0c3V"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 651F07A0100;
	Thu, 30 Oct 2025 21:39:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 21:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761874756; x=
	1761961156; bh=N+VRxLkMf807wGPr32m2paAX0Q6hrBoEQ+Q4zgHfvOc=; b=o
	CJzAO6AXiRURQAMBR+pZMMOF7Lq52AAWYdAqSR00AILSwElCVAeJq943TkqEEZDA
	J4C42knWz2qfWz0c5OEgJm0H97WgPU4Jw1kbZPKosjsM6UV/KWzGBv5OqeBdQFgb
	deMFaijdAXQz54b5Nmgc4tFdEMTXTpK7WW43rwna9uDC32Z03FMgLPs9cfQtjgTA
	u9v0NUZtwgvOulXc814SAwzwK7opR5iny6ZJ160QblmMJa38csUi+TsrNNPOn8TI
	2Zbvc81g5x+NZnvteCcUWU2WzTqrMIMtEbeBvYuZOM6bf06RAIKnZ2yxflK8eOtW
	KdHBbIawQ1ihEVvGyd8eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761874756; x=1761961156; bh=N
	+VRxLkMf807wGPr32m2paAX0Q6hrBoEQ+Q4zgHfvOc=; b=qdcO0c3VZR9t+425R
	u5OmEkVdAxTpOZnLHXgPXMYkKfApVTZUc2Pr95N8mLgj83774Nf43YUzdrbtS5n4
	ShKPpb4KemVP1ZPPu0EcBVTBZ+cty2KS32i6A1Nd/TCrFNu46WA8B3ANyMbhgHS4
	EzuS0+Me8mveY8DRPUc5RKwfo80Tlp49q5FDw2YLvIctv/YQe/RpCGABgkwjTKQv
	LFDasgZKjSD4IA8W6MCy2rucWuvA8HycPx56IPWNaA24VcFn78GHeikyB04uGP8W
	6F5I9F4UjlPO0BKIYP6fZZ6jHEMnWJBslC63/SvBOGmun9WiEkEPsisvkE9ETacq
	5hjVg==
X-ME-Sender: <xms:QxMEaUGig6x6q4GwSAhkIvzCvtesTQQlJx9IGHAR0BG0t9Tnea9ZgQ>
    <xme:QxMEaUxzkFt1kPqElmmptp7pxk6uVzJ9ySsmxaPR5S_eOtL2WTI0Ctz-FGfShIJy1
    LooXeZjb-hOC-SnHMT4uczCa52-o73--XH-cpjsWLa4iDUt>
X-ME-Received: <xmr:QxMEabhnpSr8OV7bY5KBg7UiEk4iB6nx-FOYMgGiXSsfBeYuPvlJgU2eCcpVFleb_fsyO42yYXfVvBLd1qCUuMd3ZIZA9CgCUqFN-wVDPWRMNYUSFbKMUE-L0g>
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
X-ME-Proxy: <xmx:QxMEafz8Btpo8sVW6pdwTGhtoHbQ_7UIK5aSKsr2srMV5Fho8_OKCw>
    <xmx:QxMEaeKa9UbcnPFJhhgaHNLWmJjvZz06RwBkZOONzunAGIj4I4tpIw>
    <xmx:QxMEaWR_o67tM7opQJt30hbz3bBzMEQ61qNQzMlAqhKU7CjOU5HqTQ>
    <xmx:QxMEaWofFNYmUoHP6HX4BBQiSG44ZPdtVOUh_Mx4ZFkvP_2vzMRPWQ>
    <xmx:RBMEaWbt5JY3KvyeecjfHMIflwtYdL_M_aBH1bXGvmNadxBvxtTcb1_b>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 21:39:14 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: David Disseldorp <ddiss@suse.de>
Cc: Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>
Subject: [PATCH 06/11] autofs-5.1.9 - remove unnecessary assignment in umount_multi()
Date: Fri, 31 Oct 2025 09:31:34 +0800
Message-ID: <20251031013745.11150-7-raven@themaw.net>
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

Remove the leftover initialisation of left from when there were multiple
calls to umount_subtree_mounts().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          | 1 +
 daemon/automount.c | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index c1f8073dc..a8aabe797 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -73,6 +73,7 @@
 - fix cache writelock must be taken in update_map_cache().
 - fix skip valid map entries on expire cleanup.
 - remove unnecessary call to set_direct_mount_tree_catatonic().
+- remove unnecessary assignment in umount_multi().
 
 02/11/2023 autofs-5.1.9
 - fix kernel mount status notification.
diff --git a/daemon/automount.c b/daemon/automount.c
index 75399ac9b..afd3bfd0e 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -719,9 +719,7 @@ int umount_multi(struct autofs_point *ap, const char *path, int incl)
 		mnts_put_mount(sbmnt);
 	}
 
-	left = 0;
-
-	left += umount_subtree_mounts(ap, path, is_autofs_fs);
+	left = umount_subtree_mounts(ap, path, is_autofs_fs);
 
 	/* Delete detritus like unwanted mountpoints and symlinks */
 	if (left == 0 &&
-- 
2.51.0

