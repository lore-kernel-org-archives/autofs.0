From: Ian Kent <raven@themaw.net>
Subject: Re: [rfc][patch] fs: dcache remove d_mounted
Date: Fri, 09 Oct 2009 13:47:20 +0800
Message-ID: <4ACECE68.70009@themaw.net>
References: <20091009025621.GB4287@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20091009025621.GB4287@wotan.suse.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

Nick Piggin wrote:
> Hi,
> 
> I'd just like to ask you to look at autofs4 in the context of this change.
> I don't really know what needs to be considered there. If this is a
> generally visible dentry that any other users may mount filesystems on,
> then this might be difficult to get working here.
> 
> I'm not quite sure what games you're playing here with d_mounted... In the
> simplest case we might be able to just remove DCACHE_MOUNTED.

Hahaha, "games", harsh but true.

My need is fairly simple really.

I must be able to stop the follow down at the mount point for some cases
of a covered dentry. Which, IIRC, means that d_mountpoint() needs to be
sensitive to this requirement, and that's about all.

This was always questionable, but seemed like the best way to do it at
the time, without adding autofs specific code to the VFS. Since we are
changing this part of the VFS now with this patch, it is a good time to
fix it in a generic non-autofs specific way.

> 
> Anyway this would be great if we can make it work so I can replace the
> member with d_seq for my path walk patches and not bloat dentry. Can you
> take a look please if you have a chance?

Sure, let me have a look around and think about it for a while.

From a quick look it appears that all I could just change the
DCACHE_MOUNTED flag and check the actual mounted status when restoring it.

> --
> 
> XXX: breaks autofs4, have to work out what it is doing. We can get a mounted
> count if needed by counting the hashtable.
> ---
>  fs/dcache.c            |    1 -
>  fs/namespace.c         |   19 +++++++++++++++----
>  include/linux/dcache.h |   42 +++++++++++++++++++++---------------------
>  3 files changed, 36 insertions(+), 26 deletions(-)
> 
> Index: linux-2.6/fs/dcache.c
> ===================================================================
> --- linux-2.6.orig/fs/dcache.c
> +++ linux-2.6/fs/dcache.c
> @@ -1192,7 +1192,6 @@ struct dentry *d_alloc(struct dentry * p
>  	dentry->d_sb = NULL;
>  	dentry->d_op = NULL;
>  	dentry->d_fsdata = NULL;
> -	dentry->d_mounted = 0;
>  	INIT_HLIST_NODE(&dentry->d_hash);
>  	INIT_LIST_HEAD(&dentry->d_lru);
>  	INIT_LIST_HEAD(&dentry->d_subdirs);
> Index: linux-2.6/fs/namespace.c
> ===================================================================
> --- linux-2.6.orig/fs/namespace.c
> +++ linux-2.6/fs/namespace.c
> @@ -574,6 +574,15 @@ static void __touch_mnt_namespace(struct
>  	}
>  }
>  
> +static void dentry_reset_mounted(struct vfsmount *mnt, struct dentry *dentry)
> +{
> +	if (!__lookup_mnt(mnt, dentry, 0)) {
> +		spin_lock(&dentry->d_lock);
> +		dentry->d_flags &= ~DCACHE_MOUNTED;
> +		spin_unlock(&dentry->d_lock);
> +	}
> +}
> +
>  static void detach_mnt(struct vfsmount *mnt, struct path *old_path)
>  {
>  	old_path->dentry = mnt->mnt_mountpoint;
> @@ -582,7 +591,7 @@ static void detach_mnt(struct vfsmount *
>  	mnt->mnt_mountpoint = mnt->mnt_root;
>  	list_del_init(&mnt->mnt_hash);
>  	list_del_init(&mnt->mnt_child);
> -	old_path->dentry->d_mounted--;
> +	dentry_reset_mounted(old_path->mnt, old_path->dentry);
>  	WARN_ON(mnt->mnt_mounted != 1);
>  	mnt->mnt_mounted--;
>  }
> @@ -591,8 +600,10 @@ void mnt_set_mountpoint(struct vfsmount
>  			struct vfsmount *child_mnt)
>  {
>  	child_mnt->mnt_parent = mntget(mnt);
> -	child_mnt->mnt_mountpoint = dget(dentry);
> -	dentry->d_mounted++;
> +	spin_lock(&dentry->d_lock);
> +	child_mnt->mnt_mountpoint = dget_dlock(dentry);
> +	dentry->d_flags |= DCACHE_MOUNTED;
> +	spin_unlock(&dentry->d_lock);
>  }
>  
>  static void attach_mnt(struct vfsmount *mnt, struct path *path)
> @@ -1170,7 +1181,7 @@ void umount_tree(struct vfsmount *mnt, i
>  		p->mnt_mounted--;
>  		if (p->mnt_parent != p) {
>  			p->mnt_parent->mnt_ghosts++;
> -			p->mnt_mountpoint->d_mounted--;
> +			dentry_reset_mounted(p->mnt_parent, p->mnt_mountpoint);
>  		}
>  		change_mnt_propagation(p, MS_PRIVATE);
>  	}
> Index: linux-2.6/include/linux/dcache.h
> ===================================================================
> --- linux-2.6.orig/include/linux/dcache.h
> +++ linux-2.6/include/linux/dcache.h
> @@ -83,14 +83,13 @@ full_name_hash(const unsigned char *name
>  #ifdef CONFIG_64BIT
>  #define DNAME_INLINE_LEN_MIN 32 /* 192 bytes */
>  #else
> -#define DNAME_INLINE_LEN_MIN 40 /* 128 bytes */
> +#define DNAME_INLINE_LEN_MIN 44 /* 128 bytes */
>  #endif
>  
>  struct dentry {
>  	unsigned int d_count;		/* protected by d_lock */
>  	unsigned int d_flags;		/* protected by d_lock */
>  	spinlock_t d_lock;		/* per dentry lock */
> -	int d_mounted;
>  	struct inode *d_inode;		/* Where the name belongs to - NULL is
>  					 * negative */
>  	/*
> @@ -161,30 +160,31 @@ d_iput:		no		no       yes
>  
>  /* d_flags entries */
>  #define DCACHE_AUTOFS_PENDING 0x0001    /* autofs: "under construction" */
> -#define DCACHE_NFSFS_RENAMED  0x0002    /* this dentry has been "silly
> -					 * renamed" and has to be
> -					 * deleted on the last dput()
> -					 */
> -#define	DCACHE_DISCONNECTED 0x0004
> -     /* This dentry is possibly not currently connected to the dcache tree,
> -      * in which case its parent will either be itself, or will have this
> -      * flag as well.  nfsd will not use a dentry with this bit set, but will
> -      * first endeavour to clear the bit either by discovering that it is
> -      * connected, or by performing lookup operations.   Any filesystem which
> -      * supports nfsd_operations MUST have a lookup function which, if it finds
> -      * a directory inode with a DCACHE_DISCONNECTED dentry, will d_move
> -      * that dentry into place and return that dentry rather than the passed one,
> -      * typically using d_splice_alias.
> -      */
> +#define DCACHE_NFSFS_RENAMED  0x0002
> +     /* this dentry has been "silly renamed" and has to be deleted on the last
> +      * dput() */
> +
> +#define	DCACHE_DISCONNECTED	0x0004
> +     /* This dentry is possibly not currently connected to the dcache tree, in
> +      * which case its parent will either be itself, or will have this flag as
> +      * well.  nfsd will not use a dentry with this bit set, but will first
> +      * endeavour to clear the bit either by discovering that it is connected,
> +      * or by performing lookup operations.   Any filesystem which supports
> +      * nfsd_operations MUST have a lookup function which, if it finds a
> +      * directory inode with a DCACHE_DISCONNECTED dentry, will d_move that
> +      * dentry into place and return that dentry rather than the passed one,
> +      * typically using d_splice_alias. */
>  
>  #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
>  #define DCACHE_UNHASHED		0x0010	
> -
> -#define DCACHE_INOTIFY_PARENT_WATCHED	0x0020 /* Parent inode is watched by inotify */
> +#define DCACHE_INOTIFY_PARENT_WATCHED 0x0020
> +     /* Parent inode is watched by inotify */
>  
>  #define DCACHE_COOKIE		0x0040	/* For use by dcookie subsystem */
> +#define DCACHE_FSNOTIFY_PARENT_WATCHED 0x0080
> +     /* Parent inode is watched by some fsnotify listener */
>  
> -#define DCACHE_FSNOTIFY_PARENT_WATCHED	0x0080 /* Parent inode is watched by some fsnotify listener */
> +#define DCACHE_MOUNTED		0x0100	/* is a mountpoint */
>  
>  extern seqlock_t rename_lock;
>  
> @@ -349,7 +349,7 @@ extern void dput(struct dentry *);
>  
>  static inline int d_mountpoint(struct dentry *dentry)
>  {
> -	return dentry->d_mounted;
> +	return dentry->d_flags & DCACHE_MOUNTED;
>  }
>  
>  extern struct vfsmount *lookup_mnt(struct path *);
