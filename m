Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ADA1C84D0
	for <autofs@vger.kernel.org>; Tue, 26 Aug 2025 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169368; cv=none; b=o91n2mLoeBVbL68hLPQ5lbFiHmuBAqELzMF/Ad0bE6BTUYy9HzMHkwiDrg5hKbn7xzKg7zQyoJGUzJQmPD9++tM+YLoEUCGKefzJ+j6p8Bd6l92e2jO0UBOmqVmTvrnBfCl1sYT6kpa/kt1ljs3iI/G2ljmtUDmMASoef+uA8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169368; c=relaxed/simple;
	bh=+6lgQ1/ZiwN/BbPNG0mLbUkp8ST9NgQwerKZTscv+3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvjtfxcpPu+HaqijpnkeghZ2fxOoANlBbXdUWxtutQZb/X5ZldsORzEeXyvR8T28pnQ4dREPEfBhxF037ENKmJgj/CRYEC8b/PvEh//J61rSExh4cR7+5Bl4SNPgV1oMXmvy8C8j9ou6N/LD0mVbUpupUUNJ+qni/Kx7MxOUl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=nkpSt8L/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eXGAjERe; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="nkpSt8L/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eXGAjERe"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2688EEC0489;
	Mon, 25 Aug 2025 20:49:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 25 Aug 2025 20:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756169364;
	 x=1756255764; bh=jki7qQgBFxWu8a+PH/6QgLnoBQNqQQSwz0swOvk4lFk=; b=
	nkpSt8L/QImh1GCDmh3k1w+nX+frypt+bT1t8sxkDgwXlpWf/QhRVEEm5qIyu2pz
	SWCBRa6NyzRxnybwHFRGMaC2lCS4ELwql7aJ35vyIgi4B6tAMBhw6rup0T3DsQ54
	9FdUE0AtCzTY1hE40o4OLSIIjat1/1MxPp3tKCvnTWdKa2zHexDq4RXIXP8Mxo5M
	QjhcJ0nsALLGASxeXx7gONBvsmBbCkX8c4ZqUtvEEgMRzFY2MMbyl1btj38TfRSy
	Oguz8NPKXM89Iahhl3Fd0SsXPkk9UCs02JM3hiKPuJCq6tKjhV2ZaJbRT4c3z+wP
	AaueofriPMTrR78g5T9VXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756169364; x=
	1756255764; bh=jki7qQgBFxWu8a+PH/6QgLnoBQNqQQSwz0swOvk4lFk=; b=e
	XGAjERexHZ1BltLjnZTP3RwpdMKTH7lLvaBwnFxc56ON/8E1SfFSKfWtUiINfQVI
	j7HrJBsvHTUzJuGMWzn/lvCuvTQRLlfUeq3NfC/65/SIwM/jpZ3pVJ9lcFg0g6vv
	m//fcUsjz84NtOsLDjX4PZh2125r+QsGG38dSJE+hG1lRT8b+whwpCmmWL0y2+W+
	grs9bij+XDYAmArMrGKWmhkAOwLEuY8rIKceTzLfPBqehBV8qrXX3IRu1KMGPJ1W
	yZN2T22wMk1uw1Dg5bmgxq/ALvZHrAIoQxJjlL8OPpj27otiwsmBvaGGDmLQOTcr
	pfbCFhdjLmbvP3FVg6jEg==
X-ME-Sender: <xms:kwStaNZfe6LPkbO9IXV_D0dqwZiM_lPr6bBUatwLUTwmE9_pZiH4QA>
    <xme:kwStaEkIMyiKFsVnUUjG2Jsf0X6V9NfCyYapFru2v4MQbmt_ro_bpZGP1F2-qS60R
    jGpL6zDc1sB>
X-ME-Received: <xmr:kwStaBxmUhCeDwxDJz4kRWCFbP4avs5kB2rCtIrnUWylGL0zHPUUYUQXSsiJDKNB9yvhGDkl8Ybn3uto9kAtv1BTFNbITpXkruubmvAZssgQPYpioe_ijEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepie
    fggfevffdvjedttedutdefheehgfejieduueffveelueeffeeuffduffdvkeevnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepugguihhsshesshhush
    gvrdguvgdprhgtphhtthhopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kwStaKMfaU424yMWVsk1N5GyuXEHNtAmgVIX0rjr8QAUqcD_Vj40eg>
    <xmx:kwStaNTVCvcdsvaTCc16rZ7X3u3gqI2KfpcTa0LzPAIQ-SkiEX9_bw>
    <xmx:kwStaAY2vr45YuikIM_d5e4Bh16VK24AWznMMzVUYTzLptbkqLe6_A>
    <xmx:kwStaC1c4M7M1umFNDEhmG7Sy1bG8sdligjq2bAdU7G11mt0TpE1yw>
    <xmx:lAStaH_-dib70TM7fJIzJ5ZgriR426SCevV1Cj1S_mG1wGe6gXjJd8nA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 20:49:22 -0400 (EDT)
Message-ID: <f9ae0076-d4fc-4041-b652-da3d07e206e1@themaw.net>
Date: Tue, 26 Aug 2025 08:49:19 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Patch series for direct map reload bug
To: David Disseldorp <ddiss@suse.de>
Cc: autofs mailing list <autofs@vger.kernel.org>
References: <20250808021655.12774-1-raven@themaw.net>
 <20250822205019.40573a03.ddiss@suse.de>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20250822205019.40573a03.ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/8/25 18:50, David Disseldorp wrote:
> Hi Ian,
>
> On Fri,  8 Aug 2025 10:16:46 +0800, Ian Kent wrote:
>
>> There have been reports of log messages like:
>> automount[nnnn]: handle_packet_expire_direct: can't find map entry for (1048647,114082)
>>
>> These messages are fatal because the direct mount path must be known to
>> lookup the mount. Historically the autofs kernel communication packet
>> size is fixed and based on the maximum path name component size used by
>> indirect mounts but direct mounts have a variable length multi-component
>> path. To solve this while maintaining compatability with indirect mounts,
>> an index of (device, inode) tuples is maintained to allow lookup of the
>> direct mount path so the map entry can be located.
>>
>> Also it's necessary to understand that direct mount maps are always read
>> fully in order to mount direct mount triggers for all direct mount map
>> entries so they must exist so this approach should always work.
>>
>> So the message above only occurs for direct mounts and the ioctl file
>> handle used by each direct mount is stored in the map entry so it's
>> not possibile to respond to the kernel at all if the map entry cache
>> entry can't be found.
>>
>> Unfortunately map entry cache cleanup on update is complicated and can
>> lead to problems which (I believe) is what's happening here.
>>
>> While I suspect your reproducer is a different case to what I've seen
>> it probably symtomatic of the underlying problem.
>>
>> Patches "autofs-5.1.9 - fix devid update on reload" and "autofs-5.1.9
>> - fix stale direct mount trigger not umounted on expire" are the main
>> fixes I was able to identify working through the code.
>>
>> Please test them and let me know how it goes.
> Your patches do indeed resolve the kernel stall in autofs_wait following
> direct map reload, but there's one slight difference in behaviour
> between my RFC and this series when running the reproducer from the
> https://lore.kernel.org/autofs/20250801152210.15501-2-ddiss@suse.de/
> commit msg:
> The share that gets removed from the direct map and then explicitly
> unmounted will be remounted by the background `df` workload when running
> this series. With my RFC the MOUNT_FLAG_STALE flag tracks removal,
> avoiding subsequent remount.

I didn't think this would be a problem because the case should only

apply to map cache entries that have a real mount for which the cache

entry has been removed. The trigger mount has to be umounted after

being uncovered by the expire and walks should be blocked until the

daemon responds to the kernel with a result status.


Clearly something isn't right with my series, let me have a look.

We may need to merge in your recommendation of adding a flag ...


Ian

