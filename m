From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 1/2] autofs4: allow autofs to work outside the initial PID namespace
Date: Mon, 26 Nov 2012 17:11:23 +0100
Message-ID: <CAJfpegvfeSoZz_uFE_HyGcqGq4_ZLGsicu_PHsi3jt5DYp-_gw@mail.gmail.com>
References: <87obipehbt.fsf@tucsk.pomaz.szeredi.hu>
	<1353642304.2309.25.camel@perseus.themaw.net>
	<1353672540.6699.18.camel@perseus.themaw.net>
	<874nkgwfw0.fsf@tucsk.pomaz.szeredi.hu>
	<1353723813.2348.48.camel@perseus.themaw.net>
	<1353724641.2348.56.camel@perseus.themaw.net>
	<878v9rmcgc.fsf@xmission.com>
	<CAJfpegvQGhzDvQt=OBf=GVQF2gDynTp6F+zO-dn5skFLtukFCQ@mail.gmail.com>
	<87lidqfx3u.fsf@xmission.com>
	<1353885956.2323.4.camel@perseus.themaw.net>
	<1353896968.2323.7.camel@perseus.themaw.net>
	<CAJfpegsqwd57NdHVhwfdNjauj8HKJb=x+2GAZtJQ8vLdt+A=sw@mail.gmail.com>
	<87boekzawt.fsf@xmission.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=H+d1YtqfefFepYnB1g7Ku3qDeehWg0Y9Y/tt2bh+3mk=;
        b=e9T6J+JJKVWCyMrx2Cz6VuKmHaJIG1urFuba/ZQ2Z94BZM14TC7c5KMZ+sgT5OgMdQ
         LVZ/d4NRH4li0W9D7Qf5TD7brgF9/V2ipS3UfSeT0F8FL5gmnKu2Xc8DyBdR+ta90awQ
         Lnps+BYrJKS6LVQ3B0gVCa7nYX84MXx2AbusU=
In-Reply-To: <87boekzawt.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, Al Viro <viro@zeniv.linux.org.uk>

On Mon, Nov 26, 2012 at 3:38 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> So I don't know how much MS_UNBINDABLE helps over MS_PRIVATE.  Both
> prevent propogation of changes to other namespaces.  I don't know how
> much using MS_UNBINDABLE to also prevent bind mounts helps.


MS_PRIVATE says ops on children (mount, unmount) won't be propageted,
MS_UNBINDABLE says the mount itself won't be copied.

I think it may make sense to introduce a new flag similar to
MS_UNBINDABLE that applies to namespace cloning as well as bind
mounting.  It says: this mount is managed by some userspace entity
(autofs) and copying it to the new namespace or to some other part of
the tree makes no sense since a new instance of the  userspace entity
responsible for managing those mounts will need to be started in the
new namespace as well.  I can't think of any other sane solution to
this issue.

Thanks,
Miklos

>
> Eric
>
