From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Thu, 15 Sep 2016 12:12:55 +0800
Message-ID: <1473912775.3205.122.camel@themaw.net>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
         <20160914061445.24714.68331.stgit@pluto.themaw.net>
         <87zina9ys3.fsf@x220.int.ebiederm.org>
         <1473898163.3205.32.camel@themaw.net>
         <87k2ed530d.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=lPGDfK5Xjw4Y7phUc/SLdCUvg30=; b=JVHurY
        Lnje1U2ret5DzWz04yhPi6aULh4dowb+6FB34kTL127WzBBZD+fhDjMUhrCYIj7P
        NSgbeIhEl4Hwm8/R4x39/RWvMyOfbc+9Yal0oGOJvNOtK9s2KBbQNmLgeE0Dj3Od
        l10egGTVLnfVky2o+076s1/aiwwxHSh5R3v9s=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=lPGDfK5Xjw4Y7ph
        Uc/SLdCUvg30=; b=bso2ZobfSE7wmKgltDi044hkb1r43WZVFZtdLjWJNjRQDC1
        uApUiOj7mMkc4djUCQGbwbLRNhd83WZ4K2iKnb64DyU78W8ZRGQjPKdoFqD1y3ht
        DCQ1RASVR11f2ozrShEyZ7FkxrWbCNEPNF/fjoEVLvR6T4+eF8+LuNcMiizQ=
In-Reply-To: <87k2ed530d.fsf@x220.int.ebiederm.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Wed, 2016-09-14 at 21:08 -0500, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Wed, 2016-09-14 at 12:28 -0500, Eric W. Biederman wrote:
> > > Ian Kent <raven@themaw.net> writes:
> > > 
> > > > If an automount mount is clone(2)ed into a file system that is
> > > > propagation private, when it later expires in the originating
> > > > namespace subsequent calls to autofs ->d_automount() for that
> > > > dentry in the original namespace will return ELOOP until the
> > > > mount is manually umounted in the cloned namespace.
> > > > 
> > > > In the same way, if an autofs mount is triggered by automount(8)
> > > > running within a container the dentry will be seen as mounted in
> > > > the root init namespace and calls to ->d_automount() in that namespace
> > > > will return ELOOP until the mount is umounted within the container.
> > > > 
> > > > Also, have_submounts() can return an incorect result when a mount
> > > > exists in a namespace other than the one being checked.
> > > 
> > > Overall this appears to be a fairly reasonable set of changes.  It does
> > > increase the expense when an actual mount point is encountered, but if
> > > these are the desired some increase in cost when a dentry is a
> > > mountpoint is unavoidable.
> > > 
> > > May I ask the motiviation for this set of changes?  Reading through the
> > > changes I don't grasp why we want to change the behavior of autofs.
> > > What problem is being solved?  What are the benefits?
> > 
> > LOL, it's all too easy for me to give a patch description that I think
> > explains
> > a problem I need to solve without realizing it isn't clear to others what
> > the
> > problem is, sorry about that.
> > 
> > For quite a while now, and not that frequently but consistently, I've been
> > getting reports of people using autofs getting ELOOP errors and not being
> > able
> > to mount automounts.
> > 
> > This has been due to the cloning of autofs file systems (that have active
> > automounts at the time of the clone) by other systems.
> > 
> > An unshare, as one example, can easily result in the cloning of an autofs
> > file
> > system that has active mounts which shows this problem.
> > 
> > Once an active mount that has been cloned is expired in the namespace that
> > performed the unshare it can't be (auto)mounted again in the the originating
> > namespace because the mounted check in the autofs module will think it is
> > already mounted.
> > 
> > I'm not sure this is a clear description either, hopefully it is enough to
> > demonstrate the type of problem I'm typing to solve.
> 
> So to rephrase the problem is that an autofs instance can stop working
> properly from the perspective of the mount namespace it is mounted in
> if the autofs instance is shared between multiple mount namespaces.  The
> problem is that mounts and unmounts do not always propogate between
> mount namespaces.  This lack of symmetric mount/unmount behavior
> leads to mountpoints that become unusable.

That's right.

It's also worth considering that symmetric mount propagation is usually not the
behaviour needed either and things like LXC and Docker are set propagation slave
because of problems caused by propagation back to the parent namespace.

So a mount can be triggered within a container, mounted by the automount daemon
in the parent namespace, and propagated to the child and similarly for expires,
which is the common use case now.

> 
> Which leads to the question what is the expected new behavior with your
> patchset applied.  New mounts can be added in the parent mount namespace
> (because the test is local).  Does your change also allow the
> autofs mountpoints to be used in the other mount namespaces that share
> the autofs instance if everything becomes unmounted?

The problem occurs when the subordinate namespace doesn't deal with these
propagated mounts properly, although they can obviously be used by the
subordinate namespace.

> 
> Or is it expected that other mount namespaces that share an autofs
> instance will get changes in their mounts via mount propagation and if
> mount propagation is insufficient they are on their own.

Namespaces that receive updates via mount propagation from a parent will
continue to function as they do now.

Mounts that don't get updates via mount propagation will retain the mount to use
if they need to, as they would without this change, but the originating
namespace will also continue to function as expected.

The child namespace needs cleanup its mounts on exit, which it had to do prior
to this change also.

> 
> I believe this is a question of how do notifications of the desire for
> an automount work after your change, and are those notifications
> consistent with your desired and/or expected behavior.

It sounds like you might be assuming the service receiving these cloned mounts
actually wants to use them or is expecting them to behave like automount mounts.
But that's not what I've seen and is not the way these cloned mounts behave
without the change.

However, as has probably occurred to you by now, there is a semantic change with
this for namespaces that don't receive mount propogation.

If a mount request is triggered by an access in the subordinate namespace for a
dentry that is already mounted in the parent namespace it will silently fail (in
that a mount won't appear in the subordinate namespace) rather than getting an
ELOOP error as it would now.

It's also the case that, if such a mount isn't already mounted, it will cause a
mount to occur in the parent namespace. But that is also the way it is without
the change.

TBH I don't know yet how to resolve that, ideally the cloned mounts would not
appear in the subordinate namespace upon creation but that's also not currently
possible to do and even if it was it would mean quite a change in to the way
things behave now. 

All in all I believe the change here solves a problem that needs to be solved
without affecting normal usage at the expense of a small behaviour change to
cases where automount isn't providing a mounting service.

> 
> Eric
> 
> 
> 
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
