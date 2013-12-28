From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs - fix symlinks aren't checked for expiry
Date: Sat, 28 Dec 2013 10:31:54 +0800
Message-ID: <1388197914.13774.1.camel@perseus.fritz.box>
References: <20131227042828.3519.11223.stgit@perseus.fritz.box>
	 <20131227043216.3519.3477.stgit@perseus.fritz.box>
	 <CA+icZUVz0imGxosj2gzXt9gi93VwdD2qFP-9=M3TgSkbfMNy4w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=3zElMSTLoKPpBkDqjpghhYhZiE0=; b=PmKJMJXStif2zPFOGQWEAv+Ax+0F
	HrefQi9uLVXfL+9wnMLjzs2tVw9oFnVqryVO4SsEwjIxFmjQYco25xlKi7OqXFHY
	tsP8quTrZiOM19I37ylGaQDUmfR83lG5l1dIovt4D/s8I1XcIA0OIEhnsfzdECvc
	tQNb1v2sZeummwQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=3zElMSTLoKPpBkDqjpghhY
	hZiE0=; b=RslfERRA9bxnOlWSNBn0F4sO+UnMVyYEr2aaLQAGST8dGwEUIqAmQ+
	5v4WDigMJVGQ6lIKc6ZRxHaorPTaS7tdGdu6Xz+IcPV+/ZhKineL1M9YEyyxyd6n
	uENvXxEoIYADZ1zM7REwhwcQG8zcqnZEJmgQXHnAqc9FMdlwcVPBo=
In-Reply-To: <CA+icZUVz0imGxosj2gzXt9gi93VwdD2qFP-9=M3TgSkbfMNy4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: sedat.dilek@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2013-12-27 at 11:53 +0100, Sedat Dilek wrote:
> On Fri, Dec 27, 2013 at 5:32 AM, Ian Kent <raven@themaw.net> wrote:
> 
> Hi,
> 
> saw some typos...

Right, I'm pretty tired, and seem to be so a lot these days.

Andrew, let me fix the typos and re-submit the patch.

> 
> > From: Ian Kent <ikent@redhat.com>
> >
> > The autofs4 module doesn't consider symlinks for expire as it did
> > in the older autofs v3 module (so it's actually a long stnding
> 
> s/stnding/standing
> 
> > regression).
> >
> > The user space daemon has focused on the use of bind mounts instead
> > of symlinks for a long time now and that's why this has not been
> > noticed. But with the future addition of amd map parsing to
> > automount(8), not to mention amd itself (of am-utils), symlink
> > expiry will be needed.
> >
> > The direct and offset mount types can't be symlinks and the tree
> > mounts of version 4 were always real mounts so only indirect
> > mounts need expire symlinks.
> >
> > Since the current users of the autofs4 module haven't reproted
> 
> s/reproted/reported
> 
> - Sedat -
> 
> > this as a problem to date this patch probably isn't a candidate
> > for backport to stable.
> >
> > Signed-off-by: Ian Kent <ikent@redhat.com>
> > ---
> >  fs/autofs4/expire.c  |   14 ++++++++++++++
> >  fs/autofs4/symlink.c |    4 ++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> > index 3d9d3f5..394e90b 100644
> > --- a/fs/autofs4/expire.c
> > +++ b/fs/autofs4/expire.c
> > @@ -402,6 +402,20 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
> >                         goto next;
> >                 }
> >
> > +               if (dentry->d_inode && S_ISLNK(dentry->d_inode->i_mode)) {
> > +                       DPRINTK("checking symlink %p %.*s",
> > +                               dentry, (int)dentry->d_name.len, dentry->d_name.name);
> > +                       /*
> > +                        * A symlink can't be "busy" in the usual sense so
> > +                        * just check last used for expire timeout.
> > +                        */
> > +                       if (autofs4_can_expire(dentry, timeout, do_now)) {
> > +                               expired = dentry;
> > +                               goto found;
> > +                       }
> > +                       goto next;
> > +               }
> > +
> >                 if (simple_empty(dentry))
> >                         goto next;
> >
> > diff --git a/fs/autofs4/symlink.c b/fs/autofs4/symlink.c
> > index f27c094..1e8ea19 100644
> > --- a/fs/autofs4/symlink.c
> > +++ b/fs/autofs4/symlink.c
> > @@ -14,6 +14,10 @@
> >
> >  static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
> >  {
> > +       struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
> > +       struct autofs_info *ino = autofs4_dentry_ino(dentry);
> > +       if (ino && !autofs4_oz_mode(sbi))
> > +               ino->last_used = jiffies;
> >         nd_set_link(nd, dentry->d_inode->i_private);
> >         return NULL;
> >  }
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

