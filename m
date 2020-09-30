From: Ian Kent <raven@themaw.net>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Wed, 30 Sep 2020 13:50:14 +0800
Message-ID: <689756d7d7d73a8eb86d020b0dfeb976e28cc9b4.camel@themaw.net>
References: <20200921163011.GZ3421308@ZenIV.linux.org.uk>
         <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
         <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
         <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
         <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
         <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
         <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
         <05c18390d485ae6d84c49f707d20b49e28f210a6.camel@themaw.net>
         <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
         <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
         <20200929180037.GA12447@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        Mp9EqWJ4lUoNUl6c9m7THxG0vTK6pHSVa8wUIjwah7U=; b=ankom8DyIiQ+f5GR
        QbMxnDP32vp7AOWdPOGsbegp24fY9xujXYyST4xC5PqMredoKwSfBruFjMUWvroy
        81hY4WDA8m7bI3nJ5awlRThuRS1wqr5/5JKnxKAI2K4g4d7Do5dN17YjogWo1Gs0
        dX42MvKifQ3q/YSbym/YnYvR00pf41h3hCjCHbAHoWvsdrc+nPCynPGfHtc02NMG
        rouFrA57rHcneLWSA1d1fDqlxNH6SHoNKCCYQVOhTYnfhib6T4daJ0tEoMpwjdTx
        XFCGoFCLAlnqFOLyGl1S7AsfPR/SSGMCCRBXkOb+yu4C/4Uj5dKFmajOTTZtBSBO
        KaDGjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Mp9EqWJ4lUoNUl6c9m7THxG0vTK6pHSVa8wUIjwah
        7U=; b=B2KqN8M7C517SqGwaazCflnXDlSHILOVG5C8VgaxEvKEUpnrKMg78jFOn
        9edzsSp1/5A+GiqjCnlpvmdX3Q0S1TlbeCKTRhhUNeQBgT75u1+IVJ3fi98vDjUs
        KPA0HuGR/KTM+m7sDFAHY1y2q+NI3gjrflPZ21pdQpb+Mwb43/roFtv/DcVsA4zf
        1ab2o6WHDctFZdzWCqdBQDEebbOfrev8GKdRxrSPUlCQv5BAsDtkrPxZQdrYVnwD
        47QNr6tgwN7UJ5M2LXBkog2A79BvLhI7kJL/HP7qINqXJjIz9bK3usp+TBjfzBxC
        5dSTrQ1rvRMcr94RmMOFs8FipBo5Q==
In-Reply-To: <20200929180037.GA12447@lst.de>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>

On Tue, 2020-09-29 at 20:00 +0200, Christoph Hellwig wrote:
> On Tue, Sep 29, 2020 at 10:23:50AM -0700, Linus Torvalds wrote:
> > On Tue, Sep 29, 2020 at 5:16 AM Ondrej Mosnacek <
> > omosnace@redhat.com> wrote:
> > > OK, so it seems that reverting comes out as the best choice here.
> > 
> > Yeah.
> > 
> > > BTW, I'm looking at rw_verify_area() and I see this "If (ppos)"
> > > check
> > > and the comment above it... And then I look at autofs_write(),
> > > which
> > > passes &file->f_pos, while ksys_write() passes file_ppos(file)
> > 
> > Ok, that doesn't matter for the security_file_permission() issue,
> > but
> > yes, autofs is doing the traditional thing, and it's pointless.
> > Using
> > file_ppos(file) isn't an option since it's an inline to
> > read_write.c,
> > but it could just pass in NULL these days and avoid that too.
> > 
> > So how about we just do the appended patch? Can whoever sees this
> > problem just verify, even though it looks trivially correct...
> 
> This looks sensible to me.  I'd throw in a
> 
> /* only for autofs, don't use in new code */
> 
> near the export, but users of these kind of functions tend to be
> blind copy and paste code anyway, so the comment probably isn't
> even read by the relevant parties..

I'll build a patched kernel and give it a whirl.

Ian

