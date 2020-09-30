From: Ian Kent <raven@themaw.net>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Wed, 30 Sep 2020 13:42:34 +0800
Message-ID: <da9841a1f2f145f1c2f29933360eacb412439e45.camel@themaw.net>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
         <20200921160922.GA23870@lst.de>
         <20200921163011.GZ3421308@ZenIV.linux.org.uk>
         <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
         <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
         <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
         <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
         <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
         <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
         <05c18390d485ae6d84c49f707d20b49e28f210a6.camel@themaw.net>
         <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        sbcy6wGZ59hwt/gqPQd4hkoF3BHdAsFrdMKjNxABWNw=; b=mUvHlukkMxaBsXgJ
        CD8nq1vO0EbmJTozk9E9YyT1ac2ETtSzRvzRk+alHykq3T6jV0fwIMPOAWmQAmip
        2sCMHb5sXVHl8GJFv13+swjaRCUITjpmt90mkjEvRfwVQPKhiLWpGGcIoUw3N+bN
        FvhdU7XqpHhXD/W9n28qOHtD00zYoQA087SKIc/WX6lBgzs13mERPzHLakLLoZVV
        5eY99tmvRURo+m1AbPYQOpndyOmg8IWCEMa/CllJkS91OwyvTed2Q9i2e+bFEvxh
        zcB3GL3JFKC5C195XjvJvm8V8cM42mjDIOlOPagVYV+1SV8REhPLMAMffeX7Pqj4
        GEfwOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=sbcy6wGZ59hwt/gqPQd4hkoF3BHdAsFrdMKjNxABW
        Nw=; b=R6OGSgyRIfFpwaG0GvUmUHWf/CfNwLnIMFonPx55ui5uhYKkH+6rhY48i
        M7mv3y01u5pBeRkWfiUTVUH56LhsUttg5EVf5iXmuh1KBvLobew1hTlA6LkhJ5o8
        2UWdd3j+7swgoPJKNguhpp8DhVfI9jasgsxs+Yd6MZn+0kubGEOIJoTZXGwxREyp
        N/UT8nezdGFg0BNFwJdPMNcz6vlo85aOJWe6g/rxRlkOGk67bCwcTpd7odRk/YVk
        UkkOXy5vpHPyGM5UrRjdXH0SLKtRSc2XVXy+K5dGWNzlRxo1SWqDIvnIWq3S087E
        M0CWYEZsIcThD8HOtl6iRIaP6stPA==
In-Reply-To: <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>

On Tue, 2020-09-29 at 14:16 +0200, Ondrej Mosnacek wrote:
> On Sun, Sep 27, 2020 at 5:08 AM Ian Kent <raven@themaw.net> wrote:
> > On Fri, 2020-09-25 at 10:38 -0700, Linus Torvalds wrote:
> > > On Fri, Sep 25, 2020 at 6:38 AM Ondrej Mosnacek <
> > > omosnace@redhat.com>
> > > wrote:
> > > > On Thu, Sep 24, 2020 at 4:16 PM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > Up-thread I thought Linus indicated he didn't really want a
> > > > > flag
> > > > > to
> > > > > disable pemission checking due to potential abuse (and I
> > > > > agree).
> > > > 
> > > > IIUC he was against adding an FMODE flag, while I was rather
> > > > suggesting a new function parameter (I realize it probably
> > > > wasn't
> > > > clear from what I wrote).
> > > 
> > > I really would prefer neither.
> > > 
> > > Any kind of dynamic behavior that depends on a flag is generally
> > > worse
> > > than something that can be statically seen.
> > > 
> > > Now, if the flag is _purely_ a constant argument in every single
> > > user,
> > > and there's no complex flow through multiple different layers, an
> > > argument flag is certainly fairly close to just having two
> > > different
> > > functions for two different behaviors.
> > > 
> > > But I don't really see much of an advantage to adding a new
> > > argument
> > > to kernel_write() for this - because absolutely *nobody* should
> > > ever
> > > use it apart from this very special autofs case.
> > > 
> > > So I'd rather just re-export the old __kernel_write() (or
> > > whatever it
> > > was that broke autofs) that didn't do that particular check. We
> > > already use it for splice and core dumping.
> > > 
> > > autofs isn't that different from those two, and I think the only
> > > real
> > > difference is that autofs is a module. No?
> > 
> > It can be, yes, many distro builds compile it in.
> > 
> > > So I think the fix is as simple as exporting __kernel_write()
> > > again -
> > > and let's just make it a GPL-only export since we really don't
> > > want
> > > anybody to use it - and revert  commit 13c164b1a186 ("autofs:
> > > switch
> > > to kernel_write").
> > 
> > Yes, sorry I missed this initially.
> > 
> > There are a couple of other sanity checks in kern_write() but since
> > __kern_write() is meant to be for internal use that's not really
> > an issue IMHO.
> 
> OK, so it seems that reverting comes out as the best choice here.
> 
> BTW, I'm looking at rw_verify_area() and I see this "If (ppos)" check
> and the comment above it... And then I look at autofs_write(), which
> passes &file->f_pos, while ksys_write() passes file_ppos(file), which
> checks FMODE_STREAM and returns NULL if it is set. And since the
> autofs pipe should be a... well... pipe, which AFAIK implies
> FMODE_STREAM, file_ppos() should return NULL for it. So shouldn't
> autofs_write() use file_ppos(file) instead of &file->f_pos? Not sure
> if there are any practical implications, but seems more
> correct/consistent that way... And in that case most of the
> rw_verify_area() checks would be skipped anyway. And
> file_start_write()/file_end_write() do nothing on non-regular files,
> so it seems kernel_write() vs. __kernel_write() makes only very
> little
> difference for pipes.

Ok, let me have a look at the file position handling there.

Ian

