From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 00/18] Introduce automount support in the VFS [ver #4]
Date: Fri, 14 Jan 2011 07:02:24 +0000
Message-ID: <20110114070224.GB19804@ZenIV.linux.org.uk>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2011 at 09:53:59PM +0000, David Howells wrote:

>  (1) struct vfsmount *(*d_automount)(struct path *path);
> 
>      This is used by follow_automount() in fs/namei.c to ask the filesystem
>      that owns the dentry at the current path point to mount something on
>      @path.
> 
>      It is called if DCACHE_NEED_AUTOMOUNT (which is propagated from the
>      S_AUTOMOUNT inode flag) is flagged on a dentry and if that dentry has
>      nothing mounted on it in the current namespace when someone attempts to
>      use that dentry.
> 
>      No locks will be held when this is called.
> 
>      d_op->d_automount() may return one of:
> 
>      (a) The vfsmount mounted upon that dentry, in which case pathwalk will
>      	 move to the root dentry of that vfsmount.  ->d_automount() must have
>      	 in some manner mounted this before returning.
> 
>      (b) NULL if something was already mounted there, in which case pathwalk
>      	 will loop around and recheck the mountings.

That makes very little sense as-is.  Look:
	* autofs4 never does (a)
	* everybody else could replace (a) with (b) just fine - we do (a)
only when we'd just mounted new vfsmount on top of path.  So (b) would lead
to follow_managed() looping over, finding DCACHE_MOUNTED and cheerfully
transiting into the root of that vfsmount.

Note that it's not subtle at all - *all* cases doing (a) lack ->d_manage(),
so behaviour of follow_automount() is as simple as it gets.

Now, I'd like to have (a) and (b) distinct, but not in that fashion.  Namely,
let's take do_add_mount() et.al. into follow_automount().  Leave autofs4
as in your series; it'll be completely unaffected.  But switch all (b) in
nfs/cifs/afs over to modified (a).  That is,
	* have vfsmount created as it's done in your series
	* grab extra reference and put it on chosen list.  That'd be done
by helper in fs/namespace.c under namespace_sem.  Extra ref would make sure
that nobody walking the list would decide that it's expirable.
	* schedule whatever expiry activity we currently do.
	* return vfsmount
In follow_automount() we'd see that we have non-NULL and non-ERR_PTR.  Then
we'd attempt do_add_mount(), without bothering to pass it expiry list.  And
do the same checks for return value, etc. we currently do in the method
instances; just remember that we have an extra vfsmount reference that will
need to be dropped and that we'll need to take the sucker off the expiry list
in case we decide we don't need it (again, namespace.c helper).

As the result, we stop abusing do_add_mount() in there.  Moreover, with
pending mnt_devname nfs rework we will be able to get rid of passing
vfsmount to ->d_automount(), AFAICT, which would be nice...
