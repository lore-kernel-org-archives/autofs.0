From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: autofs: make the autofsv5 packet file descriptor use a packetized pipe
Date: Sun, 29 Apr 2012 17:37:11 -0700
Message-ID: <CA+55aFyjJa0jeyhXNoa8D5C43T=EfTtr2CkxTc8n+=N_t1w79g@mail.gmail.com>
References: <20120429205429.63CCD7C0064@ra.kernel.org> <4F9DD994.70202@zytor.com>
 <CA+55aFy72rPMq3M2_PU0ue45Fb38_Effrfhu2uOpdVXt9H1XOg@mail.gmail.com> <4F9DDD3E.6010801@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=COmNscX/AuTKRODjtgamZcBJgawM9NepYDUXHE3gqHI=;
        b=CSbdvNZE1Q7M+6tQQdxz+s6lEGPqBiJPjzrUMaK+PBW217bORFbcX4L5SY20S0jdyh
         hVgf17UWgZscIibukf6WtMb8agXxQb7N10BOpgeYPwMhYSTHActK9l2m3qMiO9wSIjMd
         H07d9XgA2a4SvZDXm9GU68lOgYgZ8fRlUDftahikgLuCW+fw6Pzsk1CGsrUC5sLU4R9K
         y4gV/sF+ypVKWWwJSGwIppVU/lX9r2rHP2o1391TYYeFEcrbgsHBEcnDRHgVSswOTL3P
         vL0odXkmu4Ctc593xcg+lcO1O/oJ/1YJaP8ZYeLg8M1PrFO2KPpfx6Na8coFPF+F4OlO
         J+Rg==
In-Reply-To: <4F9DDD3E.6010801@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, autofs@vger.kernel.org

On Sun, Apr 29, 2012 at 5:30 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> Incidentally, I think there is a good reason to add a v6 packet type
> regardless, for efficiency: with packetized pipes there really is no
> point in sending a packet which is mostly padding for no good reason.

That I agree with - making a v6 that sends a minimum-sized packets,
and where the readers just always try to read the maximum size.

That said, this is not exactly something high-performance, and copying
the pointless padding to make a fixed-size packet isn't a big deal.
We're talking just 240 extra bytes or so (NAME_MAX is 255, and most
names are obviously much shorter), so I do believe that we might as
well wait unless there are other good cleanups too.

                   Linus
