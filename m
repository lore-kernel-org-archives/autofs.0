From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: Add BUG_ON(1) for non dir/link inode case
Date: Mon, 04 Jul 2016 14:08:27 +0800
Message-ID: <1467612507.3317.13.camel@themaw.net>
References: <1467541782-1676-1-git-send-email-kusumi.tomohiro@gmail.com>
	 <ad28e0a0-f0b3-1934-1ef9-081c593700d0@suse.com>
	 <1467599063.3317.10.camel@themaw.net>
	 <CAHndrB=8zS7zdr4X6aTby4TsqKc5waGjc3Lbrva-puZZv6q9pw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=ZccZ9eN8Xe0lEIgkwyu2+YU1Q8g=; b=hvWjiP
	y8XzaTn5T9LchgXp0m0P5kwY8QUFZE6DDu31u1x+K85PSh7WkoL0fQo60fRuwr05
	RDK1jI0rPgME1viKTZmVqgCoNWJw8nNldUeIE1mObu5+IOCZ4jvobdEtZK+ucQrE
	VFlbf8LzPjiTfdgA3K7J4JuKD883ujm/V9UFo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ZccZ9eN8Xe0lEIg
	kwyu2+YU1Q8g=; b=HAgQDpdSxAujOOQoDy7d3FGYG1gvRk8oCrIK4+6IAY5Mavk
	UAlbkLLQanB+nPCxQUIqloLpbgU+BPHyIaxSMSVk3kNbNhMFXECUtv9k9+0f4FJK
	QeV6vvmJiWj9C5lNfKerb2xbdl7u5rBqkhQflOn2dunTYQV9a168kC8WqpmM=
In-Reply-To: <CAHndrB=8zS7zdr4X6aTby4TsqKc5waGjc3Lbrva-puZZv6q9pw@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: Jeff Mahoney <jeffm@suse.com>, autofs@vger.kernel.org

On Mon, 2016-07-04 at 13:04 +0900, Tomohiro Kusumi wrote:
> Thanks for your review.
> I've submitted the v2 patch which only changed BUG_ON to WARN_ON.

Yep, it's always called internally and should return something close to sensible
on error.

The case really shouldn't happen so a WARN_ON() is the better way to handle
this.

> 
> I didn't use a return value of EINVAL as this function returns a pointer.
> (and I didn't want to return EINVAL casted to a pointer)
> 
> 2016-07-04 11:24 GMT+09:00 Ian Kent <raven@themaw.net>:
> > On Sun, 2016-07-03 at 18:51 -0400, Jeff Mahoney wrote:
> > > On 7/3/16 6:29 AM, Tomohiro Kusumi wrote:
> > > > It's invalid if the given mode is neither dir nor link,
> > > > so don't let it fallthrough on else case.
> > > 
> > > Is this case really worth crashing the entire system?
> > > 
> > > Wouldn't a WARN_ON + return -EINVAL be sufficient?  At the very least it
> > > means that a developer doesn't need to reboot to reload the module if
> > > they hit this.
> > 
> > That error return should be sufficient to cover this case and the WARN_ON()
> > is
> > useful too.
> > 
> > And while there is some justification for the BUG_ON() earlier I also think
> > an E
> > INVAL return would be more sensible there too.
> > 
> > BUG()ing on errors that should be handled is really bad IMHO.
> > 
> > > 
> > > -Jeff
> > > 
> > > > Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> > > > ---
> > > >  fs/autofs4/inode.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> > > > index ad0ee93..7f35c82 100644
> > > > --- a/fs/autofs4/inode.c
> > > > +++ b/fs/autofs4/inode.c
> > > > @@ -305,6 +305,7 @@ int autofs4_fill_super(struct super_block *s, void
> > > > *data, int silent)
> > > >     if (autofs_type_trigger(sbi->type))
> > > >             __managed_dentry_set_managed(root);
> > > > 
> > > > +   BUG_ON(!root_inode->i_fop || !root_inode->i_op);
> > > >     root_inode->i_fop = &autofs4_root_operations;
> > > >     root_inode->i_op = &autofs4_dir_inode_operations;
> > > > 
> > > > @@ -368,7 +369,8 @@ struct inode *autofs4_get_inode(struct super_block
> > > > *sb,
> > > > umode_t mode)
> > > >             inode->i_fop = &autofs4_dir_operations;
> > > >     } else if (S_ISLNK(mode)) {
> > > >             inode->i_op = &autofs4_symlink_inode_operations;
> > > > -   }
> > > > +   } else
> > > > +           BUG_ON(1);
> > > > 
> > > >     return inode;
> > > >  }
> > > > 
> > > 
> > > 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
