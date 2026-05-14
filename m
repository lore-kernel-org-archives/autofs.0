Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9933191CA
	for <autofs@vger.kernel.org>; Thu, 14 May 2026 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788917; cv=none; b=I1xp0dybJCT6mTD20iQXah7uZv9mofo2/1Q50loHy0BP2EOXsVyYn+quJVNVaCKBEwm6DyfCo3M1ozlRw6XejvZjFVMSBAN/oDLFdkUNztu8fFo6zIxctVLrt4iMZvEkzfwuCqmehpnHc4szcmjt0ai96wTOH4fojspH4i35Was=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788917; c=relaxed/simple;
	bh=J7eRNTJBToxIrxX/q093z+bGZqPvKVUrHjh+2doSAEU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ee0L8od9KBggcy587K1aLsnGjNM/9yVjutj75Tuud9YbjaFIeGndF3MgBKQYXgG3NCOCAnrNKI6VwD1/pqt4Y3MJF9wkd9ZYiDeRWuWL6YKmAdt0MSR/9ET+7iu8NUxfivUzvI1fUPJqUbxfThVbqOvupzlbr5bmvs/6Yj4rxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E5Vs5rxd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RNlQw+u2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BKVWXATU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bAzUcNQ9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E5Vs5rxd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RNlQw+u2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BKVWXATU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bAzUcNQ9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A5CB67242;
	Thu, 14 May 2026 20:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778788907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8cHkUvQmRtqM1VzF9hgdugMSvMSvzl2zQPkbk371LVM=;
	b=E5Vs5rxdNyRlnvhDEL3zSdN3WIkgE1Y2SQwUo8PIATZD6KpPd6zxFrmDN4AInHQ1d3E+Cp
	wICAu7PyM/jb2j1r/JRLKaGSQgFLImEL10moualnZUwHP3AS4+Z1S6gUaK0KDRg56OEBVC
	weF+xOfLbOfMltse4DdgGgrQvfOzHbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778788907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8cHkUvQmRtqM1VzF9hgdugMSvMSvzl2zQPkbk371LVM=;
	b=RNlQw+u27HYUQzWDv1G69t6Dh2Qt8ROoKcGXGJ38OgClnHlbU0vxJ6EyknC9WPVbb8uM9p
	IYTxGlx/XxqZfiDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BKVWXATU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bAzUcNQ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778788906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8cHkUvQmRtqM1VzF9hgdugMSvMSvzl2zQPkbk371LVM=;
	b=BKVWXATUso6FgGJqRp9FYnArynAk2GII8bxFp5bBpOTAx0ri4deqLqYYF2F0zWYO5gaZNR
	oJEmM5ux0ZAy6vR2uL8sXHP1P1mdJSV2IGPnrez6kpCZrxbqpfbtEBAJO4er1yqNIRSteb
	jgOO288iWp037wdmpvNCx4X601ew0ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778788906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8cHkUvQmRtqM1VzF9hgdugMSvMSvzl2zQPkbk371LVM=;
	b=bAzUcNQ97XKdIQZ9S5n8LBLjGisvQ7KPBhnD27iv43CM1fgREwgPO0R/w4vgfM+dZUfdp6
	fz4JZitQAr+9hsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B4D9593A9;
	Thu, 14 May 2026 20:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1v6POykqBmqebAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Thu, 14 May 2026 20:01:45 +0000
Date: Thu, 14 May 2026 16:01:44 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: autofs@vger.kernel.org
Cc: lidong.zhong@suse.com
Subject: Unable to set log priority for all direct mounts
Message-ID: <agYonWw9_WVrWyub@zuko.lan>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.42 / 50.00];
	BAYES_HAM(-2.91)[99.60%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,zuko.lan:mid];
	RCPT_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 5A5CB67242
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.42

Hello,

Since the work to have a single FIFO file for setting log priority
(16ea4156 ("autofs-5.1.8 - switch to application wide command pipe"), to
be more precise 16ea4156 (autofs-5.1.8 - switch to application wide
command pipe), automount has lost the ability to set the log priority of
all direct mounts using the path "/-".


# sudo automount -l info /-
Could not find device id for mount /-

This is because automount attempts to mount and get verifies the real
path which is non-existent in case of direct mounts "/-".

In the automount program, the log priority is set pretty early and much
before the master map is setup. So we cannot check on the autofs dev
either.

What would be the best way to solve this? Should we just document it
as a feature loss?

-- 
Goldwyn
