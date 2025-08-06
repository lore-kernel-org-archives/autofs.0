Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4421E49F
	for <autofs@vger.kernel.org>; Wed,  6 Aug 2025 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440593; cv=none; b=Fv6P+WyxM5C3zaBC5epm2jv8L4NS/n0a5yQY6KRCPx9RSn3pw6bNUUpypE2iF7/e2DRJ1KpXjRjvIBFE0TQdAeCCGnvM/KQZBl6sFLOPJQDRzVjaED5ZD1xzJWRhvh2Xma5w6LPa0IAseUp4qM4U++/qH/BNas0ksZYCbiu5gzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440593; c=relaxed/simple;
	bh=1OtDbstwaXuANDEC/H+B5Q6NsxM5ZrAjHgOyN7fhMKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aByqTwz2LshgneJgtBffpOA7dzpTXdSOCES2KgwdkJptb3+In1z2uELlr9Jh6fTm8SYV005Hx+JfbyaJMsZ235AnTcu9LaFaIbF8wozPJwYSPyFoReTh8kG+yF9nF4qcbpGEH2uqwB31S1QzbO/YO92hCQlYz0jh43eLRfK4NAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=DpT8p2iP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oRrtQbbe; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="DpT8p2iP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oRrtQbbe"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 632D11400109;
	Tue,  5 Aug 2025 20:36:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 05 Aug 2025 20:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754440589;
	 x=1754526989; bh=1OtDbstwaXuANDEC/H+B5Q6NsxM5ZrAjHgOyN7fhMKo=; b=
	DpT8p2iPoOSD2BpinbjEA4Oa+DqEr1+5JzsS7eocAFk0TEg5u3CQ5bO5Qh3yKbRT
	kJbfBaDMv9JABtFB4zD6CIlSUXdpbcFXrHqObcUnUmD7ScVY0JhtOA2WXO3Gqgpg
	EXVAShVoWt0kdXTLUixHgk3YrSGKCeLYEIiQ9FUzo9OZRjmeC5DstzIwHZuOVvn9
	4HnaylIB2Vu4RJ0TFl5SI12RF6+48HmNPwLkWEiAwBvsdfjK2QKfcaZbCZ57wpRf
	WWSXkiUDkJJuIAnaHX70XqhR1ERVR/p42p0vVNYRBmmfkanqPXgjiHORLgPLXBGD
	ggUpN9XVZa6V24iTjx8Mlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754440589; x=
	1754526989; bh=1OtDbstwaXuANDEC/H+B5Q6NsxM5ZrAjHgOyN7fhMKo=; b=o
	RrtQbbeyyCoxBcvDZvG/I4cLELs1pfNyAxTZYWOwhFWZwyk4qzCajWz8obh5cWqj
	3DEe+ByqnCe9AoyGbemWKA7U4Cex8SBVLkE3wH0yPFH0cLZvmTloTuaNhnvCKq2F
	1/8MKmfaSDMAJ77bS3g3AjMFgn5NCUlc/VOXCdWrw5JxQTgdyYNYcO7Dw7YL5Ops
	MDzHzqaBlOd87VWpt3jopNwTW3nzy28DDPXdJG1MgZwSitLC3szw62NX8mFBjX2k
	2oEdouerK8mpHQtgWupnlnDQ6Y+MD4C00LPag2362B12uHiximtx4PniaWHlm9ms
	kZkM8R84a3cieepczQ/GQ==
X-ME-Sender: <xms:jaOSaFw3LfdvJ0OM0q3Z3PWRM2XcX3t5IhgfLav_bQ3RATQgGBq0iw>
    <xme:jaOSaFcwFuO9luERy9BnUBmrtJJF-OyPSaA-n2iAOmTx6SA2UYm4BTKtT8NjQbDjP
    UICnFRWf_9W>
X-ME-Received: <xmr:jaOSaBII78m65Pa7aArrYoe9sL0EMAxakJEuRDODGijX1GpImSAH2rOHAYr8bv0U9H7dAi2NgTzAtCdt_ZcnH4xiE5RBBA0rMt7fJAQZGk2CEnTsEudeXi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeiieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ekhfegieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopeguughishhssehsuhhsvgdruggvpdhrtghpthhtoheprghuthhofhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jaOSaGEZZbJzjh-We_3GqeQtU7uuGBl4bZw6AOvD3MgYDsMIPjxDUA>
    <xmx:jaOSaLrf3Op_71vp56u4sxigs4cHOKll1Lvy2jZ3hohM9a-ipbesIA>
    <xmx:jaOSaPQQGdgh9ieWoq4p6K6Y0UNNqpr1OjKq4dcZeVvwcLrG9S5IAg>
    <xmx:jaOSaINnqXI6Oo3InUtS-g5gihQVlqXR0kmcuYDogvs5TxJvzrPbLA>
    <xmx:jaOSaAUR-fvC-meE4ZEZULnlAXARSCBMuK57oR9kPRgzCFcSHyfqjOh1>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 20:36:27 -0400 (EDT)
Message-ID: <a66880ba-5d70-47f5-bc2c-d9e3ec4a2fef@themaw.net>
Date: Wed, 6 Aug 2025 08:36:24 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: autofs-5.1.9 - flag removed entries as stale
To: David Disseldorp <ddiss@suse.de>
Cc: autofs@vger.kernel.org
References: <20250801152210.15501-2-ddiss@suse.de>
 <8754561f-4be7-4d41-9330-a0e5691ca48b@themaw.net>
 <20250805183752.208f63d3.ddiss@suse.de>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20250805183752.208f63d3.ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/8/25 16:37, David Disseldorp wrote:
> Hi Ian,
>
> On Mon, 4 Aug 2025 09:31:22 +0800, Ian Kent wrote:
>
>> Hi David,
>>
>>
>> I was surprised to see this because I'm working on the very same problem.
>>
>> But since I didn't have a reproducer I've painstakingly worked through
>>
>> the map reload related code.
>>
>>
>> I don't know if my changes have fixed the problem but I can post them
>>
>> for you to try them out.
> Sounds good to me, I'm happy to run any rough drafts in my reproducer
> environment.

I've been a bit ill with a respiratory infection so I've been slowed up.

I'll post the series as soon as I can give the latest revision a bit of

a test myself.


Ian


