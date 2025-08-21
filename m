Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752C1A2632;
	Thu, 21 Aug 2025 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777846; cv=none; b=BTam0eZ88L1ZzykJMHqM4mO2HNKlp03DHIeYqr+WwOEqAdpT0PTK9JwumWollBdPVB/CUmMPaANWFMNrNxjcGVc2dDMFMvOZwQ+TQzFjHVkudkMQvTJeEH7W/OFmqEfNKDE2SEw6Gwnj/N+fpl5Z4uIG94U8K/IVjRtDG+CBZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777846; c=relaxed/simple;
	bh=iWqVCpEyCYQu75iRwh/RNEKe7kLijDnU6Sa+rhotX28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Il9yOiHM6ecWY7GhCS6b/3M8ioChkeAknNHAffTwLRPbc5lWwSRxevnRomxbDKkDFeYqzXDMBvcw/2w4k3jeZw+kV7K5WaH0RVlaN7YJA9rp0w0Bq5UPeTUVD52zBeo2EznWHUWBSunH++emBMoFend1zsU7s30ZY8XVaeCbY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IABLKUv1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IABLKUv1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9e4148134so595852f8f.2;
        Thu, 21 Aug 2025 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755777843; x=1756382643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LPqDY2/mkP8AxkxfM5xJgI36OxqyfgR7+KAcWwBVK4=;
        b=IABLKUv1AO8Tj466/moiNMxj2UhnIu0FVKcJvYbNqitHmgMgjWQ3kEoWHQ4pkbaTKk
         U1fSqL0VwMYWAihnFQH8Lb/Al5iELobmq6NblAIrVeJqdcRrkMNB71Tq2DDZVgDvxtBe
         TGpsrzt8Pyzf4F7Xatax2YCBvraDAlXtK6OP3TOIa74PFn9Vk+on4eMfbbfx4E3EoEY3
         icRYwPX55/RwGdnLL2WvYQMBln8I4J5lx6b4qOloBc4HVyuE/dF8R5jSNRFDuw7nJzoa
         BC8zJkGwq42qagN1R+wGeF5llkcr9a7Cn7/xP4XF9RohnP07ttJJdGQZOLLxG67AKGKM
         yxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755777843; x=1756382643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LPqDY2/mkP8AxkxfM5xJgI36OxqyfgR7+KAcWwBVK4=;
        b=PTSxGPj9uthAtpQ29OhR8Mj42gfVKS/05J8f22Ea1oUP9GUG0pzQUoiCJA8XQws++d
         6DUiW1pCUzShiXnRNLbvJMX9gc8yYgVUSHqDtOTH+qN7MOG5dJ4sTfX/pbbu8afTHsBx
         I0VLZld2CwmcHTw9fZSjclbinbFy3jABtIJtSUApd3fI99d/iywaESkjUrhAipoNe57T
         upVpSvfPJgoSB7MFFm7NPvhfuz3DdbRHYCEDKbhtHWfIuYONJ5NSwDs9WilI9MasEtNM
         bqnFkxKY//oFjrXxdaLb3tCa6XJOWhjW95JFdN7btC2koV0f7NLvq/txjXfDeD5hhIqw
         w/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAF66H+HBg9AUKy6vBTPZxE3cVxFU0/gQsjlTuCr+vaXWvz6Di/l9ADVpkszHySeZcTRjmyTxmKByq7PoA@vger.kernel.org, AJvYcCVdOjr5NJapb9RdMUpZhNIa32uxWuzKQH6cgdh0rwxggi15MwNdpaft7ir6YmuWrS1I4LRVTeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmW19XqK8v2UC3HdLJ7tHp6iaI373HqsM/PusJpcoILy0PNrn
	ziSVDvEYnUukndL2aMDazTw0jGHG3jVvKjV5xMokjSgTPieDNgjbN11W
X-Gm-Gg: ASbGncuUlS0VJvry+G7vijAPtRGNLOuLUEezpDK80Vfmb5o3QkYC8UTkuqtHU1CGvB7
	6SdmoB4BqT2bq3j74zqB7y7Wt2l7xbQpEk2K8BQHelqLIcbja8wdgCwEvyDNUH4WzqkfOgDWVGX
	qWObQA5lw9fR5MEsJz0BvS9QVnxVqOvkP44nQEKESlxowskXlol/8HTRL3ScGgfr+O7Xmp/3lNd
	5NvhrDChLbjFGgH5EBo28W5WpV4PIhptpyUMnYn1PrsLb55IoyC4Xf2QCO/wcROMHsq8pk+i75S
	+lkMqHq6ZOJaRpPF/47iD7mIjWKHFxpXaddD/lhpm4JY6CFlGR0NRJfRK6krH+cW+EyOV6ea0pD
	xZhCzfQcw/OGn4Y+txhO3iWVr64oAdSnWophfMVK5XKCNTB0tWWd5+HFFqLW2avx8
X-Google-Smtp-Source: AGHT+IFckJ4WtlTmzyLHyIWZeU9o8mDbA8wfhj+ryhIamNuLocYch7hanc58/VS+k7IKHPsP/mOpwA==
X-Received: by 2002:a05:6000:3111:b0:3b9:48f:1960 with SMTP id ffacd0b85a97d-3c4965fb3f5mr1688464f8f.49.1755777842695;
        Thu, 21 Aug 2025 05:04:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c19fbsm11511362f8f.41.2025.08.21.05.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:04:02 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:03:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
 autofs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spin_lock_irqsave() in autofs_write() is bogus
Message-ID: <20250821130342.15ebaa26@pumpkin>
In-Reply-To: <CAHk-=wj-NB_5KTCj7yhBsF145oLDuxQPt4J87tXsd6j+p3vzDw@mail.gmail.com>
References: <20250817163609.GV222315@ZenIV>
	<CAHk-=wj-NB_5KTCj7yhBsF145oLDuxQPt4J87tXsd6j+p3vzDw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 09:50:25 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 17 Aug 2025 at 09:36, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         That function should never be (and never is) called with irqs
> > disabled - we have an explicit mutex_lock() in there, if nothing else.
> > Which makes spin_lock_irqsave() use in there pointless - we do need to
> > disable irqs for ->siglock, but that should be spin_lock_irq().  
> 
> I think we basically did the irqsave/restore version as the default
> when not wanting to think about the context.
> 
> Your patch looks fine, but I doubt it's measurable outside of "it
> makes the code a few bytes smaller".

There is a separate problem with all non-irqsave spin locks.
The lock hold time for spin locks is expected to be short,
perhaps only a few instruction.
(If the hold time is long it shouldn't be a spin lock...)

So disabling interrupts won't have a significant effect on interrupt
latency.

OTOH if an interrupt happens while the spin lock is help the lock
hold time is extended until the interrupt completes.
Get caught by an ethernet rx interrupt and it can be a very long
time (easily several milliseconds) before the hardware interrupt
and soft-int code returns.
During that time any other code attempting to acquire the lock
will spin.

So you may want to disable interrupts on all spin locks.
The downside is that the disable/enable isn't cheap on a lot
of systems.
I'm sure something could be done with the 'pre-empt disable'
counter to conditionally enable/disable interrupts.

There have also been systems that don't actually disable interrupts,
they just set a flag.
When an interrupt happens 'magic' is done so that the ISR can return
and the interrupt processed when (eg) the spin lock is released.

	David

