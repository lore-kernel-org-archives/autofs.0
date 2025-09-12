Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74955270EBF
	for <autofs@vger.kernel.org>; Fri, 12 Sep 2025 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719887; cv=none; b=bfuPfk7blSjPC0xje+s7kmryv/nFDjSfvf14fwcbVqSWRvUlfkn96DxnqoR0mI7rfWsdhXHuuxVlhyjroaqz5mVFICx1yvGk3b4BZdir7F2D8/K7FTAkW3vBO0r03dW0zZjtsZpPOk7jh8omvE97X973FSxwVFKvb0Ys05NYJRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719887; c=relaxed/simple;
	bh=TV2siNpwBhiaAJleww+GzIGHMTayhExRCJo18mkqO/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sW/OyvUAbb9Gc1rZwpqAt120rXKXySBlD4ohfuRVWsS+rvgKxIU7N668EIfNWOZpTt3/4AHUrPuTr74c0XJastaAx9J1Jh6p57meEWf03sViuf7XPhIaAjGtnLK6bKRTyzrIlkXnl5wXYv7WH0ZQh4L6uMdRQJrGkXxMXoQguu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=UdzWi0tb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k14v4KZg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="UdzWi0tb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k14v4KZg"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B170EC00FB;
	Fri, 12 Sep 2025 19:31:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Sep 2025 19:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757719882;
	 x=1757806282; bh=PrhzOuJRB4yOVAD4vczfdxW3ikIHIOIUfTHa347efVs=; b=
	UdzWi0tbmsLJTqEWPeCjaqfKxFz8xwlRVxKvahMmU4Xwhnr5AoxMAEQLpu9FPE0L
	dLi9+1dRi1NATA33Etx6CFvH4PPmXRVVrDo7Bn7TmTnpiFIR36etVcIlgR5KPP/l
	TM/adwOHakLfPjmQwO8Vkrrwmwd1+VZll4TBae+1CPQtvt5z88kZ/k4Auj7gS3Uh
	lTX371Ca4ennXVfHaeBoY7r6ouCrSR28ifcWlkxRjwThO0esDvhNaCIauCUyS7cK
	vHkhyhcjRIBGnIF3niNSnpI3b9oBJLzdB1jUfyPzUiTuPMzyskheFZ14k2ZHrH2/
	azu97e+Macwy7/yoVxeuxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757719882; x=
	1757806282; bh=PrhzOuJRB4yOVAD4vczfdxW3ikIHIOIUfTHa347efVs=; b=k
	14v4KZg3R4+UmDItltufGayggcSIZ7nxpe7qJXQEv0TYhrl+1DPEwtzINT7A3F9A
	8Bodskwdu3268HNS9Wn/lR6OufqNXPiSQcvP+NUl4K+AMlLYqImlXZlNo2zHDIJO
	FSbaS7B6w6rbI5SrblghYMoQ8A27k5yux2F/VvsJvZi8A135chnuJhwUo5tM3qfq
	CFPNKpyXI1i2N258z5gdUdVCd/KMJqFfiBshTxBZO30ZBI+lG5jBFAJZ0icZF2GS
	U1icF2CqLsJD9ZAFNbVW7tvpKEHZY9+RjfFczbLmxSMDBYzCHlwrOQKzkHht/pLg
	ykZtCzpalPhj6ATjrUmSw==
X-ME-Sender: <xms:Sq3EaJ3HmoWsDTRPS4wn4qa3PNHaOor0GlrGktNuOCH3F7xzJVtSJw>
    <xme:Sq3EaAQCQ1EOxsme4dgVmYBr6kwLGvnLOgwNzB1Bxb6b6CH2HhvQdMS4BkO3K6--W
    hoEFE_z7_-Y>
X-ME-Received: <xmr:Sq3EaLu84UhM8FjU9kXgJCO1wAl1TTAjZpoBm795eTpXGg5OJWteVhrF9TCPulv_tRLbuhvnLo6rsqsAn6aBopO85FmiJks6-j9xxChR6Ks85OlrVJw2qYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeefke
    fhgeeigeetleffgeelteejkeduvdfhheejhfehueeitdehuefhkeeukeffheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhgvvghosehjrghnvghsthhrvggvthdrtghomhdprhgtphhtthhopegruh
    htohhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Sq3EaFbb1-fa3cJCfIGFmXy6NYP0M1U2roW8FS21lbgShTMnU-zZew>
    <xmx:Sq3EaAuT1wr8oM865wW95ovQY9FfUpm6h4j0qQkW_BqAR2ujYe6b2A>
    <xmx:Sq3EaHEwnj_H-e6ipFF4r1Pd0EA8P_9VAfwozVCrzoq4CopyzY8QRQ>
    <xmx:Sq3EaLwd3o3J3SaUWr7xS0B2vg3Ys7QvEE2L_QLNVAWOCUCbE-fJNA>
    <xmx:Sq3EaHT64TIcvIlEV7oXGp4nhpaozUE3-QQih7H-67LcxF_yYn1w230i>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 19:31:21 -0400 (EDT)
Message-ID: <922abdb7-659a-4663-af65-15e8415b87c8@themaw.net>
Date: Sat, 13 Sep 2025 07:31:17 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] deadlocks due to setenv in lookup_program.c
To: Jun Eeo <jeeo@janestreet.com>
Cc: autofs@vger.kernel.org
References: <20250911132249.458873-1-jeeo@janestreet.com>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20250911132249.458873-1-jeeo@janestreet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 21:22, Jun Eeo wrote:
> Hi,
>
> When using the lookup_program module, we've seen an issue where the
> main automount process waits forever for the forked child to produce
> output (and quit). This causes whatever processes that require the
> automount to wait on autofs_wait.
>
> Coredump of the forked child showed that it was stuck waiting on a
> lock when calling setenv (it never went so far as doing the execl):
>
> #0  __lll_lock_wait_private () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:63
> #1  0x00007ffff60505ce in __add_to_environ (name=0x55555558b2e0 "autodir", value=0x55555558b300 "/a",
>      combined=0x0, replace=1) at setenv.c:133
>
> This seems to be caused by the macro_setenv call in lookup_one in
> modules/lookup_program.c -- that calls into glibc's setenv, and
> depending on when exactly the process was forked, it could be looking
> at a locked envlock.
>
> I guess there are two approaches which to fixing the issue and I'd
> like to get some thoughts before sending a patch:
>
> 1. Not calling out to any environment-mutating functions (clearenv,
>     putenv, setenv) which can hold the envlock after the initial setup.
>     In our deployment, the only place this happens is macro_setenv
>     and the sd_notify call in daemon/automount.c.
>
> 2. Avoiding the use of setenv in the forked child (it is MT-Unsafe
>     anyway). We can copy environ and use something like execle.

Certain macros are required to implement the Sun map functionality

so not using environment setting functions isn't really ok I think.


Sounds like not using env modifying calls in the forked child is

preferable although the child environment is independent in this

case. From what I've seen MT-unsafe problems occur when you do

something in the parent MT environment and don't undo it in both

the parent and forked child.


>
> I tested both patches about a week ago which seemed to fix the
> problem; there are no more deadlocks of this shape.

Post patches and we can discuss the implications.


I'm happy to change things if needed. But it sounds a little bit

like there's a glibc bug at play (unlikely) too, we'll need to

understand what's going on there too.


Ian

