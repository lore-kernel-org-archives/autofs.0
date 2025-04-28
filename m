Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7AF78F3A
	for <autofs@vger.kernel.org>; Mon, 28 Apr 2025 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745818480; cv=none; b=Whm/tCF+w1QhB8PhWnQu3MykuKdlomH+WFhAzzwMYzdoAIGmxo47pXmJhEfsPFNkZs9ANP3am7LijXpPGwTkY9psvaEPKzwj6Ml6sH0KjEcl2skN5B5GYB7C9wiPZBpw8C9Y9O9FDwgscY5qR041usqGroCk66a8GdE3itssui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745818480; c=relaxed/simple;
	bh=GqdQZ74wTjAqp9CeoBQBFDrPyg0ef4E8Pq4dLcQKb4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJGyFm1/n5fSsRSDBuBqBFemhVA3sjgGPI2XViDtejxyC9guMp1m/Dd1uXWe6QzD5EJq1UjXRwLYDloS9awT37tc1D3xBBy5LiqJPDRuC4uCYoClO+BY7BohuxB2/ZTGhy3noS9L7kUO0Bq2YVQzsyW4XeAcXlQq2BBp0NA2Ovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uLwTZUpe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GHaZh2ev; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uLwTZUpe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GHaZh2ev; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uLwTZUpe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GHaZh2ev";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uLwTZUpe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GHaZh2ev"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2BCAC211F9;
	Mon, 28 Apr 2025 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745818476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Ij3tkrvRey7dHihqAia2fGL0+oW5cT0DPxj3Jf8RI=;
	b=uLwTZUpehgtA9T+g+JVmUVP3o4tvmuXT/vcjdJEKndy/6ifHDNLBTlncAkdk+GZJ2ednHP
	qAG04aztCzAo7kgeUC6eyqv09nfDvnHCWG4Kddihehcjeeeep4iN/E9apWMtWl0qkQ4ARt
	4uwxtGpqLKkGuqf5h30jVTiMbnWyfbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745818476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Ij3tkrvRey7dHihqAia2fGL0+oW5cT0DPxj3Jf8RI=;
	b=GHaZh2evk5O5IYR+JTWUxA4PLMyEyl2DTHQDQygotZcb/l3Nxx8h3XX579kAXbuveHiO/k
	jYB11xa4XBU7DACg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745818476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Ij3tkrvRey7dHihqAia2fGL0+oW5cT0DPxj3Jf8RI=;
	b=uLwTZUpehgtA9T+g+JVmUVP3o4tvmuXT/vcjdJEKndy/6ifHDNLBTlncAkdk+GZJ2ednHP
	qAG04aztCzAo7kgeUC6eyqv09nfDvnHCWG4Kddihehcjeeeep4iN/E9apWMtWl0qkQ4ARt
	4uwxtGpqLKkGuqf5h30jVTiMbnWyfbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745818476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Ij3tkrvRey7dHihqAia2fGL0+oW5cT0DPxj3Jf8RI=;
	b=GHaZh2evk5O5IYR+JTWUxA4PLMyEyl2DTHQDQygotZcb/l3Nxx8h3XX579kAXbuveHiO/k
	jYB11xa4XBU7DACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB435136A5;
	Mon, 28 Apr 2025 05:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WXfcJ2oTD2jcSgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 28 Apr 2025 05:34:34 +0000
Date: Mon, 28 Apr 2025 15:34:16 +1000
From: David Disseldorp <ddiss@suse.de>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: autofs@vger.kernel.org
Subject: Re: [PATCH] man/autofs.conf.5: fix manpage formatting
Message-ID: <20250428153416.35621f2c.ddiss@suse.de>
In-Reply-To: <20250427221034.149247-1-ailiop@suse.com>
References: <20250427221034.149247-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -7.25
X-Spamd-Result: default: False [-7.25 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-2.95)[99.78%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 28 Apr 2025 00:10:34 +0200, Anthony Iliopoulos wrote:

> Fix man page formatting by removing stray "+" characters preceding the
> open_file_limit option description, which also corrects the rendering of
> the timeout option.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

Might be worth adding a:
Fixes: 29f7882 ("autofs-5.1.8 - make open files limit configurable")

Either way this looks fine to me.
