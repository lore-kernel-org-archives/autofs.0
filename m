From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 1/2] autofs4: allow autofs to work outside the initial PID namespace
Date: Fri, 23 Nov 2012 15:30:39 +0100
Message-ID: <874nkgwfw0.fsf@tucsk.pomaz.szeredi.hu>
References: <87obipehbt.fsf@tucsk.pomaz.szeredi.hu>
	<1353642304.2309.25.camel@perseus.themaw.net>
	<1353672540.6699.18.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=12BIQWVvh0lpCp7zgnbE4xevmTAwuwElB3YfbDJbmoM=;
        b=bmv8zvNbMhQE6Lk3nWDlSiu1kZnNNF9HHQTTMRO25kk+g8mTvsc3YR1PCA+Km2CtOA
         jJEGGCoYZB5Qs1WbZpyOHFEk4SHnfNm5LAQW308QpdUb6NFSoHZ7ZpBLSz53r6s6Zcut
         Dbl07iFecBgxBc+U83f2PuZ0bv/dZlxk+c3/0=
In-Reply-To: <1353672540.6699.18.camel@perseus.themaw.net> (Ian Kent's message
	of "Fri, 23 Nov 2012 20:09:00 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, ebiederm@xmission.com

Ian Kent <raven@themaw.net> writes:

> On Fri, 2012-11-23 at 11:45 +0800, Ian Kent wrote:
>> On Thu, 2012-11-22 at 17:24 +0100, Miklos Szeredi wrote:
>> > Patches were tested by the customer.
>> > 
>> > Ian, Eric, do these patches look OK?
>> 
>> They look OK to me but I'm still a bit concerned about changing the way
>> this behaves, but I also believe this is the way we want it to behave.
>
> OK, I ran the autofs Connectathon tests that I often use on a kernel
> with these patches and they worked fine. So, AFAICS. the patches
> shouldn't introduce regressions.

And the reason for that is the patches introduce no behavioral changes
at all if the automount daemon was started in the initial namespace.

They only change (and fix) semantics of the case when automount is
started in a cloned pid namespace.

>
>> 
>> Give me a little bit more time to run a simple test to ensure we can at
>> least do what we could previously, and that's nothing more than
>> umounting duplicated mounts (which probably shouldn't be duplicated at
>> all) in the container.
>
> Interestingly the simple container test program I have also worked in
> the same way it does on current kernels so again I didn't see a problem
> adding the patches.
>
> But I do have a couple of questions that are a little related.
>
> Calling clone(2) with flags
> CLONE_NEWPID|CLONE_NEWNS|CLONE_NEWUTS|CLONE_NEWIPC|SIGCHLD|CLONE_NEWNET
> will result in a copy of the existing set of mounts. The autofs mounts
> can be umounted if they are not needed.
>
> But, on Fedora systemd sets "/" as shared at boot which prevents the
> umount of these autofs mounts, unless you mark "/" as private in the
> clone, after which the mounts can be umounted.
>
> Does having "/" marked as shared in the root namespace mean that further
> mounts in the root namespace will also appear in the clone and that
> mounts done in the clone will appear in the root namespace?

Yes.

>
> Will mounting all autofs mounts with MS_PRIVATE prevent the autofs
> mounts and any mounts under them from appearing in the root namespace?

Changing autofs mounts to MS_PRIVATE will prevent submounts of these
from being propagated to/from the root namespace.

>
> I assume there is no way for autofs to stop the propagation from the
> root namespace, is that correct?

Not for the children of the shared mount.  For the children of the
autofs mounts, they can be prevented, which is really what you want, I
guess.

Thanks,
Miklos
