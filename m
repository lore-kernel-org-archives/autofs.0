From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/2] struct pid-ify autofs4
Date: Mon, 24 Sep 2012 08:38:50 +0800
Message-ID: <1348447130.2318.1.camel@perseus.themaw.net>
References: <1348068576-21363-1-git-send-email-miklos@szeredi.hu>
	 <87haqrwfbj.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=KVAr7SoVOZrB8ih7QztxsCyijII=; b=DwoHZK5bMp3yiRBNhJY+JG3q/hui
	3sni+qi6XEzB7bcmRo2BkEQG/GSI+lwbLpfJmqw8cNzYNfCa9DIIFFRYYAUCRTMQ
	txg13MWZVGnPHvms5itk9Z0iUJd8cFQxnTIOWvpbN/NY7CWPsgFtG+O8NFTSiA71
	7WDqUzcXhU2vzUs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=KVAr7SoVOZrB8ih7QztxsCyijII=; b=Nbp
	sEybOEQzfJloLcH6NW/+MhaX7sntXyxTB6YaFGtJH2MK6J0+ovkKmRjFpvKAR6CS
	wMzZNGYRgPf6J71HqRLRFJ+whs/eBmgQ5NhbITqAQMpBprpNdunW4TCBoZ1u5np7
	wZ6QLaJw9zhMmGcKuO4J5BKZxnmLCVcn/C00Q2c0=
In-Reply-To: <87haqrwfbj.fsf@tucsk.pomaz.szeredi.hu>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, ebiederm@xmission.com

On Fri, 2012-09-21 at 17:44 +0200, Miklos Szeredi wrote:
> Miklos Szeredi <miklos@szeredi.hu> writes:
> 
> > These two patches change autofs4 to store struct pid pointers instead of pid_t
> > values.
> >
> > Fixed various issues with the previous post.  Not tested, handle with
> > care!
> 
> Customer gave positive test results.

For what exactly, there's no problem description in these patches?

> 
> Thanks,
> Miklos
> 
> >
> > Thanks,
> > Miklos
> > ---
> >
> >
> > Serge Hallyn (1):
> >       autofs4: store struct pids in autofs_waitqs
> >
> > Sukadev Bhattiprolu (1):
> >       Replace pid_t in autofs4 with struct pid reference.
> >
> > ---
> >  fs/autofs4/autofs_i.h  |    8 ++++----
> >  fs/autofs4/dev-ioctl.c |    3 ++-
> >  fs/autofs4/inode.c     |   22 +++++++++++++++-------
> >  fs/autofs4/waitq.c     |   19 +++++++++++++------
> >  4 files changed, 34 insertions(+), 18 deletions(-)


