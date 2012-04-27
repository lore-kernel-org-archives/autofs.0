From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 12:19:56 -0700
Message-ID: <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
References: <CA+55aFwvFaxBT8Mdp5s4-6Gxy7nM4WVzbWna4RF_OUK3hnx+jQ@mail.gmail.com>
 <CA+55aFyLk-uPMVaic19YOWdvdj2pv4R+E3s7UQ6voAy6UkO_Sg@mail.gmail.com>
 <20120427.151433.1007849975903946491.davem@davemloft.net> <20120427.151651.2274764174217164454.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=z4VfXgVbRYw3NIu19NHdUiV7UGK66SnJDWkJN3uBN2M=;
        b=EJ9LYFKmh+JbFVIe+anvJMZ542vLPa4jxrPHNiUCWEajkOgq8aolu3RN6MKWB55ZhD
         hyr+NYCQ04OHRovDFM5cCck5HEW2J0+S8swAzJlycXUQwyhg9+ubyPUxoC3xVIuX/2n7
         Nx4PxVfcCAUdedbkOqPeMVD8tyBy616AehxJ/uOQpi4sQC17b7Aom+NgNay9UOxjuYH3
         bI4JTeK3ClDkbUqNuyDXVKi+BJeGbHaXFOnkziAZcmA51CxeWSSLMgKeypsQHlVql3N2
         J1aA+L6Z/UyyauF0CoYFk3vHBAwiCx2peMv1h243l8BgNn0wBQehoHvu7OHKYgl1YcxS
         1G+w==
In-Reply-To: <20120427.151651.2274764174217164454.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On Fri, Apr 27, 2012 at 12:16 PM, David Miller <davem@davemloft.net> wrote:
>
> BTW, I want to clarify that my position is that userland might have
> been the best place to handle this rather than the kernel.

It definitely is not.

You are ignoring the fact that the user-land workaround resulted in an
independent bug in *another* user-land project.

Your whole argument was apparently that "that point in user-land is
the only place that knows the details". But that argument is bogus
crap - and we can *see* that it is bogus crap by the fact that there
was *another* user-land place that had this problem, but didn't
realize it.

That's why fixing it in user land was always wrong. There isn't just a
single user of this interface!

Btw, I think I may have an alternate fix. Which is to simply add a
"packetized" mode to pipes.

                   Linus
