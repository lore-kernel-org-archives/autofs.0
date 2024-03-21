Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF11851
	for <autofs@vger.kernel.org>; Thu, 21 Mar 2024 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985206; cv=none; b=ixFXWYngObyPoDNDzFffzB3/DAoQEPFeQQgVuPpP3Fhcchr+Lswbja7gPhfbn3rDHFtWzG52Gc6gkSIeqZPYYSxHMSk+I1AS+BAq86m+bxY6RSjQRVgEQ8ApVh0dMPZls+mt8GuLRhCH6MvR8FPKA1RuPqjTxG7WBJmnIqp8HxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985206; c=relaxed/simple;
	bh=r9r7iRkFq1V9X6RIgWPPdwtD/GJG/8bUwSGd6xFrFeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DPXVe1/GRg7phQegEF4/DuNFnzPLjlwW0hPOV2fivfo2kNSZ3Xp9SJ3ek89XENzYtEXhMB0oEsZdnBc8Fn8oCWMUwoh6+TO4K/t+kUA8aZw5lL54PRy9lEfJSPj9lFQq/rOWuiSdC4jr2D4ySjEcjdh4WGHdjcWuYtW0q0PnhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sWa5Tet4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TEBQbGmF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sWa5Tet4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TEBQbGmF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sWa5Tet4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TEBQbGmF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sWa5Tet4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TEBQbGmF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3470C5C66C;
	Thu, 21 Mar 2024 01:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710985202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jokfd7YD1TuwUQCJ9NpLWAEfpFB962iA57xHqjQY+kE=;
	b=sWa5Tet4ZLY3I3kwXFrS84zh5d+1+YdCb79xWGSmE1fRmhM9knzv2UOjVfxAaXDjJVjqgA
	MnBEI5DA1fw+92nxvxuXZCMCUUO4ejGcaQiUkCPj5sl6jQStz3/0ubS6S3/OajEIMA7MSd
	/hbqpql0ZDDHFuKwqUNfMV3OJ5IHYrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710985202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jokfd7YD1TuwUQCJ9NpLWAEfpFB962iA57xHqjQY+kE=;
	b=TEBQbGmFUC63doH760uR0AG+yFcMk1u3jU8+MD7SkL0TrK3ihSykCGE/f8WP0av1S/sjle
	DOUiFIq1YqkvvRBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710985202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jokfd7YD1TuwUQCJ9NpLWAEfpFB962iA57xHqjQY+kE=;
	b=sWa5Tet4ZLY3I3kwXFrS84zh5d+1+YdCb79xWGSmE1fRmhM9knzv2UOjVfxAaXDjJVjqgA
	MnBEI5DA1fw+92nxvxuXZCMCUUO4ejGcaQiUkCPj5sl6jQStz3/0ubS6S3/OajEIMA7MSd
	/hbqpql0ZDDHFuKwqUNfMV3OJ5IHYrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710985202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jokfd7YD1TuwUQCJ9NpLWAEfpFB962iA57xHqjQY+kE=;
	b=TEBQbGmFUC63doH760uR0AG+yFcMk1u3jU8+MD7SkL0TrK3ihSykCGE/f8WP0av1S/sjle
	DOUiFIq1YqkvvRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5E6213432;
	Thu, 21 Mar 2024 01:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rForJfCP+2X+BAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 21 Mar 2024 01:40:00 +0000
From: David Disseldorp <ddiss@suse.de>
To: autofs@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] autofs-5.1.9 - cast sasl_callback_t function pointers
Date: Thu, 21 Mar 2024 12:39:47 +1100
Message-Id: <20240321013947.31673-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.01
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sWa5Tet4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TEBQbGmF
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[35.49%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3470C5C66C

GCC 14+ uses -Werror=incompatible-pointer-types by default.
sasl.h:sasl_callback_t doesn't offer a type-safe mechanism for setting
@proc callback functions, so a cast is necessary.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 modules/cyrus-sasl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/modules/cyrus-sasl.c b/modules/cyrus-sasl.c
index e742eaf..107e182 100644
--- a/modules/cyrus-sasl.c
+++ b/modules/cyrus-sasl.c
@@ -109,17 +109,17 @@ static int getpass_func(sasl_conn_t *, void *, int, sasl_secret_t **);
 static int getuser_func(void *, int, const char **, unsigned *);
 
 static sasl_callback_t callbacks[] = {
-	{ SASL_CB_USER, &getuser_func, NULL },
-	{ SASL_CB_AUTHNAME, &getuser_func, NULL },
-	{ SASL_CB_PASS, &getpass_func, NULL },
+	{ SASL_CB_USER, (int (*)(void))&getuser_func, NULL },
+	{ SASL_CB_AUTHNAME, (int (*)(void))&getuser_func, NULL },
+	{ SASL_CB_PASS, (int (*)(void))&getpass_func, NULL },
 	{ SASL_CB_LIST_END, NULL, NULL },
 };
 
 static sasl_callback_t debug_callbacks[] = {
-	{ SASL_CB_LOG, &sasl_log_func, NULL },
-	{ SASL_CB_USER, &getuser_func, NULL },
-	{ SASL_CB_AUTHNAME, &getuser_func, NULL },
-	{ SASL_CB_PASS, &getpass_func, NULL },
+	{ SASL_CB_LOG, (int (*)(void))&sasl_log_func, NULL },
+	{ SASL_CB_USER, (int (*)(void))&getuser_func, NULL },
+	{ SASL_CB_AUTHNAME, (int (*)(void))&getuser_func, NULL },
+	{ SASL_CB_PASS, (int (*)(void))&getpass_func, NULL },
 	{ SASL_CB_LIST_END, NULL, NULL },
 };
 
-- 
2.35.3

