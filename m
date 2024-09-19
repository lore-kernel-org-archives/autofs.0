Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B58EEC9
	for <autofs@vger.kernel.org>; Thu, 19 Sep 2024 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714776; cv=none; b=MXXTNYczaP6fYuFWXgrdX81HfM/L54xFMod4sEpP185DZr+tyUtuH6INgixz44lHzHc4SyiQ7IiQPrJIxhBlefLC+4zIznjl1GVsCik3y+n8oGJJV1G0TUyZJS7hOT046bCKqEUE1VfujpzlBUBpgWpc1d5OH2cYMIh4qoJiSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714776; c=relaxed/simple;
	bh=Y2P/ij7doFcveUr4/RHneUmTPKOp/8oWVpfdp9GgS2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6/M2QIzgzA9oFg9dIPy9PcVqfZPIvvhKpw1agb58YxWo1AdoKd964BfhPgEYWQ2ivGJo8hO4ATSBJpa0UOrsxhDe+Q+busRwIx1lDMGbz/YV2rT+rELh14GqtPzzXrJ+w2S1hAnnJ80+k3A0gL/8CT5iJMBqkrIfwVeGqlt3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=fHQhIGa/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=inOZ1ckt; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="fHQhIGa/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="inOZ1ckt"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EAAFE138032A;
	Wed, 18 Sep 2024 22:59:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 18 Sep 2024 22:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726714772;
	 x=1726801172; bh=slWec5+kKh57ljY4QinTTf1nBKBPavmUTaD1Pksl6Vo=; b=
	fHQhIGa/l2Nf0XHPxh5QkTzGv8OlKLmvGdCuyTxnMW3K80OLxnBj5N8GtwK2YO5Q
	xhA1moaYZQIbnKnZohj2oMfynb4dNhr0HNESMjaiNUZHrTxdEA3kDVozMpMfaScB
	JVaY+dxbVL7ZTPvo+s4fkmNhICBAmz2c4svZse3oRQqcbQRs/65wTt1B6gzUT3Hi
	V5sHoso5+UHfuT0OpSyFJ3dmchlrlMN2hmFbMUDmOExepApFsjD44/pMuxwYJcT5
	Xo0hcat54oKJcu4uqW3wXeW6l5NfE3BvuSc7iPuDNWk4U5hAkj7+n0WwMrenptYa
	Aa1ifRIG8lx0GKytGTRdbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726714772; x=
	1726801172; bh=slWec5+kKh57ljY4QinTTf1nBKBPavmUTaD1Pksl6Vo=; b=i
	nOZ1ckt6pJope8wQlbSuKr2EN/v/G31iJq6dLB0lI5RmfVkFdi0i0XdUZzx+vybV
	zYX8+y8lM8riRQao7sicldDuqzdzAeYRfr31yhPMPP+uDAmBpSJ8IRA0I5i3rAnc
	ZKorynM/dACQPVWiJc1eiuRHabSHkH99H4nW15RoFlVpkxZmLf615xuuKH9t4y8J
	BPgbUwJdO41A0njE5VM0OtuGWVAF+8cbIZNRrE+H/m3p2FimNdNm1TL5rTAk4MIr
	ScsQg/dkLCrTp2p+DBdQvvL9n8i1c1wFoAd9pI9MNVWPKMgvpVFdizbqF63Nirk2
	Kb8e8pVkj3h0sHMF0XbdA==
X-ME-Sender: <xms:lJPrZgHN-22M4M3t1sYQs5yJ44BIttZdO4AS2v7rMbM7JhxFyEBOUA>
    <xme:lJPrZpVLRzErmYcxSl2MGIbKlGO-XXdWtgZRy1y_9BhbDTNBlm_DSbgyQjZuEpKqZ
    zdK-jcuqRIK>
X-ME-Received: <xmr:lJPrZqJk_-PvRoWVnCjtmPi1szN8mY0GysVwnq3IEnvaVE2SOBYk5p9fJVOkLdB7MLkXvMG7nsKaFGBdviSBM-l392xpNhKaBeMW9vm07HoDrloXLuUhPzY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeltddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfg
    fuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgr
    vhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeeflefhhfekteduff
    evueevvdfhleeivedtudefheefuddthfduvdfhtdduveekgfenucffohhmrghinhepuggv
    sghirghnrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghrnhhilhesuggvsghirghnrdhorh
    hgpdhrtghpthhtoheprghuthhofhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lJPrZiHRYg627MaFyY-xnnA3u5A4vxbUj0-6uyBLaMAOwVdCfwzoJQ>
    <xmx:lJPrZmV1pozQYOvsfq4G1TPWS1WDiI0cBADrLwUDx5ADPap74EEs5g>
    <xmx:lJPrZlNWW8CQf0pmdWJ1wj65COpeGwpg3m6MBAbaxSU6o9UEoc3uNw>
    <xmx:lJPrZt3kk_fuGR8dm_NcjUDmQCdqpVIyQH1ARX9NH88ade4BaRAgLQ>
    <xmx:lJPrZpd_vA6nniAanl4LevVcJwEODah9LtOzz7cBYmVJztVLPRxRbo45>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 22:59:31 -0400 (EDT)
Message-ID: <4abb09fb-9319-4d63-a360-ee93a382bbf5@themaw.net>
Date: Thu, 19 Sep 2024 10:59:27 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] samples/auto.net: Remove mentioning of nonstrict option
 in comment
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: autofs@vger.kernel.org
References: <20240912201136.3571920-1-carnil@debian.org>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20240912201136.3571920-1-carnil@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Salvatore,

Just to let you know I have seen your patches and I'll get to them soon.
They look fine at first glance anyway so there shouldn't be any problem.

Ian
On 13/9/24 04:11, Salvatore Bonaccorso wrote:
> Since 8e7823c2a317 ("Make nonstrict the default for multi-mount map
> entries.") 'nonstrict' is the default for for multi-mount map entries
> and the '-strict' option was introduced in autofs(5).
>
> Link: https://bugs.debian.org/603091
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>   samples/auto.net | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/samples/auto.net b/samples/auto.net
> index c5b145d545fc..5635c4344b3f 100755
> --- a/samples/auto.net
> +++ b/samples/auto.net
> @@ -8,7 +8,6 @@
>   key="$1"
>   
>   # add "nosymlink" here if you want to suppress symlinking local filesystems
> -# add "nonstrict" to make it OK for some filesystems to not mount
>   opts="-fstype=nfs,hard,nodev,nosuid"
>   
>   for P in /bin /sbin /usr/bin /usr/sbin
