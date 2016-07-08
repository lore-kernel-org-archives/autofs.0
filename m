From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/2] autofs: Fix conditional to kfree dentry data
Date: Fri, 08 Jul 2016 09:10:17 +0800
Message-ID: <1467940217.3832.1.camel@themaw.net>
References: <1467480264-1801-1-git-send-email-kusumi.tomohiro@gmail.com>
	 <1467480264-1801-2-git-send-email-kusumi.tomohiro@gmail.com>
	 <1467864853.3206.12.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=z6/w4h/0yr+rldGNugwAQCiR8zA=; b=rGEU+L
	sW+LaVg0aWJm2KGzox8CdjdlmjztVEcnKiIDwHM2YuequR4+Q3imlsKtN0yeS0sS
	6UBC4/WHvD42T0x4nml30NP9aP+j011HlQtN4uY5KRKaYg613Y9D4LIZrlEep8Lo
	ieTJ50gIKwiWm7CdmlsL4g+NoelrYSqgnF3sU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=z6/w4h/0yr+rldG
	NugwAQCiR8zA=; b=aKzahoaPnwjsVCtRlqUqL+eyB8Jnc06DGqm8ock/fIWVZbr
	I1ijx13eG4Gx41LkbsmM4IupruLUAL31ZuqAEBzz4lT5vrg7kcnEBTieUYkSzGP4
	f54ClnX2ISXapBqpIX4787aPgMvSYbQoS78iAQWrhHbIm2WM2bVyEWowPTz8=
In-Reply-To: <1467864853.3206.12.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Thu, 2016-07-07 at 12:14 +0800, Ian Kent wrote:
> On Sun, 2016-07-03 at 02:24 +0900, Tomohiro Kusumi wrote:
> > if (!dentry->d_fsdata) should be testing d_fsdata or ino without !.
> 
> I've added both of these to the list of kernel patches I have, hopefully I'll
> be
> able to get the needed testing done to send them to Andrew after the next
> merge
> window.
> 
> But I need to take a closer look at this one though.
> 
> There's another ENOMEM return just above this where ino is not freed.
> 
> So I'm wondering if it should be freed here at all.
> 
> It belongs to the dentry and would get freed using autofs4_dentry_release() on
> final dput() and that takes care of additional house keeping too (although a
> symlink dentry is a bit different and shouldn't need that extra cleanup).
> 
> What really worries me is that autofs4_free_ino() doesn't set d_fsdata to NULL
> so there's a chance of a double free when autofs4_dentry_release() is finally
> called.

I've removed the free from autofs4_dir_symlink(), it really should be done by
d_release() on final dput.

> 
> > 
> > Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> > ---
> >  fs/autofs4/root.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> > index 93d3232..5a877bf 100644
> > --- a/fs/autofs4/root.c
> > +++ b/fs/autofs4/root.c
> > @@ -577,7 +577,7 @@ static int autofs4_dir_symlink(struct inode *dir,
> >  	inode = autofs4_get_inode(dir->i_sb, S_IFLNK | 0555);
> >  	if (!inode) {
> >  		kfree(cp);
> > -		if (!dentry->d_fsdata)
> > +		if (ino)
> >  			autofs4_free_ino(ino);
> >  		return -ENOMEM;
> >  	}
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
