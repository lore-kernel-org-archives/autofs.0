From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/18] Introduce automount support in the VFS [ver #4]
Date: Fri, 14 Jan 2011 11:43:48 +0000
Message-ID: <2443.1295005428@redhat.com>
References: <20110114070224.GB19804@ZenIV.linux.org.uk> <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110114070224.GB19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> >      d_op->d_automount() may return one of:
> > 
> >      (a) The vfsmount mounted upon that dentry, in which case pathwalk will
> >          move to the root dentry of that vfsmount.  ->d_automount() must
> >          have in some manner mounted this before returning.
> > 
> >      (b) NULL if something was already mounted there, in which case
> >          pathwalk will loop around and recheck the mountings.
> 
> That makes very little sense as-is.  Look:
> 	* autofs4 never does (a)
> 	* everybody else could replace (a) with (b) just fine - we do (a)
> only when we'd just mounted new vfsmount on top of path.  So (b) would lead
> to follow_managed() looping over, finding DCACHE_MOUNTED and cheerfully
> transiting into the root of that vfsmount.

Indeed.  It's merely an optimisation and not strictly necessary.  I suppose
that, given the amount of time that's probably spent in performing the mount
part of the automount, repeating the check is negligible cost.

> Now, I'd like to have (a) and (b) distinct, but not in that fashion.  Namely,
> let's take do_add_mount() et.al. into follow_automount().

I presume that people aren't expected to do things like do_move_mount() here,
but might they want to do a bind mount?  Or do we just say if they want to do
something more exotic than do_add_mount(), they have to follow path (b)?

> Leave autofs4 as in your series; it'll be completely unaffected.  But switch
> all (b) in nfs/cifs/afs over to modified (a).  That is,
> 	* have vfsmount created as it's done in your series
> 	* grab extra reference and put it on chosen list.  That'd be done
> by helper in fs/namespace.c under namespace_sem.  Extra ref would make sure
> that nobody walking the list would decide that it's expirable.

It would be simpler, perhaps, to allow d_automount() to return the list also:

   struct vfsmount *(*d_automount)(struct path *mountpoint,
				   struct list_head **expiry_list_to_use);

This pointer can then be passed directly to do_add_mount() and we don't have
to worry about having an extra reference or cleaning up the list on error.

> 	* schedule whatever expiry activity we currently do.
> 	* return vfsmount
> In follow_automount() we'd see that we have non-NULL and non-ERR_PTR.  Then
> we'd attempt do_add_mount(), without bothering to pass it expiry list.  And
> do the same checks for return value, etc. we currently do in the method
> instances; just remember that we have an extra vfsmount reference that will
> need to be dropped and that we'll need to take the sucker off the expiry list
> in case we decide we don't need it (again, namespace.c helper).
> 
> As the result, we stop abusing do_add_mount() in there.  Moreover, with
> pending mnt_devname nfs rework we will be able to get rid of passing
> vfsmount to ->d_automount(), AFAICT, which would be nice...

:-)

David
