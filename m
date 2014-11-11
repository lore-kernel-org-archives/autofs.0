From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs - fix log print messages
Date: Tue, 11 Nov 2014 14:07:28 +0800
Message-ID: <1415686048.2486.20.camel@perseus.themaw.net>
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
	 s=mesmtp; bh=HREe3tf/X+xsIxZj/3fYrrNaqcY=; b=XM6SUwDx5jbGMfzMD3
	5mwZAteSB5sz62Zeq2AeVDhWArCkFBuFUSVtipzv2n7G/UN/UuLG5P07+1KPb1bO
	B0WZAUfIySLopDCrn9QyrAawKp1R6iD/Vq7lnA75e//xUYWb8TJlHrpccR3gFOg5
	5bN+cb8sdvn/2mZOjg8mYpjek=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=HREe3tf/X+xsIxZj/3fYrr
	NaqcY=; b=jZ+ANzF+LVFitfLRcWJaqqttNYsPu6wtSAfWTmc/jfrce4bKH5uJV9
	FbM8oMc7ImsEx296r8YAjRhmX0qihBej3YYuRAALVB+PyeWJWIaBfOGRUrLxtUKF
	S4HQrLRoiHH6/hpSFQI843rD7YCJoAQmy7R3Eroqq+8g8bscKBecE=
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

... and I forgot about updating that fs/autofs4/ in MAINTAINERS too, ha,
that'll need another patch.

Ian

