From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] autofs4 - fix get_next_positive_subdir()
Date: Tue, 22 May 2012 19:53:49 -0700
Message-ID: <CA+55aFwCESHx0d+ZEe-zi3PS6mkMaMng75Dnfit93cTwhb5gSg@mail.gmail.com>
References: <20120523024950.3905.89811.stgit@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=CW6MvR7uNbcap6NVOlh5CaYttR4wTghU7oxHwkgWzos=;
        b=zo8AnnGG4IfS7irikYx0tv3pqglO/ppjk9wHt6MrJ3r04Tk9rJyrz9fSBiYSR0v+SN
         Dq4sGMreABr9HeAnqyJJLUXOeDA6BGo534mHcXzUFpfEbaUgzTxDUu/n/1kQaSsg5/V9
         sZIrNztiK02n1Jx0nev29I0CY+ErQfv93bMwLjeld6pFjwAC5qiCaoGrIZzDTPnBI9jx
         SKQV0D/cPot3x7yKWdBNJF+CjNLulq6O67nQ/JepRZlI5wgu6TxIuzAPhQLy4jq0qEtO
         /7xR0HUMyPeOpL9ID19CL1I2J1+nmBHDTUt7TsNSO+FNCc/UADfy65jCsxWylrL+Im2A
         cvRA==
In-Reply-To: <20120523024950.3905.89811.stgit@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <ikent@redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Tue, May 22, 2012 at 7:49 PM, Ian Kent <ikent@redhat.com> wrote:
>
> The locking for the list traversal in get_next_positive_subdir() is
> wrong, so fix it.

As an explanation, this kind of thing is totally useless. It doesn't
actually give any information at all. It's like saying "change
locking"

What happened, and why? Why is the new nested spinlock ok and won't
deadlock against other nested users? Wazzup?

                 Linus
