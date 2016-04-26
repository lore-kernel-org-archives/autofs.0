From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Tue, 26 Apr 2016 17:53:53 +0800
Message-ID: <1461664433.3218.42.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net> <1460110224.2979.35.camel@themaw.net>
	 <20160408122552.GW15153@bccms.uni-bremen.de>
	 <20160408142907.GX15153@bccms.uni-bremen.de>
	 <1460166126.3073.20.camel@themaw.net>
	 <20160409095659.GB15153@bccms.uni-bremen.de>
	 <1461559248.3012.24.camel@themaw.net>
	 <20160425150638.GC30271@bccms.uni-bremen.de>
	 <1461632818.3218.29.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=AYObG8y6cwLmq0sxxMYxamsSXOk=; b=ieX+rk
	3hd5ijan05cy9s+SWqo2puNwQmfNveZ6Y5K3UnvmGzqdNNuQBusBkO4hd/EesNtd
	zNg5EMQG1+ZVCk0tRS2LLfSWljJLHYExTnkMAXFKd+Pzb4GZodenuvFeoMJFRfZh
	kUiduA9CXMj+uXmpEnAcdMgRgS5RwL4Wuhmbs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=AYObG8y6cwLmq0s
	xxMYxamsSXOk=; b=mEu+F5Y56KGtEFWXju9gPB4xfWY9m34kb58awRv2wMEtecS
	p9GEvN0y671K5fTeXyhwqH/3CXYXFLd0zIulnme6s5A/nFafbT76+TiPZke3P9oh
	wulzyBTXFWhdgIwYYf2PaBEdzWuURfy4pu+PuBu0pbtRW+Aud93RwWRDJxOI=
In-Reply-To: <1461632818.3218.29.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Tue, 2016-04-26 at 09:06 +0800, Ian Kent wrote:
> > So re-building and testing autofs on 16.04 with IPv6 could still be
> > useful assuming the segfault is a separable problem (which might not
> > be
> > the case of course) ?
> 
> That most likely will function ok from what I saw.
> 
> Even more surprising is the proximity and availability probe code uses
> the same client creation as the code that has the problem and it seems
> to work ....
> 
> Anyway I can cleanup what I have and send over what's needed to build
> the debs when your ready.
> 
> > 
> > 
> > I can also offer to try to do it with debian testing in a vm. If it
> > also
> > segfaults I could file a bug report hoping to get the maintainer
> > interested, especially if there are no problems with fedora. Shall I
> > try
> > that ? Instead or in addition to the test with IPv6 mentioned above
> > ?
> 
> Not sure how to go about this.
> I think a couple of changes are needed but fiddling with LDFLAGS
> presence and position as I did might not be in line with what the
> Debian
> folks want.
> 
> I suggest we just go along and see what we come up with.

I spent a little more time on this.

I used a smallish sledge hammer approach, building an updated libtirpc
and building dependencies I'm aware of against it, nfs-common and
rpcbind as well as autofs 5.1.1.

I just went straight to libtirpc 1.0.1.

The resulting autofs package didn't show the problem I saw with the
internal hosts map.

So I'd have to say this looks like a library version problem after all.

It seems to me that spending some time to work out how to provide a
lanchpad ppa is probably the best way to get you to a position to test
the IPv6 functionality.

That also means that in time there could be a 14.04 build too, not sure
about that though.

I can't spend more time on this for a little while so I'll need some
time to work out how to do the ppa thing, if in fact I can.

I guess the other thing to worry about is if doing this will annoy the
official downstream maintainer ... maybe we should attempt to make
contact some time.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
