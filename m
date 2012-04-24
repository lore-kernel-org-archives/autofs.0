From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Breaking userspace? Re: 3.0.24 broke aufofs on mixed 32/64bit environment
Date: Tue, 24 Apr 2012 08:08:02 -0700
Message-ID: <CA+55aFyQ4y9jyRXyejKwtf3yXJX52hQkLuwJ5=jfQM+yLkBNMw@mail.gmail.com>
References: <4F94222C.6080608@msgid.tls.msk.ru> <1335172741.2226.10.camel@perseus.themaw.net>
 <4F958352.7050106@msgid.tls.msk.ru> <4F95897B.2040103@msgid.tls.msk.ru> <4F959A5A.8070907@msgid.tls.msk.ru>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=29g/Iizm1iU2Zk96b4ueEUiq4XYgOFZtV5vZGIhe0QQ=;
        b=s48NxOv/B/hL88wydNxn4m50D1FhJBQYs1trA3dx9+heWkD/h65a/iH4AaCfT9nnAX
         g5+ZHYeAAW3GU8yHIo3/LbUqehlbiYvvUTBICPzsd8+kvuATq7MUb/NLXjBh6gnrtS0+
         ORQaZH47pQGeFjwLPsAX4iBRxWbvn/Dmt5o2tfdoX75hcBcQAno01mD5XeJGVsnoxA+K
         izu0p1/ll9R7zCNLunCvj0EwFkiXscRLFMXkMSYqRDjudk3m6B5a4qGuTzpUadgKEtQt
         k0LqmaHu0BGOBVIsO5qU7gFnGzTnMRtZlcfTQq/KsyCXUmzq3MPRGY0QqtsgBvB/C5p7
         nQkA==
In-Reply-To: <4F959A5A.8070907@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Ian Kent <raven@themaw.net>, "stable@kernel.org" <stable@kernel.org>, autofs@vger.kernel.org, Linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Apr 23, 2012 at 11:07 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Okay, even if messy, there are quite easy pure userspace
> solutions to all this.

Yes.

> But first of all, I want to question this change in the
> first place, hence CC'ing to LKML too.

So the reason for the change was to make it much easier for people to
upgrade their 32-bit environment to a 64-bit kernel, and then you can
- maybe even just one package at a time: you may only care about a few
things - upgrade your binaries.

And the 64-bit compat layer really *should* make that "just work". A
32-bit binary really should work exactly the same on a 32-bit kernel
as it does on a 64-bit kernel. The optimal situation is that the
binary couldn't really even tell the difference, with the possible
exception of just doing an uname (and quite frankly, even *that* I
think is debatable: if you run a 32-bit binary, I seriously think we
should have just returned "i386", but people argued against that).

> Kernel has been shipping with this brokeness for quite
> some time, namely, since introduction of autofs4, dated
> Mon Mar 27 01:14:55 2006 -0800 (commit 5c0a32fc2cd0).

Absolutely. That said, we I did have several reports of it making it
possible to use a 64-bit kernel with user land from a couple of
regular distributions. So it's a real fix, and I'd like to keep it
around some way too.

> Main userspace user of this interface adopted long ago
> too, and has been in wide use for years as well.

Actually, that's just not true. The *main* users of the interface seem
to have never fixed anything. As far as I know, neither the upstream
autofs tools nor several of the big distributions ever had patches to
make 32-bit autofs work with the old broken 64-bit compat layer.

So this is a regression, but it does seem to be the case that the
workarounds for the old broken kernel behavior were fairly limited in
distribution too. Which makes me wonder if

 (a) we could make it a kernel boot command line option (which would
be better than a hardcoded compile-time config option)

 (b) which distros did the work-around for the old broken 32-bit user
space compat behavior, and how widely spread is that (which would
likely imply which way the *default* behavior should be)

But yes, we'll need to fix it somehow in the kernel, even if it might
be just a horrible hack.

Sadly, the autofs interface is *disgusting*. It just uses a pipe, so
the kernel side of autofs doesn't even *see* how big the read will be.
It just sees a random pipe, never seeing the read itself. So we can't
just say "oh, he's doing a 300-byte read, so he must be the old broken
interface". But if somebody figures out how to detect that
automatically in the kernel, that would be really good too.

Anybody?

                  Linus
