From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs - fix log print messages
Date: Tue, 11 Nov 2014 14:01:52 +0800
Message-ID: <1415685712.2486.17.camel@perseus.themaw.net>
References: <20141111012954.25773.4002.stgit@perseus.themaw.net>
	 <1415676341.16070.0.camel@perches.com>
	 <1415684245.2486.9.camel@perseus.themaw.net>
	 <1415684989.16070.2.camel@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=SqEXhNzlz8g+w6pYkq7vkngz39w=; b=SCUIytIdBDSqW1xXfm
	M1dG/y0WWZm3BwRSA3V+fz4PYP1kUEWrpdJCmyreAd1oM65wb2yS1WJP+4REg8z6
	bNEhpUltx2PdhEndbw8SbTTpPzcKc7dZOvtPAxO0fhCos67+tJ7hUlUv4XKa+tWs
	nIlpqnRhtADAg+qXxaIV9y1qg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=SqEXhNzlz8g+w6pYkq7vkn
	gz39w=; b=tRxEsyq4j0QNpKjxXEi51BOMEk2v4aDUHB3cyQuKuerSo0dtGLKTqT
	Ji/Gps/NNg0QjjVG68uooI+xWyynJM0E+YJJFcwV9RNmgr+bS+PJ6Y9l4702ohdw
	bm9fTLfCTklJe7Ne+94OMoc62mpWPcO0DRl7mTq6dbv15q5f3vztA=
In-Reply-To: <1415684989.16070.2.camel@perches.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2014-11-10 at 21:49 -0800, Joe Perches wrote:
> On Tue, 2014-11-11 at 13:37 +0800, Ian Kent wrote:
> > On Mon, 2014-11-10 at 19:25 -0800, Joe Perches wrote:
> > > On Tue, 2014-11-11 at 09:29 +0800, Ian Kent wrote:
> > > > Fix some inconsistencies in log print output and ensure that
> > > > the module name is included in all log prints.
> > > > 
> > > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > > Cc: Joe Perches <joe@perches.com>
> > > > ---
> > > >  fs/autofs/autofs_i.h  |    6 +++---
> > > >  fs/autofs/dev-ioctl.c |    2 +-
> > > >  fs/autofs/inode.c     |   10 +++++-----
> > > >  fs/autofs/waitq.c     |    4 ++--
> > > >  4 files changed, 11 insertions(+), 11 deletions(-)
> > > 
> > > What tree are these patches made against?
> > 
> > They live in an StGit patch queue against the current Linus tree.
> > They depend on the prior series to rename autofs4 to autofs.
> 
> Hey Ian.
> 
> Maybe you could add the git tree location to
> the MAINTAINERS entry:
> 
> MAINTAINERS-KERNEL AUTOMOUNTER v4 (AUTOFS4)
> MAINTAINERS-M:  Ian Kent <raven@themaw.net>
> MAINTAINERS-L:  autofs@vger.kernel.org
> MAINTAINERS-S:  Maintained
> MAINTAINERS:F:  fs/autofs4/
> 
> T:	git git://somewhere_or_other...
> 
> and maybe you also could get Stephen Rothwell
> to add that tree to -next

Oh, you meant what public tree.

I guess I could make a kernel.org tree but, apart from this recent
rename autofs4 -> autofs, the number of autofs changes hasn't warranted
maintaining a separate tree for quite a while.

It looks like the place holder under /pub/scm/linux/kernel/git/raven is
no longer present so I expect I'd need to request that be setup.

That's why I just send my patches to Andrew to include them in -next.

Andrew, thoughts?
Ian

