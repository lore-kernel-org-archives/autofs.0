From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Fri, 25 Sep 2020 10:38:12 -0700
Message-ID: <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk>
 <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
 <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
 <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
 <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com> <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xV1ixFKYBYzs9xQqtXfpj87vpxE9fe3bTqmPmwrmWRA=;
        b=fx6QQkhaEaLL0IKUt52H3mzpFGb3zgZouYy5OWhuqmRYp9EJXuJxfucb1VNywFmJBp
         z+VoiRTM4dfJhadiLfJOAFLLSWYu9fOPhVDXnKtf+Uut9p4/+eQ39wnmESomu2cg7F9e
         jWPjxuon8GFrLiwrLCrEukW0y5tUfyxnjOFNA=
In-Reply-To: <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>

On Fri, Sep 25, 2020 at 6:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Sep 24, 2020 at 4:16 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Up-thread I thought Linus indicated he didn't really want a flag to
> > disable pemission checking due to potential abuse (and I agree).
>
> IIUC he was against adding an FMODE flag, while I was rather
> suggesting a new function parameter (I realize it probably wasn't
> clear from what I wrote).

I really would prefer neither.

Any kind of dynamic behavior that depends on a flag is generally worse
than something that can be statically seen.

Now, if the flag is _purely_ a constant argument in every single user,
and there's no complex flow through multiple different layers, an
argument flag is certainly fairly close to just having two different
functions for two different behaviors.

But I don't really see much of an advantage to adding a new argument
to kernel_write() for this - because absolutely *nobody* should ever
use it apart from this very special autofs case.

So I'd rather just re-export the old __kernel_write() (or whatever it
was that broke autofs) that didn't do that particular check. We
already use it for splice and core dumping.

autofs isn't that different from those two, and I think the only real
difference is that autofs is a module. No?

So I think the fix is as simple as exporting __kernel_write() again -
and let's just make it a GPL-only export since we really don't want
anybody to use it - and revert  commit 13c164b1a186 ("autofs: switch
to kernel_write").

Hmm?

             Linus
