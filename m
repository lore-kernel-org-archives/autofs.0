Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC900128805
	for <autofs@vger.kernel.org>; Tue, 16 Apr 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277425; cv=none; b=GW0CHACBZaIFFOQn8aPN6/WNdpcfxJn/ibDPllVtQD6+DjNlFb9tfSNavLw6Pm1tZCaas6kde9QcwRHuRvoe4dJopiSlPjeX6pXwKNAL4xiMbcqwiciBaOtu+1KFCxr1RI8P2/5oNP84BqnSXXPldLOH2h7+9DaOoIQDKB5f4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277425; c=relaxed/simple;
	bh=9Qs/KLkDGyfzwvR/NpOgjkWvq07d+G48X3YW3Su2XLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3/CxfAYiE76p0ywitIz/nCLObreoe1UUM19ewABQsjs8DZzMWUfxkJEums6M3t8tEozTkUYkthU4BsvgSVBUW3ZDSJKdlVbwpcB+V/hTB4lLsQoVIcl0+Upkn0f+pYyGl+QVjDHc35HKSJpzj6DJzBktQ6F/OGbv7QkvebQnO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZloRo7IR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c8wQ+QKr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SqFVTBMc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7ouBJshw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZloRo7IR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c8wQ+QKr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SqFVTBMc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7ouBJshw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F36CA3754E;
	Tue, 16 Apr 2024 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713277422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uU83WmBVgkglzdJtx7vzchnz7CEEp88okUZ3spPk1s=;
	b=ZloRo7IRahLxYy9eoYhzIDLbEILEQQfycXcDMw1xPERgNC3rMT6qT/pytDAWSORYZw/o7D
	dYkMgIORwIlZV0jglUdUmhjYJqf4GK/Z8WmbyhS31cvSIUoi1b4+vWpYwMBd0mh2gsRGrl
	b1NvufbmdPB36eXMADu/PRJz4WSPl4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713277422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uU83WmBVgkglzdJtx7vzchnz7CEEp88okUZ3spPk1s=;
	b=c8wQ+QKr8xinwKhBuiKA40fwLEsIo46KDNrt9kVQ6lDxIvgubVjLBJsuPc56E/MT2FXCnD
	a694KOkh9apka4DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713277421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uU83WmBVgkglzdJtx7vzchnz7CEEp88okUZ3spPk1s=;
	b=SqFVTBMcfArl+WKQ/prfIKCHVRl5OmWku2f3k5HTl1Qx6npcyLo2ijaQqw5FtN/DTVqu04
	qxXsLz3Dw4Fc7/qFXP7p5VgrEXFTWuEZZYoGOWfvzO/vu69S7kj+L3CQ5vaMlV3O6lDMk2
	KhWUxwOjhLNiaAynGJv/f4S/EyW1Knc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713277421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uU83WmBVgkglzdJtx7vzchnz7CEEp88okUZ3spPk1s=;
	b=7ouBJshwuAXwFHC2RJZb8aXhH8ftlNDxAkc+Vz0oKsR/G5P3AdTUIqiQMALol8J177ZQU1
	7E0dVDH47lrKQrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A93CD13931;
	Tue, 16 Apr 2024 14:23:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c1i9FuyJHmb0bgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 16 Apr 2024 14:23:40 +0000
Date: Wed, 17 Apr 2024 00:23:30 +1000
From: David Disseldorp <ddiss@suse.de>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
Subject: Re: [PATCH] autofs-5.1.9 - fix ldap_parse_page_control() check
Message-ID: <20240417002330.120b1046@echidna>
In-Reply-To: <02526a0f-5f6c-43e1-9a3b-15d7f0a72e18@themaw.net>
References: <20240320005949.2661-1-ddiss@suse.de>
	<02526a0f-5f6c-43e1-9a3b-15d7f0a72e18@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.13 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	BAYES_HAM(-0.33)[75.80%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -1.13
X-Spam-Flag: NO

On Wed, 20 Mar 2024 11:43:19 +0800, Ian Kent wrote:

> On 20/3/24 08:59, David Disseldorp wrote:
...
> > -      struct berval *c;
> > +      struct berval **c;
> >         int ret;
> >         LDAPControl **clp;
> >         ret = ldap_parse_page_control(ld,clp,ct,c); ]])],  
> 
> 
> Thanks David, looks ok to me, will have a closer look and (I expect) 
> will apply it.

Thanks for the feedback Ian. Is there anything holding this one up from
being merged?

Cheers, David
