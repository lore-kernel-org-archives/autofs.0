From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling into fs
Date: Tue, 06 Jul 2010 09:11:30 +0800
Message-ID: <1278378690.3070.6.camel@localhost>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de>
	 <4C3235C3.7050303@zytor.com> <20100705194759.GE5240@nowhere>
	 <201007052152.55954.arnd@arndb.de>  <20100705195837.GF5240@nowhere>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=5ZVMTLUkDHRYNqtmsEAoa4J7XLQ=; b=Cye/eMOWuvtiyo3BYbK7aheRP5J4Wutig+2gpTpCXFx0OBwg2LIx11Xe0Xmtob470CP5qyQeQ+s2ToAozhCSCdgGx2u9ffiDV7gQU0ZAYEgMtogT9B5Yy9oN5TZiXvvQbUaCixGGoThfgx4T+XdpUhbtykFCOWkN5H4gd9FCfNc=
In-Reply-To: <20100705195837.GF5240@nowhere>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, autofs@linux.kernel.org

On Mon, 2010-07-05 at 21:58 +0200, Frederic Weisbecker wrote:
> On Mon, Jul 05, 2010 at 09:52:55PM +0200, Arnd Bergmann wrote:
> > On Monday 05 July 2010 21:48:01 Frederic Weisbecker wrote:
> > > On Mon, Jul 05, 2010 at 12:42:59PM -0700, H. Peter Anvin wrote:
> > > > On 07/05/2010 12:24 PM, Frederic Weisbecker wrote:
> > > > > 
> > > > > Peter, if you're fine with this version. May I apply it?
> > > > > Unless you have a tree for autofs.
> > > > > 
> > > > Ian Kent is the maintainer of autofs4 and patches for autofs4 should go
> > > > through him (or acked by him.)
> > > > 
> > > > autofs 3 is officially unmaintained; I'm more than happy to have you
> > > > push the autofs 3 bits of this patch.
> > > 
> > > Sure, I can split up the patch and integrate the autofs 3 part, I'll send
> > > the standalone autofs4 version to Ian.
> > 
> > I think in this case it's really more appropriate to change both autofs3
> > and autofs4 together, to avoid interdependencies. Whichever way Ian
> > prefers (ack the patch or take it) would work though.
> > 
> > 	Arnd
> 
> 
> Yeah indeed. Ian?

As Peter says the autofs module isn't supported anymore and autofs4 will
replace autofs when I eventually get around to re-doing and re-testing
my patch for that.

So it makes no difference whether the patches are combined, if it breaks
autofs then it probably won't be fixed but it may cause the replacement
to happen sooner.

As far as the patch goes that should be fine and we should be able to
remove the BKL from autofs4 soon after but I'm not brave enough to try
just yet.

Ian
