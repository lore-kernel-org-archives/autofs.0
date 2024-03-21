Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232971C3D
	for <autofs@vger.kernel.org>; Thu, 21 Mar 2024 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979323; cv=none; b=VVoiS4dm6sfFR6H03/qJXuLZiU9TC2lEc++Ip9ffyToMtM+zah3iF/SBly/yO8zxFttaKvOo3K4E7uHrjWWG3ItW/XGAgNG2Qs/hpUg3nRIcqfeKP8tq4/sTuFqq61o6wvotuuzZ1YChQcyUF0ZnMW1GOt/YITt/6JA+IXeljAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979323; c=relaxed/simple;
	bh=FlY+hzmmzn5wSpTlwDqxYZQiyAHxDLtO+l/FQ4zuaS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+3+DNvOF+mznWQJNsVuTIJy+YggrKiwcKDAvbTK7UZWNt99JvO++zKGN5xpvnoIRTklDn9WZwxtZF4U3m2IdVqOESzoLoX3B4qJKv0yxt5C/scEg3Mf+J79TVXYTEVGrI10ge/AZwXMUWWpUmOJ9Ytj8oQqft7jzoknxA8yA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D92sWstN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gqVpGmbA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D92sWstN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gqVpGmbA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D92sWstN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gqVpGmbA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D92sWstN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gqVpGmbA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04EAF3368C;
	Thu, 21 Mar 2024 00:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710979318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThrHn04rFTy5ZIGrk60q61oqUwadEEp7n6mOCIWsk5o=;
	b=D92sWstN0UzVBUuSH3lmxx9ajlVBtcWJlu9m2HrwyeBQrZci7tzMGRTzli96xTJ0cXx9ST
	9obr6Ljq3p0wDOTBZWc14AsYKaJQ2IV5HEpJpqPEuPmAiSVjLbmBXcDcJNzLMpjzc+boaL
	+RRCyaJIumWMYqGgkZSwh8/ekT9noN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710979318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThrHn04rFTy5ZIGrk60q61oqUwadEEp7n6mOCIWsk5o=;
	b=gqVpGmbAANVlXvkvV6A/XSCNfhebJkivvZsyvmrx2kZq/SkXcxK95dFlWL6mfJfw1HV2k9
	bWOY6N//DKhJbkCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710979318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThrHn04rFTy5ZIGrk60q61oqUwadEEp7n6mOCIWsk5o=;
	b=D92sWstN0UzVBUuSH3lmxx9ajlVBtcWJlu9m2HrwyeBQrZci7tzMGRTzli96xTJ0cXx9ST
	9obr6Ljq3p0wDOTBZWc14AsYKaJQ2IV5HEpJpqPEuPmAiSVjLbmBXcDcJNzLMpjzc+boaL
	+RRCyaJIumWMYqGgkZSwh8/ekT9noN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710979318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThrHn04rFTy5ZIGrk60q61oqUwadEEp7n6mOCIWsk5o=;
	b=gqVpGmbAANVlXvkvV6A/XSCNfhebJkivvZsyvmrx2kZq/SkXcxK95dFlWL6mfJfw1HV2k9
	bWOY6N//DKhJbkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2390136AD;
	Thu, 21 Mar 2024 00:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PPNRFPR4+2VFawAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 21 Mar 2024 00:01:56 +0000
Date: Thu, 21 Mar 2024 11:01:42 +1100
From: David Disseldorp <ddiss@suse.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: autofs@vger.kernel.org
Subject: Re: [PATCH] autofs-5.1.9 - fix ldap_parse_page_control() check
Message-ID: <20240321110142.1b3ddb96@echidna>
In-Reply-To: <fe523469-beb4-493e-b88a-af7242f27714@molgen.mpg.de>
References: <20240320005949.2661-1-ddiss@suse.de>
	<fe523469-beb4-493e-b88a-af7242f27714@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.973];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[40.86%]
X-Spam-Flag: NO

Hi Paul,

On Wed, 20 Mar 2024 08:51:30 +0100, Paul Menzel wrote:

...
> > /usr/include/ldap.h:2155:25: note: expected 'struct berval **' but
> > argument is of type 'struct berval *'
> >   2155 | ldap_parse_page_control LDAP_P(( =20
>=20
> I wouldn=E2=80=99t wrap the lines of the pasted parts, and use a more spe=
cific=20
> commit message summary instead of just *fix =E2=80=A6 check*. Maybe:
>=20
>      ldap_parse_page_control(): Use correct type for @cookie

I'm fine with it either way, but I think the commit summary should
indicate that it's the config-time ldap_parse_page_control() call that's
problematic, not the modules/lookup_ldap.c invocation.
@Ian: feel free to update the commit message as you see fit.

...

> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks for the review!

David
