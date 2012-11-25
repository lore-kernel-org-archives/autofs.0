From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/2] autofs4: allow autofs to work outside the initial
 PID namespace
Date: Mon, 26 Nov 2012 07:25:56 +0800
Message-ID: <1353885956.2323.4.camel@perseus.themaw.net>
References: <87obipehbt.fsf@tucsk.pomaz.szeredi.hu>
	 <1353642304.2309.25.camel@perseus.themaw.net>
	 <1353672540.6699.18.camel@perseus.themaw.net>
	 <874nkgwfw0.fsf@tucsk.pomaz.szeredi.hu>
	 <1353723813.2348.48.camel@perseus.themaw.net>
	 <1353724641.2348.56.camel@perseus.themaw.net> <878v9rmcgc.fsf@xmission.com>
	 <CAJfpegvQGhzDvQt=OBf=GVQF2gDynTp6F+zO-dn5skFLtukFCQ@mail.gmail.com>
	 <87lidqfx3u.fsf@xmission.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=6rZyu8C2BYqNQF6DRnm4mzSeNkI=; b=Gz0OSeeI3jeL1qku17Lb5PoZCxBO
	PVIJPRGPQphZL8G+TURO586nGh7YJFlu3zXGfMAX5aqsVOApIs8eTuBzoXdNS/a9
	+seueZxSVKSOJeEjAeE/scqAcOa8VkT+6YbQw6fMnu9Ne2jNb354BZkfQaBHwAga
	4c8bxY2L89kRbik=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=6rZyu8C2BYqNQF6DRnm4mzSeNkI=; b=r0R
	w2FLsJ/QVZzKntLrjdS2KTg0mHgqipzPIu1cdWDQRIp2iqTd7fIvom7i8xGkqbHT
	8vWhRwmqkJE2dQz660e10WMyGn8dXzmLzzgoNG1Yr1VYgSNu2HyR7zQGn5XPkFI2
	ALX4hrJqjyK8YL5/T3ev4F1kvnvQgUzX+kzRjY4E=
In-Reply-To: <87lidqfx3u.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com

On Sat, 2012-11-24 at 14:35 -0800, Eric W. Biederman wrote:
> Miklos Szeredi <miklos@szeredi.hu> writes:
> 
> > On Sat, Nov 24, 2012 at 1:07 PM, Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
> >> Ian Kent <raven@themaw.net> writes:
> >>
> >>> On Sat, 2012-11-24 at 10:23 +0800, Ian Kent wrote:
> >>>> On Fri, 2012-11-23 at 15:30 +0100, Miklos Szeredi wrote:
> >
> >>>> AFAICS autofs mounts mounted with MS_PRIVATE in the initial namespace do
> >>>> propagate to the clone when it's created so I'm assuming subsequent
> >>>> mounts would also. If these mounts are busy in some way they can't be
> >>>> umounted in the clone unless "/" is marked private before attempting the
> >>>> umount.
> 
> Subsequent mounts after the clone do not have a mechanism to propogate
> with MS_PRIVATE.  As creating a new mount namespaces is essentially
> an instance of mount --bind.  Those semantics are a little unintuitive
> I have to admit.
> 
> >>> This may sound stupid but if there something like, say, MS_NOPROPAGATE
> >>> then the problem I see would pretty much just go away. No more need to
> >>> umount existing mounts and container instances would be isolated. But, I
> >>> guess, I'm not considering the possibility of cloned of processes as
> >>> well .... if that makes sense, ;)
> >>
> >> Something is very weird is going on.  MS_PRIVATE should be the
> >> MS_NOPROPOGATE you are looking for.  There is also MS_UNBINDABLE.
> >> which is a stronger form of MS_PRIVATE and probably worth play with.
> >>
> >
> > MS_UNBINDABLE says:  skip this mount when copying a mount tree, such
> > as when the mount namespace is cloned.
> >
> > If you set MS_UNBINDABLE on autofs mounts then they will simply not
> > appear in a cloned namespace.  Which sounds like a good idea,  no?
> 
> Good point.  If the desire is for a mount to be managed by autofs
> setting MS_UNBINDABLE seems required.

Arrgh, I know that's something I should have looked into long ago.
The fact is that autofs mounts are directly related to a specific path
defined by automount maps that are associated with the daemon so bind
mounting them elsewhere makes no sense.

Is it necessary (or sensible) to use MS_PRIVATE with MS_UNBINDABLE?

> 
> Eric
> 

