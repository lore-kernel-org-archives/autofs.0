From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs4: deadlock during create
Date: Thu, 16 Aug 2007 23:54:27 -0700
Message-ID: <20070816235427.7563103e.akpm@linux-foundation.org>
References: <1187087280.4963.18.camel@raven.themaw.net>
	<x49mywuci9i.fsf@segfault.boston.devel.redhat.com>
	<1187159503.3249.36.camel@raven.themaw.net>
	<1187322972.3560.12.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763152AbXHQGzH@vger.kernel.org>
In-Reply-To: <1187322972.3560.12.camel@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>

On Fri, 17 Aug 2007 11:56:11 +0800 Ian Kent <raven@themaw.net> wrote:

> On Wed, 2007-08-15 at 14:31 +0800, Ian Kent wrote:
> > On Tue, 2007-08-14 at 10:17 -0400, Jeff Moyer wrote:
> > > Ian Kent <raven@themaw.net> writes:
> > > >
> > > > After spending quite a bit of time trying to resolve this on more than
> > > > one occassion, using rather complex and ulgy approaches, it turns out
> > > > that just delaying the hashing of the dentry until the create operation
> > > > work fine.
> > 
> > There seems to be an unexpected problem with the patch after removal of
> > the d_rehash line left in the original by mistake.
> > 
> 
> I see you haven't got to this yet, probably because I used your old
> email address, 

Actually my cursor has advanced that far, but you said it didn't work right
yet.

> so to save hassle, here is the final patch and the
> description.

OK, thanks.
