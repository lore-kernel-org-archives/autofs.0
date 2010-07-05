From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling into fs
Date: Mon, 5 Jul 2010 21:52:55 +0200
Message-ID: <201007052152.55954.arnd@arndb.de>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de> <4C3235C3.7050303@zytor.com> <20100705194759.GE5240@nowhere>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100705194759.GE5240@nowhere>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>, autofs@linux.kernel.org

On Monday 05 July 2010 21:48:01 Frederic Weisbecker wrote:
> On Mon, Jul 05, 2010 at 12:42:59PM -0700, H. Peter Anvin wrote:
> > On 07/05/2010 12:24 PM, Frederic Weisbecker wrote:
> > > 
> > > Peter, if you're fine with this version. May I apply it?
> > > Unless you have a tree for autofs.
> > > 
> > Ian Kent is the maintainer of autofs4 and patches for autofs4 should go
> > through him (or acked by him.)
> > 
> > autofs 3 is officially unmaintained; I'm more than happy to have you
> > push the autofs 3 bits of this patch.
> 
> Sure, I can split up the patch and integrate the autofs 3 part, I'll send
> the standalone autofs4 version to Ian.

I think in this case it's really more appropriate to change both autofs3
and autofs4 together, to avoid interdependencies. Whichever way Ian
prefers (ack the patch or take it) would work though.

	Arnd
