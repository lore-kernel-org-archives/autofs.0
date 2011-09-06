From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Tue, 06 Sep 2011 22:38:23 +0800
Message-ID: <1315319903.3210.51.camel@perseus.themaw.net>
References: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
	 <17416.1315240659@redhat.com> <87hb4q9b3r.fsf@tucsk.pomaz.szeredi.hu>
	 <1315281208.3210.26.camel@perseus.themaw.net>
	 <87mxeixfaq.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:from:to:cc:in-reply-to:references
	:content-type:date:message-id:mime-version
	:content-transfer-encoding; s=smtpout; bh=6Ez7+B77SXw4zg3CvBVXKz
	+2unk=; b=NOtre7IWWPv5Z5xGb7aYFCBiL0OgctOAizBSEF3mK0yfwNDf9HOHuM
	F+bROfku4GYOaj00TQtABFrpMpdvC+7qs5gsw24LwnUHIZTOvoeydhitqfmU6BSv
	wdIUbCNh+aiVNt/3Wcbcf4c+G6ZWzUDCVPlItjmhMTiBOcsiBdAGY=
In-Reply-To: <87mxeixfaq.fsf@tucsk.pomaz.szeredi.hu>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@linux.kernel.org

On Tue, 2011-09-06 at 10:09 +0200, Miklos Szeredi wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Mon, 2011-09-05 at 19:02 +0200, Miklos Szeredi wrote:
> >> 
> >> If automounting on lstat(2) is the correct behavior (is it?  why?)  then at
> >> least it should be enabled by a global switch or mount option, IMO.
> >
> > Ideally we wouldn't need to take special precautions for these
> > operations at all but we can't, especially for GUI environments that
> > constantly scan file systems on mount/umount activity.
> >
> > Historically for autofs, neither stat(2) or lstat(2) would trigger a
> > mount. With the current implementation stat(2) now does but lstat(2)
> > doesn't which is a step in the right direction IMHO. So, I recommend we
> > continue to encourage user space to make the needed changes so we
> > continue to move in the right direction, and yes, I acknowledge it is a
> > pain but it'll never get done otherwise.
> 
> I'm not quite convinced.  What's the advantage of triggering automount
> on stat(2)?

You get the information of the directory of the mounted fs and for many
peoples purposes automounting should be transparent so that would be
best.
 
> 
> Has anybody complained that stat(2) on the mountpoint doesn't cause an
> automount?

Yes, based on the reasoning above.

I have plead my case on that a number of times and because I have had no
choice but to continue with it the users have no choice but to accept
it. For these people I recommend not using the "browse" option with
autofs mount maps.

For autofs this is only a problem for mount maps that use "browse"
option. Basically ones where the mount point directory already exists
and is later mounted upon. When the dentry doesn't exist exist a mount
needs to be performed, at least it is needed to maintain previous
semantics. Other users of automounting are usually mounting on
directories that already exist, such as NFS crossing mount point
directories. I'm pretty sure the automount should be transparent for
them and similarly for CIFS DFS mounts.

Ian


