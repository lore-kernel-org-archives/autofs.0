From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: autofs: use __kernel_write() for the autofs pipe writing causes
 regression in -next was Re: 5.9.0-next-20201015: autofs oops in update-binfmts
Date: Sat, 17 Oct 2020 11:05:06 -0700
Message-ID: <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
References: <20201016123530.GA30444@duo.ucw.cz> <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net>
 <20201017100234.GA3797@amd>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzzkfpJGlrB+NzoqhMm5+0wWAh7Rs2lQArX41HEAZCI=;
        b=TKzbCbUH7/c9ZSIadXiw2jBTw8FZOtumacQ3aVsQPG3EMi3ovIrNr1LT83lI/QH6RX
         6SYmz6HeVIjzp5Sr0WpMUwSO9mzQG42mg+5ygnrIHPoOo7L2Cw7XHagFYbBRDwk3tqba
         +KviVi+0xg52SClQeey5o0rS6yC1vNh69NVxo=
In-Reply-To: <20201017100234.GA3797@amd>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Ian Kent <raven@themaw.net>, Ondrej Mosnacek <omosnace@redhat.com>, Christoph Hellwig <hch@lst.de>, kernel list <linux-kernel@vger.kernel.org>, autofs@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Peter Anvin <hpa@zytor.com>

On Sat, Oct 17, 2020 at 3:02 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Bad Linus!

Christ people.

The bug is in linux-next, not in mainline.  I've told the people
involved already over a week ago.

I can't do anything about linux-next being broken and people not fixing it.

              Linus
