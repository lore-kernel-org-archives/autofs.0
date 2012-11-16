From: Ian Kent <ikent@redhat.com>
Subject: Re: [PATCH] autofs4 - use simple_empty() for empty directory check
Date: Sat, 17 Nov 2012 00:36:13 +0800
Message-ID: <1353083773.2332.40.camel@perseus.themaw.net>
References: <20121116041523.18624.46918.stgit@perseus.themaw.net>
	 <CA+55aFx-9A0xknhX7z9KmLAoGMf5GXhuFgroZUixHtevGAFsOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFx-9A0xknhX7z9KmLAoGMf5GXhuFgroZUixHtevGAFsOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

On Fri, 2012-11-16 at 07:45 -0800, Linus Torvalds wrote:
> On Thu, Nov 15, 2012 at 8:15 PM, Ian Kent <ikent@redhat.com> wrote:
> >
> > +static inline int __simple_empty(struct dentry *dentry)
> > +{
> 
> This seems completely bogus.
> 
> It's a duplicate of the existing fs/libfs.c "simple_empty()" function,
> but without taking the outer lock.
> 
> That kind of code duplication - and doing it in a totally different
> file, and making it look autofs-specific - seems entirely wrong.

Sure, are you recommending I alter the fs/libfs.c functions to add a
function that doesn't have the outer lock, and have simple_empty() call
that, then use it in autofs?

Or are recommending I rework the autofs code?

Ian
