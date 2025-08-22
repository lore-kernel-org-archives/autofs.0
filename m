Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EB7283C9E
	for <autofs@vger.kernel.org>; Fri, 22 Aug 2025 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859833; cv=none; b=PmLCindHxlEqof4Z0iZkMEEDDqpG6js9/8FScrPlZ59OwGqAB2kFUee/kwMmOL1WXIJRXki3P4lSn928mvpBT14MapuheCV6y6phoeAZjuv1jR67TNe8gOslD/oMWpSl4qBMOSX6GAxiwyz72Uch4DZGrSr6FzGXSFSRB97cas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859833; c=relaxed/simple;
	bh=DqRFL5MnHTAIK9Fn67JcgjPfUKc+nCfPzl2xYOJiFjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8gGNwAvpRTynB45sHOcs3a8e8zEf/EOahif2xtiw32hKkdX7nCeRzvPl5ReT00fAe2nremHgajO+thRH7xsy6JUYaGkaJ/h/KDz4AWiTwd+l4eaN2h0uvP42+rYTPGCeaUcPmeRwChEtgkVGGoUaJ1WUVuW2GhRIjNDeBoGJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IKF+Opel; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ui4ckur1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IKF+Opel; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ui4ckur1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IKF+Opel";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ui4ckur1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IKF+Opel";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ui4ckur1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15BA1211EB;
	Fri, 22 Aug 2025 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755859830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c0yY17UrLoff30b+EKHv+UeYx/5LmyxnqQoznuKH6I=;
	b=IKF+OpelX/WYqA/XItjrpRdKfg+q0+Ju2OMvcoNV3Hw51tKZJkSqkWx0IvJvaUtsUkbF9e
	YJPPZ/maP7mwNbzcoxaF1QOnQoDlO/IxgVs5lCEBbfLzNrd7XYt/AL7C7hCI0K8jojP4yh
	fsm0Bt57ev6FuULITIo3OV6d9AeczHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755859830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c0yY17UrLoff30b+EKHv+UeYx/5LmyxnqQoznuKH6I=;
	b=ui4ckur1P88l+EE1UNGUV58+Y18AxlgTp112KsSHfgXNB9uEhpAN36PiFCwc++wYrT2lgS
	bTFSCAl/B3+6lyCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IKF+Opel;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ui4ckur1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755859830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c0yY17UrLoff30b+EKHv+UeYx/5LmyxnqQoznuKH6I=;
	b=IKF+OpelX/WYqA/XItjrpRdKfg+q0+Ju2OMvcoNV3Hw51tKZJkSqkWx0IvJvaUtsUkbF9e
	YJPPZ/maP7mwNbzcoxaF1QOnQoDlO/IxgVs5lCEBbfLzNrd7XYt/AL7C7hCI0K8jojP4yh
	fsm0Bt57ev6FuULITIo3OV6d9AeczHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755859830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c0yY17UrLoff30b+EKHv+UeYx/5LmyxnqQoznuKH6I=;
	b=ui4ckur1P88l+EE1UNGUV58+Y18AxlgTp112KsSHfgXNB9uEhpAN36PiFCwc++wYrT2lgS
	bTFSCAl/B3+6lyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDCDA13931;
	Fri, 22 Aug 2025 10:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t3DLJHRLqGjWRwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 22 Aug 2025 10:50:28 +0000
Date: Fri, 22 Aug 2025 20:50:19 +1000
From: David Disseldorp <ddiss@suse.de>
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Patch series for direct map reload bug
Message-ID: <20250822205019.40573a03.ddiss@suse.de>
In-Reply-To: <20250808021655.12774-1-raven@themaw.net>
References: <20250808021655.12774-1-raven@themaw.net>
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
X-Rspamd-Queue-Id: 15BA1211EB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

Hi Ian,

On Fri,  8 Aug 2025 10:16:46 +0800, Ian Kent wrote:

> There have been reports of log messages like:
> automount[nnnn]: handle_packet_expire_direct: can't find map entry for (1048647,114082)
> 
> These messages are fatal because the direct mount path must be known to
> lookup the mount. Historically the autofs kernel communication packet
> size is fixed and based on the maximum path name component size used by
> indirect mounts but direct mounts have a variable length multi-component
> path. To solve this while maintaining compatability with indirect mounts,
> an index of (device, inode) tuples is maintained to allow lookup of the
> direct mount path so the map entry can be located.
> 
> Also it's necessary to understand that direct mount maps are always read
> fully in order to mount direct mount triggers for all direct mount map
> entries so they must exist so this approach should always work.
> 
> So the message above only occurs for direct mounts and the ioctl file
> handle used by each direct mount is stored in the map entry so it's
> not possibile to respond to the kernel at all if the map entry cache
> entry can't be found.
> 
> Unfortunately map entry cache cleanup on update is complicated and can
> lead to problems which (I believe) is what's happening here.
> 
> While I suspect your reproducer is a different case to what I've seen
> it probably symtomatic of the underlying problem.
> 
> Patches "autofs-5.1.9 - fix devid update on reload" and "autofs-5.1.9
> - fix stale direct mount trigger not umounted on expire" are the main
> fixes I was able to identify working through the code.
> 
> Please test them and let me know how it goes.

Your patches do indeed resolve the kernel stall in autofs_wait following
direct map reload, but there's one slight difference in behaviour
between my RFC and this series when running the reproducer from the
https://lore.kernel.org/autofs/20250801152210.15501-2-ddiss@suse.de/
commit msg:
The share that gets removed from the direct map and then explicitly
unmounted will be remounted by the background `df` workload when running
this series. With my RFC the MOUNT_FLAG_STALE flag tracks removal,
avoiding subsequent remount.

Thanks, David
