Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A0215F5C;
	Sat, 27 Dec 2025 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766795114; cv=none; b=o/yTq6syzflShfYYG6klfMlMbdD1A24G7GZeNz7BeZO60Qccxml6HEfWYJsjO/Pyt8NB00iBEW/TcGro+29WpQdN/3YGfbh3+BygsEQb/QHKHzUzJ4StQ+IYWJOTMWqeC7eH1FQOj5pG2fRlZFvFZy9kkcdIffw8b4wxbaPsrY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766795114; c=relaxed/simple;
	bh=Q+CiPZflSWjcYFwfVM0nb6mmeA4YCBn3cLnQqiwhVck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XehFF++ZVt2tbKsmd4QmnoMKawB+IkF5QJTQywk5ZeKE+x8KHGeonxuolC5M5JTF0ZHEl8Xrea7/vNWH/9ds6HTWZQZ/j5li4HzXc1pZktlXFCphyPDCFOs67zj6P1PECTZn90CF+uBNt0beUPyYFA+xi1OpUKvSjDsgjItnQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=ABzEeK84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ypUAU89B; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="ABzEeK84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ypUAU89B"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D06F140009C;
	Fri, 26 Dec 2025 19:25:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 26 Dec 2025 19:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766795111;
	 x=1766881511; bh=fvh1wXz8D9/H8JMPx5sVKS8H8CvO0hcRNTS4kLA2uAo=; b=
	ABzEeK84bB2p5v+V9PtaSBi8Yq4m677PI0f8cZhVPb4gmdDKnwcoemmkYJPezrWc
	s8lXv9KXitzapMcFMowzjsKLVu2CgDW2dkH7kL+PLxXFGGbXW/SyT7+cFAV09qKa
	hQIyfYoPWVzAZSDJV1rReghNhjWjdMqz4O+hwTOCgoV0ijTNqtEJcrBrjccdpTkw
	lnrpjU6fL/Dd+Mxpw7P1/8OSIt7xf7Xs8JRcubgQRyCar/FCFkizG/MKOzp1PXhm
	vj+zlFByek+Ru3sTNdIf2Kyz6TIhkNR23NPoidD/BPFBpkhcF6ZjC3eOQzkFlGSf
	lnt5syiZ+2mgGMf/Wkj3Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766795111; x=
	1766881511; bh=fvh1wXz8D9/H8JMPx5sVKS8H8CvO0hcRNTS4kLA2uAo=; b=y
	pUAU89B1gES9axCd8Rrz/akjlgicxr8uzZwq+vkIOIdvTGVTUAlaZBFke66n54Oh
	SD2lIhfasOx583wQd22HC+AzDTM2izeGIpsalNgPiXQBgQwMt07mZyJFnInU2b9M
	27LKVVyWNjuQ3dZLP7DwrIIkChHXRQT0hGMqBopFyklYCnRcdbB0IFFRqMyMEymY
	EZdAN+9hMQ0HGjGpMHLZeXmkF2UMMc3jo8AnwT2DV/NWmmGs2UFUN5ti71smE6bo
	K2N+MjJEW3nITe6YppqUBHFHM3KGxicYxKHmxLKIH+LJLs55VLD0CPxsu4i94+CZ
	kGflQXA+NwpaiPI7TKP4A==
X-ME-Sender: <xms:ZidPaQ2aw7DzwJDHOb49VVm00PosYwfTV1FJ8PzKoRuIwwMvvFHP6Q>
    <xme:ZidPaR8s2WS2P1ujW_N26tbHCZFdBZoAzFiI49VrS5WqZv-SWGMhxPoNeVQ1rI9mY
    Wp4Hj-c7qKNaJFvqNVJHdv5Y2R-sZmtsHY4N7k2aD81msD_0g>
X-ME-Received: <xmr:ZidPaRM2wj9IB77hFvnmjA889eq2RkpCgpJB53VGAKIfhzAGm9OXFy-EE2i5qcsSMNMiOdRl1ip-v24QJ4QHRayrPbuy9YhMG6hL9SP9c0nuA2ihnNQlpY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeileeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeefke
    fhgeeigeetleffgeelteejkeduvdfhheejhfehueeitdehuefhkeeukeffheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepiihilhhinhesshgvuhdrvgguuhdrtghnpdhrtghpthhtoheprghuthhofh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirghnhhgrohdrgi
    husehsvghurdgvughurdgtnh
X-ME-Proxy: <xmx:ZidPaVdCa3vASL--KT8HuV2__B8D4WhzVBNHEAFX3KvSy0P2QmnGYg>
    <xmx:ZidPaQUmj7mPcpsq_ifbhyhqC68PMb18e4wXkghbj5qVOtcsaRe62g>
    <xmx:ZidPadgHtAQRdgwPage56931N2MZbg6EKareExdfMw1lRs2Z4PhRKQ>
    <xmx:ZidPaf-uDKHpwR3yGlT1PWnv4CIlzfqPRa2eVNiNVBQbSGJFzmQk-Q>
    <xmx:ZydPaTV7lAHQ0kUsgZsQMbUv25YZfqw4GYMt832FsO15xtbO8W81jd5D>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Dec 2025 19:25:08 -0500 (EST)
Message-ID: <c8a82305-1c55-4c21-b0e0-e19a6ef9b543@themaw.net>
Date: Sat, 27 Dec 2025 08:25:05 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] autofs: Fix memory leak in autofs_fill_super()
To: Zilin Guan <zilin@seu.edu.cn>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
References: <20251225142754.1114352-1-zilin@seu.edu.cn>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20251225142754.1114352-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/12/25 22:27, Zilin Guan wrote:
> The autofs_new_ino() function allocates a new autofs_info structure.
> If the subsequent call to autofs_get_inode() fails, this structure is
> not freed, leading to a memory leak.
>
> Fix this by adding a new error label to free the structure and jumping
> to it upon failure.
>
> While at it, consolidate the error handling for the d_make_root()
> failure case to use the same label.
>
> Fixes: 66917f85db600 ("autofs: add: new_inode check in autofs_fill_super()")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Acked-by: Ian Kent <raven@themaw.net>


So obvious, one wonders how things like this go unseen for so long, ;)


Ian

> ---
>   fs/autofs/inode.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index b932b1719dfc..391979f8b2bb 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -324,7 +324,7 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
>   
>   	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
>   	if (!root_inode)
> -		return -ENOMEM;
> +		goto nomem;
>   
>   	root_inode->i_uid = ctx->uid;
>   	root_inode->i_gid = ctx->gid;
> @@ -332,10 +332,9 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
>   	root_inode->i_op = &autofs_dir_inode_operations;
>   
>   	s->s_root = d_make_root(root_inode);
> -	if (unlikely(!s->s_root)) {
> -		autofs_free_ino(ino);
> -		return -ENOMEM;
> -	}
> +	if (unlikely(!s->s_root))
> +		goto nomem;
> +
>   	s->s_root->d_fsdata = ino;
>   
>   	if (ctx->pgrp_set) {
> @@ -358,6 +357,10 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
>   
>   	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
>   	return 0;
> +
> +nomem:
> +	autofs_free_ino(ino);
> +	return -ENOMEM;
>   }
>   
>   /*
