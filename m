From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: autofs: use __kernel_write() for the autofs pipe writing causes
 regression in -next was Re: 5.9.0-next-20201015: autofs oops in update-binfmts
Date: Sat, 17 Oct 2020 17:13:20 -0700
Message-ID: <CAHk-=wikZkCGVkeuDUb6jvz7xyeO4RsH3zQU4bCCnP=MBrd95g@mail.gmail.com>
References: <20201016123530.GA30444@duo.ucw.cz> <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net>
 <20201017100234.GA3797@amd> <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
 <20201017194758.GA9904@duo.ucw.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxGkthbhuOicJJzYUAHjMjkOp7k2zTWOMFRCAnwQA1o=;
        b=SIiMEuHhWb/JI2XHUI3ytOG/T1lgKfGalFCYU4XjJy7kbVQpoJnmHks4O2StGkpTwY
         4JuguGBTT8R+rr+OVnZufPo0cty+s4jaM1FRw+y365EmNCZ4ClaIfGi/7WMYvRAz49Nu
         MTR+Z+wjn+DqwA5LUGleZ54vjoimkx6W3PnJk=
In-Reply-To: <20201017194758.GA9904@duo.ucw.cz>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Ian Kent <raven@themaw.net>, Ondrej Mosnacek <omosnace@redhat.com>, Christoph Hellwig <hch@lst.de>, kernel list <linux-kernel@vger.kernel.org>, autofs@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Peter Anvin <hpa@zytor.com>

On Sat, Oct 17, 2020 at 12:48 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> But: you are the last one to sign it off, so I assume committed it to
> git, and you are the one to talk to about fixing it.

The thing is, the commit you point to - and the one I signed off on - is fine.

The buggy one is in linux-next, which breaks that whole "NULL means no
position" thing.

IOW, the real bug is in commit 4d03e3cc5982 ("fs: don't allow kernel
reads and writes without iter ops"), which does that bogus

        kiocb.ki_pos = *pos;

and no, I never signed off on that.

Get it? Stop confusing people. This bug does not exist in mainline,
and never will. Because I'm not pulling that buggy commit.

The commit you talk about IS NOT THE BUGGY ONE.

                 Linus
