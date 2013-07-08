From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH 7/7] autofs - change CONFIG_AUTOFS4_FS to
 CONFIG_AUTOFS_FS
Date: Mon, 08 Jul 2013 17:11:00 +0800
Message-ID: <1373274660.2278.26.camel@perseus.fritz.box>
References: <20130701031335.4423.6154.stgit@perseus.fritz.box>
	 <20130701031449.4423.58614.stgit@perseus.fritz.box>
	 <20130701143924.79f57e7206577a2e7777c0a2@canb.auug.org.au>
	 <1373017884.2497.10.camel@perseus.fritz.box>
	 <20130708151023.f29446059a3161fc2e8c9b2d@canb.auug.org.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=/b/JiwNyIZo7CkrI8RQpE7RRYsg=; b=MvuWh4OmqMZb40YDB7CGknWsVHqM
	g7UZz6vTddVoPO9gpmRGuR8d3H5D7dXYXRfS1l4xONPaiMMbEioEV9XAfUkUrbxV
	GgTyiujgKtC0UjHBJoqZpxjeLvtmz4bvx9xEgM0GTcWvOW3bjgYf6k4ctVS/ezM3
	iLLqUmqd6pKIqnE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=/b/JiwNyIZo7CkrI8RQpE7
	RRYsg=; b=EBLLpjo7/4Dd1GWo4i3FIXsackgeVeWkocmYv/Xcs4G7p0UQYOZcdq
	m9avUOgnYwxXghLPe1Sk9BcxTzqZ+SuD+SzRMkQssqi+gYHNO2/SL4Yy3lj6NI8S
	G95Aphti/9kQZgVBPjmwia2jIRs9msthdwBI/Ncnd29CwHTgL/UNU=
In-Reply-To: <20130708151023.f29446059a3161fc2e8c9b2d@canb.auug.org.au>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2013-07-08 at 15:10 +1000, Stephen Rothwell wrote:
> Hi Ian,
> 
> On Fri, 05 Jul 2013 17:51:24 +0800 Ian Kent <raven@themaw.net> wrote:
> >
> > On Mon, 2013-07-01 at 14:39 +1000, Stephen Rothwell wrote:
> > > 
> > > On Mon, 01 Jul 2013 11:14:51 +0800 Ian Kent <raven@themaw.net> wrote:
> > > >
> > > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > 
> > > Please don't do this.  Find a simple way to make sure that if
> > > CONFIG_AUTOFS4_FS is set, then "make oldconfig"  (or equivalent) will
> > > cause CONFIG_AUTOFS_FS to be set the same.
> > 
> > I get what your recommending but still can't think of a way to do it,
> > any thoughts?
> 
> Isn't just having
> 
> config AUTOFS4_FS
> 	tristate
> 	select AUTOFS_FS

I though that would set AUTOFS_FS=y unconditionally which I think is not
necessarily the setting that is needed. Also, I believe there's no way
to set it based on AUTOFS4_FS after it's value has been set from the
menu.
 
Ian


