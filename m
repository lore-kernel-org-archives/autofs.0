From: Ian Kent <raven@themaw.net>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Thu, 23 Feb 2012 19:26:56 +0800
Message-ID: <1329996416.25314.12.camel@perseus.themaw.net>
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
	 <1329978558.25314.0.camel@perseus.themaw.net>
	 <2b90acba-a8e9-485a-b2a6-608d61751f2c@email.android.com>
	 <1329996024.25314.10.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=3jbk0aZ9RIAZQ3E1CK2fKMnL0JI=; b=Yj73p1yIUru5F+ivbk4ZJZcZ70vG
	zekq9CuK/ojhdXjtnuTUO114pvQImnF8EHEWOke8jUhZS3UDxAf+bbz85d8sa4Fr
	pF6RsHRKFiq6yIqrFGKmqEVlMgnyugnItyAyY7QBsnM9DvESgwJKZ4ZmMLeu7gtX
	Ivl2YPlMTU66cx0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=3jbk0aZ9RIAZQ3E1CK2fKMnL0JI=; b=gxy
	QOA0ht8mh9zRHdOWMJtR3jPWJax0UFf3k47WrciMr4+1rUFH0JJmQ0AphtkVkm9/
	L/N1hp+sGQYfsaBU8bOtja3nabj4qO/bdRoUVBsnziNX593XRiiQlwrW5wr33oxT
	W85IssGfyrDNVPuwML+wBRDFu7Z8ygEx//FpyevQ=
In-Reply-To: <1329996024.25314.10.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Meyer <thomas@m3y3r.de>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>

On Thu, 2012-02-23 at 19:20 +0800, Ian Kent wrote:
> On Wed, 2012-02-22 at 22:31 -0800, H. Peter Anvin wrote:
> > However, I liked Linus' approach.of using the version ioctl; any reason not to?
> 
> Not really, although that ioctl is used it doesn't have to be but you
> must mount the autofs file system to use it. Setting a timeout is
> another ioctl that is almost mandatory although not using it amounts to
> saying you don't want anything to expire which is valid.

The open, to get an ioctl is another that pretty much must be done to
use the mount.

> 
> > 
> > Ian Kent <raven@themaw.net> wrote:
> > 
> > >On Thu, 2012-02-23 at 10:21 +0800, Ian Kent wrote:
> > >> On Thu, 2012-02-23 at 09:54 +0800, Ian Kent wrote:
> > >> > On Thu, 2012-02-23 at 09:48 +0800, Ian Kent wrote:
> > >> > > On Wed, 2012-02-22 at 08:12 -0800, Linus Torvalds wrote:
> > >> > > > On Wed, Feb 22, 2012 at 1:32 AM, Ian Kent <raven@themaw.net>
> > >wrote:
> > >> > > > >
> > >> > > > > Oh, DOH ...
> > >> > > > >
> > >> > > > > The process mounting the autofs mount is passing the pipe it
> > >will use
> > >> > > > > for communication via a mount option so we can do this right
> > >in
> > >> > > > > fill_super.
> > >> > > > 
> > >> > > > No, we really cannot.
> > >> > > 
> > >> > > Sorry, I think your wrong this time.
> > >> > 
> > >> > On second thought, I suppose other user space users don't "have" to
> > >use
> > >> > mount(2) ....
> > >> 
> > >> Thomas, what does systemd use to mount the autofs mounts that it
> > >uses?
> > >
> > >Mmm ... AFAICS systemd uses mount(2) so that looks OK too.
> > >
> > >Ian
> > 
> 

