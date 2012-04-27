From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 11:19:13 -0700
Message-ID: <CA+55aFwud1nXRr+HpzH8rSkEWcZ_rJmoE7UtQt76D=A3qcb6GQ@mail.gmail.com>
References: <1335447289-9909-1-git-send-email-mjt@msgid.tls.msk.ru>
 <CA+55aFxEP7-+N7vTPZ-4hD-UirZ=+YMJh2x3EjZvUmjjyOchtg@mail.gmail.com> <4F9A6ABA.6050503@msgid.tls.msk.ru>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=x6YUzL1c5/nFJZEfKz5Uo7B6+EyBtigLfeUr7ryoywU=;
        b=NsKp6UoAbm3ZcXY0P2OC6o1r4tcQNvkQJj+bcL+rWOL4QE3gml5EPQuO8TK86dmRm2
         jlRKiUMVn9DjPoc4UPoSPesSu+f+2HvOSSvxbN5CcPSQKTMF7Q9FWcO14jEsW60BZSFm
         +Gxmgpd3GYWzBHHG/PIB/6RyNnDdCvkI4IhK+iSor4HjiqZVDritevjNERy1NlX4yPn9
         pe36IOgl9aCUsfw7JKXjogRYmcFxVzydPXKvh6knpzg0vvMJSZRCdLzsABpVxat0/1aR
         H/f+uRlZdajU2BDj4ad9NR/9eZ/VkYVuQGzwnGmdV2DQ6ON/djFWxL+u6sKJ7sOvGnNZ
         wAnQ==
In-Reply-To: <4F9A6ABA.6050503@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, autofs@vger.kernel.org, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, stable@kernel.org

On Fri, Apr 27, 2012 at 2:45 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> I posted an alternative patch that "fixes" this issue for both
> old systemd and old autofs, by checking for current->comm being
> "automount". Not nice solution but it should work in practice.

Yes, I agree, it's probably what we have to go with.

I really would prefer to match on something else than ->comm, though.
I would hope that there is some *behavioral* difference between autofs
and systemd that we could trigger on. That said, it's always going to
be conditional on the whole "running 32-bit daemon on 64-bit kernel",
so whatever solution we pick will at least always be self-limiting to
that specific nasty buglet case.

> And please note also that systemd developers are saying they're
> fine with new interface and non-working old binaries of systemd,
> as long as this new interface actually solves the problem.

So the thing is, I think that a new "version 6" is worthless, if the
only problem it solves is this one - since I feel that we have to fix
the binary compatibility issue regardless.

So to me, a version 6 with just this fix is just completely pointless.
We can't just ignore existing binaries. You don't like ignoring
existing 'automount' binaries, and Thomas doesn't like ignoring
existing 'systemd' binaries. And I don't like ignoring *any* binaries
that are shipped with distributions - especially when they are central
and hard to work around.

> That's reality too, and _current_ reality we have _now_ is that
> autofs package, which worked fine for many years before, is broken.
> While systemd actually NEVER worked in this context so far, except
> of 3.3 kernel which included the fix.

Oh, I agree. We need to fix the autofs package. But reverting isn't
going to be acceptable either.

The strcmp is actually something I can accept, but I'd want it
separated out in a nicer helper function with a big comment. And quite
frankly, I'd really prefer to be able to trigger on some other
behavior - like looking at the exact details of the mount() system
call or maybe the ioctl's that get done on the control fd.

But yes, the strcmp is ugly, but it's less ugly than saying "we won't
fix this, and instead we'll create a whole new pointless protocol
version".

Btw, the whole autofs protocol is *full* of stuff like this. I just
looked at some other places where the automount daemon does reads of
fixed sizes, and one of them is a "sizeof(enum states)". Doing a
sizeof() on an enum is a f*cking bad idea - it's not very well-defined
at all (different compilers will consider the enum different sizes -
seriously). But at least that one seems to be something that is purely
internal to autofs - but it does show that the people involved did not
think through and design the protocols they used in general - more of
these kinds of "random sizes of random data structures that we don't
understand".

                         Linus
