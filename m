Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9508A2F7478
	for <autofs@vger.kernel.org>; Thu, 19 Mar 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950888; cv=none; b=MKp1MJKSXlAM9qz0wItsOuDsajKisP/xxFoDuIoeIEHwIZpvjg3DLGowCgbQTDlLE6RtkEyaHa87UiftaO/q6xQlrxAYKlvmxtTOuKrJui4zSWpVgj3FlKTsk16syPsEiOaRJnC8Ci5S45c7l6QqKMhMtGBWvIbk85bcGWiUd0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950888; c=relaxed/simple;
	bh=IZ3ZIkeW5PT4Z7F644Ino/rJrzMS8jPxO7kVLXAU0Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQSoHvOBzsvgzlg/V3Z5SmpBLzaU1WDQzAylrG+/nCNjfD/5eQzT39vpAAQ54WTglhIGCqniW6/VVRYktO9zDM7N9yx1EXJg/J8ZHboXZ8FXkgxH3g90rgbCR5+XPu7EUuNv5F5pp7yKnhqGAhrR/iOpijbatPc8X6bj3pFCUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqJ/c0Io; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqJ/c0Io"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773950886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=22FKulR4hqVef7/03mkHLovFbrH0Bu4nvZGPtSVeJVg=;
	b=XqJ/c0IoA6GdlJ+rm0dFXLVUWvRPef5cAjpJ2reeXwIAIBZse8taAelzMHaxhnobPyx2Js
	yFyMHUw1glknuKmZ28vdN5QC+s8vWfVIcstZTVrvYBRIu3nM8RC8OlDHFgob1MKm1vvwlR
	X8EOJz7NA//WgJiA5fFU8uM18pPn+do=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-mqxtvfPiOgGtkvmnWB8yRQ-1; Thu,
 19 Mar 2026 16:08:05 -0400
X-MC-Unique: mqxtvfPiOgGtkvmnWB8yRQ-1
X-Mimecast-MFC-AGG-ID: mqxtvfPiOgGtkvmnWB8yRQ_1773950884
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D43A195609E
	for <autofs@vger.kernel.org>; Thu, 19 Mar 2026 20:08:04 +0000 (UTC)
Received: from tbecker-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E47F30002E0;
	Thu, 19 Mar 2026 20:08:03 +0000 (UTC)
From: tbecker@redhat.com
To: autofs@vger.kernel.org
Cc: Thiago Becker <tbecker@redhat.com>
Subject: [PATCH] Fix masks in parse_sub.c, so that hosts are correctly matched.
Date: Thu, 19 Mar 2026 17:08:00 -0300
Message-ID: <20260319200800.2512262-1-tbecker@redhat.com>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Thiago Becker <tbecker@redhat.com>

In the case local address is 10.x.x.x and one of the replica addresses
is 138.x.x.x, MASK_A will make both equal, and get_priority will return
PROXIMITY_NET, which is not correct.

MASK_A = 0x7F000000 = 01111111 00000000 00000000 00000000
LOCAL  = 10.x.x.x   = 00001010 00000000 00000000 00000000
REMOTE = 138.x.x.x  = 10001010 00000000 00000000 00000000

Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 lib/parse_subs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/parse_subs.c b/lib/parse_subs.c
index 2acb056b..1575e999 100644
--- a/lib/parse_subs.c
+++ b/lib/parse_subs.c
@@ -37,9 +37,9 @@
 static int volatile ifc_buf_len = MAX_IFC_BUF;
 static int volatile ifc_last_len = 0;
 
-#define MASK_A  0x7F000000
-#define MASK_B  0xBFFF0000
-#define MASK_C  0xDFFFFF00
+#define MASK_A  0xFF000000
+#define MASK_B  0xFFFF0000
+#define MASK_C  0xFFFFFF00
 
 /* Get numeric value of the n bits starting at position p */
 #define getbits(x, p, n)	((x >> (p + 1 - n)) & ~(~0 << n))
-- 
2.53.0

