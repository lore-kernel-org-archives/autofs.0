From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Tue, 06 Sep 2011 12:03:00 +0800
Message-ID: <1315281780.3210.31.camel@perseus.themaw.net>
References: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
	 <17416.1315240659@redhat.com>  <87hb4q9b3r.fsf@tucsk.pomaz.szeredi.hu>
	 <1315281208.3210.26.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:from:to:cc:in-reply-to:references
	:content-type:date:message-id:mime-version
	:content-transfer-encoding; s=smtpout; bh=DLnFWvxqSGes52Me2j5faQ
	JebDQ=; b=FwyvH7paCaKfs3/i1S+qwuTfkp1O+5TSZivp5i9oTCtnx8ZsSrs6RN
	nNrclmmAowNh4UAWtU7MN1TMhKL73da+sUb88/jwXigx3j6Dtutjv0U54+wzdThZ
	0OjX6mREQeAmDEQRNOH9CVUviNhdQ3WGb6T2YLPFCRvUJ30FNGh/g=
In-Reply-To: <1315281208.3210.26.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@linux.kernel.org

On Tue, 2011-09-06 at 11:53 +0800, Ian Kent wrote:
> On Mon, 2011-09-05 at 19:02 +0200, Miklos Szeredi wrote:
> > David Howells <dhowells@redhat.com> writes:
> > 
> > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > >> After 2.6.38, with the introduction of the ->d_automount()
> > >> infrastructure, stat(2) and others would start triggering automount
> > >> while lstat(2), etc. still would not.  This is a regression and a
> > >> userspace ABI change.
> > >
> > > It doesn't necessarily mean it's wrong.  The main class of program that needs
> > > to be prevented from automounting are things that do bulk stat'ing (e.g. ls) -
> > > and they should probably be doing lstat() anyway.
> > 
> > Yeah, some of those uses are probably minor bugs in userspace, but there are
> > probably many of them (Leonardo reported that for example Nautilus also
> > triggers all child automounts in a directory).  So I don't think it's OK to
> > just change the behavior here.
> 
> Yes, Leonard has been a big help with his recent efforts, thanks
> Leonard.
> 
> > 
> > If automounting on lstat(2) is the correct behavior (is it?  why?)  then at
> > least it should be enabled by a global switch or mount option, IMO.
> 
> Ideally we wouldn't need to take special precautions for these
> operations at all but we can't, especially for GUI environments that
> constantly scan file systems on mount/umount activity.
> 
> Historically for autofs, neither stat(2) or lstat(2) would trigger a
> mount. With the current implementation stat(2) now does but lstat(2)
> doesn't which is a step in the right direction IMHO. So, I recommend we
> continue to encourage user space to make the needed changes so we
> continue to move in the right direction, and yes, I acknowledge it is a
> pain but it'll never get done otherwise.
> 
> And, yes, other subsystems that need to automount also have the same
> problems as autofs now so we do need to take precautions, but that was
> already the case before the current implementation.
> 
> Hopefully, in time, user space will adopt the use of fcntl(2) and
> AT_NO_AUTOMOUNT and we will be able to fix this once and for all, as
> this was David's intent in introducing it. Not quite sure how we will go
> about promoting that adoption or how much pain that will mean for user
> space though.

Actually, maybe that's not entirely sensible either, now that I think
about it. Isn't it so that if we have one process that shouldn't trigger
mounts and sets the flag, other processes that possibly should won't
either ... mmm ... I'll need to check that.

Ian
