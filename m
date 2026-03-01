Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFE1E832A
	for <autofs@vger.kernel.org>; Sun,  1 Mar 2026 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772325590; cv=none; b=YOjIRQZOYg0Uep3VgebFonozO6BcRK2PnDMQqZ6rHEQzTJYm/i9BwuRMyo6QGQid1/TBwg3ZnD8+dCjRiJ2R+1UtrBsE5/dPqyoGSQTJKFOF+BjGJY7Xpu3CYpUswJ3eSjxUKsOJOTmG5kXyq7SV1au7mvQmEIRQcd3V0JjRMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772325590; c=relaxed/simple;
	bh=PFKys6V5F1OHMOiyXKy2OwsMzPF145awKXwvPdewKdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U+J4n/0IW3jjH9+RRpAH1IL3MvaIDrKPTfgepgD7SK/fUQzCfZmE3VNhHSb0TJiyyVzZjlG56o3az79u8iNv1Tsp/sfYXpgYWFOrwrSKspCMWLyrOSdhiMPqwiMn7+Wkt1tkXVrDAasmVwkJUKQ9600JxYx5luAxjj+QTBtPJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=m2j4Ul6k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QM7r3v4g; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="m2j4Ul6k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QM7r3v4g"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 176BB1D00119;
	Sat, 28 Feb 2026 19:39:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 28 Feb 2026 19:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772325587;
	 x=1772411987; bh=HI9+VVOdacsafsFzLX0kSRHJqVSzPS9GesgPMRVx+jg=; b=
	m2j4Ul6krL3Ol7jZyOOzhZxSDBuU2I4cNTw43lT5VnZwSXhyid/cJ8OncNzgJxe2
	n1a0afN2a6L9ZFx57UXO9GNIJsHVQmTxi49+++4H8vIwhT4FFr2DLUh7rJBF7bL+
	gT5+bDCkXZAVp+O/22bxLjkAinRviNbJt+qtGK8LDQ1Y7kuRVB7pJMu8/ByaBOCw
	Mn48qhzcODvXULwEX32upfmDdZSyqX1sS7SEHE88RVbmTtxL2FqriQQsB+eoDj5n
	wEuD+1Ee1g0bLunyM5GpYk6mphnYutbvOT4dDvlrfVQDFeqToRfEz8379iNz5doP
	IXjTnA7kZeoE+GCNrtxqUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772325587; x=1772411987; bh=H
	I9+VVOdacsafsFzLX0kSRHJqVSzPS9GesgPMRVx+jg=; b=QM7r3v4gOGatqJBLO
	2mZnJE+DKzQM8FWjPDUUf38nIMxdQnLtYiv7uZc4dxnIc3HMsq2DNyAHStyA+YKz
	Qeecb50pzApKVZ1rGmkpz9t99E3YQY54AJYfji+2BRhZ1vztucneka5e2ULuuJFW
	sSUXnyCB9Na2ob8JbLMj4UytUUUvgLdLBNAGByz/wPwDuZfMTyXJJXBEj9rx0rl/
	6/nDQMSluD27QpEiEStLdzQU9mdyBV/fZ4+TlKM8DRLjPBkUExn9uYpJKMoTu7dX
	ELZv8qK6ldsz4kqmGEdbMfSqPwZSf6hpEAb4T4w/5+ALFwYpIXl2MioAt6MbPjWB
	2KsSg==
X-ME-Sender: <xms:04qjaTRqCuLCxBaPhtlPGvVQ1wcXtSw-D_SPQPa583mjsc3-lEHtLA>
    <xme:04qjaSs5pMHXsnDoIloSdJntMiKiHf5DelZdlumxYTSNB3wwrumd3Hoi24ghratL0
    2k1GxyqTbh4F627HCAYN0cvlQiYXoF0fuYSBlS89cq-4cgC>
X-ME-Received: <xmr:04qjaQZ3s-V6_udFEj6_z4OnMUdvJ4lH6TaJm_OZ3bpfObXPbpvG3t5Sid8hYKMg8fbVUJ3dmRwRvj57ejkCuFmfQZQ3MnazgsdRVPqB-XrohcDjmLRNUw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeffeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeejue
    euteffueegjeehkeetiedufeehvdehteejtdejteelleehkefgfeefuedtgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgtvghrnhhkohesmhhpihdqkhhlshgsrdhmphhgrdguvgdprhgtphhtth
    hopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:04qjafv8eJWZxW_D_LbWXivhPk7gJksbH4CXocN3EsRJe77pUXk-eQ>
    <xmx:04qjaaHrxRR_izxk8YExVmfUgwiq16AW6bzS4-JPG-q330f8d8FLIA>
    <xmx:04qjaSzxNTKgp16MQez3I6KrXz1--VqtlxuBMQiEF29qAi8EkRb62A>
    <xmx:04qjaRhAs4jttcLt0Y2FCvrnrj3vHFdcZUDTaJLL8XXvfeuPdD6weQ>
    <xmx:04qjaT69Lj4L7-HK4yssZPGaijCOos-kVas5nlUYZZBYj8lDVxIPuzY9>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Feb 2026 19:39:46 -0500 (EST)
Message-ID: <4d6271da-9f5e-4fab-aaf8-428f5fb85f4d@themaw.net>
Date: Sun, 1 Mar 2026 08:39:44 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] <autofs-5.1.9> fixed mailing list subscription address
To: Patrick Cernko <pcernko@mpi-klsb.mpg.de>, autofs@vger.kernel.org
References: <54c5e579-f38b-49a8-a21f-ecd1c9243afc@mpi-klsb.mpg.de>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <54c5e579-f38b-49a8-a21f-ecd1c9243afc@mpi-klsb.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/2/26 17:22, Patrick Cernko wrote:
> Hi Autofs developers, Hi Ian,
>
> trying to subscribe to the mailing list with the old instructions, I 
> learned from vger, that you have to use a new address for subscribing.

That's a dumb mistake on my part.


I did see a change ages ago but didn't quite register the instructions

would need to be changed too.


Thanks for the heads up and fix.


Ian

