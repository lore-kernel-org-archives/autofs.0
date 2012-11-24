From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/2] autofs4: allow autofs to work outside the initial
 PID namespace
Date: Sat, 24 Nov 2012 10:23:33 +0800
Message-ID: <1353723813.2348.48.camel@perseus.themaw.net>
References: <87obipehbt.fsf@tucsk.pomaz.szeredi.hu>
	 <1353642304.2309.25.camel@perseus.themaw.net>
	 <1353672540.6699.18.camel@perseus.themaw.net>
	 <874nkgwfw0.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=0DraazHMJLK54ZEiiTZOuZ9PbhA=; b=kxihiAjQ/NrqqtNMiTDBJikyxqwS
	JHD+7k8hgZwbytinxVjnKI4qFh8cV0KwXBgWprby+/6kgdayUfvsoGNhBroRVdsN
	D2kFEbzSKG97mlE8qIGFuiRmsA+QwCjU/UQfNkVJtRyVtOAqufaHnuystUVT8z1i
	9pnDAhcKPsH7vQo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=0DraazHMJLK54ZEiiTZOuZ9PbhA=; b=DSw
	Vc6oeKzu8lmz9gfPrW3NbAvIWH2jYGGjXQHRowvqHDp7XL6GDqsccsmmzjcS3nxd
	iiJlr7A8xd3bUZF705a+5Ne1oRN83OF9dmn8Hfd0Mwe5DZ2ub8sk2tPwqbx8YcPR
	+H/ihOEy95Vn1CGFu6Bpc1Uz8zf69Rt1RfdChO7U=
In-Reply-To: <874nkgwfw0.fsf@tucsk.pomaz.szeredi.hu>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, ebiederm@xmission.com

On Fri, 2012-11-23 at 15:30 +0100, Miklos Szeredi wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Fri, 2012-11-23 at 11:45 +0800, Ian Kent wrote:
> >> On Thu, 2012-11-22 at 17:24 +0100, Miklos Szeredi wrote:
> >> > Patches were tested by the customer.
> >> > 
> >> > Ian, Eric, do these patches look OK?
> >> 
> >> They look OK to me but I'm still a bit concerned about changing the way
> >> this behaves, but I also believe this is the way we want it to behave.
> >
> > OK, I ran the autofs Connectathon tests that I often use on a kernel
> > with these patches and they worked fine. So, AFAICS. the patches
> > shouldn't introduce regressions.
> 
> And the reason for that is the patches introduce no behavioral changes
> at all if the automount daemon was started in the initial namespace.

Sure but I had to check.

> 
> They only change (and fix) semantics of the case when automount is
> started in a cloned pid namespace.
> 
> >
> >> 
> >> Give me a little bit more time to run a simple test to ensure we can at
> >> least do what we could previously, and that's nothing more than
> >> umounting duplicated mounts (which probably shouldn't be duplicated at
> >> all) in the container.
> >
> > Interestingly the simple container test program I have also worked in
> > the same way it does on current kernels so again I didn't see a problem
> > adding the patches.
> >
> > But I do have a couple of questions that are a little related.
> >
> > Calling clone(2) with flags
> > CLONE_NEWPID|CLONE_NEWNS|CLONE_NEWUTS|CLONE_NEWIPC|SIGCHLD|CLONE_NEWNET
> > will result in a copy of the existing set of mounts. The autofs mounts
> > can be umounted if they are not needed.
> >
> > But, on Fedora systemd sets "/" as shared at boot which prevents the
> > umount of these autofs mounts, unless you mark "/" as private in the
> > clone, after which the mounts can be umounted.
> >
> > Does having "/" marked as shared in the root namespace mean that further
> > mounts in the root namespace will also appear in the clone and that
> > mounts done in the clone will appear in the root namespace?
> 
> Yes.
> 
> >
> > Will mounting all autofs mounts with MS_PRIVATE prevent the autofs
> > mounts and any mounts under them from appearing in the root namespace?
> 
> Changing autofs mounts to MS_PRIVATE will prevent submounts of these
> from being propagated to/from the root namespace.

Right, but maybe I don't understand what you mean by the "from" here.

AFAICS autofs mounts mounted with MS_PRIVATE in the initial namespace do
propagate to the clone when it's created so I'm assuming subsequent
mounts would also. If these mounts are busy in some way they can't be
umounted in the clone unless "/" is marked private before attempting the
umount.

> 
> >
> > I assume there is no way for autofs to stop the propagation from the
> > root namespace, is that correct?
> 
> Not for the children of the shared mount.  For the children of the
> autofs mounts, they can be prevented, which is really what you want, I
> guess.

I think that's what is needed but it's only one direction.

It seems to me that people using containers and wanting to run an
instance of automount within them can't run automount in the initial
namespace if they wish to use systemd (or if "/" is marked shared for
some other reason). And from the discussion here it appears there really
isn't anything I can do within autofs to remove that restriction.

Ian


