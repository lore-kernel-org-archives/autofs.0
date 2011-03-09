From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS creates unmountable directories when ghosting
 is enabled
Date: Wed, 09 Mar 2011 12:21:01 +0800
Message-ID: <1299644461.3037.16.camel@perseus>
References: <20101210191042.GA4396@libre.l.ngdn.org>
	<1292381344.2979.6.camel@perseus>
	<AANLkTikY+xO2voYOQqFR6qUyKusLBbknNLGLda6nHVbY@mail.gmail.com>
	<1299644155.3037.15.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=pRxgk5cgnaiGk3ehm8IYMTY61/U=;
	b=e2vFYF8VJMVdd/Mx+8dy5mnXyY+uxlAkj9A1HvHTPeVmgpNYVLSHLWfMF3fxTrJKuON09X8zjOgzyWxWfU5QEWIwgNZewMrB4XaPdhj2iFnU4H7zyoTZG8uQiHaRlYq7wMFTnJjz+PYbypEM5XL7rLqVZXJW+RBVHeFbMj2Me3U=
In-Reply-To: <1299644155.3037.15.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

On Wed, 2011-03-09 at 12:15 +0800, Ian Kent wrote:
> > 
> > Hello Ian,
> > 
> > I bisected this problem today and discovered that it appeared after the
> > following commit:
> > 
> > commit 08aafab4c1d0ab6227c80f8cd1086ae78556a370
> > Author: Ian Kent <raven@themaw.net>
> > Date:   Thu Sep 9 11:10:47 2010 +0800
> > 
> >     autofs-5.0.5 - fix direct map not updating on reread
> > 
> >     If the map type is explicitly specified for a map the map isn't
> >     properly updated when a re-read is requested. This is because
> >     the map stale flag is incorrectly cleared after after the lookup
> >     module reads the map instead of at the completion of the update
> >     procedure. The map stale flag should only be cleared if the map
> >     read fails for some reason, otherwise it is updated when the
> >     refresh is completed.
> > 
> > Does this ring a bell? If not, I'll see if I can debug it further tomorrow.
> 
> Not really.
> I'm still not sure your original patch deals with the problem fully.
> 
> Could you also have a look at and try (from kernel.org):
> autofs-5.0.5-fix-prune-cache-valid-check.patch

Although, looking again, maybe we need both patches.

> 
> Ian
> 
