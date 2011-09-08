From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Thu, 08 Sep 2011 20:36:46 +0800
Message-ID: <1315485406.3476.9.camel@perseus.themaw.net>
References: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
	 <17416.1315240659@redhat.com> <87hb4q9b3r.fsf@tucsk.pomaz.szeredi.hu>
	 <1315281208.3210.26.camel@perseus.themaw.net>
	 <87mxeixfaq.fsf@tucsk.pomaz.szeredi.hu>
	 <1315319903.3210.51.camel@perseus.themaw.net>
	 <87ipp5y912.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:from:to:cc:in-reply-to:references
	:content-type:date:message-id:mime-version
	:content-transfer-encoding; s=smtpout; bh=nBONsk0fbRoLubTuHc5fbS
	H+d/s=; b=EZR09a5rimkEPKd6+qDUtTXqLtyDFAkmBs417pnMnknTnMQ6nLY8xI
	eew99jUgtXx5iGaA4/lq20lCt9Jd8Kp2BlgsPrP4pNl1QkN2kafj6wptHgiOupp9
	W7nSgfL/bZOPu0k3pYnSHSvc5uQ5a0a/vS+1EOudfU8b57tnbSl+k=
In-Reply-To: <87ipp5y912.fsf@tucsk.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@linux.kernel.org

On Tue, 2011-09-06 at 17:39 +0200, Miklos Szeredi wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Tue, 2011-09-06 at 10:09 +0200, Miklos Szeredi wrote:
> >> Ian Kent <raven@themaw.net> writes:
> >> 
> >> > On Mon, 2011-09-05 at 19:02 +0200, Miklos Szeredi wrote:
> >> >> 
> >> >> If automounting on lstat(2) is the correct behavior (is it?  why?)  then at
> >> >> least it should be enabled by a global switch or mount option, IMO.
> >> >
> >> > Ideally we wouldn't need to take special precautions for these
> >> > operations at all but we can't, especially for GUI environments that
> >> > constantly scan file systems on mount/umount activity.
> >> >
> >> > Historically for autofs, neither stat(2) or lstat(2) would trigger a
> >> > mount. With the current implementation stat(2) now does but lstat(2)
> >> > doesn't which is a step in the right direction IMHO. So, I recommend we
> >> > continue to encourage user space to make the needed changes so we
> >> > continue to move in the right direction, and yes, I acknowledge it is a
> >> > pain but it'll never get done otherwise.
> >> 
> >> I'm not quite convinced.  What's the advantage of triggering automount
> >> on stat(2)?
> >
> > You get the information of the directory of the mounted fs and for many
> > peoples purposes automounting should be transparent so that would be
> > best.
> 
> The same is true for lstat(2).
> 
> >  
> >> 
> >> Has anybody complained that stat(2) on the mountpoint doesn't cause an
> >> automount?
> >
> > Yes, based on the reasoning above.
> 
> Would any of those complaints go away if stat(2) did cause an
> automount and lstat(2) didn't?

Ummm .... please forgive me, I'm confused over which of these cause an
automount to occur, again.

Much of what I've said previously is wrong because stat(2) does cause
the automount and lstat(2) doesn't, which is, I think, the way it should
be, semantically (see bug
https://bugzilla.redhat.com/show_bug.cgi?id=692823 for example).

I'll go back and check the code "again", just to be doubly sure, which I
need to do given my constant confusion on this, oops!

The comments about working through problems that arise in order to
retain this behavior still apply though.

Ian

