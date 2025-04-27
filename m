Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08808192B74
	for <autofs@vger.kernel.org>; Sun, 27 Apr 2025 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745791855; cv=none; b=GLdEJHuP8wnd5PuELz5hSNXIHI+pqG2zl/d68Tdw2NUwsxJk+d0OFwz8qZ51Ij1q3x4RAEvimQ0k26wKX8iIvnFi7XgH4J121Do5rVrfds41Ljv90YyN6EkJPRMAA8IuDq3V6ojf5OQn/bl13fn0+uXKYslpLSkVwmmoWPV/UaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745791855; c=relaxed/simple;
	bh=Rxr0cw9bYBwikVdeS9m3Tfj546QkeQJ3xBSOdiiZAYk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tNl/VO+fQYIkz9SxbqNFn/VRO7JMTN+maKBnOgtbsuJoPVCrMLClHEtE9k0o90zgOwsjaD/rD8WMTxxlYOqtH4noy3dnPrJwUgoNqT4YjjeMF72jY0q8+CrbfchOVmgMo9qyrH6TYYMFSOM2C0go6At32CYReE+sfV1CtVB/FwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kq2gojXK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kq2gojXK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kq2gojXK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kq2gojXK"
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id DB7DD1F38A
	for <autofs@vger.kernel.org>; Sun, 27 Apr 2025 22:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745791850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Iy3w/YagoV9t01msDjcu4P/j/m3WUTPABIPIJfxCS/0=;
	b=Kq2gojXKxxsfH8jFyArkkEsgHH0NqXALTx3aooKiocCK0xj3JExji7Sk5fFNJ9tp5YeO1b
	zlskRjHcAgGaXfyUCof+ep6tmPGaWVfnPcpy893VcjZn++6v+/90AQh9SqTi6WXVJiEstP
	3/sNpt5GyR9uLjCHj4iU/Xi9xUkuVWU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745791850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Iy3w/YagoV9t01msDjcu4P/j/m3WUTPABIPIJfxCS/0=;
	b=Kq2gojXKxxsfH8jFyArkkEsgHH0NqXALTx3aooKiocCK0xj3JExji7Sk5fFNJ9tp5YeO1b
	zlskRjHcAgGaXfyUCof+ep6tmPGaWVfnPcpy893VcjZn++6v+/90AQh9SqTi6WXVJiEstP
	3/sNpt5GyR9uLjCHj4iU/Xi9xUkuVWU=
From: Anthony Iliopoulos <ailiop@suse.com>
To: autofs@vger.kernel.org
Subject: [PATCH] man/autofs.conf.5: fix manpage formatting
Date: Mon, 28 Apr 2025 00:10:34 +0200
Message-ID: <20250427221034.149247-1-ailiop@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.76
X-Spamd-Result: default: False [-2.76 / 50.00];
	BAYES_HAM(-2.96)[99.82%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Fix man page formatting by removing stray "+" characters preceding the
open_file_limit option description, which also corrects the rendering of
the timeout option.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 man/autofs.conf.5.in | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index 27fe4a4f4c77..c46176f0d025 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -23,13 +23,13 @@ configuration settings.
 .P
 Configuration settings available are:
 .TP
-+.B open_file_limit
-+.br
-+Set the maximum number of open files. Note there may be other limits
-+within the system that prevent this from being set, systemd for example
-+may need a setting in the unit file to increase its default. The autofs
-+default is 20480.
-+.TP
+.B open_file_limit
+.br
+Set the maximum number of open files. Note there may be other limits
+within the system that prevent this from being set, systemd for example
+may need a setting in the unit file to increase its default. The autofs
+default is 20480.
+.TP
 .B timeout
 .br
 Sets the default mount timeout in seconds. The internal program
-- 
2.49.0

