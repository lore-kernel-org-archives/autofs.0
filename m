Return-Path: <autofs-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9684CDB474
	for <autofs@archiver.kernel.org>; Mon, 23 Oct 2023 13:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjJWN55 (ORCPT <rfc822;autofs@archiver.kernel.org>);
        Mon, 23 Oct 2023 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjJWN54 (ORCPT
        <rfc822;autofs@vger.kernel.org>); Mon, 23 Oct 2023 09:57:56 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9194BC2
        for <autofs@vger.kernel.org>; Mon, 23 Oct 2023 06:57:54 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3add37de892so1901987b6e.1
        for <autofs@vger.kernel.org>; Mon, 23 Oct 2023 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698069474; x=1698674274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uAR9jRMbJYUaNeURAFSY6EICyx4/2aLGhiU5vbPVydU=;
        b=PaIesrfselMNTcKHGlDY9hZ7R9HF6bKiAVc1JrgNVEjCNepTg3YsCqBBIN5VdPfMmS
         NQSfVyrpm4aN9F9g34nxFqZHU+ZQOk+cWM8mtspKJ4/NJTZd5i0FPA7hbHWYQooOJq2D
         nW8x62ptzhTCKIspk9K98a7+SHfO35rOhFFYBgT6+XPv3cSbjtYWDdeuCLsnmNS+wFwZ
         +HXFtMEZ77T+TdXBQUJ+omT5OLoqzjUspAF1CwUdwcsxDje+ZV2LE/h436qrxoevz5Vi
         VTp8CWO9vDbmTaCfJgsovSBCu5J1Nj/c3lDxOrRkFbsyO76tWNkqQvFdh4JrR1vrQlfv
         X+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698069474; x=1698674274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAR9jRMbJYUaNeURAFSY6EICyx4/2aLGhiU5vbPVydU=;
        b=sLXipxNrt9g3K6TUrGcEi5qWNUjNvpasiwvdin7xGP9veCEodE/o3p1hjIgqBIx+hv
         KDBmKXS+oY4/38h1USJcQu+xaF2udhEQMkcg2ctefb5z9WpFTgMWdy54FCuw6TtkG3PQ
         o45AStGd4xKD3bVHajnHWzfthNUb0XBffQJWsmFsfbnshIScWdGXUdU7+iAYYT+y0d3O
         DwvJ8zf/VeM6vfAJkjcPIhIaJXDgiSaAr1TP8tzj4WBJR+3A/XDmQedV7vFXyK/CQ6H2
         q2Tt5Thqjmoh9fVc4bVrrfaq2yYB+JQEmymTng+PFLFekSI+kX9alaDuHKhE/Wr3zdjW
         uTlw==
X-Gm-Message-State: AOJu0Yx7b6ugZBXIL3oCWlCGFEqvIcZoGQFAJZJ4paeQvDJ7nDBx3t7t
        mZziDrqA6SgxKT5UKnYktyNyvS6Xx3nDR5qKXBRXiQ==
X-Google-Smtp-Source: AGHT+IE8n7Akqlfn8IuvmHYLL/NxGHF4IszpExxzbeU/MQwZ6u4W7ehZfYI0EZCXdhnrrVSvNykKWGnMIyiIHSj8y4s=
X-Received: by 2002:a05:6808:144d:b0:3af:26e3:92e with SMTP id
 x13-20020a056808144d00b003af26e3092emr11037614oiv.28.1698069473779; Mon, 23
 Oct 2023 06:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com> <CADYN=9+HDwqAz-eLV7uVuMa+_+foj+_keSG-TmD2imkwVJ_mpQ@mail.gmail.com>
 <432f1c1c-2f77-4b1b-b3f8-28330fd6bac3@kadam.mountain> <f1cddf6e-2103-4786-84ff-12c305341d7c@app.fastmail.com>
 <11ba98f2-2e59-d64b-1a1a-fd32fd8ba358@themaw.net> <9217caeb-0d7e-b101-33f0-859da175a6ef@themaw.net>
 <a5dfbe4f-b6fc-e282-2a3c-3e487493336c@themaw.net>
In-Reply-To: <a5dfbe4f-b6fc-e282-2a3c-3e487493336c@themaw.net>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 23 Oct 2023 15:57:43 +0200
Message-ID: <CADYN=9JS5QO5pmcFPJXY2TJB7TKg30k867SJ9BwPcgY-Wvm61A@mail.gmail.com>
Subject: Re: autofs: add autofs_parse_fd()
To:     Ian Kent <raven@themaw.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        autofs@vger.kernel.org, "Bill O'Donnell" <bodonnel@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <autofs.vger.kernel.org>
X-Mailing-List: autofs@vger.kernel.org

On Mon, 23 Oct 2023 at 09:35, Ian Kent <raven@themaw.net> wrote:
>
> On 23/10/23 08:48, Ian Kent wrote:
> > On 20/10/23 21:09, Ian Kent wrote:
> >> On 20/10/23 19:23, Arnd Bergmann wrote:
> >>> On Fri, Oct 20, 2023, at 12:45, Dan Carpenter wrote:
> >>>> On Fri, Oct 20, 2023 at 11:55:57AM +0200, Anders Roxell wrote:
> >>>>> On Fri, 20 Oct 2023 at 08:37, Arnd Bergmann <arnd@arndb.de> wrote:
> >>>>>> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
> >>>>>>> The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit
> >>>>>>> rootfs we call
> >>>>>>> it as compat mode boot testing. Recently it started to failed to
> >>>>>>> get login
> >>>>>>> prompt.
> >>>>>>>
> >>>>>>> We have not seen any kernel crash logs.
> >>>>>>>
> >>>>>>> Anders, bisection is pointing to first bad commit,
> >>>>>>> 546694b8f658 autofs: add autofs_parse_fd()
> >>>>>>>
> >>>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>>>>>> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> >>>>>> I tried to find something in that commit that would be different
> >>>>>> in compat mode, but don't see anything at all -- this appears
> >>>>>> to be just a simple refactoring of the code, unlike the commits
> >>>>>> that immediately follow it and that do change the mount
> >>>>>> interface.
> >>>>>>
> >>>>>> Unfortunately this makes it impossible to just revert the commit
> >>>>>> on top of linux-next. Can you double-check your bisection by
> >>>>>> testing 546694b8f658 and the commit before it again?
> >>>>> I tried these two patches again:
> >>>>> 546694b8f658 ("autofs: add autofs_parse_fd()") - doesn't boot
> >>>>> bc69fdde0ae1 ("autofs: refactor autofs_prepare_pipe()") - boots
> >>>>>
> >>>> One difference that I notice between those two patches is that we no
> >>>> long call autofs_prepare_pipe().  We just call autofs_check_pipe().
> >>> Indeed, so some of the f_flags end up being different. I assumed
> >>> this was done intentionally, but it might be worth checking if
> >>> the patch below makes any difference when the flags get put
> >>> back the way they were. This is probably not the correct fix, but
> >>> may help figure out what is going on. It should apply to anything
> >>> from 546694b8f658 ("autofs: add autofs_parse_fd()") to the current
> >>> linux-next:
> >>>
> >>> --- a/fs/autofs/inode.c
> >>> +++ b/fs/autofs/inode.c
> >>> @@ -358,6 +358,11 @@ static int autofs_fill_super(struct super_block
> >>> *s, struct fs_context *fc)
> >>>          pr_debug("pipe fd = %d, pgrp = %u\n",
> >>>                   sbi->pipefd, pid_nr(sbi->oz_pgrp));
> >>>   +        /* We want a packet pipe */
> >>> +        sbi->pipe->f_flags |= O_DIRECT;
> >>> +        /* We don't expect -EAGAIN */
> >>> +        sbi->pipe->f_flags &= ~O_NONBLOCK;
> >>> +
> >>
> >>
> >> That makes sense, we do want a packet pipe and that does also mean
> >>
> >> we don't want a non-blocking pipe, it will be interesting to see
> >>
> >> if that makes a difference. It's been a long time since Linus
> >>
> >> implemented that packet pipe and I can't remember now what the
> >>
> >> case was that lead to it.
> >
> > After thinking about this over the weekend I'm pretty sure my mistake
> >
> > is dropping the call to autofs_prepare_pipe() without adding the tail
> >
> > end of it into autofs_parse_fd().
> >
> >
> > To explain a bit of history which I'll include in the fix description.
> >
> > During autofs v5 development I decided to stay with the existing usage
> >
> > instead of changing to a packed structure for autofs <=> user space
> >
> > communications which turned out to be a mistake on my part.
> >
> >
> > Problems arose and they were fixed by allowing for the 64 bit to 32 bit
> >
> > size difference in the automount(8) code.
> >
> >
> > Along the way systemd started to use autofs and eventually encountered
> >
> > this problem too. systemd refused to compensate for the length difference
> >
> > insisting it be fixed in the kernel. Fortunately Linus implemented the
> >
> > packetized pipe which resolved the problem in a straight forward and
> >
> > simple way.
> >
> >
> > So I pretty sure that the cause of the problem is the inadvertent
> > dropping
> >
> > of the flags setting in autofs_fill_super() that Arnd spotted although I
> >
> > don't think putting it in autofs_fill_super() is the right thing to do.
> >
> >
> > I'll produce a patch today which includes most of this explanation for
> >
> > future travelers ...
>
> So I have a patch.
>
>
> I'm of two minds whether to try and use the instructions to reproduce this
>
> or not because of experiences I have had with other similar testing
> automation
>
> systems that claim to provide a reproducer and end up a huge waste of
> time and
>
> are significantly frustrating.
>
>
> Can someone please perform a test for me once I provide the patch?

Just tested it, and it passed our tests. Added a tested by flag in your patch.

Thanks for the prompt fix.

Cheers,
Anders





>
>
> Ian
>
> >
> >
> >>
> >>
> >> Ian
> >>
> >>>          sbi->flags &= ~AUTOFS_SBI_CATATONIC;
> >>>            /*
