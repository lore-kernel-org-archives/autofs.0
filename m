From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs - fix log print messages
Date: Tue, 11 Nov 2014 13:37:25 +0800
Message-ID: <1415684245.2486.9.camel@perseus.themaw.net>
References: <20141111012954.25773.4002.stgit@perseus.themaw.net>
	 <1415676341.16070.0.camel@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=LhEwfOCnp2tC1GN/jbq9GzF567o=; b=tfn9LDtsP692pANG86
	iLYWgAbY4Rvv0s8QQRTIo7Tm186VfA8yIQKsGgR9R0zTNc7Y+bdqkJiePo6WoLDq
	llxePTT9fB9GQGmzL3+v8jYtdutDHfW+xVUaDDJPloQ1SAmNdBU+CzTk6i2ebNUY
	8VVdaqDoaG/+L5R30suQvVWQ8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=LhEwfOCnp2tC1GN/jbq9Gz
	F567o=; b=tFpAfoecsF3LQ+OttZ+FZ/Cxs5K3eRp48DfLNXZFKnHpNYdbpZpSw3
	gV6LPKAy1S3/qL1BW9AS5R+ubrpDbu/FxMu2cZz7L7Y7RXtejR8ufE7mVeQngbDq
	wWAKOPmOZ+Ja1aecAqZ/iwcHU9Kzp43etHucijXQwSazlIzwjigOg=
In-Reply-To: <1415676341.16070.0.camel@perches.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2014-11-10 at 19:25 -0800, Joe Perches wrote:
> On Tue, 2014-11-11 at 09:29 +0800, Ian Kent wrote:
> > Fix some inconsistencies in log print output and ensure that
> > the module name is included in all log prints.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > Cc: Joe Perches <joe@perches.com>
> > ---
> >  fs/autofs/autofs_i.h  |    6 +++---
> >  fs/autofs/dev-ioctl.c |    2 +-
> >  fs/autofs/inode.c     |   10 +++++-----
> >  fs/autofs/waitq.c     |    4 ++--
> >  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> What tree are these patches made against?

They live in an StGit patch queue against the current Linus tree.
They depend on the prior series to rename autofs4 to autofs.

Ian

