From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs - fix fix symlinks arent checked for expiry
Date: Thu, 26 Dec 2013 17:19:49 -0800
Message-ID: <20131226171949.9ca42eaa.akpm@linux-foundation.org>
References: <20131224094459.20051.4889.stgit@perseus.fritz.box>
	<20131226134253.5f4b2f02a00e11b8de49770e@linux-foundation.org>
	<1388106592.2446.25.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1388106592.2446.25.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 27 Dec 2013 09:09:52 +0800 Ian Kent <raven@themaw.net> wrote:

> On Thu, 2013-12-26 at 13:42 -0800, Andrew Morton wrote:
> > On Tue, 24 Dec 2013 17:44:59 +0800 Ian Kent <raven@themaw.net> wrote:
> > 
> > > When following a symlink the last_used counter is unconditionally
> > > updated causing the expire checks from user space to prevent
> > > expiry. Opps!
> > 
> > A bit unclear.  You're saying that userspace's act of checking expiry
> > status will itself disrupt the expiry process?
> 
> If the user space expire code uses stat(2) instead of lstat(2), yes.
> It's quite possible this will be the case since it made no difference
> when not using symlinks in the autofs directory tree.
> 
> > 
> > Also, it's rather unclear what the userspace impact is here, and how
> > severe it is.  Please always carefully describe the user-visible impact
> > so that others can decide which kernel version(s) need the patch.
> 
> The impact of this is that symlinks within an an autofs directory tree
> don't cause a callback to the daemon so they can be expired (removed in
> this case).
> 
> autofs4_oz_mode() is the mechanism that's used to identify the user
> space process that's managing the automount tree. It's used in a number
> of places to prevent the process managing the tree from doing things
> like triggering mounts itself or updating the last_used counter.
> 
> It's a bit of a puzzle why it worked when I originally tested it.  But
> later when I looked at it to work out why some symlinks weren't expiring
> it was obvious.
> 
> Do you want me to re-submit this with an updated description?

Yes please.  The questions which a bugfix changelog should answer are
"should this be backported to -stable and if so, why".  It's also
helpful if it answers "if not, why not".

> > 
> > > --- a/fs/autofs4/symlink.c
> > > +++ b/fs/autofs4/symlink.c
> > > @@ -14,8 +14,9 @@
> > >  
> > >  static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
> > >  {
> > > +	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
> > >  	struct autofs_info *ino = autofs4_dentry_ino(dentry);
> > > -	if (ino)
> > > +	if (ino && !autofs4_oz_mode(sbi))
> > >  		ino->last_used = jiffies;
> > >  	nd_set_link(nd, dentry->d_inode->i_private);
> > >  	return NULL;
> > 
> > What kernel is this against?  3.13-rc5 is quite different:
> 
> That's a good question.
> Which tree should I be basing patches on?

Current Linus git is almost always the one to target.

> As it turns out it is against 3.13-rc5 which was the version the linus
> tree was at (when I pulled it) prior to mailing the patch.

Nope, autofs4_follow_link() looks like
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/autofs4/symlink.c
all the way back to 3.12.

