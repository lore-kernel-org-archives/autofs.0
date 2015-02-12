From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4: Wrong format for printing dentry
Date: Thu, 12 Feb 2015 09:08:51 +0800
Message-ID: <1423703331.2663.2.camel@pluto.fritz.box>
References: <1423236497-28139-1-git-send-email-linux@rasmusvillemoes.dk>
	 <87bnl0w58e.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:message-id:subject:from:to:cc:date:in-reply-to
	:references:content-type:mime-version:content-transfer-encoding;
	 s=mesmtp; bh=KzfmhfeIVNQGCKd9LFIAHFp/7Zk=; b=EB1HMQemN7OKlclX4U
	bVr0zNwYwrJJMO/13xpbuhLM99cCkTvtDWTsMLgckiM2eBo+mUCXKMX5SRcVVIH+
	vLGJa7UcfKYVHNEW7Dl8CKbTq15K7ClPZeC4zmbeeGN23qHlBZkuwXMP5xhXIKAJ
	PEVlJc2YZT9jbmdxpKiXaG6/I=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:subject:from:to:cc
	:date:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=KzfmhfeIVNQGCKd9LFIAHF
	p/7Zk=; b=uBjzw/ydfifVCwfxpaC+vK13JZLmLOBzp/QxZHO5dGuIN1hYkfQ2ou
	5dPc4RflUAbjQzbFGhjcauBZ55PzZqBY68AufG9IXUKMmw0ZFJsiNXcnVHkept4w
	OjendX/f5brg+Mte0HRruvPI+HV36dM7sVxydfcIDT7TvU44gYYUg=
In-Reply-To: <87bnl0w58e.fsf@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Al Viro <viro@zeniv.linux.org.uk>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2015-02-11 at 21:41 +0100, Rasmus Villemoes wrote:
> Ping...

The patch looks fine to me.
I'll check there are no other instances of this and send it to Al.

> 
> On Fri, Feb 06 2015, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
> > %pD for struct file*, %pd for struct dentry*.
> >
> > Fixes: a455589f181e ("assorted conversions to %p[dD]")
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> >  fs/autofs4/root.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> > index dbb5b7212ce1..7ba355b8d4ac 100644
> > --- a/fs/autofs4/root.c
> > +++ b/fs/autofs4/root.c
> > @@ -108,7 +108,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
> >  	struct dentry *dentry = file->f_path.dentry;
> >  	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
> >  
> > -	DPRINTK("file=%p dentry=%p %pD", file, dentry, dentry);
> > +	DPRINTK("file=%p dentry=%p %pd", file, dentry, dentry);
> >  
> >  	if (autofs4_oz_mode(sbi))
> >  		goto out;

