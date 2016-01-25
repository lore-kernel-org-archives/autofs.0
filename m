From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs: show pipe inode in mount options
Date: Mon, 25 Jan 2016 15:48:34 -0800
Message-ID: <20160125154834.3afe2ede52d0342b61120943@linux-foundation.org>
References: <20151216120222.19097.54512.stgit@localhost.localdomain>
	<568E8840.3010801@odin.com>
	<1452237640.2973.19.camel@themaw.net>
	<568F9D85.6070601@odin.com>
	<1452257913.7030.25.camel@themaw.net>
	<568FD028.5090207@odin.com>
	<1452303110.3067.29.camel@themaw.net>
	<5693931F.9070101@odin.com>
	<56A213CA.5090704@odin.com>
	<1453509017.3042.7.camel@themaw.net>
	<20160126101907.388686e7@canb.auug.org.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20160126101907.388686e7@canb.auug.org.au>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ian Kent <raven@themaw.net>, skinsbursky@virtuozzo.com, criu@openvz.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>

On Tue, 26 Jan 2016 10:19:07 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Ian,
> 
> On Sat, 23 Jan 2016 08:30:17 +0800 Ian Kent <raven@themaw.net> wrote:
> >
> > I haven't had anything significant enough for autofs to warrant
> > maintaining a tree and sending push requests so I'll need to ask
> > Stephen what I need to do (perhaps you could offer some advise on that
> > now Stephen, please).
> 
> I guess if its just a few patches every now and then, then Andrew
> Morton may be the best person to shepherd them upstream.

yup, send 'em along.

I actually was handling the autofs4 stuff back in 2014 for a bit.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
