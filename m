From: Ian Kent <raven@themaw.net>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Thu, 23 Feb 2012 14:29:18 +0800
Message-ID: <1329978558.25314.0.camel@perseus.themaw.net>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
	 <20120221.221609.218135609185671883.davem@davemloft.net>
	 <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
	 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
	 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
	 <1329889428.2193.45.camel@perseus.themaw.net>
	 <1329890027.2193.48.camel@perseus.themaw.net>
	 <1329890251.2193.50.camel@perseus.themaw.net>
	 <1329903139.2193.66.camel@perseus.themaw.net>
	 <CA+55aFwkYkSC1O=fWtj1CBAeKDP-ogEL4Mai8U-dd2uCMArppw@mail.gmail.com>
	 <1329961703.2244.8.camel@perseus.themaw.net>
	 <1329962085.2244.10.camel@perseus.themaw.net>
	 <1329963683.2244.19.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=gtO3OhNSIjkLlQX9INDHKVfp+38=; b=tgPIwiOLqUd4XIhaJrBwqC4xrwT1
	J6GqW1V/QYlEVq35SQPKEdABZmcWm9umxKzMzkjYxk19Eem4Z9BalIlQxTXESwtY
	bmNkjoN6F7qVlV/+x1/eDfB4QCZqwOPs2EOk7qK4Tjcm9hDxmsHU9kGefGYrLDle
	64H7E8xvjJcBuc8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=gtO3OhNSIjkLlQX9INDHKVfp+38=; b=kGt
	qgwyDuShnDF3SwdnFueaYFiMQ6Ya+cyjuvrQOrR2dTMKeGtvP0noagDD3z7KZuHl
	HBQvmhFBBR2dRx9m7pFKnOSruLSvEZFNxAf7L8nHfJrqB7nxn5aabCowSROx6ILm
	AXr9g5OByrwuNMDTUbvBJI2/+8s6VgxV35NHA4WE=
In-Reply-To: <1329963683.2244.19.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Meyer <thomas@m3y3r.de>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>

On Thu, 2012-02-23 at 10:21 +0800, Ian Kent wrote:
> On Thu, 2012-02-23 at 09:54 +0800, Ian Kent wrote:
> > On Thu, 2012-02-23 at 09:48 +0800, Ian Kent wrote:
> > > On Wed, 2012-02-22 at 08:12 -0800, Linus Torvalds wrote:
> > > > On Wed, Feb 22, 2012 at 1:32 AM, Ian Kent <raven@themaw.net> wrote:
> > > > >
> > > > > Oh, DOH ...
> > > > >
> > > > > The process mounting the autofs mount is passing the pipe it will use
> > > > > for communication via a mount option so we can do this right in
> > > > > fill_super.
> > > > 
> > > > No, we really cannot.
> > > 
> > > Sorry, I think your wrong this time.
> > 
> > On second thought, I suppose other user space users don't "have" to use
> > mount(2) ....
> 
> Thomas, what does systemd use to mount the autofs mounts that it uses?

Mmm ... AFAICS systemd uses mount(2) so that looks OK too.

Ian
