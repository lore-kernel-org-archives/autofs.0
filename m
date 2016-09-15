From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Wed, 14 Sep 2016 21:08:02 -0500
Message-ID: <87k2ed530d.fsf@x220.int.ebiederm.org>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
        <20160914061445.24714.68331.stgit@pluto.themaw.net>
        <87zina9ys3.fsf@x220.int.ebiederm.org>
        <1473898163.3205.32.camel@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1473898163.3205.32.camel@themaw.net> (Ian Kent's message of
        "Thu, 15 Sep 2016 08:09:23 +0800")
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

Ian Kent <raven@themaw.net> writes:

> On Wed, 2016-09-14 at 12:28 -0500, Eric W. Biederman wrote:
>> Ian Kent <raven@themaw.net> writes:
>> 
>> > If an automount mount is clone(2)ed into a file system that is
>> > propagation private, when it later expires in the originating
>> > namespace subsequent calls to autofs ->d_automount() for that
>> > dentry in the original namespace will return ELOOP until the
>> > mount is manually umounted in the cloned namespace.
>> > 
>> > In the same way, if an autofs mount is triggered by automount(8)
>> > running within a container the dentry will be seen as mounted in
>> > the root init namespace and calls to ->d_automount() in that namespace
>> > will return ELOOP until the mount is umounted within the container.
>> > 
>> > Also, have_submounts() can return an incorect result when a mount
>> > exists in a namespace other than the one being checked.
>> 
>> Overall this appears to be a fairly reasonable set of changes.  It does
>> increase the expense when an actual mount point is encountered, but if
>> these are the desired some increase in cost when a dentry is a
>> mountpoint is unavoidable.
>> 
>> May I ask the motiviation for this set of changes?  Reading through the
>> changes I don't grasp why we want to change the behavior of autofs.
>> What problem is being solved?  What are the benefits?
>
> LOL, it's all too easy for me to give a patch description that I think explains
> a problem I need to solve without realizing it isn't clear to others what the
> problem is, sorry about that.
>
> For quite a while now, and not that frequently but consistently, I've been
> getting reports of people using autofs getting ELOOP errors and not being able
> to mount automounts.
>
> This has been due to the cloning of autofs file systems (that have active
> automounts at the time of the clone) by other systems.
>
> An unshare, as one example, can easily result in the cloning of an autofs file
> system that has active mounts which shows this problem.
>
> Once an active mount that has been cloned is expired in the namespace that
> performed the unshare it can't be (auto)mounted again in the the originating
> namespace because the mounted check in the autofs module will think it is
> already mounted.
>
> I'm not sure this is a clear description either, hopefully it is enough to
> demonstrate the type of problem I'm typing to solve.

So to rephrase the problem is that an autofs instance can stop working
properly from the perspective of the mount namespace it is mounted in
if the autofs instance is shared between multiple mount namespaces.  The
problem is that mounts and unmounts do not always propogate between
mount namespaces.  This lack of symmetric mount/unmount behavior
leads to mountpoints that become unusable.

Which leads to the question what is the expected new behavior with your
patchset applied.  New mounts can be added in the parent mount namespace
(because the test is local).  Does your change also allow the
autofs mountpoints to be used in the other mount namespaces that share
the autofs instance if everything becomes unmounted?

Or is it expected that other mount namespaces that share an autofs
instance will get changes in their mounts via mount propagation and if
mount propagation is insufficient they are on their own.

I believe this is a question of how do notifications of the desire for
an automount work after your change, and are those notifications
consistent with your desired and/or expected behavior.

Eric





--
To unsubscribe from this list: send the line "unsubscribe autofs" in
