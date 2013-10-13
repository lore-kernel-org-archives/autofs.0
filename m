From: David Ahern <dsahern@gmail.com>
Subject: Re: NULL pointer dereference in autofs4_expire_wait
Date: Sun, 13 Oct 2013 14:13:56 -0600
Message-ID: <525AFF04.50306@gmail.com>
References: <525736C7.9080400@gmail.com>	  <1381457199.2631.3.camel@perseus.fritz.box>	 <1381485327.2631.18.camel@perseus.fritz.box> <5257FD34.2060406@gmail.com> <1381542984.2272.21.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zhyH+yw3fWORjaCeeZK+RSvZHpA7Oc/J8dMoGAlrbzg=;
        b=fQCj/d6mKt6MixgCZf6AukpNYLxOa4kaXpOw9RajuKoLVsoWSHyTAS6QD/QXyb+hys
         vF2NHXzsxjO72Or6fPnv0MXeqUsGK+baaj50kQUXYcxlmiwo5JlISbA6ECpe8bZB7bx3
         1Dhtq2u3lthLgkPIrSrqE4yBuN+dvDLE5Bz59ww3MiRv7Eb5aOf7MwiXkgayyWNRNicV
         TFr/eO2wie5hiXIjiJdevZCaoavodO4z4H7rJs9Txj+x2GlPk/OupEfXNfklxN+Ertil
         eBoncSSd2S9yD2eRhS48uMw9NrTtt/gxbH5+TmFvapXVVi8DVCi1Yy5yQk01b6N0EcqT
         8cQA==
In-Reply-To: <1381542984.2272.21.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, viro@ZenIV.linux.org.uk, linux-kernel@vger.kernel.org

On 10/11/13 7:56 PM, Ian Kent wrote:
> So more history please, had you used 3.11 for an extended amount of
> time, before using the 3.12-rc? IOW what's your kernel version use
> history please?

I think I did have a 3.11 installed, but was not doing a heavy 
nfs/autofs load. That started in the past week.

David
