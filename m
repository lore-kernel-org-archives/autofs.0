From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: check dev ioctl size before allocating
Date: Sun, 06 Apr 2014 11:03:23 +0800
Message-ID: <1396753403.24991.3.camel@perseus.fritz.box>
References: <1394934021-16965-1-git-send-email-sasha.levin@oracle.com>
	 <53401C11.7010601@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=wQSYAf1nO1WQmkTQiIZUAo4ST8U=; b=SwC4Lfw198mgqhdmUYxP8sdNezvA
	EktRf+Vn9EcYi1VViDvB9+tqdIFGSK4QNlOqzXjtIJmxIY0c34RJvvd0sgRyg9nR
	92EmitkGXRvT6r10BEzqIQLWJ6U88UUmAB89M0AlH6sOmBerA4lD270mvGBUkQtP
	0pwikQ0N+dL/7QQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=wQSYAf1nO1WQmkTQiIZUAo
	4ST8U=; b=l3I6xlIvMtJxYgMJ0qULFDr1iQ0RIfxVA8osUWB3xV9b3RAd4RjONc
	v/5oe9GanEOCVNLrOOYDs6/2QWkLWPFWH7VZFY7Wc6dbg0NKaK3ESgMBW5af0Dvg
	Cd2TCqsZmWfft5/xPrqA2ih0xjHsFDo2EOCCEFasxmS1k2leOz1kE=
In-Reply-To: <53401C11.7010601@oracle.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sasha Levin <sasha.levin@oracle.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, akpm@linux-foundation.org

On Sat, 2014-04-05 at 11:06 -0400, Sasha Levin wrote:
> Ping? Anyone wants to take this?

Is this causing a problem for users?
If it is I'll send it to Andrew straight away.

I do have this on my queue but don't have any other patches to send so
it's just sitting there.

If it worries you I'll send it to Andrew now.

> 
> On 03/15/2014 09:40 PM, Sasha Levin wrote:
> > There wasn't any check of the size passed from userspace before
> > trying to allocate the memory required.
> > 
> > This meant that userspace might request more space than allowed,
> > triggering an OOM.
> > 
> > Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> > ---
> >  fs/autofs4/dev-ioctl.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
> > index 3182c0e..86fa7af 100644
> > --- a/fs/autofs4/dev-ioctl.c
> > +++ b/fs/autofs4/dev-ioctl.c
> > @@ -103,6 +103,9 @@ static struct autofs_dev_ioctl *copy_dev_ioctl(struct autofs_dev_ioctl __user *i
> >  	if (tmp.size < sizeof(tmp))
> >  		return ERR_PTR(-EINVAL);
> >  
> > +	if (tmp.size > (PATH_MAX + sizeof(tmp)))
> > +		return ERR_PTR(-E2BIG);
> > +
> >  	return memdup_user(in, tmp.size);
> >  }
> >  
> > 
> 


