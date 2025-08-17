Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F52FC883
	for <autofs@vger.kernel.org>; Sun, 17 Aug 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755449447; cv=none; b=npBu+yhHmI4f30f94/II6WDoCG8CiiGXOZ7/4Rf8hW+BiJYpydtN6nEfSFe1xDc96sWHy+KJP5ApIrkxaN3LQMsadfR2pByv8aqHBCVBIV2FujSoEaTzgMD1GlCwG0DrATqiSqIgyetkEDPFKUiFzoinu1BHWNh5WuUp6zUfN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755449447; c=relaxed/simple;
	bh=X6spNPqrh4bgXvrO1J4kDpbBugOahcsnBb60o9fYuck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVH+Jim+Oa4lL7k9KWRF56IuR1rAb/tXUJFFljoVSiVTTvLh36sTtfrbeYJ08K0negbBBVLqI9+WST4cP17vW6jRS1PAHnxsSO7vW5/oG3s/PcBaRb0sK6x6Bw7masyIEHmjlGnCOsM+fW0Gv5wMLJkDZZmOUOX6YSwCepvUQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AL/7LO/j; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AL/7LO/j"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-618896b3ff9so6837578a12.1
        for <autofs@vger.kernel.org>; Sun, 17 Aug 2025 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755449443; x=1756054243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bifBG0HdmWlpPr/1SzHtWkElsh3tLh55jQ42e+XiVuU=;
        b=AL/7LO/jKY5k8p5Qrl5JKqc2P7M9IV0z4th3CaRFEsjDYpgVSWuy636X0uip+RcDxe
         zdFZzfRTkZvjo23IML0VXnbSCXQyGegLbJiK4LcR1/NR02GQfl9dklZTi7WP4Vi7Vy0B
         l6tDZX1LVGH3Whyrujg2j0gqaTMxaIiFa3mO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755449443; x=1756054243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bifBG0HdmWlpPr/1SzHtWkElsh3tLh55jQ42e+XiVuU=;
        b=j1QRCLVIqIxPoxmx9NrYuBxHI9K/fEG8dlQO5ke8auVREOMgXljKcwJa8kPaHcCY6d
         +wzU2t26dlqiHzCVsq8iWEK8kG/Xsuawfu2OfI01UGrHF5jTyTYVn+W8f1Ix38As2NAi
         Ltvw01jPZUoP9+EqamSxM628YOW997KsnmDN4BGBVe9VIIX+MLZt0kl01Z3BycBQhxoP
         IUm+QQWXoCgF6xXydcwEumQOYl5+T0WVIqXJjdAaRj//eO7doMjIItMnyTbvek04MZCw
         F0UJ3o/3reijKPRexSzQIm5NRz97Uy7q1HHUYUo2BpyUDuIYEBUnE4dfHX67jI7SEfmr
         FQoA==
X-Forwarded-Encrypted: i=1; AJvYcCXj8RZu/LrKRRYeT7YQyMLVg8QUM+mBJ5/OrvjJ0UEnir8fRo4soG55ez+QQDa7jVtk7y7onA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyofzgy4G38+wcoX2Vn1SL0aTHPFbK0kAK9bmZ8y93dYGhPfXvg
	PjMEw6fDwSmLIonlo+q85iuBy0qWe6Peq14N37F2H7KVH9CfgGLD8TjTymU4OyBqtq2AMMXLs9i
	3ZaXIMiI=
X-Gm-Gg: ASbGncsIgcUSAeVgkO/KEJxb2xyxIcqgje+L01LRJspN7gOpC3KTKxTpBhQQoMKjxjN
	sUogVZrQ9cFMKf3r/ynTE1ZQv+fe9cgcjwE2Vn4CZAwbtu5VUtKxhkxjXFojko706QsDJVIhlJp
	r2Qd9qDOFBT07YmDvf4fj4WOPoeNkuUTDUyYGAR4mSoMp8SU+a69Fe0obImsofmRUnomq8hXsH0
	rYdZzDzt3yhInepcJEkqDyPu11zbKCzl6hKIBJnNCO/fh4qja1obdBrgRITIAnXWmjIyWsrVNdQ
	amnXSEq/AlC7Zwho4R52FniMcY0VPBQ/0lRFOMz6iG//K8Oo5z6PqyicUYUC9PT1A/w6VYyf7lt
	NqOoaQBTgNIBafBG0jm/ZUnP6fwMmKjYcg5YzcX7x4d3wIDDAH3qljhy0KKytEtCsPMO6PJC3gL
	++xW3WrTQ=
X-Google-Smtp-Source: AGHT+IF2fS9vtn7TssSUwz5guV0VpJ7L1puEgoxvWeo1cBRYpUkdRQitbShajcbjl/H5PlGTiJud2w==
X-Received: by 2002:a05:6402:3250:b0:615:9247:e2fa with SMTP id 4fb4d7f45d1cf-618919bdfe3mr10177021a12.8.1755449442762;
        Sun, 17 Aug 2025 09:50:42 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae80csm5488576a12.39.2025.08.17.09.50.41
        for <autofs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 09:50:41 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61868d83059so7219131a12.0
        for <autofs@vger.kernel.org>; Sun, 17 Aug 2025 09:50:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZkTOLQUu4K00G5fZVj669tBwBpG+MdPVyuR0lSZXjuGtBoXy8Af4OzQcv6gU4JWkILuOjMcg=@vger.kernel.org
X-Received: by 2002:a05:6402:5041:b0:61a:13d5:6caf with SMTP id
 4fb4d7f45d1cf-61a13d571b6mr5201931a12.2.1755449441317; Sun, 17 Aug 2025
 09:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817163609.GV222315@ZenIV>
In-Reply-To: <20250817163609.GV222315@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Aug 2025 09:50:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-NB_5KTCj7yhBsF145oLDuxQPt4J87tXsd6j+p3vzDw@mail.gmail.com>
X-Gm-Features: Ac12FXywdGIbBfQPe7J0Tp5bA1tValys2xnri0ed59elJ02zPNHmqJn6IQW9tyk
Message-ID: <CAHk-=wj-NB_5KTCj7yhBsF145oLDuxQPt4J87tXsd6j+p3vzDw@mail.gmail.com>
Subject: Re: [PATCH] spin_lock_irqsave() in autofs_write() is bogus
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Aug 2025 at 09:36, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         That function should never be (and never is) called with irqs
> disabled - we have an explicit mutex_lock() in there, if nothing else.
> Which makes spin_lock_irqsave() use in there pointless - we do need to
> disable irqs for ->siglock, but that should be spin_lock_irq().

I think we basically did the irqsave/restore version as the default
when not wanting to think about the context.

Your patch looks fine, but I doubt it's measurable outside of "it
makes the code a few bytes smaller".

So ACK on it, but I'm not convinced it's worth spending time actively
_looking_ for these kinds of things.

            Linus
