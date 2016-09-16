From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Fri, 16 Sep 2016 10:58:19 +0800
Message-ID: <1473994699.3087.53.camel@themaw.net>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
         <20160914061445.24714.68331.stgit@pluto.themaw.net>
         <87zina9ys3.fsf@x220.int.ebiederm.org>
         <1473898163.3205.32.camel@themaw.net>
         <87k2ed530d.fsf@x220.int.ebiederm.org>
         <1473912775.3205.122.camel@themaw.net>
         <8737l0wtzp.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=mk68lVlKq+sPX8IgusW7ciACWSs=; b=MpbCzt
        bu9ZTPqEopoo+RX5t0fSx3zNDaq3y1dkz3o0OcnvFlGPKfqN0K4JjMqNhDCFaLcH
        q1qPGVtSEbTV+8oCQWgn87JSXvZ8U0ybylNUtWNlQrdmKNjE7vtGNDhi+EoiSCrW
        GvJafV3Dc3scOw8AEWGUpXAUnY4SsqEWdW0go=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=mk68lVlKq+sPX8I
        gusW7ciACWSs=; b=l1elKjVyYGiOCiDEZufNL1Z8FUgQtCr5mhwtK1aZOcUcTle
        txuvIqZeIUA+l59cI4MU7HINGGJiQ+X+13/sg8j/QDMJV/DGnepZkA3+w9if1/z8
        txIJtDNbBvmoOqQE+FR7cQyJbEkRT+/VlJp3/QRsOkv4j7ARJPAPozGpE2XQ=
In-Reply-To: <8737l0wtzp.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Thu, 2016-09-15 at 19:47 -0500, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Wed, 2016-09-14 at 21:08 -0500, Eric W. Biederman wrote:
> > > Ian Kent <raven@themaw.net> writes:
> > > 
> > > > On Wed, 2016-09-14 at 12:28 -0500, Eric W. Biederman wrote:
> > > > > Ian Kent <raven@themaw.net> writes:
> > > > > 
> > > > > > If an automount mount is clone(2)ed into a file system that is
> > > > > > propagation private, when it later expires in the originating
> > > > > > namespace subsequent calls to autofs ->d_automount() for that
> > > > > > dentry in the original namespace will return ELOOP until the
> > > > > > mount is manually umounted in the cloned namespace.
> > > > > > 
> > > > > > In the same way, if an autofs mount is triggered by automount(8)
> > > > > > running within a container the dentry will be seen as mounted in
> > > > > > the root init namespace and calls to ->d_automount() in that
> > > > > > namespace
> > > > > > will return ELOOP until the mount is umounted within the container.
> > > > > > 
> > > > > > Also, have_submounts() can return an incorect result when a mount
> > > > > > exists in a namespace other than the one being checked.
> > > > > 
> > > > > Overall this appears to be a fairly reasonable set of changes.  It
> > > > > does
> > > > > increase the expense when an actual mount point is encountered, but if
> > > > > these are the desired some increase in cost when a dentry is a
> > > > > mountpoint is unavoidable.
> > > > > 
> > > > > May I ask the motiviation for this set of changes?  Reading through
> > > > > the
> > > > > changes I don't grasp why we want to change the behavior of autofs.
> > > > > What problem is being solved?  What are the benefits?
> > > > 
> > > > LOL, it's all too easy for me to give a patch description that I think
> > > > explains
> > > > a problem I need to solve without realizing it isn't clear to others
> > > > what
> > > > the
> > > > problem is, sorry about that.
> > > > 
> > > > For quite a while now, and not that frequently but consistently, I've
> > > > been
> > > > getting reports of people using autofs getting ELOOP errors and not
> > > > being
> > > > able
> > > > to mount automounts.
> > > > 
> > > > This has been due to the cloning of autofs file systems (that have
> > > > active
> > > > automounts at the time of the clone) by other systems.
> > > > 
> > > > An unshare, as one example, can easily result in the cloning of an
> > > > autofs
> > > > file
> > > > system that has active mounts which shows this problem.
> > > > 
> > > > Once an active mount that has been cloned is expired in the namespace
> > > > that
> > > > performed the unshare it can't be (auto)mounted again in the the
> > > > originating
> > > > namespace because the mounted check in the autofs module will think it
> > > > is
> > > > already mounted.
> > > > 
> > > > I'm not sure this is a clear description either, hopefully it is enough
> > > > to
> > > > demonstrate the type of problem I'm typing to solve.
> > > 
> > > So to rephrase the problem is that an autofs instance can stop working
> > > properly from the perspective of the mount namespace it is mounted in
> > > if the autofs instance is shared between multiple mount namespaces.  The
> > > problem is that mounts and unmounts do not always propogate between
> > > mount namespaces.  This lack of symmetric mount/unmount behavior
> > > leads to mountpoints that become unusable.
> > 
> > That's right.
> > 
> > It's also worth considering that symmetric mount propagation is usually not
> > the
> > behaviour needed either and things like LXC and Docker are set propagation
> > slave
> > because of problems caused by propagation back to the parent namespace.
> > 
> > So a mount can be triggered within a container, mounted by the automount
> > daemon
> > in the parent namespace, and propagated to the child and similarly for
> > expires,
> > which is the common use case now.
> > 
> > > 
> > > Which leads to the question what is the expected new behavior with your
> > > patchset applied.  New mounts can be added in the parent mount namespace
> > > (because the test is local).  Does your change also allow the
> > > autofs mountpoints to be used in the other mount namespaces that share
> > > the autofs instance if everything becomes unmounted?
> > 
> > The problem occurs when the subordinate namespace doesn't deal with these
> > propagated mounts properly, although they can obviously be used by the
> > subordinate namespace.
> > 
> > > 
> > > Or is it expected that other mount namespaces that share an autofs
> > > instance will get changes in their mounts via mount propagation and if
> > > mount propagation is insufficient they are on their own.
> > 
> > Namespaces that receive updates via mount propagation from a parent will
> > continue to function as they do now.
> > 
> > Mounts that don't get updates via mount propagation will retain the mount to
> > use
> > if they need to, as they would without this change, but the originating
> > namespace will also continue to function as expected.
> > 
> > The child namespace needs cleanup its mounts on exit, which it had to do
> > prior
> > to this change also.
> > 
> > > 
> > > I believe this is a question of how do notifications of the desire for
> > > an automount work after your change, and are those notifications
> > > consistent with your desired and/or expected behavior.
> > 
> > It sounds like you might be assuming the service receiving these cloned
> > mounts
> > actually wants to use them or is expecting them to behave like automount
> > mounts.
> > But that's not what I've seen and is not the way these cloned mounts behave
> > without the change.
> > 
> > However, as has probably occurred to you by now, there is a semantic change
> > with
> > this for namespaces that don't receive mount propogation.
> > 
> > If a mount request is triggered by an access in the subordinate namespace
> > for a
> > dentry that is already mounted in the parent namespace it will silently fail
> > (in
> > that a mount won't appear in the subordinate namespace) rather than getting
> > an
> > ELOOP error as it would now.
> > 
> > It's also the case that, if such a mount isn't already mounted, it will
> > cause a
> > mount to occur in the parent namespace. But that is also the way it is
> > without
> > the change.
> > 
> > TBH I don't know yet how to resolve that, ideally the cloned mounts would
> > not
> > appear in the subordinate namespace upon creation but that's also not
> > currently
> > possible to do and even if it was it would mean quite a change in to the way
> > things behave now.
> > 
> > All in all I believe the change here solves a problem that needs to be
> > solved
> > without affecting normal usage at the expense of a small behaviour change to
> > cases where automount isn't providing a mounting service.
> 
> That sounds like a reasonable semantic change.  Limiting the responses
> of the autofs mount path to what is present in the mount namespace
> of the program that actually performs the autofs mounts seems needed.

Indeed, yes.

> 
> In fact the entire local mount concept exists because I was solving a
> very similar problem for rename, unlink and rmdir.  Where a cloned mount
> namespace could cause a denial of service attack on the original
> mount namespace.
> 
> I don't know if this change makes sense for mount expiry.

Originally I thought it did but now I think your right, it won't actually make a
difference.

Let me think a little more about it, I thought there was a reason I included the
expire in the changes but I can't remember now.

It may be that originally I thought individual automount(8) instances within
containers could be affected by an instance of automount(8) in the root
namespace (and visa versa) but now I think these will all be isolated.

My assumption being that people don't stupid things like pass an autofs mount to
a container and expect to also run a distinct automount(8) instance within the
same container.

> 
> Unless I am misreading something when a mount namespace is cloned the
> new mounts are put into the same expiry group as the old mounts.

autofs doesn't use the in kernel expiry but conceptually this is right.

> Furthermore the triggers for mounts are based on the filesystem.

Yes, that's also the case.

> 
> 
> I can think of 3 ways to use mount namespaces that are relevant
> to this discussion.
> 
> - Symmetric mount propagation where everything is identical except
>   for specific mounts such as /tmp.

I'm not sure this case is useful in practice, at least not currently, and there
is at least one case where systemd setting the root file system shared breaks
autofs.

> 
> - Slave mount propagation where all of the mounts are created in
>   the parent and propgated to the slave, except for specific exceptions.

This is currently the common case AFAIK.

Docker, for example, would pass --volume=/autofs/indirect/mount at startup.

There's no sensible way I'm aware of that autofs direct mounts can be used in
this way but that's different problem.

> 
> - Disabled mount propagation.  Where updates are simply not received
>   by the namespace.  The mount namespace is expected to change in
>   ways that are completely independent of the parent (and this breaks
>   autofs).

This is also a case I think is needed.

For example, running independent automount(8) instances within containers.

Running an instance of automount(8) in a container should behave like this
already.

> 
> In the first two cases the desire is to have the same set of mounts
> except for specific exceptions so it is generally desirable.  So having
> someone using a mount in another mount namespace seems like a good
> reason not to expire the mount.

Yes, that's something I have been thinking about.

This is essentially the way it is now and I don't see any reason to change it.

After all automounting is meant to conserve resources so keeping something
mounted that is being used somewhere makes sense.

> 
> Furthermore since the processes can always trigger or hang onto the
> mounts without using mount namespaces I don't think those cases add
> anything new to the set of problems.
> 
> It seems to me the real problem is when something is unmounted in the
> original mount namespace and not in the slaves which causes the mount
> calls to fail and cause all kinds of havoc.

It does, yes.

> 
> Unless you can see an error in my reasoning I think the local mount
> tests should be limited to just the mount path.  That is sufficient to
> keep autofs working as expected while still respecting non-problem users
> in other mount namespaces.

Right, as I said above give me a little time on that.

Ian
