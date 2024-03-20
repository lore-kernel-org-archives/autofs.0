Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24357464
	for <autofs@vger.kernel.org>; Wed, 20 Mar 2024 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896416; cv=none; b=qh3ZceDmqY9yya6mJEDZZBtZoPd4UZaw7A14Npzqs/GgxV7wlk2tGjEo9Qc5pSJIx3dXuyFfXr+8UnSqdRBBPp162BvcsTPu0fCCxHMMjYubG4Sz3rjlAzJOk2SJmoVtTJ283+5bw5BRNB1MLzFoFbGZz8jbc2zVaIdyLeULH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896416; c=relaxed/simple;
	bh=wU5CqQ8env+9M5KoPSxW27scxeQKTxR40h6yAiUthI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I2hMP36NY3g2YdvITyySviFZYBdx304XrIBXvHeg1ACXMQWc7wnoAY7JFduWpeA2HQo8rmUuKBAdPUXq7brVvT04JxklxMPRYcyVcQ4mxw6YTogpq0ZP9vOGYNb26iMNmvYB5scufdCCvGbqQeFyoJxGB6P2V50q4XOFVFRNZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mtRZfiwe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rLH6YKuB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TK35PH2J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rompyHOJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mtRZfiwe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rLH6YKuB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TK35PH2J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rompyHOJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76CBE338B9;
	Wed, 20 Mar 2024 01:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710896412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zYHD5n4BBePuqqjA8Sooz+HKixrP2752gGjnrk2k/Gw=;
	b=mtRZfiwePaK1ZB46o+CUthEliNRyDAfkk6CEpQEwemlocNzo3xjDMqt+QKYlyZdDvrjY1k
	gYQNY4Hqvsk1gGTa3Egh/8YMOuyf5ggZxdZNioVg/5y6966Wtkn9ljsfgsk/2o2Mt7R3eS
	ZrkyHnAiPnhx5ea9NkLbERHoSVQKhIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710896412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zYHD5n4BBePuqqjA8Sooz+HKixrP2752gGjnrk2k/Gw=;
	b=rLH6YKuB7MOyV5c9CoRoI/40WmWflEL2u5w/6hbcuA/Mbh3tGCwRadCV4oItjmjWJx3WcX
	TwVllpxKBl6H/4Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710896411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zYHD5n4BBePuqqjA8Sooz+HKixrP2752gGjnrk2k/Gw=;
	b=TK35PH2JiJjw2Ybyf3gdDmMHrtHI9FALoTIdlI6KYCulgGiI3ca8oPwr5L2jICXl3KKl9R
	2iELPuaOP+Hfrz9Njng3TBOKQDbMp4mR01ZkdkVat7CCMUROfUY0hJtSwXlGglfLaQfMWP
	jItWZhQ4Loz7tTsPDMgHIx6lAfGKMLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710896411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zYHD5n4BBePuqqjA8Sooz+HKixrP2752gGjnrk2k/Gw=;
	b=rompyHOJb9V93H6InN6qWXEywIkhElKigk1xy5ZXZP1rRAiS/M3x2Faw/65ILF+0gkOaKr
	49fC8Er1Y+crbCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36001136CD;
	Wed, 20 Mar 2024 01:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0+EwNhk1+mXKPwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 20 Mar 2024 01:00:09 +0000
From: David Disseldorp <ddiss@suse.de>
To: autofs@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] autofs-5.1.9 - fix ldap_parse_page_control() check
Date: Wed, 20 Mar 2024 11:59:49 +1100
Message-Id: <20240320005949.2661-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.49
X-Spam-Flag: NO
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TK35PH2J;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rompyHOJ
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[20.06%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 76CBE338B9

The final @cookie parameter should be a struct berval ** type. The
check currently fails when -Werror=incompatible-pointer-types is set:

conftest.c: In function 'main':
conftest.c:54:47: error: passing argument 4 of 'ldap_parse_page_control'
from incompatible pointer type [-Werror=incompatible-pointer-types]
   54 |       ret = ldap_parse_page_control(ld,clp,ct,c);
      |                                               ^
      |                                               |
      |                                               struct berval *
In file included from /usr/include/lber_types.h:24,
                 from /usr/include/lber.h:29,
                 from /usr/include/ldap.h:30,
                 from conftest.c:45:
/usr/include/ldap.h:2155:25: note: expected 'struct berval **' but
argument is of type 'struct berval *'
 2155 | ldap_parse_page_control LDAP_P((

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 aclocal.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/aclocal.m4 b/aclocal.m4
index 1046d72..fa18eb1 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -424,7 +424,7 @@ AC_LINK_IFELSE(
       #include <ldap.h> ]],
    [[ LDAP *ld;
       ber_int_t *ct;
-      struct berval *c;
+      struct berval **c;
       int ret;
       LDAPControl **clp;
       ret = ldap_parse_page_control(ld,clp,ct,c); ]])],
-- 
2.35.3

