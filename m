Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690812101AE
	for <autofs@vger.kernel.org>; Sat, 28 Feb 2026 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772244321; cv=none; b=ikr0UF3j92K7heX+/IqgZJAVt46hmGTo+/bH3NqFthcYE45SdczUI5Dbjn23Hi2DMz//HDrnTZ6wmsP5fKbN1L0brwv8nOkz2O8j53JNSi5sTER98yprOjwsPYIWtgBt+AJXdhPsqpCU62qw0ydWt3Cb3BQIhv2pNDfmPtSWUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772244321; c=relaxed/simple;
	bh=za1kb10ksSl859F07QBuH7zjaJS56dXvVbgREApGxcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UyUwHh8Fqt6bSUWp8OPJ/ro5UZQYKWh5E3oQIVLsinpGc69x0MDIq6z+XewWg+tLKozBnVY0MqVzbqq88dxEQRdqQKkCL0cslaBmHz55FtDj7D861RaGy0N1RPFbXqJv8obMKoVEwhpEOOZ/taOPu18fp+G0z7oIPtSW2Idy1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=viXHIu48; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fXZrl9Wr; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="viXHIu48";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fXZrl9Wr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71FD97A01BC;
	Fri, 27 Feb 2026 21:05:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 27 Feb 2026 21:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772244318;
	 x=1772330718; bh=MhOza7MTq77MpKaJSoSGqEmoAdjXk20DS5Ksmd2un0E=; b=
	viXHIu48jAKXFmw42X3DqE7CYjnb1mPDcltEQn8gbxabAC5EakHF0pykVjhnNWxx
	G1dpkVJDMvptoIaM2L5isjWpjNdSS7JtNMOZujPG0aaCzRcr11CvlQZ9Z8f6CP/l
	pqe2PIqYmWAXevy5Q1GfAnhB1Qhe6lFRLK3ujBwf8ehhqbqOrt2b4aotXNtZzgSC
	Z3V0hXa9jbAa050QDPExYOmUDOVd0ovgNLLg1uuFseMirMI76wf7brv3LsrlJqaD
	wjJ24zB6bsMB9nqwOWuMjVXJcC63KKo9zcYFH2cnVC0IQ3NJaRtjNpAawCcgPOtZ
	yuAWCg/4U7921ov1M+2ZqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1772244318; x=1772330718; bh=M
	hOza7MTq77MpKaJSoSGqEmoAdjXk20DS5Ksmd2un0E=; b=fXZrl9Wrceyv0ioS6
	ISiC7UThfwgBh8x+5OFDsyyt63kI2wtTFPJakGQUt2nCbaCPlz7dNW6CwktkAm0n
	PwMJOFINa5mhoLNWcahHJ7dR48JAY/v7NMBwtV7JXF+/7SUx8abGXqKSZKxZhF7t
	pU59hJMgGhHftl3MKBu8BV61qi6xDnT4Xe4iQWTi1zOybxTKbHhCb28vKMXIiwFt
	7f9Cz9p8XtYzq9WWPrRnRQZVM85Tb+mO4ggyUl3rxNJtTZcoQGgtJgAhSWQvzZb6
	zGcGR90nB4Na0GcaRqhtjRhSebSzoa4mJilmWHBTnVqW2cYXGDvxpPknPEDhMrIB
	Hpdng==
X-ME-Sender: <xms:XU2iaQx0suNyz9hh6RHUEdOt7rYaqLLkUwi9eUSzFgZinIB_Z6eqbw>
    <xme:XU2iaSN6KNK_Un-U8MFiom6aAteWgx-d6m87PYrfhKlEYuNuQV6tUrkxdsQMb7vQH
    4rTbw_tVQdfxDAbjyCzryDlYKIHugXqQFs8Z4gJX0PQvfDY>
X-ME-Received: <xmr:XU2iaZ7wAbW63PbRno0teJwCfR6Cb5wfINNOfBYY9eNu-vII2ae-cgfsgeru42CGYdosDEd0cIT5V0QxQ2sMETwuwo5fs8krvxGCr--FSwSBXMrOvGRZ3Ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeejue
    euteffueegjeehkeetiedufeehvdehteejtdejteelleehkefgfeefuedtgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgtvghrnhhkohesmhhpihdqkhhlshgsrdhmphhgrdguvgdprhgtphhtth
    hopegruhhtohhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XU2iabNSQUMFe8hGcvBYuNzO9KKZNkoLXV00X5XUjHiR-c7_67INkg>
    <xmx:XU2iafm6taUT9QLBZ1GghruaZ3-eI2HpqzeHsK9ZR8a4HaXV2rhVBw>
    <xmx:XU2iaaRJutFU9UcFYUFPTIbOgw4lQKeqvlQfYtWCNt4GXlwtQBvSwQ>
    <xmx:XU2iaTC7KPoLC6ZQEWO2Gd-nJfagh8ge2nUcvgS85LVI2_uTaGXgxw>
    <xmx:Xk2iaZYYsWc6Fv500lVql5JDP4WcAjvq2LSPh3LuJtmk9TEZGCBSM_X2>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 21:05:16 -0500 (EST)
Message-ID: <19fa30b0-7fcd-4647-8a00-53913b12d555@themaw.net>
Date: Sat, 28 Feb 2026 10:05:13 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] do_reconnect: expiry check of dclist BEFORE lookup using
 it
To: Patrick Cernko <pcernko@mpi-klsb.mpg.de>, autofs@vger.kernel.org
References: <67467749-9e0f-4b4c-b840-5a9a8c300671@mpi-klsb.mpg.de>
 <c0bc64b9-e041-4f75-824a-df9d4ea2e5ce@mpi-klsb.mpg.de>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <c0bc64b9-e041-4f75-824a-df9d4ea2e5ce@mpi-klsb.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick,


Sorry, I didn't see your patch.


Fact is I get way too much mail and delete a lot of it and must

have missed it because I can't find it anywhere.


For patches try putting "autofs" or better still "autofs-<version

the patch applies to>" at the beginning of the tittle (the later

would save me the trouble of doing it myself).


So please repost your patch so I can review it.


Ian

On 27/2/26 15:22, Patrick Cernko wrote:
> Hi autofs developers,
>
> it's been quiet a while since I submitted this patch but I never got 
> any feedback if it was accepted or rejected. Is there something wrong 
> with my submission or didn't you have time yet to review it.
>
> On 2025-10-02 12:52:49, Patrick Cernko wrote:
>> Hi autofs developers,
>>
>> this patch changes the behavior when to refresh LDAP SRV records. The 
>> documentation states:
>>
>>> The server list returned from an SRV RR lookup is refreshed 
>>> according to the minimum ttl found in the SRV RR records or after 
>>> one hour, whichever is less.
>>
>> But the code in fact does not do any refreshing as long as at least 
>> one server in the dclist still responds.
>>
>> This issue became obvious in our setup, when we had to disable the 
>> first two servers: autofs continued to contact ldap-a and ldap-b, 
>> running in timeouts (~5sec) and finally got an answer from ldap-c. 
>> But due to the timeouts every mount took >10sec resulting in slow 
>> responsiveness for the whole system. Changing the SRV records (with 
>> TTLs of 7200) did not help. As a workaround we had to signal all 
>> client's automount processes with HUP.
>>
>> The change invalidates the dclist if expired. This forces autofs to 
>> do a new SRV record lookup before doing the LDAP lookup.
>>
>> Best regards,
>
> Best regards,
