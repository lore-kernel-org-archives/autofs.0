Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCA1C06
	for <autofs@vger.kernel.org>; Tue,  7 Nov 2023 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="qYlgKDij";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PVnryz/d"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91E10A
	for <autofs@vger.kernel.org>; Mon,  6 Nov 2023 18:15:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id CEA575C01E9;
	Mon,  6 Nov 2023 21:15:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 Nov 2023 21:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1699323309; x=1699409709; bh=AkPs8GaWPGAU8pWB9PAMJxxvYg17cXx58HL
	sAv2+j54=; b=qYlgKDijOzd+ZMEMEEKKolnnuRxOGjY4ZSk5T4clE+jyFbC4pZo
	S2TGwHpRHTFRDakoCS+sfhqPm0FDtH8pw6O3Uey6Wr5Ifahxtwprp2bsAlCKZm97
	9/58lwYAV8VTC5wJ395xdu+f+96Tk37uqMPdG//Q956453Czkkc9UjvTKOSQoI3B
	2fuXCznghMAFEQIALKF3vM87BPNat7H4WQOZ8EINtStsE1EWUFYlufM1g2AY3J4/
	IHXRIPesArZNsa/8NWmAmcIrBoy8AV1GLBKMg4BQz3YDzsdCbiUcckUOTKH8Gmag
	bZBncqn5SXfgLmKM9eDXJ0wbjj+BaD+0BoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699323309; x=
	1699409709; bh=AkPs8GaWPGAU8pWB9PAMJxxvYg17cXx58HLsAv2+j54=; b=P
	Vnryz/dRA0RS3jjVbJG9IxZdXSAXlwlwGdJE9gh8aTMpGYpECkRb7icUO+hcKXto
	V/TLed7b6YuLSPlV6MTzn+5z4CJan/+JBzSNEP1ZqNEayFYiqmKBGIvci2jln7ER
	abVImoMXHIZfHY4fA+DO2gbs0hupltr7fUWAeeII6ra1EduMtuTRl/pVer51x3Y7
	ywFw4i3r6vrpRjIl2N3XlWKGbXGpgxBtCXjzbH6JDcACiqge3EteM9IMXON8NcIN
	M14jsXil0hRtBw9KHuZtYnpAP/Tk/wKYg9xHVaeca0Jv4ug80rv2M6PYUQtJ+hHB
	K2P1n2+hWMgMHRPV5KWsQ==
X-ME-Sender: <xms:rZ1JZStSJ6NGxQHRv6xxU_7vtzd940Q4Z-s4nAniJjXxzasjRh73zA>
    <xme:rZ1JZXe6Kh3fKQa-Dzv7UzTES_wrEBpxUi2Mu-Evsyc1MATgviFNGjL50rxB7hr-t
    eLXSaZXJiS8>
X-ME-Received: <xmr:rZ1JZdymzN38wB4Q1N3ao0QHfYz79MfDwavw_srG_7OHaboCUnLD0F8U1L78YFuTO2u8sUrsNH6M-0BFUenckWygh1n4ZEXa2KBEl-ABz0zYNIyW4A9f1At6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfhfhffujggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fhueejuefhvddtledugeeufeduudfgveevieeffeeuudefueeuffeufedugfefieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:rZ1JZdMfwC39EZ7ucEELzfLHcnQa-97iW-FF1wHUAvCqnE5l_A80dw>
    <xmx:rZ1JZS_jLKRSurplBuney-gXXls2flEptX81LtiQK3t8KeN-SBtyGg>
    <xmx:rZ1JZVWRc-0YE7ANEg898tuHb_nYnTMstxpCmJZsyq_SnHbubNxJDA>
    <xmx:rZ1JZTIlSZiMPIqmo0EIAFvX1aWrNs13L8KFIYY5QVBuKMNMt9AX_A>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Nov 2023 21:15:08 -0500 (EST)
Message-ID: <aeb5af36-4686-9d69-22fd-89adf5fd2c80@themaw.net>
Date: Tue, 7 Nov 2023 10:15:05 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Robert Vasek <rvasek01@gmail.com>, autofs@vger.kernel.org
References: <CADVsYmhjjKYUCHGWmzeTHXuQNAiR6ELbGzyy+m30ar+yaYLBzQ@mail.gmail.com>
From: Ian Kent <raven@themaw.net>
Subject: Re: Skip autofs unmount on daemon exit
In-Reply-To: <CADVsYmhjjKYUCHGWmzeTHXuQNAiR6ELbGzyy+m30ar+yaYLBzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/23 01:05, Robert Vasek wrote:
> Dear autofs community,
>
> We run an instance of the automount daemon inside a container (a part
> of a storage plugin in Kubernetes). The autofs mount root is shared
> between different containers, and must survive restarting the daemon.

That sounds unusual, please tell me more about how this works?


My thought was always that there are two ways one would use autofs in

a container.


One is mapping an indirect mount root (from the init mount namespace)

as a volume into the container thereby using the daemon present in the init

namespace. Yes, this has had an expire problem for a long time but that will

change (soon I hope).


The second way is to run an instance of the daemon completely independently

within the container.


But this sounds like a combination of both of these which is something I

hadn't considered.


>
> The problem is that when the daemon exits, it tries to clean up all
> its mounts -- including the autofs root, so there is nothing to
> reconnect to. At the moment, we're getting around the issue by sending
> it a SIGKILL upon the daemon container exit, which skips the mount
> cleanup, leaving it available for reconnect when the container comes
> back.

Yes, it does.


My preferred configure setup is to leave mounts in use mounted at

exit but that's not what you need ...


While the SIGKILL usage won't change I agree it would be better

to be able to tell automount to just leave everything mounted at

exit. You might need to send a HUP signal at container start in

case of map updates but indirect mounts should detect changes

anyway.


>
> While this works nicely for the moment, we don't want to rely on some
> random signal which may be handled differently in the future, and I
> didn't see anything in the options that would explicitly skip mount
> clean up at exit. Would you accept a patch that adds a dedicated
> command line flag for this?

By all means, send it over.


I'm not sure how this will fit in with the configure options for

mount handling at exit ... we'll see what we get, ;)


Ian

