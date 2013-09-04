From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs4 - fix device ioctl mount lookup
Date: Wed, 04 Sep 2013 12:07:28 +0800
Message-ID: <1378267648.2364.20.camel@perseus.fritz.box>
References: <20130904005456.5025.94309.stgit@perseus.fritz.box>
	 <20130904010301.GE13318@ZenIV.linux.org.uk>
	 <20130904020013.GF13318@ZenIV.linux.org.uk>
	 <CA+55aFwF+dqSMyGE+3LamM+qSDymieyReYB+RPb8fHTTmntgqw@mail.gmail.com>
	 <20130904022617.GG13318@ZenIV.linux.org.uk>
	 <20130904024230.GH13318@ZenIV.linux.org.uk>
	 <1378266784.2364.11.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=3GmjsgR8iaIf5LsWelvBj9LV6o8=; b=ozAur9kojnfbpcKtdM8Nb66RQFIK
	WlxOAlptayTqWD5jpiBA1oNGkyutxarTKyVquQQ87PzGnjprKXNDWeq5/agct1rA
	0FcNlMUylqHV1xo/+TGfi50B0RvtX3hROtfF6XLXlhi+GoY/0rWrpNHL7IUCeEWe
	XR5nRoBISwcK4z8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=3GmjsgR8iaIf5LsWelvBj9
	LV6o8=; b=G9TL/dVT27n41cZ/8/6iPTBWnwybm1cRT9z/iqLT5pDTPmdBICdQ5Q
	42HUO1NVMVthlGEG9RvPRhIW2Kp04rllj5kW6fKqLMt4G0TVWWI6Ui9JXqLaH0jc
	4y2wv+AszKQdXNgrxJRs0uI9A04S3T0Pgg185cDLZFOu0r63IKLcY=
In-Reply-To: <1378266784.2364.11.camel@perseus.fritz.box>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, rui.xiang@huawei.com, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2013-09-04 at 11:53 +0800, Ian Kent wrote:
> On Wed, 2013-09-04 at 03:42 +0100, Al Viro wrote:
> > On Wed, Sep 04, 2013 at 03:26:17AM +0100, Al Viro wrote:
> > > I've applied slightly modified variant of Jeff's "vfs: allow umount to handle
> > > mountpoints without revalidating them" (modified by just leaving the
> > > struct path filled with mountpoint and leaving the equivalent of follow_mount()
> > > to caller) to the local queue and I'm pretty sure that it's what we want
> > > here as well.
> > 
> > ... and killed the modifications since the result ends up uglier for
> > caller(s) anyway.  Reapplied as-is.
> 
> But isn't that what's needed anyway?

Except for the question of following symlinks which is still bugging me.

Granted, the initial implementation (8d7b48e0) didn't check for a
symlink but probably should have and returned EINVAL if it found one.

That's because the whole process is driven by automount maps that have
specific paths, so needing to follow a symlink is an indication the
caller is doing something wrong.

It's probably not actually harmful to cater for it in kernel .... though
the user will likely crash and burn some time later.

> 
> Looks like it fits with the existing code that walks back down looking
> for a match.
> 
> And that fits in with fixing the bug where we want the first match just
> means breaking out early. The match should be close to the top, if not
> the first then the second, for the common case.
> 
> Ian


