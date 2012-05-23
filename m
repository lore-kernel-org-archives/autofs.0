From: Ian Kent <ikent@redhat.com>
Subject: Re: [PATCH] autofs4 - fix get_next_positive_subdir()
Date: Wed, 23 May 2012 15:22:01 +0800
Message-ID: <1337757721.2225.8.camel@perseus.themaw.net>
References: <20120523024950.3905.89811.stgit@perseus.themaw.net>
	 <CA+55aFwCESHx0d+ZEe-zi3PS6mkMaMng75Dnfit93cTwhb5gSg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwCESHx0d+ZEe-zi3PS6mkMaMng75Dnfit93cTwhb5gSg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Tue, 2012-05-22 at 19:53 -0700, Linus Torvalds wrote:
> On Tue, May 22, 2012 at 7:49 PM, Ian Kent <ikent@redhat.com> wrote:
> >
> > The locking for the list traversal in get_next_positive_subdir() is
> > wrong, so fix it.
> 
> As an explanation, this kind of thing is totally useless. It doesn't
> actually give any information at all. It's like saying "change
> locking"
> 
> What happened, and why? Why is the new nested spinlock ok and won't
> deadlock against other nested users? Wazzup?

It's good that you questioned this Linus.

Looking again at dput() I think the traversal still isn't quite right.

For a start the test for d_count 0 or positive and hashed can never be
true since the point of the change was to take the d_lock of the
d_subdirs dentry for the traversal.

I'll need to work on this some more, thanks.
Ian

