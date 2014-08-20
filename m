From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] RCU-walk support for autofs
Date: Wed, 20 Aug 2014 11:42:47 +0800
Message-ID: <1408506167.11028.32.camel@perseus.themaw.net>
References: <20140818062844.9860.43007.stgit@notabene.brown>
	 <1408350340.2533.3.camel@perseus.fritz.box>
	 <1408442547.11314.9.camel@perseus.themaw.net>
	 <20140819211654.5ec3853a@notabene.brown>
	 <1408451815.11314.15.camel@perseus.themaw.net>
	 <20140820131352.2aad3ca5@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=s3A/73qiycRyRsWD1Mp+4KgsC3U=; b=WYa21ItjHNxmPsWlr1E6/JQntZOH
	B+56Jzqc7Alz4UGyfndqv3tijtiFp7UQiHYd7q/oleZmRQUAJhak8WKp9GihoTax
	j77CsG7g6rca+wcN6Ooa8ZhLSKDk5q8YA9Fz/sOtSuuSJPLId4CgugyplhQJBYfQ
	fByo+8RLcNX07gQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=s3A/73qiycRyRsWD1Mp+4K
	gsC3U=; b=ufbPyFPMRykXsGoaFg7115/doNUof3W0SU6p1Nf+eICQOMw4g8DuW7
	ijPv7dQ8ArEimgMCSYcgfib3OZeiaZggTW2ELBou3MzbRawlAA9qQMURw1u1eF9U
	8KhdfYWiPwp2vBFikoyZvXGGLtDYP7k4eVyJWfTPyDKumqK9f63T0=
In-Reply-To: <20140820131352.2aad3ca5@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2014-08-20 at 13:13 +1000, NeilBrown wrote:
> On Tue, 19 Aug 2014 20:36:55 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > On Tue, 2014-08-19 at 21:16 +1000, NeilBrown wrote:
> > > On Tue, 19 Aug 2014 18:02:27 +0800 Ian Kent <raven@themaw.net> wrote:
> > > 
> > > > On Mon, 2014-08-18 at 16:25 +0800, Ian Kent wrote:
> > > > > On Mon, 2014-08-18 at 16:33 +1000, NeilBrown wrote:
> > > > > > Hi Ian,
> > > > > >  Have you had a chance to run your tests in these patches yet?
> > > > > >  I've done what testing I can think of and cannot fault them.
> > > > > 
> > > > > I haven't, I've been plagued with illness so I'm not getting nearly
> > > > > enough done. I'll try to put a kernel together and run the test in the
> > > > > next week or so.
> > > > 
> > > > Just to let you know that I managed to spend some time on this. I built
> > > > a kernel (3.17.0-rc1) with the series and ran a couple of tests.
> > > > 
> > > > I'm not certain that the patches I used are identical to your posting, I
> > > > saw one difference, after the fact, that shouldn't matter, I'll have to
> > > > check that.
> > > > 
> > > > It isn't possible to test expire to mount races because the mounts in
> > > > the tree never expire.
> > > > 
> > > > At first I thought it was because so many processes were accessing the
> > > > tree all the time but manually constructing the maps and mounting the
> > > > mounts shows that nothing ever expires, at least for this tree.
> > > > 
> > > > However, issuing a shut down does expire all the mounts and shuts down
> > > > autofs cleanly.
> > > > 
> > > > So there is something not quite right with the expire check or my
> > > > patches have mistakes.
> > > 
> > > Ahh.. I bet I know what it is.
> > > autofs4_can_expire() isn't idempotent.
> > > Because we call should_expire twice, autofs4_can_expire() is called twice and
> > > the second time it failed because  the first time it resets ->last_used.
> > > 
> > > diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> > > index eb4b770a4bf6..80133a9d9427 100644
> > > --- a/fs/autofs4/expire.c
> > > +++ b/fs/autofs4/expire.c
> > > @@ -26,6 +26,9 @@ static inline int autofs4_can_expire(struct dentry *dentry,
> > >  	if (ino == NULL)
> > >  		return 0;
> > >  
> > > +	if (ino->flags & AUTOFS_INF_NO_RCU)
> > > +		/* Already performed this test */
> > > +		return 1;
> > 
> > Wouldn't it be better to perform this check, or similar, further down
> > where the last_used time is updated? After all it's only updated to
> > prevent rapid fire expires on dentrys that refuse to umount for some
> > reason.
> > 
> 
> How about the follow approach instead?

Great minds think alike.
I have basically the exact same patch and I'm testing now.
It probably should be folded into "autofs4: avoid taking fs_lock during
rcu-walk".

It takes ages though, the test has two configurations to test and each
one takes about 70 minutes.

fyi, my criteria for the test is if it runs through to completion once
then that's essentially a pass. If not then there is a race that needs
to be fixed before merge. If it fails on runs two or three then there's
a hard to find race that needs attention but is not serious enough to
block merging. I usually stop after three runs but if fails are seen
later then, they too need to be resolved in the fullness of time.

The reason for this is that in heavy use sites we rarely see more than
about three processes concurrently accessing mount points and the test
run uses 10 client instances (currently on a 6 CPU machine) that all
access the mount tree at the same time so that should be somewhat more
pressure than is seen under heavy use.

And indeed this rule of has proven reliable so far.

> Though I must admit that I find the 'now' global variable feels a bit
> clumsy...
> Is there a reason for not just using "jiffies" everywhere?

Yeah, changing to use jiffies probably won't make any difference.
TBH, I can't remember why I did that.

> 
> I've created a tag 'autofs4' in git://neil.brown.name/md/ which has this in
> with all the others, in case that is useful.

I think I have all the patches but I may need to refer to that at some
point.

> 
> Thanks,
> NeilBrown
> 
> 
> 
> From 201f75bc25906e8f64e28b37f1bb478958bf2987 Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.de>
> Date: Wed, 20 Aug 2014 12:40:06 +1000
> Subject: [PATCH] autofs4: make "autofs4_can_expire" idempotent.
> 
> Have a "test" function change the value it is testing can
> be confusing, particularly as a future patch will be calling
> this function twice.
> 
> So move the update for 'last_used' to avoid repeat expiry
> to the place where the final determination on what to expire is known.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> 
> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> index bee939efca2b..af09dada91bc 100644
> --- a/fs/autofs4/expire.c
> +++ b/fs/autofs4/expire.c
> @@ -30,12 +30,6 @@ static inline int autofs4_can_expire(struct dentry *dentry,
>  		/* Too young to die */
>  		if (!timeout || time_after(ino->last_used + timeout, now))
>  			return 0;
> -
> -		/* update last_used here :-
> -		   - obviously makes sense if it is in use now
> -		   - less obviously, prevents rapid-fire expire
> -		     attempts if expire fails the first time */
> -		ino->last_used = now;
>  	}
>  	return 1;
>  }
> @@ -541,6 +535,8 @@ int autofs4_expire_run(struct super_block *sb,
>  
>  	spin_lock(&sbi->fs_lock);
>  	ino = autofs4_dentry_ino(dentry);
> +	/* avoid rapid-fire expire attempts if expiry fails */
> +	ino->last_used = now;
>  	ino->flags &= ~AUTOFS_INF_EXPIRING;
>  	complete_all(&ino->expire_complete);
>  	spin_unlock(&sbi->fs_lock);
> @@ -567,6 +563,8 @@ int autofs4_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
>  		ret = autofs4_wait(sbi, dentry, NFY_EXPIRE);
>  
>  		spin_lock(&sbi->fs_lock);
> +		/* avoid rapid-fire expire attempts if expiry fails */
> +		ino->last_used = now;
>  		ino->flags &= ~AUTOFS_INF_EXPIRING;
>  		complete_all(&ino->expire_complete);
>  		spin_unlock(&sbi->fs_lock);


