Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065D13EFFB
	for <autofs@vger.kernel.org>; Wed, 17 Apr 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361295; cv=none; b=HjjMm3g6Chf3L3VMAPxZphCPxZ2c9YZn2IPwr/RbSS4J/Z+bo+BFtjfrV5ExiDWcIEzQ06tEwZ+LH/dAc96FQE040WG8UwluwhjSiiJHSKk4uKJyDETjh4nhhk0Ss9PaxaXAOLb2BozcIRsenU3LvwbyZoOHHZJ/0nbb5ROSths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361295; c=relaxed/simple;
	bh=uT3FHvazp8TKBsVw/H7plH7hl77mxW05CFuaBJzra/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X5EIvDQeDedOFSF0R6wNQYP4m/dz2CoCxoqlSYtPguBFN1ZFSZ9bbZh2BdqDdS+ED26JR0rX47sP1Ugj8NvaX4NEe9OQEbyY+zUzvU92rRMFeha6GnGF+defbp+fBTYICH4BkXvNAXYqkBcFOlHX3TbZN/o5fcQwmJX2jXfHIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost.localdomain (unknown [10.177.233.83])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4VKMWV5KyNzyPk;
	Wed, 17 Apr 2024 16:41:26 +0300 (MSK)
From: Victoria Egorova <vegorova@astralinux.ru>
To: autofs@vger.kernel.org
Cc: Victoria Egorova <vegorova@astralinux.ru>
Subject: [PATCH] autofs-5.1.9: fix buffer overflow in macro_parse_globalvar()
Date: Wed, 17 Apr 2024 16:40:39 +0300
Message-Id: <20240417134039.29936-1-vegorova@astralinux.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepgghitghtohhrihgrucfgghhorhhovhgruceovhgvghhorhhovhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeehgfduiedvfeejheevgffhgfdtiefgtdfhfefggeehgfekffevheduuedugfduieenucfkphepuddtrddujeejrddvfeefrdekfeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutddrudejjedrvdeffedrkeefmeefjeduleeipdhmrghilhhfrhhomhepvhgvghhorhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprghuthhofhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhgvghhorhhovhgrsegrshhtrhgrlhhinhhugidrrhhu
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12603997, Updated: 2024-Apr-17 12:19:42 UTC]

Stack-buffer-overflow was detected in macros.c with AFLplusplus. 
Fix the loop condition in the lib/marcos.c:macro_parse_globalvar() 
to ensure it checks for a pointer value instead of an address.

Signed-off-by: Victoria Egorova <vegorova@astralinux.ru>
---
 lib/macros.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/macros.c b/lib/macros.c
index 5def26d..082481a 100644
--- a/lib/macros.c
+++ b/lib/macros.c
@@ -240,7 +240,7 @@ int macro_parse_globalvar(const char *define)
 	strcpy(buf, define);
 
 	pbuf = buf;
-	while (pbuf) {
+	while (*pbuf) {
 		if (*pbuf == '=') {
 			*pbuf = '\0';
 			value = pbuf + 1;
-- 
2.39.2

