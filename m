Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D21C84B8
	for <autofs@vger.kernel.org>; Tue,  5 Aug 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383092; cv=none; b=rsQ/NGx4nWl/OSzZ4Oc1Qvpj2OL4ql77OfYr1+F/5G71xcYvYYQc1pVJPXg6tyw0pNzzvgP7Of61aqkEPVOeuLNOL/7XmEOj5ZDv92bypZyhCwZJOT8mNvoS9hbhVeOu12EXH9LvTqV7P/t/lNCKa/EHTWo9ac6Imq0ZHuyaEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383092; c=relaxed/simple;
	bh=45Ch60WUQzx8ZZG+HFVSTOYeZ0iY/jhuSLCU1z1S1oM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGhAImheago56ehHmdSXbMm4NS/l2D2s05y1rjvfLevbqRpv7ZzRac02Enqg1CpPFX17DGoE6thQ32E+oRHfMNxp24u7huBKEJVlNGul9ocYUVlTSwHiRNMDIWXWMCyr6UmAbON5UPNW7v6spPv8J2z4dnZV5q/jWa7Pji2AJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NF2/5KYJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lNWk6lKZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NF2/5KYJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lNWk6lKZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NF2/5KYJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lNWk6lKZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NF2/5KYJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lNWk6lKZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95D131F449;
	Tue,  5 Aug 2025 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754383087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXE3AQwlgqrxi9caqiNxmlAdUCgwjHTeMkLS1DtxPpY=;
	b=NF2/5KYJUaYkUYgbcsZWWSGM1tN0CjxTIa6trD/CZNoToy+qMZc79ohcHAPEq9T5unzwH4
	TNrPUS5jVvOBl1zGHMelXL05XQho35RFi76vAR/1ZgnHTaMWFHrJwif9u5abrIZzy0iAln
	pBXxKSpO9Iy6hm5lC8g3BhbeIQQ9FkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754383087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXE3AQwlgqrxi9caqiNxmlAdUCgwjHTeMkLS1DtxPpY=;
	b=lNWk6lKZlhgXEiOc/TxL1TYIw0wEAD8fGi05ubNQupOlHL7fFt6ayBKSSKnOkLHskAEEYe
	t8lGiSg5bxBo8xCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="NF2/5KYJ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lNWk6lKZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754383087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXE3AQwlgqrxi9caqiNxmlAdUCgwjHTeMkLS1DtxPpY=;
	b=NF2/5KYJUaYkUYgbcsZWWSGM1tN0CjxTIa6trD/CZNoToy+qMZc79ohcHAPEq9T5unzwH4
	TNrPUS5jVvOBl1zGHMelXL05XQho35RFi76vAR/1ZgnHTaMWFHrJwif9u5abrIZzy0iAln
	pBXxKSpO9Iy6hm5lC8g3BhbeIQQ9FkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754383087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXE3AQwlgqrxi9caqiNxmlAdUCgwjHTeMkLS1DtxPpY=;
	b=lNWk6lKZlhgXEiOc/TxL1TYIw0wEAD8fGi05ubNQupOlHL7fFt6ayBKSSKnOkLHskAEEYe
	t8lGiSg5bxBo8xCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64E7A13A50;
	Tue,  5 Aug 2025 08:38:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ldM7F+/CkWi5PAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 05 Aug 2025 08:38:07 +0000
Date: Tue, 5 Aug 2025 18:37:52 +1000
From: David Disseldorp <ddiss@suse.de>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
Subject: Re: [PATCH] RFC: autofs-5.1.9 - flag removed entries as stale
Message-ID: <20250805183752.208f63d3.ddiss@suse.de>
In-Reply-To: <8754561f-4be7-4d41-9330-a0e5691ca48b@themaw.net>
References: <20250801152210.15501-2-ddiss@suse.de>
	<8754561f-4be7-4d41-9330-a0e5691ca48b@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 95D131F449
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

Hi Ian,

On Mon, 4 Aug 2025 09:31:22 +0800, Ian Kent wrote:

> Hi David,
> 
> 
> I was surprised to see this because I'm working on the very same problem.
> 
> But since I didn't have a reproducer I've painstakingly worked through
> 
> the map reload related code.
> 
> 
> I don't know if my changes have fixed the problem but I can post them
> 
> for you to try them out.

Sounds good to me, I'm happy to run any rough drafts in my reproducer
environment.

Thanks, David
