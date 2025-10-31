Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA98307ACE
	for <autofs@vger.kernel.org>; Fri, 31 Oct 2025 02:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878623; cv=none; b=OGhVdERnAgQwv00jv/1upOl+E+iUIE/soVNdxtEJFeEnhkHjGz6nSRFqgACIO2SryR/ox3vTenWDImtp0FhVtIfdC+mNzMTInx7zjlAzPVzBP86VNu4JWElzMUQlZh1trvJy4JEG42LVPCsPjH527FiSTE+rFBFfjDWfi+dbXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878623; c=relaxed/simple;
	bh=JLss5ZtMC5v+1KSQCzAjT6Qmqg/a+cXsVkDn+zKQA2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4DoYI2HQYWwAuAllnMMG9nBVic44rkZ9pZo2WMVKFGdgZ6iqmXwfqH2zwManQ1awAx83JiLRdVlUympYdjwm15+YTrhJ4G2F1ZpOHtKL54slWNDlNcpad6ft7ARL35H/Ntez1AcRkeKLacxBBgLBe34b9yTaBTIepJ2C3awAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1p7Dm2Vo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jv9X5lR1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1p7Dm2Vo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jv9X5lR1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1p7Dm2Vo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jv9X5lR1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1p7Dm2Vo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jv9X5lR1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D1843369A;
	Fri, 31 Oct 2025 02:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761878619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLss5ZtMC5v+1KSQCzAjT6Qmqg/a+cXsVkDn+zKQA2w=;
	b=1p7Dm2Vo1fCFP7NlVTfrszfA/6n1JJAfN3e+dCMdZsVtvSp5+silYaWYrP2RZ0j7ExKKeg
	M1R409ddlU8Tq2zXZaveMaWJZa/mN53SbN0vE5O7IJOXiz5lCpaKIrQ9weiBi+aAUqDtWY
	U8KjMDUYFTewbWiAKUFD2GBP+t7tA3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761878619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLss5ZtMC5v+1KSQCzAjT6Qmqg/a+cXsVkDn+zKQA2w=;
	b=jv9X5lR1PuNmcUZ74/4kGzVuSLFDSHqUeXy/N9Un64EJjOflGPcROvTYgdu5MekIUyNfsl
	GTMfeTllIxtlXeDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761878619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLss5ZtMC5v+1KSQCzAjT6Qmqg/a+cXsVkDn+zKQA2w=;
	b=1p7Dm2Vo1fCFP7NlVTfrszfA/6n1JJAfN3e+dCMdZsVtvSp5+silYaWYrP2RZ0j7ExKKeg
	M1R409ddlU8Tq2zXZaveMaWJZa/mN53SbN0vE5O7IJOXiz5lCpaKIrQ9weiBi+aAUqDtWY
	U8KjMDUYFTewbWiAKUFD2GBP+t7tA3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761878619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLss5ZtMC5v+1KSQCzAjT6Qmqg/a+cXsVkDn+zKQA2w=;
	b=jv9X5lR1PuNmcUZ74/4kGzVuSLFDSHqUeXy/N9Un64EJjOflGPcROvTYgdu5MekIUyNfsl
	GTMfeTllIxtlXeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F80813393;
	Fri, 31 Oct 2025 02:43:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zomoAloiBGleXQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 31 Oct 2025 02:43:38 +0000
Date: Fri, 31 Oct 2025 13:43:23 +1100
From: David Disseldorp <ddiss@suse.de>
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: Re: Recent reports of a failure to find a direct mount map entry on
 lookup
Message-ID: <20251031134323.3c413651.ddiss@suse.de>
In-Reply-To: <20251031013745.11150-1-raven@themaw.net>
References: <20251031013745.11150-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.28 / 50.00];
	BAYES_HAM(-2.98)[99.93%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.28
X-Spam-Level: 

Hi Ian,

Thanks a lot for sending through this patch set! I've been mostly
focused on the last problem you describe with stale triggers following
map removal, which appeared to regress via autofs commit 21ce28d.

I'll have a closer look at the changes and let you know how they fare
through my test env reproducer.

Cheers, David
