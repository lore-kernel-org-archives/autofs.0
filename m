From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs - use dentry flags to block walks during expire
Date: Fri, 09 Sep 2016 11:52:46 +0800
Message-ID: <1473393166.3097.3.camel@themaw.net>
References: <20160901012114.6476.57874.stgit@pluto.themaw.net>
         <87vay57sy3.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=Y1zhpgyW246WqmtnnU8+mVufXlw=; b=BNsrWW
        RaflEeCP58pmOhDrdH0rgbo9cX9e2Vx6CUsAIT+RiOoduJHzBCsc+VtDsF90NVoW
        cba7yxxC0Wt9y0ef25R8SkHy9J2YQKH6O9s6YP4g7dugyYjS8/y/j9tizoCfrOK7
        D8FJbLnWU4nUEnajVNUq+8Fl1Fg0TlUTzkbCM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Y1zhpgyW246Wqmt
        nnU8+mVufXlw=; b=Ie/sVabDTxhq2Z/uL98xZDZnEfDvOKeh9Zy8g7POrtnYXJq
        pd+zGRpNkIQKmc59xjZFynqSheBCS4bVjSR9ynVdw1atMthm3nihj4MsDSHJBbj/
        8ZeAWoJGhl4RCIrXIH7EyEJpuXGlAVh2yd9uMHVJadNWBnAHKNMGwMB1YsfY=
In-Reply-To: <87vay57sy3.fsf@notabene.neil.brown.name>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2016-09-09 at 11:39 +1000, NeilBrown wrote:
> On Thu, Sep 01 2016, Ian Kent wrote:
> 
> > Somewhere along the way the autofs expire operation has changed to
> > hold a spin lock over expired dentry selection. The autofs indirect
> > mount expired dentry selection is complicated and quite lengthy so
> > it isn't appropriate to hold a spin lock over the operation.
> > 
> > Commit 47be6184 added a might_sleep() to dput() causing a BUG()
> > about this usage to be issued.
> > 
> > But the spin lock doesn't need to be held over this check, the
> > autofs dentry info. flags are enough to block walks into dentrys
> > during the expire.
> > 
> > I've left the direct mount expire as it is (for now) becuase it
> > is much simpler and quicker than the indirect mount expire and
> > adding spin lock release and re-aquires would do nothing more
> > than add overhead.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/autofs4/expire.c |   55 +++++++++++++++++++++++++++++++++++++++---------
> > ---
> >  1 file changed, 42 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> > index b493909..2d8e176 100644
> > --- a/fs/autofs4/expire.c
> > +++ b/fs/autofs4/expire.c
> > @@ -417,6 +417,7 @@ static struct dentry *should_expire(struct dentry
> > *dentry,
> >  	}
> >  	return NULL;
> >  }
> > +
> >  /*
> >   * Find an eligible tree to time-out
> >   * A tree is eligible if :-
> > @@ -432,6 +433,7 @@ struct dentry *autofs4_expire_indirect(struct
> > super_block *sb,
> >  	struct dentry *root = sb->s_root;
> >  	struct dentry *dentry;
> >  	struct dentry *expired;
> > +	struct dentry *found;
> >  	struct autofs_info *ino;
> >  
> >  	if (!root)
> > @@ -442,31 +444,46 @@ struct dentry *autofs4_expire_indirect(struct
> > super_block *sb,
> >  
> >  	dentry = NULL;
> >  	while ((dentry = get_next_positive_subdir(dentry, root))) {
> > +		int flags = how;
> > +
> >  		spin_lock(&sbi->fs_lock);
> >  		ino = autofs4_dentry_ino(dentry);
> > -		if (ino->flags & AUTOFS_INF_WANT_EXPIRE)
> > -			expired = NULL;
> > -		else
> > -			expired = should_expire(dentry, mnt, timeout, how);
> > -		if (!expired) {
> > +		if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
> >  			spin_unlock(&sbi->fs_lock);
> >  			continue;
> >  		}
> > +		spin_unlock(&sbi->fs_lock);
> > +
> > +		expired = should_expire(dentry, mnt, timeout, flags);
> > +		if (!expired)
> > +			continue;
> > +
> > +		spin_lock(&sbi->fs_lock);
> >  		ino = autofs4_dentry_ino(expired);
> >  		ino->flags |= AUTOFS_INF_WANT_EXPIRE;
> >  		spin_unlock(&sbi->fs_lock);
> >  		synchronize_rcu();
> > -		spin_lock(&sbi->fs_lock);
> > -		if (should_expire(expired, mnt, timeout, how)) {
> > -			if (expired != dentry)
> > -				dput(dentry);
> > -			goto found;
> > -		}
> >  
> > +		/* Make sure a reference is not taken on found if
> > +		 * things have changed.
> > +		 */
> > +		flags &= ~AUTOFS_EXP_LEAVES;
> > +		found = should_expire(expired, mnt, timeout, how);
> > +		if (!found || found != expired)
> > +			/* Something has changed, continue */
> > +			goto next;
> > +
> > +		if (expired != dentry)
> > +			dput(dentry);
> > +
> > +		spin_lock(&sbi->fs_lock);
> > +		goto found;
> > +next:
> > +		spin_lock(&sbi->fs_lock);
> >  		ino->flags &= ~AUTOFS_INF_WANT_EXPIRE;
> > +		spin_unlock(&sbi->fs_lock);
> >  		if (expired != dentry)
> >  			dput(expired);
> > -		spin_unlock(&sbi->fs_lock);
> >  	}
> >  	return NULL;
> >  
> > @@ -483,6 +500,7 @@ int autofs4_expire_wait(struct dentry *dentry, int
> > rcu_walk)
> >  	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
> >  	struct autofs_info *ino = autofs4_dentry_ino(dentry);
> >  	int status;
> > +	int state;
> >  
> >  	/* Block on any pending expire */
> >  	if (!(ino->flags & AUTOFS_INF_WANT_EXPIRE))
> > @@ -490,8 +508,19 @@ int autofs4_expire_wait(struct dentry *dentry, int
> > rcu_walk)
> >  	if (rcu_walk)
> >  		return -ECHILD;
> >  
> > +retry:
> >  	spin_lock(&sbi->fs_lock);
> > -	if (ino->flags & AUTOFS_INF_EXPIRING) {
> > +	state = ino->flags & (AUTOFS_INF_WANT_EXPIRE |
> > AUTOFS_INF_EXPIRING);
> > +	if (state == AUTOFS_INF_WANT_EXPIRE) {
> > +		spin_unlock(&sbi->fs_lock);
> > +		/*
> > +		 * Possibly being selected for expire, wait until
> > +		 * it's selected or not.
> > +		 */
> > +		schedule_timeout(HZ/10);
> 
> Hi Ian,
> 
> I think you want schedule_timeout_uninterruptible(HZ/10) here.
> schedule_timeout() only causes a delay if the task state has been
> changed from runnable.

Right, I'll have another look, I saw that should be used but didn't actually do
the change state.

I have another location that calls schedule_timeout() which likely needs the
same treatment.

> 
> There is a similar bug in fscache_object_sleep_till_congested().
> Nothing changes the task state from TASK_RUNNING in that function
> before it calls schedule_timeout(*timeoutp);
> 
> Also should this patch be marked as
> 
> Fixes: 47be61845c77 ("fs/dcache.c: avoid soft-lockup in dput()")

Indeed yes, I'll do that in a re-post, thanks.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
