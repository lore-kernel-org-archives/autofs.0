Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0930B533
	for <autofs@vger.kernel.org>; Fri, 15 May 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853569; cv=none; b=TWSuz63Z/lyhE4H4hAITToJ0lUYizxtzJT/gZfX6NprpVxxv1sMIGxRbYXDGYmJufDsVGRXFEGzhveV2AxoSMHMiLrFTdRwADHVkridoQKz22k6zqIcZ1OCtNuQiAQ4fRzO/eTxdThVS2z6n5JxnSndX4yDNYOFrhk1jMKjSMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853569; c=relaxed/simple;
	bh=gmdv4WMLgV0itT7fpII2jr+l/bMb8+w3pDEwKEyfLso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cd1lNIATG37BoQ2QkMyT8W62WcIR5eT2LVXDJ3UEZ05D5mm3wBeyNaqkZHGmtCaT62n8JH3/fU7ii6xhL+jVIH1v4K4M9f5cGz4BGr+4EnUTwqlP0sACirY8VAn0gu/fY4JAok2MjjgaVduQB7Tx4k4q4LYS9+7w+1A42zIL/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=cC/I2TCE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=am2NU2Fo; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="cC/I2TCE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="am2NU2Fo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1E3F7A00DB;
	Fri, 15 May 2026 09:59:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 15 May 2026 09:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778853566;
	 x=1778939966; bh=gmdv4WMLgV0itT7fpII2jr+l/bMb8+w3pDEwKEyfLso=; b=
	cC/I2TCEbiyQ4mGjElFVyMaBMxvaoXUFvxLvYAuKBqJzU/XxkI6gds3tMoZ+h60K
	wWQ25IswnK/76IK7gkB5or2I5ZpSp+SrFsRj4Wo7/A+wbARdoCLNLRlxgJbI9CKp
	8L8IJNkOcnnxok8XabxX8R2uPtYfgUV1whwgLYarCklzZqQ/XpmlVWdENntZv/4i
	c2j9S2eH2eaeCbDhxhntPkYTY6bKCr+aLJqLMZ1K3VEM0m27nvs5zJNItJzKCbK+
	KouDhIkbFAraxGDswiQ6oXMyB8hwlVOe0PyK4pNs0ytF2sr6PVZGpcUroIV/FmWo
	61IwJPMy7mpMF0QFb26xQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778853566; x=
	1778939966; bh=gmdv4WMLgV0itT7fpII2jr+l/bMb8+w3pDEwKEyfLso=; b=a
	m2NU2FobhiDpR0RBncDfwjWREJj32JZjfr4p6doPQ4dR7PcolM5Bn7YuQfqVjDSv
	KPrsLNNar6f6SrNWL09zCfX7oFyfzThdvIzBMjKEB9v2BcoXNqjUv28YXMTEXqXJ
	x3I7h9LlJAJJNMd1GfpXeirtmA4SN0gha1JFLnibBOfXUj1dJDV1uxDoMFRFSjgG
	qtB/3EpJQg251GywsAxvKbWBnXJNaU1T8VgVi4rL1m2yW1/ApqEZgsmJLxddwr4y
	w/YN1jjEHCXo+7Q3AowWAKhaDruAiKhFaZzDtj5oevaA4BSgBKsCtEeaYqBSjPlc
	uD7wLNnRJ3V2K5aI8DGBg==
X-ME-Sender: <xms:viYHahrlesuub41wySAeC965AmOx5Cqwyn9VXyZ5s-nYpqDLI7B5uA>
    <xme:viYHarHf8n4eGcqPzoA_HEdQjB1Ml7zr9qcw90-0JAoeAnXI4ljZyYHyy4y__WHE2
    cJa3lffS-b3uY2bDS_ijbUptB47O1wRk71I9j2ZGSZPqqs>
X-ME-Received: <xmr:viYHarlMDCzD9tJmGbFJ5B4xvoT63aDCIPi4HUYNuFLvUybj4TMZMgcEqMuymRzu960B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ekhfegieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrghholhgufiihnhesshhushgvrdguvgdprhgtphhtthhopegruhhtoh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihguohhnghdriihh
    ohhnghesshhushgvrdgtohhm
X-ME-Proxy: <xmx:viYHamlkgd-q7pTQt-k5tTZ2XX5YqUD-8cm2MWlMoeVczUp2n6AC4A>
    <xmx:viYHakuSe3ORZb7ieL7hkY74R-pdRuBDhof3Auqly7jAwGmgztc0PQ>
    <xmx:viYHahktwiKuk7H_7U6zrLcFlPq2PLjEy1wvTSzlb2e3rQ69E9se1w>
    <xmx:viYHanuzEPCkDYqiEDRMxKzCufMmXOgWEg81E2F_PQQnttt_-Xk8IQ>
    <xmx:viYHamSimuHWVyFXSwDrMi_aNsIXGQBtbz_ojVhCJcNgFEMNY7MnX1GQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 09:59:24 -0400 (EDT)
Message-ID: <0b19868a-a3f0-44fb-856c-1d3464b080a2@themaw.net>
Date: Fri, 15 May 2026 21:59:20 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to set log priority for all direct mounts
To: Goldwyn Rodrigues <rgoldwyn@suse.de>, autofs@vger.kernel.org
Cc: lidong.zhong@suse.com
References: <agYonWw9_WVrWyub@zuko.lan>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <agYonWw9_WVrWyub@zuko.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/5/26 04:01, Goldwyn Rodrigues wrote:
> Hello,
>
> Since the work to have a single FIFO file for setting log priority
> (16ea4156 ("autofs-5.1.8 - switch to application wide command pipe"), to
> be more precise 16ea4156 (autofs-5.1.8 - switch to application wide
> command pipe), automount has lost the ability to set the log priority of
> all direct mounts using the path "/-".
>
>
> # sudo automount -l info /-
> Could not find device id for mount /-
>
> This is because automount attempts to mount and get verifies the real
> path which is non-existent in case of direct mounts "/-".

Of course yes.


>
> In the automount program, the log priority is set pretty early and much
> before the master map is setup. So we cannot check on the autofs dev
> either.

But it should be settable on a per-mount basis.

The command line log setting was always meant to modify an existing

global log priority. Setting it for /- should mean setting it for

all direct mounts, ie. the global setting.


>
> What would be the best way to solve this? Should we just document it
> as a feature loss?

It sounds more like a regression, I'd rather try and fix it.


There should be (is/used to be?) a global log priority for both direct

and indirect mounts which shouldn't need this sort of validation and

should be used if the validation fails.


Let me have a look and get back.


Ian

