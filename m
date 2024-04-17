Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D585680
	for <autofs@vger.kernel.org>; Wed, 17 Apr 2024 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323462; cv=none; b=J60n7gmyPJZap8CAyqwjin4EnvF7r3692HUZ/X2TLaQjd4Wvok1gWq2mdTHl58gkOoV1PHDSKnW1go1ggxjvagqG9yaUGnThLgDjSVK6QkOU+7ApDreksl76d6VI0NkV4j23xpjmPI4yC8+URo/pYQVlYR/vTFRTnXoMExyplgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323462; c=relaxed/simple;
	bh=As8B/NXyayYaUQgUB20m9EsEF/AvsVJkAsuVPkbPE9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Im2g4OKlw0LLe/kR0d7yZ6/WuaFSg2IosPglwZ3/kknyjCiugMy4jq21bg2sYXs+EbtDm+xErcNVryacdFtyDO7CErSqzQp7DK7P+Bx7GqAMeyQE4CaSH01NB2bO6zdanesXN9PITVll5EAP57/TdnbirdPHCwinw38YdOqcnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=A/bXWcdM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oz0C1gx8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="A/bXWcdM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oz0C1gx8"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id BC7F41380179;
	Tue, 16 Apr 2024 23:10:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 16 Apr 2024 23:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713323458;
	 x=1713409858; bh=PQgDw4TZvCUkgVCZlz6A1tBZ8RPki1jinDM8a3lsKPw=; b=
	A/bXWcdM1j46p1JEdcGGBLY1WWN45dJ6mSHgQtOmL7tdaH0WRflnCG4nRzWpzZoI
	LMSbfsTfTE4oAm7m2Meqzb9d98sH4mlOFAPAVo0CtA1e8HZHa7O42ghmWG9hjKW0
	WiqXv9UdeuV5BDvfSFI+x9IjbuyJASollUQwH1bmePr6hWApqFkxmHYfQcHpbTlt
	pt2BOnMJUpgifViSEH6hHATlDtNHhnn7xihstfT8CCBMmU9Fc3onmmRTsGo8vJy/
	viP4U7ejuOzJy0H1o+0Fp3veO/VNY7j6r+jdwMhi5Te0iyM35kGCJW9Nip4Uw0/8
	9pnxh9BTrK0/+KWG7LtkyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713323458; x=
	1713409858; bh=PQgDw4TZvCUkgVCZlz6A1tBZ8RPki1jinDM8a3lsKPw=; b=o
	z0C1gx8qp5BR5gYfmWzcd9Hs1IdOSaRwkyl6R+30+ZU8kIcI6zYTvBw1i1vOVM9G
	1wdfY0R1rSpVy4cLEB0CgRIR554/6owT+M30tMQYReFmsG82EQAsS3TRfAQlFNKn
	aTa9EjTr7hRuwqUKwQo3nPKEs5GPdBXPOwIuQiMeYT8qVxxxuWMUj/roDadWHROq
	jy69I6g+R+zuL+m7IeIwylt1bjepn6b18dGuCobaMaZ6uniRfvwFe3YciomYpQLb
	L4j0YTHPLt0vODKUwqBeEUzOuMeJ5u8ICXOJJM5NkJWQ/68jqzV+m49zZLWSOoFd
	4S3vkhXumzc0/CmPQFAPg==
X-ME-Sender: <xms:wT0fZotWUvvJtaZwicHinrZDU8GtLiGuwFDed1_gJ1C1yu2CT2kJAQ>
    <xme:wT0fZlfX6ZV8G_uJgitiDU-eRjP-EIQR-YYOqpuMQ1yD7cS4d3s9aNTstZngdtIdc
    GgPmQCQ-BgA>
X-ME-Received: <xmr:wT0fZjwyndniB1UTvwjaCe_obrvg2C2PFLx0nllqSO8LFusW4bFj7hJmGWR3FhlHLNhcGbmnPLYkrnOIq2ga-yt4cfx7qvziUw2_j4gNk-LNBOyUe29t6KlJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejjedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epfeekhfegieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:wT0fZrO3Q3-BmWbSbSjAhF7zpdlnkhIQTGt7r7obt2w8oqN0pjvMbQ>
    <xmx:wT0fZo_NJ9YVlcqQDAwA-lftdapLnxhUGTEn2ChsU2KfyDuNynGSKQ>
    <xmx:wT0fZjWcW_QOGgoJ-jkF0Kn1DwWhkTZl0YkZj_kkv9144i8le5vlsQ>
    <xmx:wT0fZhey0sKUjzrNfyojWrAbOXhjYfiGqZhfzKkFfDRBi2eveFSytQ>
    <xmx:wj0fZmnmCEyS17dHkea2YMXwNW0m2Jpg1uPhExC9tP1eojIwnX9XBBrG>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 23:10:56 -0400 (EDT)
Message-ID: <e41668c1-c523-4b41-9fa7-208682d63ac3@themaw.net>
Date: Wed, 17 Apr 2024 11:10:48 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] autofs-5.1.9 - fix ldap_parse_page_control() check
To: David Disseldorp <ddiss@suse.de>
Cc: autofs@vger.kernel.org
References: <20240320005949.2661-1-ddiss@suse.de>
 <02526a0f-5f6c-43e1-9a3b-15d7f0a72e18@themaw.net>
 <20240417002330.120b1046@echidna>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= xsFNBE6c/ycBEADdYbAI5BKjE+yw+dOE+xucCEYiGyRhOI9JiZLUBh+PDz8cDnNxcCspH44o
 E7oTH0XPn9f7Zh0TkXWA8G6BZVCNifG7mM9K8Ecp3NheQYCk488ucSV/dz6DJ8BqX4psd4TI
 gpcs2iDQlg5CmuXDhc5z1ztNubv8hElSlFX/4l/U18OfrdTbbcjF/fivBkzkVobtltiL+msN
 bDq5S0K2KOxRxuXGaDShvfbz6DnajoVLEkNgEnGpSLxQNlJXdQBTE509MA30Q2aGk6oqHBQv
 zxjVyOu+WLGPSj7hF8SdYOjizVKIARGJzDy8qT4v/TLdVqPa2d0rx7DFvBRzOqYQL13/Zvie
 kuGbj3XvFibVt2ecS87WCJ/nlQxCa0KjGy0eb3i4XObtcU23fnd0ieZsQs4uDhZgzYB8LNud
 WXx9/Q0qsWfvZw7hEdPdPRBmwRmt2O1fbfk5CQN1EtNgS372PbOjQHaIV6n+QQP2ELIa3X5Z
 RnyaXyzwaCt6ETUHTslEaR9nOG6N3sIohIwlIywGK6WQmRBPyz5X1oF2Ld9E0crlaZYFPMRH
 hQtFxdycIBpTlc59g7uIXzwRx65HJcyBflj72YoTzwchN6Wf2rKq9xmtkV2Eihwo8WH3XkL9
 cjVKjg8rKRmqIMSRCpqFBWJpT1FzecQ8EMV0fk18Q5MLj441yQARAQABzRtJYW4gS2VudCA8
 cmF2ZW5AdGhlbWF3Lm5ldD7CwXsEEwECACUCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheA
 BQJOnjOcAhkBAAoJEOdnc4D1T9iphrYQALHK3J5rjzy4qPiLJ0EE9eJkyV1rqtzct5Ah9pu6
 LSkqxgQCfN3NmKOoj+TpbXGagg28qTGjkFvJSlpNY7zAj+fA11UVCxERgQBOJcPrbgaeYZua
 E4ST+w/inOdatNZRnNWGugqvez80QGuxFRQl1ttMaky7VxgwNTXcFNjClW3ifdD75gHlrU0V
 ZUULa1a0UVip0rNc7mFUKxhEUk+8NhowRZUk0nt1JUwezlyIYPysaN7ToVeYE4W0VgpWczmA
 tHtkRGIAgwL7DCNNJ6a+H50FEsyixmyr/pMuNswWbr3+d2MiJ1IYreZLhkGfNq9nG/+YK/0L
 Q2/OkIsz8bOrkYLTw8WwzfTz2RXV1N2NtsMKB/APMcuuodkSI5bzzgyu1cDrGLz43faFFmB9
 xAmKjibRLk6ChbmrZhuCYL0nn+RkL036jMLw5F1xiu2ltEgK2/gNJhm29iBhvScUKOqUnbPw
 DSMZ2NipMqj7Xy3hjw1CStEy3pCXp8/muaB8KRnf92VvjO79VEls29KuX6rz32bcBM4qxsVn
 cOqyghSE69H3q4SY7EbhdIfacUSEUV+m/pZK5gnJIl6n1Rh6u0MFXWttvu0j9JEl92Ayj8u8
 J/tYvFMpag3nTeC3I+arPSKpeWDX08oisrEp0Yw15r+6jbPjZNz7LvrYZ2fa3Am6KRn0zsFN
 BE6c/ycBEADZzcb88XlSiooYoEt3vuGkYoSkz7potX864MSNGekek1cwUrXeUdHUlw5zwPoC
 4H5JF7D8q7lYoelBYJ+Mf0vdLzJLbbEtN5+v+s2UEbkDlnUQS1yRo1LxyNhJiXsQVr7WVA/c
 8qcDWUYX7q/4Ckg77UO4l/eHCWNnHu7GkvKLVEgRjKPKroIEnjI0HMK3f6ABDReoc741RF5X
 X3qwmCgKZx0AkLjObXE3W769dtbNbWmW0lgFKe6dxlYrlZbq25Aubhcu2qTdQ/okx6uQ41+v
 QDxgYtocsT/CG1u0PpbtMeIm3mVQRXmjDFKjKAx9WOX/BHpk7VEtsNQUEp1lZo6hH7jeo5me
 CYFzgIbXdsMA9TjpzPpiWK9GetbD5KhnDId4ANMrWPNuGC/uPHDjtEJyf0cwknsRFLhL4/NJ
 KvqAuiXQ57x6qxrkuuinBQ3S9RR3JY7R7c3rqpWyaTuNNGPkIrRNyePky/ZTgTMA5of8Wioy
 z06XNhr6mG5xT+MHztKAQddV3xFy9f3Jrvtd6UvFbQPwG7Lv+/UztY5vPAzp7aJGz2pDbb0Q
 BC9u1mrHICB4awPlja/ljn+uuIb8Ow3jSy+Sx58VFEK7ctIOULdmnHXMFEihnOZO3NlNa6q+
 XZOK7J00Ne6y0IBAaNTM+xMF+JRc7Gx6bChES9vxMyMbXwARAQABwsFfBBgBAgAJBQJOnP8n
 AhsMAAoJEOdnc4D1T9iphf4QAJuR1jVyLLSkBDOPCa3ejvEqp4H5QUogl1ASkEboMiWcQJQd
 LaH6zHNySMnsN6g/UVhuviANBxtW2DFfANPiydox85CdH71gLkcOE1J7J6Fnxgjpc1Dq5kxh
 imBSqa2hlsKUt3MLXbjEYL5OTSV2RtNP04KwlGS/xMfNwQf2O2aJoC4mSs4OeZwsHJFVF8rK
 XDvL/NzMCnysWCwjVIDhHBBIOC3mecYtXrasv9nl77LgffyyaAAQZz7yZcvn8puj9jH9h+mr
 L02W+gd+Sh6Grvo5Kk4ngzfT/FtscVGv9zFWxfyoQHRyuhk0SOsoTNYN8XIWhosp9GViyDtE
 FXmrhiazz7XHc32u+o9+WugpTBZktYpORxLVwf9h1PY7CPDNX4EaIO64oyy9O3/huhOTOGha
 nVvqlYHyEYCFY7pIfaSNhgZs2aV0oP13XV6PGb5xir5ah+NW9gQk/obnvY5TAVtgTjAte5tZ
 +coCSBkOU1xMiW5Td7QwkNmtXKHyEF6dxCAMK1KHIqxrBaZO27PEDSHaIPHePi7y4KKq9C9U
 8k5V5dFA0mqH/st9Sw6tFbqPkqjvvMLETDPVxOzinpU2VBGhce4wufSIoVLOjQnbIo1FIqWg
 Dx24eHv235mnNuGHrG+EapIh7g/67K0uAzwp17eyUYlE5BMcwRlaHMuKTil6
In-Reply-To: <20240417002330.120b1046@echidna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 16/4/24 22:23, David Disseldorp wrote:
> On Wed, 20 Mar 2024 11:43:19 +0800, Ian Kent wrote:
>
>> On 20/3/24 08:59, David Disseldorp wrote:
> ...
>>> -      struct berval *c;
>>> +      struct berval **c;
>>>          int ret;
>>>          LDAPControl **clp;
>>>          ret = ldap_parse_page_control(ld,clp,ct,c); ]])],
>>
>> Thanks David, looks ok to me, will have a closer look and (I expect)
>> will apply it.
> Thanks for the feedback Ian. Is there anything holding this one up from
> being merged?

No, only me, actually I want to do a release but (just a couple of days 
ago) I was thinking I need

to push this and a couple of other patches to the repo. before I start 
the round of testing.


I have a bit to do (unrelated to this) before I get to it so sorry for 
the hold up.


Ian

