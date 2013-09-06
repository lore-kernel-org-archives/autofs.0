From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs4 - fix device ioctl mount lookup
Date: Fri, 06 Sep 2013 16:38:02 +0800
Message-ID: <1378456682.2311.21.camel@perseus.fritz.box>
References: <20130904005456.5025.94309.stgit@perseus.fritz.box>
	 <20130904010301.GE13318@ZenIV.linux.org.uk>
	 <20130904020013.GF13318@ZenIV.linux.org.uk>
	 <CA+55aFwF+dqSMyGE+3LamM+qSDymieyReYB+RPb8fHTTmntgqw@mail.gmail.com>
	 <20130904022617.GG13318@ZenIV.linux.org.uk>
	 <20130904024230.GH13318@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=nYlS8PWdrgY8CPlGR9eWkrVjZ8s=; b=TQNv2OAp6IeG8jFuJ4P9SYONn9LI
	IqbU+H+ucNHCrGHX4eJTtbO/PJw1jgyQKxpQmL9+wpr/0DV+Y7CQZEhls9EjHXft
	EkCRvjQmHKP/yrDb2N54KRbQpj1f+BSq1yA5K7wF7CpnOKupUys7/r2+M576iDDP
	zBUB39sYRCufCsQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=nYlS8PWdrgY8CPlGR9eWkr
	VjZ8s=; b=mIe9VL+IrrZ8+kc7gMfUyEEE4LLiUQlsIenS9UHJHaEqv3enmI7wJF
	QGJ5fE9BQIR27h86mC4aMEb7PqxrOxRoA5FoVtMlUPk5Ly4Vf+efJwA1Dsg67XA2
	ZiJvIJYdZ7PsfREqGKUMghiVyAfYctLtGGRT5Run3uP34ZGI1mh9I=
In-Reply-To: <20130904024230.GH13318@ZenIV.linux.org.uk>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, rui.xiang@huawei.com, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2013-09-04 at 03:42 +0100, Al Viro wrote:
> On Wed, Sep 04, 2013 at 03:26:17AM +0100, Al Viro wrote:
> > I've applied slightly modified variant of Jeff's "vfs: allow umount to handle
> > mountpoints without revalidating them" (modified by just leaving the
> > struct path filled with mountpoint and leaving the equivalent of follow_mount()
> > to caller) to the local queue and I'm pretty sure that it's what we want
> > here as well.
> 
> ... and killed the modifications since the result ends up uglier for
> caller(s) anyway.  Reapplied as-is.

Looks like Jeff's patch has been merged, commit 8033426e6.

Revalidation isn't the only thing not done on the last component using
Jeff's user_path_umountat() path walk. It also bypasses the managed
dentry code for the last component, which is why it's what I need as
well.

Encoding umount in the name seems misleading as to what it really does
as would encoding unmanaged or similar since that doesn't properly cover
it either.

I can rename it in a patch to solve my autofs problem, so how about
something like user_path_simple_last(), other suggestions anyone?

Ian

