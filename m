From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] Lockdep splat in autofs with 2.6.39-rc2
Date: Mon, 25 Jul 2011 10:46:51 +0800
Message-ID: <1311562011.3401.13.camel@perseus.themaw.net>
References: <20110407194403.GA29404@elliptictech.com>
	 <20110421212537.GC24898@home.goodmis.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:from:to:cc:in-reply-to:references
	:content-type:date:message-id:mime-version
	:content-transfer-encoding; s=smtpout; bh=ZKbhtfz2jKqfKV6QRNTHV3
	GiRVw=; b=mFCii1z387EWFqA8AFTdOvWSUsUqrmKFaPrah4QcL5iRnw6hJZVuuB
	EkxOGSSYV8z7XflFvGTG+fpApuuyAlugaZO/kU8695S03nxsDi+0GM5i/a7066Re
	s52QZS86yKUvw+NHpoMVjPKiQwULYoco+ITennEMIi/o5+3L18TIQ=
In-Reply-To: <20110421212537.GC24898@home.goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: autofs@linux.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Thu, 2011-04-21 at 17:25 -0400, Steven Rostedt wrote:
> On Thu, Apr 07, 2011 at 03:44:03PM -0400, Nick Bowler wrote:
> > Just saw this on 2.6.39-rc2 after half a day or so of uptime.  I've
> > never seen it before today so it may be a regression from 2.6.38.
> > Nothing seems have failed as a result.  Please let me know if you
> > need any more info.
> >
> 
> Could you try this patch. I know it may be hard to reproduce, but the
> issue is that we are recursing down the locks in a tree/list and we changed a
> lock from being nested to being a parent. This patch tells lockdep about
> what we did.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Hi Steven,

It appears this is not included in current mainline yet so I'm guessing
it is still a problem.

Is this the correct way to handle the problem?
Do you want me to forward the patch to Al Viro for inclusion in his tree
and subsequent inclusion in mainline or would you like to do that?

Ian

> 
> 
> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> index 450f529..1feb68e 100644
> --- a/fs/autofs4/expire.c
> +++ b/fs/autofs4/expire.c
> @@ -124,6 +124,7 @@ start:
>  	/* Negative dentry - try next */
>  	if (!simple_positive(q)) {
>  		spin_unlock(&p->d_lock);
> +		lock_set_subclass(&q->d_lock.dep_map, 0, _RET_IP_);
>  		p = q;
>  		goto again;
>  	}
> @@ -186,6 +187,7 @@ again:
>  	/* Negative dentry - try next */
>  	if (!simple_positive(ret)) {
>  		spin_unlock(&p->d_lock);
> +		lock_set_subclass(&ret->d_lock.dep_map, 0, _RET_IP_);
>  		p = ret;
>  		goto again;
>  	}
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

