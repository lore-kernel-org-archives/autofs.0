From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than abusing follow_link()
Date: Thu, 13 Jan 2011 15:12:07 +0000
Message-ID: <16508.1294931527@redhat.com>
References: <AANLkTi=YygMc2ExFxvWqiFbSr-bWRVcn17toanJBdR08@mail.gmail.com> <20110111174809.2291.52242.stgit@warthog.procyon.org.uk> <20110111174815.2291.41967.stgit@warthog.procyon.org.uk> <AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=YygMc2ExFxvWqiFbSr-bWRVcn17toanJBdR08@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Piggin <npiggin@gmail.com>
Cc: dhowells@redhat.com, npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Nick Piggin <npiggin@gmail.com> wrote:

> > I would still prefer to see a .follow_mount API, and not tie in this
> > automount specific inode detail to what could be a more flexible
> > dentry-only API.
> >
> > The default NULL implementation would do nothing, and follow_automount
> > stuff can be in fs/libfs.c to be used by filesystem, rather than
> > fs/namei.c.
> 
> Looking further in the patchset at the d_managed "thing", that's almost what
> I'm getting at.
> 
> But I don't see why any of this stuff has to happen in fs/namei.c. Just call
> the function from path walk, and provide helpers in libfs or something if
> there is a lot of common code between autofs4 and others (and leave it autofs
> specifc when that is the case).
> 
> Of course, that would be the obvious and naive first approach. So really my
> question is why did that not work? And can we make it work?

You have a strange idea of what is 'obvious and naive'.  These are parts of
pathwalk, and as such should be in fs/namei.c.  I'd rather not expose
pathwalking directly to the filesystem, though I acknowledge that sometimes it
is necessary to let the filesystem influence it.

You need to consider d_automount() and d_manage() separately as they provide
two quite different hooks with different properties.

Firstly, d_automount().  The following are my points of consideration.

 (0) You're only allowed to automount on a directory.

 (1) Automounting does not need to be done when we follow ".." to an automount
     point.

 (2) Automount points that are mounted upon within the current namespace can
     just be skipped over.  This is the fast path.

 (3) All the filesystem should need as a parameter to determine what it is
     allowed to mount is the inode and dentry of the automount point.  This
     holds true for all the things that currently do automounting (AFS, CIFS,
     NFS, autofs).

 (4) All the filesystem should need to do is set up a vfsmount struct and
     publish it or return an indication that there was a collision and the
     transit should be retried.

 (5) The filesystem is expected to sleep to achieve the automount, so
     spinlocks, RCU locks, preemption disablements or interrupt disablements
     may not be held across this function.

 (6) The filesystem is expected to need a write lock on namespace_sem at some
     point, so this must not be held across the call to d_automount().

 (7) The filesystem won't necessarily be calling do_add_mount() itself in
     d_automount() - in autofs's case, the construction is performed by the
     userspace daemon and then autofs4_d_automount() indicates a collision - so
     we can't move the do_add_mount() to the caller.  Additionally, the
     filesystem may want to use an expiration list.

 (8) There needs to be some limitation in place to prevent runaway
     automounting.  The ELOOP detection mechanism can be used for this.

Taking these considerations, it shows that a small amount of code can be
inserted into pathwalk and used for everything.  However, having worked with
Ian to try and get autofs4 to work with this, we came up with d_manage() to add
in a missing piece.

Note that autofs4 also uses d_automount() to build directory structures behind
the mountpoint rather than mounting on the mountpoint.  In this case, it clears
the AUTOMOUNT flag when construction is complete.

I've allowed d_automount() to return -EISDIR to follow_automount() to indicate
that no mount should be attempted here, and the directory should be given back
to pathwalk to treat as a directory.  This allows autofs's daemon access to the
directory.

Having follow_automount() update the path it has been given with the new
vfsmount and root dentry is purely an optimisation; we could instead simply
return and __follow_mount() will do lookup_mnt() again as it would if a
collision is reported.

In answer to why I haven't made __follow_mount_rcu() handle automount points, I
thought previously I saw a reason why it was unnecessary, but now I'm not so
sure.  It may be that if there are child objects of this dentry then it will
walk onto those rather than automounting - but for some reason it seems still
to automount rather than doing that.


Secondly, d_manage().  The following are the points of consideration:

 (1) A filesystem may want to hold up client processes that want to transit
     from directories in its control during pathwalk - such as when autofs is
     letting its userspace daemon tear down the stuff mounted on or created
     behind a directory.

 (2) A transit may be from a directory to a directory mounted over it, or from
     a directory to an object (file, dir, etc.) pointed to by an entry in that
     directoy.

 (3) The management of dentries in this fashion is a transient affair.

 (4) The mode in which the filesystem is normally entered for this purpose
     should be disabled as soon as possible, though it may be reenabled later
     if needed.

 (5) When the filesystem is ready it should let the held processes proceed or
     it may reject them.

 (6) The filesystem is expected to sleep to achieve this, so spinlocks, RCU
     locks, preemption disablements or interrupt disablements may not be held
     across this function.

 (7) The filesystem must be able to let some processes through whilst holding
     up others.  This allows autofs to let its daemon pass to construct or
     destroy stuff.

 (8) Because do_add_mount() and do_move_mount() transit through piles of
     mounted directories, the filesystem may have to contend with being called
     with namespace_sem held.  This means initiating (un)mounting, even
     indirectly via userspace, is not permitted from this function.

Taking the above into consideration, we determined that we couldn't use one
entry point for both automounting and holding up.  Autofs had the possibility
to deadlock against itself because of (8).

I've allowed autofs to return -EISDIR from d_manage() to indicate that this
directory is the one of interest, and that any directory mounted upon it should
be ignored.  This permits the autofs daemon to ignore the fact the automount
flag is set and it should go through d_automount().


> Second observation when adding rcu-walk/ref-walk operations. What we've done
> now (which is what Linus preferred and I agree with now) is to make functions
> always able to accept rcu-walk mode, and have filesystems bail out as needed.
> 
> Unless there are really fundamental reasons why rcu-walk won't work (eg.
> ->lookup, if it is required to do allocations and IO), or if it really
> doesn't matter (eg. a function to be called once to set up a mount, and never
> again).

d_automount() is expected to sleep, so there's no point not cancelling rcu-walk
mode before entering it.  Granted there will be rare occasions when the
cancellation proves unnecessary because there was a mount collision, but even
then it's very likely we'll be calling alloc_vfsmnt() - which may sleep - and
doing I/O - which may also sleep - before we realise we've got a collision.

Besides, d_automount() is skipped without cancelling rcu-walk mode if the
directory is mounted over.  That is the fast path, and I'd rather not route
that through the filesystem.

So after automounting has happened, all subsequent transits of that mountpoint
will maintain rcu-walk mode, assuming they don't meet DCACHE_MANAGE_TRANSIT.


I grant that I could extend RCU pathwalk through d_manage().  The autofs daemon
might benefit from that, but I contend that the benefit would be minor overall,
and any processes that do get held up will have to abandon RCU pathwalk so that
they can sleep.

David
