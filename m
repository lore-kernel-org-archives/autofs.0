From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Typo in man pages
Date: Wed, 28 Jun 2017 08:02:18 +0800
Message-ID: <1498608138.2740.1.camel@themaw.net>
References: <ea0127fc-496d-56cf-71e8-4602c7570b23@ica.jku.at>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=rFuy8rOOJ2jSmqQlzZ
        upE4k6wozev80wS0nODhd2erk=; b=lOQDXCED5pxGABjebhR/pVLIElUfwoxGwU
        Pn0BeuklzbifFxnG2NU/5jlJOU2Cqqp6s3vinnZtrCxq6jQVE9+ewSHKqoNVZick
        +BppNKGEXOwsayIt9iszJPszsG2Fhpi4VLQ3sntoYPS2XTU/YW0NCIAB6o47vbJ5
        IL03zgyaF64hfG6BdekTKh7AB2s9TXAb6eXiLQHi74+bkZcANUjXWpJoWOESzuLh
        OqTMsWGISJnhopMAhxuVn3Xj2wa0Ur6b474XPbDOiuR0hhr9jjPGTC8Tvqdw5qvX
        xFtDU16h4i8AOA568daNacl6i75hyMXCU6YljdgoCjerppAROM3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=rFuy8rOOJ2jSmqQlzZupE4k6wozev80wS0nODhd2erk=; b=DKWutuiR
        9tMSO294okQQKUayJ1AwCHSKwE3Hpy1o5V4U2YpeFn16OX8VK4Z0Yr2v512rxyLV
        vKcP1pMLvcyzK0q1I1JURjMFu1D7JZ3zXeuzZGdrOH9qCVqStLn7VDF23QbjliD+
        NoLg7b8cjUgWOX+cfEWo/d9vlCP7CoMraeFxsY+6wATn390U5MLFh+z+Bxj/UMCV
        c3wH7hkqjoKxqSlghIfxNO22jQ0hAKyvI+hPckoL+C2DT4Aft/Het6rYPth1JbRk
        4ge0Zag6cnEdS7eUeRsyVt0mdc0Bt5p2csu5mkQFjxyOxrXFFa/5RTJsvkj1VXIn
        IufY1+YGDzkZyA==
In-Reply-To: <ea0127fc-496d-56cf-71e8-4602c7570b23@ica.jku.at>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roland Hopferwieser <rhopfer@ica.jku.at>, autofs@vger.kernel.org

On Mon, 2017-06-19 at 16:50 +0200, Roland Hopferwieser wrote:
> Hi,
> 
> I found two typos in the man pages of autofs.5 and autofs.conf.5.in.

Ha, I had seen the typo in the autofs.conf(5) man page the day before you posted
this and had made a patch for it.

Since your patch didn't apply I added the fix for autofs(5) to my patch and
credited you as the reporter, hope you don't mind.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
