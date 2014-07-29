From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/6] autofs4: allow RCU-walk to walk through autofs4.
Date: Tue, 29 Jul 2014 14:37:59 +0800
Message-ID: <1406615879.2776.19.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <20140709234114.4525.46882.stgit@notabene.brown>
	 <1405485857.2527.38.camel@perseus.fritz.box>
	 <20140716155150.044c2ea3@notabene.brown>
	 <1405493777.2527.72.camel@perseus.fritz.box>
	 <1405573256.3002.25.camel@perseus.fritz.box>
	 <20140717180414.2e2596d1@notabene.brown>
	 <1405592252.20621.63.camel@perseus.fritz.box>
	 <20140729115101.0805ecd8@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=ntnrehC8JBmlPFoFP2/A6iW8gI8=; b=HRu6J/Q92PHQ+UyE4kXLj9YJs0SP
	Zqwpl8bWGoY/YnmupvY0imtq6EshMkvHu/R38f9GOabP8mGqr8a75ijCIIPrJ6c/
	fuYV2BIrbZNBKiFNkND87p4RvsZdzk+urik78/Ukqve3nPEeBLVEpggg3a/OI0Ki
	xNMHRpdeUtZbOZ4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=ntnrehC8JBmlPFoFP2/A6i
	W8gI8=; b=Zo2LpM75wxvOPmLMH8WEoC7DD+Rw1/rrI3mX7/cetcwsZ5LCpOe9Rt
	G/ewKF95a/9eTuKr6zY5+e3bl/DNjh2Ns9CbWZaHz0/x+M8AGw+deGpxiELmSOUl
	n8kM+XFGQxFTc4kG/DbJV3onR4KKO+OLux1yPt9Xoim4KY135q8sQ=
In-Reply-To: <20140729115101.0805ecd8@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2014-07-29 at 11:51 +1000, NeilBrown wrote:
> On Thu, 17 Jul 2014 18:17:32 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > 
> > On Thu, 2014-07-17 at 18:04 +1000, NeilBrown wrote:
> > > If there some documentation about the interactions between the automountd and
> > > the kernel?
> > 
> > Not really, only the ioctl interaction described in
> > Documentation/filesystems/autofs4-mount-control.txt
> > 
> > > It looks like:
> > >  With V5, every name in the root directory gets something mounted on it,
> > >       either another autofs or the target filesystem.
> > >  With V4, you don't mount an autofs onto an autofs, but when a name in the
> > >       root is automounted, all the names beneath there are created and the
> > >       target filesystems are mounted before the top level automount is
> > >       acknowledged.
> > > 
> > > Does that sound at all right (I suspect I haven't explained it very clearly).
> > 
> > Mostly, but let me try and simplify it (or perhaps confuse you even more
> > and bore you as a bonus, ;)) and offer a broader picture.
> 
> Thanks for going into all that detail!  Having read that, and read the code
> (a few times) and having tried to document it myself I think I really
> understand it all now.

Glad you appreciated the effort.

> 
> I wanted to be sure I understood from the perspective of what the module
> actually supports rather than just how the automount daemon uses it, so I put
> together a document describing the module.  At 3000 words, I'm not sure
> whether to call it "verbose" or "thorough".  I'll post it separately.

Indeed, that's very sensible since it can easily be used by others.

I still way behind and I'm ill, in fact the whole family is ill (winter
here as you know), so I'll have a look at what you've put together soon
as I can.

FWICS you've put a lot of effort into writing it and I appreciate it
very much.

Once we're both happy with it do you think it should go somewhere in
Documents in the kernel tree or did you have somewhere else in mind?

> 
> I did discover one thing that is important for the RCU-walk work.
> If you have a "root-less multimount" then the top-level directory will have
> DCACHE_NEED_AUTOMOUNT set even though it is not a mount-trap.
> As it contains a sub-directory (or more), d_manage will return -EISDIR so
> normal REF-walking will side-step d_automount and it will be treated as a
> normal directory.
> However in RCU-walk mode, d_manage cannot usefully return -EISDIR so the VFS
> will always drop into REF-walk mode, which negates some of the value of my
> RCU-walk patches.

Yes, think we discussed that before.

> 
> I see two ways to fix this:
>  1- clear DCACHE_NEED_AUTOMOUNT when creating a subdir or symlink, just like
>     we do with protocol-version 4
>  2- teach the VFS to accept -EISDIR from d_manage and to ignore
>     DCACHE_NEED_AUTOMOUNT in that case.  I have a patch to do this and it is
>     fairly straight forward.
> 
> I think I prefer 2 (it seems easier to document:-) but thought I'd ask if you
> have an opinion before I post it (I haven't even tested it properly yet).

I definitely prefer option 2 also.

Trying to juggle the flag adds at least one seriously ugly test in the
expire code and the path walk code and likely eliminates the ability to
use the optimization of not calling ->d_automount() for these.

Keep in mind that there's also the multiple namespace problem I
mentioned before.

d_mountpoint() says, "is this dentry mounted (in any namespace)" which
is clearly unreliable.

Since autofs path walks were always done in ref-walk mode I haven't
looked at how this would be done in rcu-walk mode but in ref-walk mode I
believe the only solution is to use lookup_mnt() and that won't work in
rcu-walk and would require kicking the process back to ref-walk mode.

Ian

