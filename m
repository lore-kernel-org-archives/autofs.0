From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 04/13] autofs4 - change printks AUTOFS defined prints
Date: Mon, 03 Nov 2014 17:20:18 +0800
Message-ID: <1415006418.6573.6.camel@perseus.themaw.net>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
	 <20141103081234.6215.82821.stgit@perseus.themaw.net>
	 <1415003136.17743.9.camel@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=AzimBBXqZ4TotrnNp84h93z/YxQ=; b=UvGveRmmNYxWhU8EFE
	SyVBxL/IwnOPY7uIZbA/QioKxhcbp3wP3rY2K9/8i+G+d6xALJH/0+cxg85ktui+
	D+eAmwssKwwR8VjoFEZh7D9BGkyA135HXE3FDKmZJyEFbjflyL9FdhqRM6YSCAnW
	ej3irtZiW7VXRr+D6ZJkwngos=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=AzimBBXqZ4TotrnNp84h93
	z/YxQ=; b=MVmNmIMwm2Lmqy6Th3HqCF1wwmPoI4tIZWDiPHB8OYFLa3jQr0pes5
	XSufXAHFjUqlW/itYDOQDXi1BxidtgZJdpBI9D5sQnquNvSEuTg9bOcXRAPZhLzU
	BbaQIbo+xDEX1LNPcUmIKGjlPa/ujQPAVF3dFOxjk8HH1e/D1AuYs=
In-Reply-To: <1415003136.17743.9.camel@perches.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2014-11-03 at 00:25 -0800, Joe Perches wrote:
> On Mon, 2014-11-03 at 16:12 +0800, Ian Kent wrote:
> > Use the AUTOFS_*() print defines instead of raw printks.
> 
> Please check the output of these conversions.
> 
> For instance:
> 
> > diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> []
> > @@ -162,7 +162,7 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
> >  		break;
> >  	}
> >  	default:
> > -		printk("autofs4_notify_daemon: bad type %d!\n", type);
> > +		AUTOFS_WARN("autofs4_notify_daemon: bad type %d!", type);
> >  		mutex_unlock(&sbi->wq_mutex);
> >  		return;
> >  	}
> 
> The current #define is:
> 
> #define AUTOFS_WARN(fmt, ...)                          \
> 	pr_warn("pid %d: %s: " fmt "\n",        \
> 		current->pid, __func__, ##__VA_ARGS__)
>  
> So this duplicates the function name in the output.

Ahh, yes, I'll fix that.

> 
> It's probably better to simply use
> 	#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> or
> 	#define pr_fmt(fmt) KBUILD_MODNAME ":%d:%s" fmt, current->pid, __func__
> if you _really_ want pid/func in the output

I do, yes.

> 
> and just use pr_<level> instead of AUTOFS_<LEVEL> macros.
> 
> And it's better to use a consistent style for
> these logging functions ideally with terminating
> newlines so there isn't a mix of code with
> and without those newlines.  That inconsistency
> leads to unintended defects.

The idea here was to make the logging consistent throughout.

I have become used of not using the new-line terminator in logging over
the years and tend to favour that myself. You recommend not doing that
probably from a kernel wide consistency perspective? Maybe that is
better ...

Ian

