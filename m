From: Ian Kent <raven@themaw.net>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Sun, 27 Sep 2020 11:07:56 +0800
Message-ID: <05c18390d485ae6d84c49f707d20b49e28f210a6.camel@themaw.net>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
         <20200921160922.GA23870@lst.de>
         <20200921163011.GZ3421308@ZenIV.linux.org.uk>
         <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
         <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
         <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
         <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
         <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
         <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        Toi4GKci6LJ4XuJVCZ1rchzevDUA6mJ5/+b5ClssVN4=; b=jn9iv+DFN0TRdLR7
        sEO8BbO12zq+kE8bE8b56W7tpJ2ZAwF2PB4zLJ3W97hZzoHpQHL09zR5/h96ETzc
        1BZLn4ImO8mbhseQomSU1L4AxeZ6qd0SydYX3J7yVj1FNHQp01YAH5lFN5vQlBei
        HhOxiJoQLhx+QpN63F/e++/06ijjx+zG22Mol0j2UY1oB2M91uwmz5wf/6G7nRkG
        SWBEcqfscNPG0SvB7lfgZUYsc+fCAgNfT1xEuUc4Kut1kpJjJJRFiwPyLmMfqoeN
        46yYjARwgt9lyx7AHTLrNJ0Fa7KftmPTcCCoewhovOo/mTgu4wU4CrSBSFGIBeSA
        5PD6Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Toi4GKci6LJ4XuJVCZ1rchzevDUA6mJ5/+b5ClssV
        N4=; b=ZTNOgkNsd6BngHunVrfsn3Ls1dBeu4AYvf06a7Hs3+zKM2V0m/yPGDf3H
        hyp/fo20KA6WhdwP/6TAZQG+NMj0V2YFKotNYz6DHwfFDRHzdp1MpMYoRQBbRrMp
        GVqV5M2kXw9UHRyXDkOVHKdNBRuESjjonKkkYG9rGzULKP0RXRaCH7MEHiHRwjO4
        Jhpu1naFi+mBy7IBYXJ6UpGeXCFsRWRVDr/4JuvZq5qyv0YSAYsyajBcJWO4EXzq
        nro50t7Lyn4c/guDDC4tUzbBVGqyCc/Hmp5X/WMDKwOv+VjzxMi4qAUTtRH91xW1
        7jTKV9uqrrAgPOu0N1ySAniKmO1Vg==
In-Reply-To: <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>

On Fri, 2020-09-25 at 10:38 -0700, Linus Torvalds wrote:
> On Fri, Sep 25, 2020 at 6:38 AM Ondrej Mosnacek <omosnace@redhat.com>
> wrote:
> > On Thu, Sep 24, 2020 at 4:16 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Up-thread I thought Linus indicated he didn't really want a flag
> > > to
> > > disable pemission checking due to potential abuse (and I agree).
> > 
> > IIUC he was against adding an FMODE flag, while I was rather
> > suggesting a new function parameter (I realize it probably wasn't
> > clear from what I wrote).
> 
> I really would prefer neither.
> 
> Any kind of dynamic behavior that depends on a flag is generally
> worse
> than something that can be statically seen.
> 
> Now, if the flag is _purely_ a constant argument in every single
> user,
> and there's no complex flow through multiple different layers, an
> argument flag is certainly fairly close to just having two different
> functions for two different behaviors.
> 
> But I don't really see much of an advantage to adding a new argument
> to kernel_write() for this - because absolutely *nobody* should ever
> use it apart from this very special autofs case.
> 
> So I'd rather just re-export the old __kernel_write() (or whatever it
> was that broke autofs) that didn't do that particular check. We
> already use it for splice and core dumping.
> 
> autofs isn't that different from those two, and I think the only real
> difference is that autofs is a module. No?

It can be, yes, many distro builds compile it in.

> 
> So I think the fix is as simple as exporting __kernel_write() again -
> and let's just make it a GPL-only export since we really don't want
> anybody to use it - and revert  commit 13c164b1a186 ("autofs: switch
> to kernel_write").

Yes, sorry I missed this initially.

There are a couple of other sanity checks in kern_write() but since
__kern_write() is meant to be for internal use that's not really
an issue IMHO. 

Ian

