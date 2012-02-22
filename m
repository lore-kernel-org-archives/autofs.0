From: Ian Kent <raven@themaw.net>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Wed, 22 Feb 2012 12:20:10 +0800
Message-ID: <1329884410.2193.29.camel@perseus.themaw.net>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
	 <20120221.221609.218135609185671883.davem@davemloft.net>
	 <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
	 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=wilAoddkqn4mXpBIg4UV5eRrlss=; b=oh6yD72jGjb5ZGooGX+rhY/bFbn6
	EC1EyvflQ/miqtD+mKOYloHpbeEyzKhoczQLgqewRn1B4MJNv8pJiOb+qJy1srBb
	opA9H8oAkVlDXfJVLz/UjZ70ApisdgV3lBaZL8sluElMpkkKVSOH5Pb2aLNFA5ra
	zSIyO9twpCdXQK4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=wilAoddkqn4mXpBIg4UV5eRrlss=; b=Wek
	AfA7xS344VvlHpKkpQLROKqca3sBVQHYW2y6w5KJjA8KWELfrv6OfJEZ2iLgkBDB
	8qSAoyq+4+3HI5hnii/6CFN6pZXO//7OJG/X6Or8XqMgQWfYN47AhiQwTrl+p4u7
	cbomSJPqmJvFm51+vzGyQGZLuzEiVjb9KgvQiNbs=
In-Reply-To: <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, hpa@zytor.com, autofs@linux.kernel.org, thomas@m3y3r.de, viro@zeniv.linux.org.uk

On Tue, 2012-02-21 at 19:47 -0800, Linus Torvalds wrote:
> On Tue, Feb 21, 2012 at 7:33 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But I'm sure that the autofs daemon does something simple that we can
> > depend on in practice.
> 
> I didn't find the most recent source code, but the first thing that
> automount.c does after calling "mount" (which is a for+exec, so we
> cannot take the mounting is_compat_task() into account is to open the
> new root for the ioctlfd, and then it does a stat.
> 
> And then it does a AUTOFS_IOC_PROTOVER ioctl to see what the protocol
> version is.
> 
> So we could just decide that
> 
>  (a) we add a mount option for the packet size (or just "v6" - which
> would be "v5 with a fixed packet size")
> 
>  (b) in the absence of an explicit mount option, we look at
> is_compat_task() for the first AUTOFS_IOC_PROTOVER ioctl we get.
> 
> That looks fairly straightforward and safe. Hmm?
> 
> Where are the automount sources supposed to be, anyway? kernel.org has
> a v5 directory, but it's empty.

I'm repopulating the autofs directory with content right now.
I had some difficulty with getting appropriate signatures for my PGP
key, consequently my account wasn't activated for quite. The upshot of
that is I wasn't aware of announcements about kup either. Anyway, I've
sorted that out and I'm trying to upload the content right now. 

The git repo has been available for a while now though @
/pub/scm/linux/kernel/git/raven/autofs

at least that is the place I thought it should go?
Ian

