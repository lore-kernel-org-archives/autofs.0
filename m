From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs4 - fix device ioctl mount lookup
Date: Fri, 06 Sep 2013 16:54:19 +0800
Message-ID: <1378457659.2311.23.camel@perseus.fritz.box>
References: <20130904005456.5025.94309.stgit@perseus.fritz.box>
	 <20130904010301.GE13318@ZenIV.linux.org.uk>
	 <20130904020013.GF13318@ZenIV.linux.org.uk>
	 <CA+55aFwF+dqSMyGE+3LamM+qSDymieyReYB+RPb8fHTTmntgqw@mail.gmail.com>
	 <20130904022617.GG13318@ZenIV.linux.org.uk>
	 <20130904024230.GH13318@ZenIV.linux.org.uk>
	 <1378456682.2311.21.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=cVTO0wDZ1BgtGTihL+77+rAvelo=; b=a2Bqh3qKCiqGwqo/KGAJY40Lxiv5
	qtLen1uWOV3n7FJ9I+iajPR0WzTOwQ23dGaFolpvgKYu+MwHq58H2LIPjF5T7LPI
	6tOLI+f3ENYEOb+oUAD1zu/+Lc9T+Kt0TMnZDmf5b+Kw3VBDNOmxWrsWU/w5/0yw
	d9FoRN87AKxBDs8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=cVTO0wDZ1BgtGTihL+77+r
	Avelo=; b=HLIttji0ns+mNSieGvuu+YnwSeVYx9YajR+g8Ka/BxiulY2m50S+b+
	tWyxuP2lQjPMlXl/JptOjdcSEBOEbaUrSREjzXhqLISLMVkNBM7jHrc+u3uCKFaF
	uPvpNn0M7jegrfSMi8u7gZOoqtKHRH0AIZEI7DyDZjmEFjq5lndEg=
In-Reply-To: <1378456682.2311.21.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeffrey Layton <jlayton@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, rui.xiang@huawei.com, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>


Sorry, I should have added Jeff to the cc for this post.

On Fri, 2013-09-06 at 16:38 +0800, Ian Kent wrote:
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
> Looks like Jeff's patch has been merged, commit 8033426e6.
> 
> Revalidation isn't the only thing not done on the last component using
> Jeff's user_path_umountat() path walk. It also bypasses the managed
> dentry code for the last component, which is why it's what I need as
> well.
> 
> Encoding umount in the name seems misleading as to what it really does
> as would encoding unmanaged or similar since that doesn't properly cover
> it either.
> 
> I can rename it in a patch to solve my autofs problem, so how about
> something like user_path_simple_last(), other suggestions anyone?
> 
> Ian


