From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH linux-next] autofs4: autofs4_catatonic_mode(): remove
 redundant null check on kfree()
Date: Wed, 13 Feb 2013 15:37:46 +0800
Message-ID: <1360741066.2288.7.camel@perseus.themaw.net>
References: <1360689138-59191-1-git-send-email-tim.gardner@canonical.com>
	 <1360740008.2288.3.camel@perseus.themaw.net>
	 <511B3F5B.4050803@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=bP+6Os4IXfNGGh0DjTMnN4DS6zQ=; b=UUkKjuU419NwGDDKhlB+SQJCPalO
	QpmAuay+Q0Phlps7gQS3Hiubt1dlO4QEehgzWSCFfSORPmEmMEUzzZ0rld9h9fWX
	NANREtb1h8nZLjFOlOhyhzYlPTnXud6/MrgpYfzNJRJd4jVQlySMGRTG7st4IXkD
	Uw1t66DIuoSex2A=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=bP+6Os4IXfNGGh0DjTMnN4DS6zQ=; b=hLf
	zbD+RIrMN4ACb6ZsRujhP7nyb4wsP6CFqWENQwMUQG7FGSwbum4xVKFMTlaE1PqS
	pZwSZF01GxaDrflmyuH7+fXqib1cmiUVG70Zsv37z7jEeABvO9hCWLF94eyDtQZI
	eNp1Y64ZdF0uGFwU700zmXdiQh0odlddoBG0U1bk=
In-Reply-To: <511B3F5B.4050803@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Tim Gardner <tim.gardner@canonical.com>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org

On Wed, 2013-02-13 at 11:23 +0400, Michael Tokarev wrote:
> 13.02.2013 11:20, Ian Kent wrote:
> > On Tue, 2013-02-12 at 10:12 -0700, Tim Gardner wrote:
> >> smatch analysis:
> >>
> >> fs/autofs4/waitq.c:46 autofs4_catatonic_mode() info: redundant null
> >>   check on wq->name.name calling kfree()
> >
> > I'm not sure about this change.
> >
> > autofs4_catatonic_mode() could be called when there are remaining
> > entries in the wait queue, which is nulled, so autofs4_wait_release()
> > won't see the the discarded waits if it is called.
> 
> Ian, this is about something else really.  The patch is about the
> NULL check before calling kfree() -- it does the NULL check internally.
> It is nothing about code flow or anything else, it is about calling
> kfree() unconditionally regardless whenever the argument is actually
> NULL or non-NULL.  It makes the code shorter and easier to read.

Oh, right, kfree() does the a NULL check since a long time now.
My bad, sorry.

> 
> You can add my
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

So, you would like me to forward this to Linus?

I'd be inclined to wait until the window for 3.9 opens since Linus
probably has more than enough to do finalizing 3.8 right now.

Ian

