From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Breaking userspace? Re: 3.0.24 broke aufofs on mixed 32/64bit environment
Date: Tue, 24 Apr 2012 14:01:57 -0700
Message-ID: <CA+55aFx9hATsnANWYSoagycc2HnXO=5Oa3gtqBjMr9eoe1obpA@mail.gmail.com>
References: <4F94222C.6080608@msgid.tls.msk.ru> <1335172741.2226.10.camel@perseus.themaw.net>
 <4F958352.7050106@msgid.tls.msk.ru> <4F95897B.2040103@msgid.tls.msk.ru>
 <4F959A5A.8070907@msgid.tls.msk.ru> <CA+55aFyQ4y9jyRXyejKwtf3yXJX52hQkLuwJ5=jfQM+yLkBNMw@mail.gmail.com>
 <4F96D0E7.9060000@msgid.tls.msk.ru> <CA+55aFw=cfYZO7PWDRRuZw1nYxvUk-63qfVVwfdJWevtmZoOig@mail.gmail.com>
 <1335300159.1393.13.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=B3h1gSblOybpEqXfbfNoKd54O4hHJ7o6rdIwQmrpeOA=;
        b=bhZ9sQLTTEWzAQr3UT1XCo12s0698q1z4STlGrJC+b8OuLszrXC5jbS6KPHIBQoJD0
         6k2rrbo6D1RRDB7OcsNU8Gm/P4pleZeCJSqqbBBXcZIGzRMMVP+7krv4MCoLoAa/bf2E
         3haV0kpfc+IXK2OR7YhAj8e3zt4TF/qNXVfltxLO8X7XsCaPylIts3itPxnX22gsmNoi
         +VUm3cWRid9M5ioV6pSed6mF21EaSeAfy/4TfUri6gMINiTcdC6EUf/2l84wLR8r1679
         dD7LbnCyZtkePPP5YFC9JN+oxsKsqAHqbp7oltOwcpQxP9su/My3IJqQZ4GIP3wtDS/i
         Iqug==
In-Reply-To: <1335300159.1393.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Ian Kent <raven@themaw.net>, "stable@kernel.org" <stable@kernel.org>, autofs@vger.kernel.org, Linux-kernel <linux-kernel@vger.kernel.org>

On Tue, Apr 24, 2012 at 1:42 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>
> It broke the autofs feature of systemd (32bit) on a 64bit kernel, which
> resulted in an endless wait in the boot process. I don't use the autofs
> tools. I guess the fix in the autofs package to compensate the kernel
> bug, which has now been fixed, breaks the autofs package.
> The fix in the kernel makes systemd work correctly.

Oh damn, I'd forgotten the details. Ok.

That does mean that we probably just have to do a kernel command line
option for this. And then the autofs4 code that currently does

    sbi->compat_daemon = is_compat_task();

needs to change that to take the command line option into account too.

We could make it a mount option, but since the whole point is that we
want to be compatible with existing binaries that don't *use* special
mount options, I suspect the only reasonable point is at the kernel
command line.

That is, unless somebody can figure out a way to auto-detect how big
the user space read is. The problem with that really is that the
autofs read() system call isn't done directly to some "real autofs"
file descriptor, autofs literally is using the standard pipe code.

So the code in fs/pipe.c does actually see the size of the read. But
the code in fs/autofs4/ does not. And we can't change the interface,
because the whole pipe is opened in user space iirc.

Ugly.

Anybody willing to write the patch?

                 Linus

Damn.
