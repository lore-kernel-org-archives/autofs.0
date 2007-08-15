From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH] autofs4: deadlock during create
Date: Wed, 15 Aug 2007 14:31:43 +0800
Message-ID: <1187159503.3249.36.camel@raven.themaw.net>
References: <1187087280.4963.18.camel@raven.themaw.net>
	 <x49mywuci9i.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755126AbXHOGcE@vger.kernel.org>
In-Reply-To: <x49mywuci9i.fsf@segfault.boston.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2007-08-14 at 10:17 -0400, Jeff Moyer wrote:
> Ian Kent <raven@themaw.net> writes:
> >
> > After spending quite a bit of time trying to resolve this on more than
> > one occassion, using rather complex and ulgy approaches, it turns out
> > that just delaying the hashing of the dentry until the create operation
> > work fine.

There seems to be an unexpected problem with the patch after removal of
the d_rehash line left in the original by mistake.

I'm working on it.
Sorry all.

Ian

