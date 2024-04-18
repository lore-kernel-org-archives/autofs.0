Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F2433A6
	for <autofs@vger.kernel.org>; Thu, 18 Apr 2024 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713415768; cv=none; b=q9cZpWAIi3uX9Jfzb8bhcTCDGzokNSj9ByqpOkQxRmHkCHGhchKC//xk4dBLGem1OTKI+G1iSYDa3pBg501oqXEzANj3llKHZ1N85D9fX+QjeXLrrkApGuA4rES+bYVNKSto8zI3xF1blrMqjyLa1qQy9GcAD4zL8jmWU+0T0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713415768; c=relaxed/simple;
	bh=DT/nU+DjXzLacx9eewsIv3qocoeJoOfJ5MQMssTDdxY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=RVNdqIkusUOtnwt2W3NWxGESe4a21PFKA80r+YHbCngcei/VzNfCuvFTwyNd6/hqAS3c4CGAR+FWe7itJxgKbGYWzQOLJUnFLNou92FxzbPWBRwkCB0XVdyP0E3qpaeO5vRAl/Dhbn/QCbvXVvNLrXeWJBWXK7iCgcr3Q9ed/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=ur4ZgW1j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDqTSb7Q; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="ur4ZgW1j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDqTSb7Q"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id B77D9180019B;
	Thu, 18 Apr 2024 00:49:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Apr 2024 00:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1713415764;
	 x=1713502164; bh=0VyLKiUoGA5+UmisUfQuIDH6a4RRg/jZCzGw8ncS0XM=; b=
	ur4ZgW1jsQ6rCAiZI6k37Dn8/Ll5YrP0vaj90ZyaH8tR+1JpHk6yOFhLIr8ezcW4
	pg/oS26HSq2tI+EVX5UhdYdyUSZkdaIuIEwF6Y2pY2HAJS7x6Ee1aLudgPt416hP
	gkN5uFqP/zFHx1TAVpTMZ3j/pYiuM68div+COmO8HA7GD+fkLU3m7pHaXtPyfIr9
	NlAc27wi51aImtu3aSRH8GsLnpwu5/Flm0I6FT9nOrRJ1TbVnKR1CD3XZ/6JLAg8
	vks3F+GGFQmgs2SONmvmUfyYFJZJptEj4szDzOqqg0UE6svUKkvr6AkDiumP6hdh
	yQZo/6mFXgytakFMQtsJ/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713415764; x=
	1713502164; bh=0VyLKiUoGA5+UmisUfQuIDH6a4RRg/jZCzGw8ncS0XM=; b=Q
	DqTSb7Q+zkYoj+l8RaastoSray3rE7Lp8DD+OlxJDyslIQ5fdtbGrOlwcG+kQfzf
	OtzIRN3t4fhqJqYO59DxbeK62HQDMrilGopWobLALNThw7Z91hgY2Y7e4EqrGsl4
	AGJ6NUvpumZ/3/npW7XL2i4+2S5WI3hJU45dkWSoQE884KRgXzrp/qM2slNTv1kp
	CMTDtf5ZojaWZIY1JoB+na5m0nRxn78M91PQ4TKCSRk0Dog7pVdhuA7rhKr/vgps
	ZoYKE6FAdS25J4HUY5U6slLoUXXTzgi5Jd9XsLcEs6rIuXKqQklzdsU8qPGAhmUi
	CDl3WaGTrMFneO1b8OgJw==
X-ME-Sender: <xms:VKYgZqXzANFapJHrot0h53RSDo5AtUyX8QEhhlu-Z6ExL76aTCMwrw>
    <xme:VKYgZmkXYNIcBlkjKmJ7bLqfA0bOeIdtcbrCxmHtOuRvKuSo9ql0yQ0XMJUUnUIPj
    eqyz-FLwABj>
X-ME-Received: <xmr:VKYgZualHoKwkT0M-ZI0j9OgAb8oRyOybWKh5OPRa569u7uePABkkqNbiX9zyCiFp39VZr7cWME3meCw2Az7BKRcY5KzJ3VKWywiXuK-f_yyNKe5YADc_N3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfhfjggtgfesthekredttddvjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ffkeeiffdufeeugfdtheekgeejleetfeetudejieeuieekjeetvdeiheejudejfeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:VKYgZhWzBJm4OKlhdsLod12QVH3L3LcKm-HV7871776Uv_MFBZqV4A>
    <xmx:VKYgZknihOmNJ3rQOYg5W0K_V-CXa-a75bmJUoMyBvCoZT11eHtiqA>
    <xmx:VKYgZmeLFDu0ZB8PPmrK01qgqvZQpumQG1Q-bm-kCdnrcIxpXtE6gg>
    <xmx:VKYgZmF2j-T9zJxuHsG8MXkeVWi8TqgXq3rtDs6XMoQIfW1uO-QMHg>
    <xmx:VKYgZgssNa3Ps1Eusm7ogZwFet1ZsTp8q1wjhZ3rjseVNqetyDsg1tts>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 00:49:22 -0400 (EDT)
Message-ID: <75049a54-f4e1-4685-9150-139b2d1a48f8@themaw.net>
Date: Thu, 18 Apr 2024 12:49:17 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: autofs 5.1.9 snprintf() crash with -D_FORTIFY_SOURCE=3
From: Ian Kent <raven@themaw.net>
To: Andreas Hasenack <andreas@canonical.com>,
 autofs mailing list <autofs@vger.kernel.org>
References: <CANYNYEEpJabu=qiQ2VUde6J4HUC9mQSgCGksbLQqGsr1-w5NYg@mail.gmail.com>
 <f06e1ea3-22e1-4748-ac61-9235643daa55@themaw.net>
Content-Language: en-US
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <f06e1ea3-22e1-4748-ac61-9235643daa55@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/4/24 11:46, Ian Kent wrote:
> On 18/4/24 01:28, Andreas Hasenack wrote:
>> Hi,
>>
>> in Ubuntu we are building most packages with -D_FORTIFY_SOURCE=3
>> nowadays, and we just got a bug report that 5.1.9 was crashing with a
>> buffer overflow warning. When rebuilt with -D_FORTIFY_SOURCE=2, it
>> does not crash.
>>
>> Here is a small reproducer using a loop device. This is on kernel 6.8.0:
>>
>> /etc/auto.master:
>> /- file,sun:/etc/auto.mp strictexpire
>>
>> "strictexpire" is what triggers the crash.
>>
>> /etc/auto.mp:
>> /mp defaults :/dev/loop0
>>
>> # automount -f -d3
>> Starting automounter version 5.1.9, master map /etc/auto.master
>> using kernel protocol version 5.05
>> lookup_nss_read_master: reading master file /etc/auto.master
>> do_init: parse(sun): init gathered global options: (null)
>> lookup_read_master: lookup(file): read entry /-
>> master_do_mount: mounting /-
>> reading file map /etc/auto.mp
>> do_init: parse(sun): init gathered global options: (null)
>> *** buffer overflow detected ***: terminated
>> Aborted (core dumped)
>>
>> gdb show this being in the snprintf call in lib/mounts.c when
>> ",strictexpire" is being added to the autofs mount options string:
>> #9  0x00007ffff7dbaab4 in snprintf (__fmt=0x7ffff7dca232 "%s", __n=93,
>> __s=0x7fffec002c1c "") at
>> /usr/include/x86_64-linux-gnu/bits/stdio2.h:54
>> No locals.
>> #10 make_options_string (path=0x5555555b7d50 "/-", pipefd=6,
>> type=type@entry=0x7ffff7dca02b "direct", flags=2560) at
>> /usr/src/autofs-5.1.9-1ubuntu3/lib/mounts.c:764
>>          kver_major = <optimized out>
>>          kver_minor = 5
>>          options = 0x7fffec002bf0
>> "fd=6,pgrp=22935,minproto=5,maxproto=5,direct"
>>          max_len = 93
>>          len = 44
>>          new = <optimized out>
>>          __FUNCTION__ = "make_options_string"
>>
>> lib/mounts.c:760
>>      /* maybe add ",strictexpire" */
>>      if (flags & MOUNT_FLAG_STRICTEXPIRE) {
>>          new = snprintf(options + len,
>>                     max_len, "%s", ",strictexpire");
>>
>> I don't think this is actually overflowing options in this particular
>> case, but the max_len argument doesn't seem right, as that was the
>> original max size for options.
>
> Ha, I had report of this just the other day and I missed that obvious 
> stupid mistake so thanks
>
> for reporting it.
>
>
> I chose to change the snprintf() to strcat() because it clearly wasn't 
> going to overflow as
>
> the calculated maximum size was sure to be larger than the contents.
>
>
> fyi, what I used was this but I'll update the description to include 
> the max_len usage mistake
>
> you have pointed out (and push the change to the repo. in case you 
> prefer to use it in Ubuntu):

I have pushed this change and a couple of others to the repo.

Unfortunately I made a grammatical mistake in the description which will 
have to remain since I don't want

to force push a change to fix it because that might cause problems for 
people with existing repo. copies.


Ian


