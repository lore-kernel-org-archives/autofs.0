From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/6] autofs4: support RCU-walk
Date: Fri, 11 Jul 2014 10:49:52 +0800
Message-ID: <1405046992.2574.10.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <1404978220.2609.25.camel@perseus.fritz.box>
	 <20140710182519.79120b90@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=7JQ1M99wrjAibcFrOE3xvdlcwyw=; b=iINWTN+P8DCPpNNii7CKat6rCrgW
	nzBEQEqymlqlc5+NrnMD8JxO6V0Sn5MqnbKhLOjl6h+2BpXuI822dEWIeaKfT96X
	oTQernBjpd6mjYEh0k7w1VxOgQS7N6ZFIktV65WbOSeuWjI2cys9IdlRCopY1HNY
	vvq6yuHlLBxdtiw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=7JQ1M99wrjAibcFrOE3xvd
	lcwyw=; b=RpGetqD/Aij/iYPK5bDbuvxOCHYA1C5G8Z557wMLLt60aHulqYlGu0
	hqgyd3VgMjpbVLwGP/LTSA+XpOBzXO+MsK+ZwTzhkXvl3VTIW4y7qLukpx5nSzcI
	TuAarNvcmAYI/SfP7rPl2k5+VbiCC8K0EKsYErnSoGMnf7e8/POZQ=
In-Reply-To: <20140710182519.79120b90@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-07-10 at 18:25 +1000, NeilBrown wrote:
> On Thu, 10 Jul 2014 15:43:40 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > On Thu, 2014-07-10 at 09:41 +1000, NeilBrown wrote:
> > > autofs4 currently doesn't support RCU-walk - it immediately
> > > aborts any attempt at RCU-walk to force REF-walk for path name
> > > lookup.
> > > 
> > > This can cause a significant performance impact on multi-core
> > > systems.
> > > I have a client with a test case which spends >80% of its time
> > > waiting for spinlocks with a "make -j 40" on a 40 core system.
> > 
> > Right, sounds worth the effort.
> > 
> > > 
> > > This patchset aims to remove most of these spinlocks.  To be fully
> > > effective in the particular case it needs a second patch set which
> > > makes NFS RCU-walk friendly, but one thing at a time.
> > > 
> > > This has only been lightly tested so far so I'm really after feed-back
> > > rather than to have the patch set accepted, though the first two
> > > patches are trivial and could be taken immediately.
> > 
> > I've only scanned the patches so far, I'll need to spend a bit more time
> > on them before I can comment.
> > 
> > I'm going to be pressed for time for at least several days so I won't be
> > able to get to this right away.
> > 
> > I expect the submount_test I use to stress path walking and expire to
> > mount transitions will likely be a good test to use. I haven't used it
> > in my personal environment for quite a while now so I'll need to have a
> > look around and see if I can still find a suitable set of scripts.
> > Otherwise I'll need to decouple it from the RedHat automated test
> > environment.
> > 
> > > 
> > > The last two patches are the most interesting so review comments on
> > > those are particularly welcome.
> > 
> > Again I haven't looked closely at these but don't you mean the last
> > three patches or am I just fussing over an obviously straight forward
> > patch 3?
> 
> Exactly right - that thirds last patch was "obviously straight forward", so
> is naturally the one that I have already found a bug in (the patch assumes
> that autofs4_check_leaves returns a different dentry, which clearly isn't
> true).

Ha, IIRC that was to support the old pseudo direct mounts that would
expire the leaves of a tree independently. That was a long time ago now
and probably isn't used but it should remain think.

I'll need to have a look at that too, to refresh my memory.

> 
> I'll repost it, probably on Monday.
> 
> > 
> > Thanks for your effort Bruce,
> > Ian
> > 
> 
>     http://www.youtube.com/watch?v=_f_p0CgPeyA
> 
> (Usually when people get my name wrong they call me "Ian", so you calling me
> Bruce is both slightly ironic and quite refreshing!)

LOL, but I have a lame excuse!
I was thinking Bruce Fields when replying since have the impression you
both work in similar areas.

Ian

