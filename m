From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/6] autofs4: support RCU-walk
Date: Wed, 16 Jul 2014 11:24:58 +0800
Message-ID: <1405481098.2527.9.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=Bk/ufepKrzCEPLNHfpIVb+qUeRk=; b=XTItd0Z0OC/XjYVbKSC3qKFtZhkL
	2etiVX+JuW+1lK9mLJeEBS47oRjEt1jBKBPHeMVAgpnu7F1nd+w1c9ym2VOaA5F5
	vzgWX/vMJTQ/z8DfGBxB4gus7zSunbQ46g3c1a2iJLaOVzUe3iLe4TbyUcI/9lJ8
	of6LJWKS8tSitPo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Bk/ufepKrzCEPLNHfpIVb+
	qUeRk=; b=StgEvPlBjOX339K6t8u+Lc5zeeWzY6kHt0sz7stZ47Bza3GJ7L3atG
	dp0TeCyqxXuRPLa7gWacZzPwXID8FPkSfB16hMAiDa9hdEWBQqop/KnCDVm/DtFC
	xrm5hfr7SGxcZSQPoZCHN0QzglpMaMRTpk+n9Gi7sdRb+nm8NyCOs=
In-Reply-To: <20140709233541.4525.25151.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-07-10 at 09:41 +1000, NeilBrown wrote:
> autofs4 currently doesn't support RCU-walk - it immediately
> aborts any attempt at RCU-walk to force REF-walk for path name
> lookup.

As discussed I don't have time to properly test these just now but I'll
do my best to review the patches and return to test them later.

My impression is that you will be submitting these patches rather than
expecting me to pick them up and submit them. If that's not what your
expecting please let me know.

I appreciate you including me in this work, all to often things get
merged that I'm miss and while I may not have identified any problem
with them at the time at least I would be aware of what I might need to
look at when problems arise.
 
> 
> This can cause a significant performance impact on multi-core
> systems.
> I have a client with a test case which spends >80% of its time
> waiting for spinlocks with a "make -j 40" on a 40 core system.
> 
> This patchset aims to remove most of these spinlocks.  To be fully
> effective in the particular case it needs a second patch set which
> makes NFS RCU-walk friendly, but one thing at a time.
> 
> This has only been lightly tested so far so I'm really after feed-back
> rather than to have the patch set accepted, though the first two
> patches are trivial and could be taken immediately.
> 
> The last two patches are the most interesting so review comments on
> those are particularly welcome.
> 
> Thanks,
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (6):
>       autofs4: remove unused autofs4_ispending()
>       autofs4: remove a redundant assignment
>       autofs4: allow RCU-walk to walk through autofs4.
>       autofs4: factor should_expire() out of autofs4_expire_indirect.
>       autofs4: avoid taking fs_lock during rcu-walk
>       autofs4: don't take spinlock when not needed in autofs4_lookup_expiring
> 
> 
>  fs/autofs4/autofs_i.h  |   20 +----
>  fs/autofs4/dev-ioctl.c |    2 -
>  fs/autofs4/expire.c    |  192 +++++++++++++++++++++++++++++-------------------
>  fs/autofs4/root.c      |   46 ++++++++----
>  4 files changed, 151 insertions(+), 109 deletions(-)
> 

