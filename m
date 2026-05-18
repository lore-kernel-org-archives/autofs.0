Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74857382F03
	for <autofs@vger.kernel.org>; Mon, 18 May 2026 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127498; cv=none; b=EWPmf0iie+3Xzj4sK2sfzSlzXdxNhMLe9F5EuYaEclRLOgAuz17uBI8Hy7NfhxzQXtKJJRZx0ytrxQF/AfI+DZdpSnWcu3iY1zlbKjbfX9HX5NUA2n7Oer6hOzE44ALL/wow0MwgPb2rDISN8TW3CmVXwm9XDpkGbOW72Ek4stk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127498; c=relaxed/simple;
	bh=dPr7xbI5uZMKzZuLozGTjX4o0Jrrvx/b9nCvxpbAxOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkaJ8fip9z1E6Bg3fQltP+Ex18uM+kp9+Wrp8qDHi6Tl6nokmLI2MV5C4mNr2keOmwDe5KHqdblwuazqsqKu+0IXcZktAbT6wGxfzshEZfC6ugClVyZ22rsa3oDQPN2VwNe1uJV4R3NyMfR/WIV2RYhUcKyJm+s0Yv0ULzCxOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wuDdsPQu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aNNiNNhq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wuDdsPQu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aNNiNNhq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wuDdsPQu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aNNiNNhq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wuDdsPQu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aNNiNNhq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 114F1628C8;
	Mon, 18 May 2026 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779127490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cY/RAPnZx0eu7jLvMc6GV9x4cpyjBgLq37uQDxl9Qz0=;
	b=wuDdsPQugqsMUd2x9j0GZrDThefpvoBmkepo+B4SfLLmJxkYvE+f0++Q7D+RGKVuExbsF8
	gWd3r4i1MVbOLFhmLqx8bOR9FHti3KtY/85kF8fIU5GjwlyFwpwamLj86e0w3wvDdGd/lu
	TNO7qQZXMi9mBcZyiC+2qyz6R+ih6Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779127490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cY/RAPnZx0eu7jLvMc6GV9x4cpyjBgLq37uQDxl9Qz0=;
	b=aNNiNNhqM9LtvXe+Y1AYdDyJZWGYoxZl0AbIYnBHNXnFH3VeupBsss35t4hiINLpPItg4K
	tvOMjP+uMfTQI5DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779127490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cY/RAPnZx0eu7jLvMc6GV9x4cpyjBgLq37uQDxl9Qz0=;
	b=wuDdsPQugqsMUd2x9j0GZrDThefpvoBmkepo+B4SfLLmJxkYvE+f0++Q7D+RGKVuExbsF8
	gWd3r4i1MVbOLFhmLqx8bOR9FHti3KtY/85kF8fIU5GjwlyFwpwamLj86e0w3wvDdGd/lu
	TNO7qQZXMi9mBcZyiC+2qyz6R+ih6Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779127490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cY/RAPnZx0eu7jLvMc6GV9x4cpyjBgLq37uQDxl9Qz0=;
	b=aNNiNNhqM9LtvXe+Y1AYdDyJZWGYoxZl0AbIYnBHNXnFH3VeupBsss35t4hiINLpPItg4K
	tvOMjP+uMfTQI5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB90E593A8;
	Mon, 18 May 2026 18:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +DQbK8FUC2p2WQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Mon, 18 May 2026 18:04:49 +0000
Date: Mon, 18 May 2026 14:04:48 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, lidong.zhong@suse.com
Subject: Re: Unable to set log priority for all direct mounts
Message-ID: <agtT8EytwEf-WN8X@zuko.lan>
References: <agYonWw9_WVrWyub@zuko.lan>
 <5047369f-b05b-402c-96a8-c957573a3ce3@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5047369f-b05b-402c-96a8-c957573a3ce3@themaw.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 17:01 18/05, Ian Kent wrote:
> On 15/5/26 04:01, Goldwyn Rodrigues wrote:
> > Hello,
> > 
> > Since the work to have a single FIFO file for setting log priority
> > (16ea4156 ("autofs-5.1.8 - switch to application wide command pipe"), to
> > be more precise 16ea4156 (autofs-5.1.8 - switch to application wide
> > command pipe), automount has lost the ability to set the log priority of
> > all direct mounts using the path "/-".
> > 
> > 
> > # sudo automount -l info /-
> > Could not find device id for mount /-
> > 
> > This is because automount attempts to mount and get verifies the real
> > path which is non-existent in case of direct mounts "/-".
> > 
> > In the automount program, the log priority is set pretty early and much
> > before the master map is setup. So we cannot check on the autofs dev
> > either.
> > 
> > What would be the best way to solve this? Should we just document it
> > as a feature loss?
> > 
> 
> Haven't actually tested this but it should work to fix the log priority
> 
> for /-.
> 
> Could you give it a try please.

Yes, this fixes the log setting and works as expected. Thanks!
Reviewed-and-tested-by: Goldwyn Rodrigues <rgoldwyn@suse.de>

> 
> 
> autofs-5.1.9 - fix handling of direct mount path in command handler
> 
> From: Ian Kent <raven@themaw.net>
> 
> Commit 16ea4156471e ("autofs-5.1.8 - switch to application wide command
> pipe") broke the ability to set the log priority from the command line
> for all direct mounts.
> 
> As Goldwyn Rodrigues points out the autofs_point structure for direct
> mounts doesn't have a real mount associated with it so it needs special
> handling which was ommitted in commit 16ea4156471e.
> 
> Fixes: 16ea4156471e ("autofs-5.1.8 - switch to application wide command pipe")
> Reported-By: Goldwyn Rodrigues <rgoldwyn@suse.de>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  CHANGELOG          |    1 +
>  daemon/automount.c |   17 +++++++++++++++--
>  daemon/master.c    |   11 +++++++++++
>  include/master.h   |    3 ++-
>  4 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/CHANGELOG b/CHANGELOG
> index d6d594e9e..0fc529f32 100644
> --- a/CHANGELOG
> +++ b/CHANGELOG
> @@ -89,6 +89,7 @@
>  - do_reconnect() expiry check of dclist BEFORE lookup using it.
>  - fix mailing list subscription address.
>  - fix table_lookup_ino() fd reference.
> +- fix handling of direct mount path in command handler.
>  02/11/2023 autofs-5.1.9
>  - fix kernel mount status notification.
> diff --git a/daemon/automount.c b/daemon/automount.c
> index 517764119..a01d176ae 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -1487,7 +1487,13 @@ static void handle_cmd_pipe_fifo_message(int fd)
>  		return;
>  	}
> -	ap = master_find_mapent_by_devid(devid);
> +	/* There's no "real" devid for the top level direct mount
> +	 * container so we use -1.
> +	 */
> +	if (devid == -1)
> +		ap = master_find_mapent_by_path("/-");
> +	else
> +		ap = master_find_mapent_by_devid(devid);
>  	if (!ap) {
>  		error(LOGOPT_ANY, "can't locate autofs_point for device id %ld.", devid);
>  		return;
> @@ -1548,7 +1554,14 @@ static int set_log_priority(const char *path, int priority)
>  	if (!ops) {
>  		fprintf(stderr, "Could not get ioctl ops\n");
>  		return -1;
> -	} else {
> +	}
> +
> +	/* There's no "real" devid for the top level direct mount
> +	 * container so we use -1.
> +	 */
> +	if (!strcmp(path, "/-"))
> +		devid = -1;
> +	else {
>  		ret = ops->mount_device(LOGOPT_ANY, path, 0, &devid);
>  		if (ret == -1 || ret == 0) {
>  			fprintf(stderr,
> diff --git a/daemon/master.c b/daemon/master.c
> index d85dd8975..8b7450e73 100644
> --- a/daemon/master.c
> +++ b/daemon/master.c
> @@ -711,6 +711,17 @@ struct master_mapent *master_find_mapent(const char *path)
>  	return NULL;
>  }
> +struct autofs_point *master_find_mapent_by_path(const char *path)
> +{
> +	struct autofs_point *ap = NULL;
> +	struct master_mapent *entry;
> +
> +	entry = master_find_mapent(path);
> +	if (entry)
> +		ap = entry->ap;
> +	return ap;
> +}
> +
>  struct autofs_point *master_find_mapent_by_devid(dev_t devid)
>  {
>  	struct master *master = master_list;
> diff --git a/include/master.h b/include/master.h
> index 71610611f..3ca7ad8d6 100644
> --- a/include/master.h
> +++ b/include/master.h
> @@ -105,7 +105,8 @@ void master_source_readlock(struct master_mapent *);
>  void master_source_unlock(struct master_mapent *);
>  void master_source_lock_cleanup(void *);
>  struct master_mapent *master_find_mapent(const char *);
> -struct autofs_point *master_find_mapent_by_devid(dev_t devid);
> +struct autofs_point *master_find_mapent_by_path(const char *);
> +struct autofs_point *master_find_mapent_by_devid(dev_t);
>  struct master_mapent *master_new_mapent(const char *, time_t);
>  void master_add_mapent(struct master_mapent *);
>  void master_remove_mapent(struct master_mapent *);
> 

-- 
Goldwyn
