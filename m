From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: Add BUG_ON(1) for non dir/link inode case
Date: Mon, 04 Jul 2016 10:24:23 +0800
Message-ID: <1467599063.3317.10.camel@themaw.net>
References: <1467541782-1676-1-git-send-email-kusumi.tomohiro@gmail.com>
	 <ad28e0a0-f0b3-1934-1ef9-081c593700d0@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=fmsAhhy1BKtbyajFhlW4mHt5Kkg=; b=lhYCxQ
	Lvdc0urqyXYBRWXtU8/wgOir4yoAyCwn3myUYLhkAQJdP56oIpt0v7K1s8UWW2R/
	1gPlznjJTG4hJwlXH4uh/apa/e2GEIIaqqwmEKo2lnxFTlWDdSqWGodF/a+iLOGm
	wisKpe3ooA09UdBfUhqtFBQ0M4uvNjmlQShX0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=fmsAhhy1BKtbyaj
	FhlW4mHt5Kkg=; b=ZPZg15mRRCgqPiN4Sy42e6rEm7sLnB0ntcRU7hAVW8hpoZl
	5etW1bE/8lJgk9lmnGKGR7Da9wpQ4ygpRqfkOKufIfquX4KTrdnp8JLqvAmwysSy
	58RL/0SMFmCiM1bXV0JJaOlAaWvEzLKr4xoRllUcUuXN/kSNNA8YLauJELYY=
In-Reply-To: <ad28e0a0-f0b3-1934-1ef9-081c593700d0@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Mahoney <jeffm@suse.com>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Sun, 2016-07-03 at 18:51 -0400, Jeff Mahoney wrote:
> On 7/3/16 6:29 AM, Tomohiro Kusumi wrote:
> > It's invalid if the given mode is neither dir nor link,
> > so don't let it fallthrough on else case.
> 
> Is this case really worth crashing the entire system?
> 
> Wouldn't a WARN_ON + return -EINVAL be sufficient?  At the very least it
> means that a developer doesn't need to reboot to reload the module if
> they hit this.

That error return should be sufficient to cover this case and the WARN_ON() is
useful too.

And while there is some justification for the BUG_ON() earlier I also think an E
INVAL return would be more sensible there too.

BUG()ing on errors that should be handled is really bad IMHO.

> 
> -Jeff
> 
> > Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> > ---
> >  fs/autofs4/inode.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> > index ad0ee93..7f35c82 100644
> > --- a/fs/autofs4/inode.c
> > +++ b/fs/autofs4/inode.c
> > @@ -305,6 +305,7 @@ int autofs4_fill_super(struct super_block *s, void
> > *data, int silent)
> >  	if (autofs_type_trigger(sbi->type))
> >  		__managed_dentry_set_managed(root);
> >  
> > +	BUG_ON(!root_inode->i_fop || !root_inode->i_op);
> >  	root_inode->i_fop = &autofs4_root_operations;
> >  	root_inode->i_op = &autofs4_dir_inode_operations;
> >  
> > @@ -368,7 +369,8 @@ struct inode *autofs4_get_inode(struct super_block *sb,
> > umode_t mode)
> >  		inode->i_fop = &autofs4_dir_operations;
> >  	} else if (S_ISLNK(mode)) {
> >  		inode->i_op = &autofs4_symlink_inode_operations;
> > -	}
> > +	} else
> > +		BUG_ON(1);
> >  
> >  	return inode;
> >  }
> > 
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
