From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/3] autofs4 - fix device ioctl mount lookup
Date: Wed, 4 Sep 2013 06:35:59 -0400
Message-ID: <20130904063559.1fb1b44d@tlielax.poochiereds.net>
References: <20130904005456.5025.94309.stgit@perseus.fritz.box>
	<20130904010301.GE13318@ZenIV.linux.org.uk>
	<20130904020013.GF13318@ZenIV.linux.org.uk>
	<CA+55aFwF+dqSMyGE+3LamM+qSDymieyReYB+RPb8fHTTmntgqw@mail.gmail.com>
	<20130904022617.GG13318@ZenIV.linux.org.uk>
	<20130904024230.GH13318@ZenIV.linux.org.uk>
	<1378266784.2364.11.camel@perseus.fritz.box>
	<1378267648.2364.20.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378267648.2364.20.camel@perseus.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, rui.xiang@huawei.com, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 04 Sep 2013 12:07:28 +0800
Ian Kent <raven@themaw.net> wrote:

> On Wed, 2013-09-04 at 11:53 +0800, Ian Kent wrote:
> > On Wed, 2013-09-04 at 03:42 +0100, Al Viro wrote:
> > > On Wed, Sep 04, 2013 at 03:26:17AM +0100, Al Viro wrote:
> > > > I've applied slightly modified variant of Jeff's "vfs: allow umount to handle
> > > > mountpoints without revalidating them" (modified by just leaving the
> > > > struct path filled with mountpoint and leaving the equivalent of follow_mount()
> > > > to caller) to the local queue and I'm pretty sure that it's what we want
> > > > here as well.
> > > 
> > > ... and killed the modifications since the result ends up uglier for
> > > caller(s) anyway.  Reapplied as-is.
> > 

Thanks Al. Note that there's a follow-on fix for the kerneldoc header
on one of the functions that will be floating around in akpm's tree
soon too. No code changes there though.

> > But isn't that what's needed anyway?
> 
> Except for the question of following symlinks which is still bugging me.
> 
> Granted, the initial implementation (8d7b48e0) didn't check for a
> symlink but probably should have and returned EINVAL if it found one.
> 
> That's because the whole process is driven by automount maps that have
> specific paths, so needing to follow a symlink is an indication the
> caller is doing something wrong.
> 
> It's probably not actually harmful to cater for it in kernel .... though
> the user will likely crash and burn some time later.
> 

If you don't want to allow the last component to be a symlink then the
easiest fix is probably to turn user_path_umountat() into a wrapper
around a new kern_path_umountat() function and simply call that without
LOOKUP_FOLLOW set. Then check to see if the last component is a symlink
before you use it. Of course, that means that you can't case symlinks
in intermediate components either. I'm not sure if that's an issue for
you though.

Doing that wrapperization would be a good opportunity to rename the
function as well, but I'm struck with my usual lack of creativity in
that department.

> > 
> > Looks like it fits with the existing code that walks back down looking
> > for a match.
> > 
> > And that fits in with fixing the bug where we want the first match just
> > means breaking out early. The match should be close to the top, if not
> > the first then the second, for the common case.
> > 
> > Ian
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Jeff Layton <jlayton@redhat.com>
