Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5974129A72
	for <autofs@vger.kernel.org>; Tue, 16 Apr 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277647; cv=none; b=aa22mdGaNT8X+I/6dDmManXoDUKPcp9Z7mC3uo6itcurCsFydahH/dUSLVrrqP6vf6tZSthezMP0ESU0Y+D4PY0Q6YMG41qmeNcmnsbehdS+SrPGmipbZUBxeb3byAXSctkdYwKAIpXc2vv+IvwLmckw9G2vx53BZYl7wyxVA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277647; c=relaxed/simple;
	bh=EB4YOss2PMTAAV/c5TQlxJPJ3hIjEGi6xOK73+X/jf0=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/EEmPXn1Y7hKzQWA+esnEcRTBnNUJgxbO9nKfLWe+9Al2mxbCTkOw2CLqGQ46ICdW9jzoqd0pLGPMl3CL7/NLhXc0hx8anOfZlZRm7whd7OVMaH8MViOa1EYqBtGDXt2MUyln4pmMvN5b26qiDLReDQSzrkmXE2lbJ8t54G/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HMoAZjXT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o2wvpD3A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HMoAZjXT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o2wvpD3A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HMoAZjXT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o2wvpD3A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HMoAZjXT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o2wvpD3A"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1946D21A2A
	for <autofs@vger.kernel.org>; Tue, 16 Apr 2024 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713277644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuJNySb/eJONIp1f/JVEibj1NDXGoGotkM18FOMRhwQ=;
	b=HMoAZjXTHGqUmtWtwR7rIIuGlRw5F59HzkjAwphPSGjPz0HuGxrges0P2bkKvRv2Q5c5qs
	GPUCiih1XZhzBupA3dddycuTlWIjjlvEDXrXrPwAtzSD5+lmRB5skROUkpAKk3PY6YUtlA
	JDR7zGDk5tbukUGO9xD9bqea837nviU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713277644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuJNySb/eJONIp1f/JVEibj1NDXGoGotkM18FOMRhwQ=;
	b=o2wvpD3Ag3tk/N+cf0iyj9Q1a00VrhLtNXP/ErUIf9rMKugVBDzZd9UmqRewDCWpoOnHbI
	jQ2dyVwwXyjZB1AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HMoAZjXT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o2wvpD3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713277644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuJNySb/eJONIp1f/JVEibj1NDXGoGotkM18FOMRhwQ=;
	b=HMoAZjXTHGqUmtWtwR7rIIuGlRw5F59HzkjAwphPSGjPz0HuGxrges0P2bkKvRv2Q5c5qs
	GPUCiih1XZhzBupA3dddycuTlWIjjlvEDXrXrPwAtzSD5+lmRB5skROUkpAKk3PY6YUtlA
	JDR7zGDk5tbukUGO9xD9bqea837nviU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713277644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuJNySb/eJONIp1f/JVEibj1NDXGoGotkM18FOMRhwQ=;
	b=o2wvpD3Ag3tk/N+cf0iyj9Q1a00VrhLtNXP/ErUIf9rMKugVBDzZd9UmqRewDCWpoOnHbI
	jQ2dyVwwXyjZB1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 249CE13931
	for <autofs@vger.kernel.org>; Tue, 16 Apr 2024 14:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7hkJMsqKHmYXcAAAD6G6ig
	(envelope-from <ddiss@suse.de>)
	for <autofs@vger.kernel.org>; Tue, 16 Apr 2024 14:27:22 +0000
Date: Wed, 17 Apr 2024 00:27:16 +1000
From: David Disseldorp <ddiss@suse.de>
To: autofs@vger.kernel.org
Subject: Re: [PATCH] autofs-5.1.9 - cast sasl_callback_t function pointers
Message-ID: <20240417002716.5f7fb670@echidna>
In-Reply-To: <20240321013947.31673-1-ddiss@suse.de>
References: <20240321013947.31673-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[21.93%];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[autofs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1946D21A2A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.01

Hi,

On Thu, 21 Mar 2024 12:39:47 +1100, David Disseldorp wrote:

> GCC 14+ uses -Werror=incompatible-pointer-types by default.
> sasl.h:sasl_callback_t doesn't offer a type-safe mechanism for setting
> @proc callback functions, so a cast is necessary.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  modules/cyrus-sasl.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/modules/cyrus-sasl.c b/modules/cyrus-sasl.c
> index e742eaf..107e182 100644
> --- a/modules/cyrus-sasl.c
> +++ b/modules/cyrus-sasl.c
> @@ -109,17 +109,17 @@ static int getpass_func(sasl_conn_t *, void *, int, sasl_secret_t **);
>  static int getuser_func(void *, int, const char **, unsigned *);
>  
>  static sasl_callback_t callbacks[] = {
> -	{ SASL_CB_USER, &getuser_func, NULL },
> -	{ SASL_CB_AUTHNAME, &getuser_func, NULL },
> -	{ SASL_CB_PASS, &getpass_func, NULL },
> +	{ SASL_CB_USER, (int (*)(void))&getuser_func, NULL },
> +	{ SASL_CB_AUTHNAME, (int (*)(void))&getuser_func, NULL },
> +	{ SASL_CB_PASS, (int (*)(void))&getpass_func, NULL },
>  	{ SASL_CB_LIST_END, NULL, NULL },
>  };
>  
>  static sasl_callback_t debug_callbacks[] = {
> -	{ SASL_CB_LOG, &sasl_log_func, NULL },
> -	{ SASL_CB_USER, &getuser_func, NULL },
> -	{ SASL_CB_AUTHNAME, &getuser_func, NULL },
> -	{ SASL_CB_PASS, &getpass_func, NULL },
> +	{ SASL_CB_LOG, (int (*)(void))&sasl_log_func, NULL },
> +	{ SASL_CB_USER, (int (*)(void))&getuser_func, NULL },
> +	{ SASL_CB_AUTHNAME, (int (*)(void))&getuser_func, NULL },
> +	{ SASL_CB_PASS, (int (*)(void))&getpass_func, NULL },
>  	{ SASL_CB_LIST_END, NULL, NULL },
>  };
>  

Does anyone have feedback on this proposed change?
