From: Ian Kent <raven@themaw.net>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Thu, 23 Feb 2012 10:32:02 +0800
Message-ID: <1329964322.2244.22.camel@perseus.themaw.net>
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
	 <CA+55aFzRQJ8YeZGnbq=OO0YgzkfrcS4r+G1cJbjtDCZe=t6DNQ@mail.gmail.com>
	 <1329962955.2244.16.camel@perseus.themaw.net>
	 <CA+55aFyRFGrT6uSSCQoX0pZPZ7j2p4oqX-dcfsFUZt4q81qMrg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=AbpJssw590g3UaNiZOHJkD8Imh4=; b=PAh9zG/XK6rqfYOQWjNIqbcJ6QN1
	g6NOLegellucoxafA36zBacfZTAWKgUN2FHq8qz6HijZvaRKPCCeS10QuuGY6ULT
	hhmHYV6352p0TPZb36av8FbYQRY/BFgfV6QVo7m+PcvaLKJT1FQGVFvziFodaarM
	e7tw6oBhxy7qLx0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=AbpJssw590g3UaNiZOHJkD8Imh4=; b=Mjf
	L09osoVWEPp8bseyELYHrvwyy2yK2jzX5jdQyf8+q+El2sF5fDp3qpMPt425X3Ab
	lDA5+7gdEtr2zD9tXxu1mh9xbXnJytg7EK2MsC77o0JfSPtdIkBLg22U/DuOvL4A
	pWSNlbKZq9pqLkghI7Do7irE9CSJkPKaTxhC9i9o=
In-Reply-To: <CA+55aFyRFGrT6uSSCQoX0pZPZ7j2p4oqX-dcfsFUZt4q81qMrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, 2012-02-22 at 18:25 -0800, Linus Torvalds wrote:
> On Wed, Feb 22, 2012 at 6:09 PM, Ian Kent <raven@themaw.net> wrote:
> >
> > Sure, that's true, and you'll see it uses the mount option maxproto with
> > the value of AUTOFS_MAX_PROTO_VERSION. But autofs uses it's own copy of
> > the headers so AUTOFS_MAX_PROTO_VERSION is 4 not 5 so it won't be
> > affected by this change.
> 
> Ok.
> 
> I fetched your git tree, and it seems this changed to use mount()
> directly in commit a74f68c99d9f ("integrated master map parsing into
> daemon") back in 2006.
> 
> Which seems to be part of autofs_5_0_0_beta1, so I guess we're safe. I
> hope no distro ever used any early pre-beta versions of autofs that
> had the new packet support but still used the external 'mount'
> command.

If there are they have bigger automount problem than the kernel packet
size, ;)

It really didn't become usable until at least the rc releases and the
actual first non-test release was 5.0.1, we never had a 5.0.0.

Ian

