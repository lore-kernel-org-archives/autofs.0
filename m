From: Ian Kent <raven@themaw.net>
Subject: Re: [rfc][patch] fs: dcache remove d_mounted
Date: Fri, 09 Oct 2009 19:53:41 +0800
Message-ID: <4ACF2445.3000205@themaw.net>
References: <20091009025621.GB4287@wotan.suse.de> <4ACECE68.70009@themaw.net> <20091009074211.GD2983@wotan.suse.de> <4ACEED94.6040002@themaw.net> <20091009080709.GA17818@wotan.suse.de> <4ACEF0FA.1060605@themaw.net> <20091009083335.GB17818@wotan.suse.de> <4ACEFAB3.4050904@themaw.net> <20091009095944.GC17818@wotan.suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20091009095944.GC17818@wotan.suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Nick Piggin <npiggin@suse.de>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

Nick Piggin wrote:
> 
> Cool, well I look forward to your reviewing the changes when I get
> a bit further down the track. In the meantime, here is the d_mounted
> patch diffed against rc3.

The autofs4 bit of the patch below isn't quite how this is supposed to
work. I'll have a look and see if I can make the appropriate change.

> 
> --
> 
> Rather than keep a d_mounted count in the dentry (which is only used to
> speculatively take a look in the mount hash table if it is non-zero), set
> a dentry flag instead. The flag can be cleared by checking the hash table
> to see if there are any mounts left. It is not time critical because it
> is performed at detach time.
> 
> This saves 4 bytes on 32-bit, nothing on 64-bit but it does provide a hole
> which I might use later.
> ---
>  fs/autofs4/expire.c    |    8 ++++++--
>  fs/dcache.c            |    1 -
>  fs/namespace.c         |   19 +++++++++++++++----
>  include/linux/dcache.h |   42 +++++++++++++++++++++---------------------
>  4 files changed, 42 insertions(+), 28 deletions(-)
> 
> Index: linux-2.6/fs/dcache.c
> ===================================================================
> --- linux-2.6.orig/fs/dcache.c
> +++ linux-2.6/fs/dcache.c
> @@ -947,7 +947,6 @@ struct dentry *d_alloc(struct dentry * p
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
> @@ -467,6 +467,15 @@ static void __touch_mnt_namespace(struct
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
> @@ -475,15 +484,17 @@ static void detach_mnt(struct vfsmount *
>  	mnt->mnt_mountpoint = mnt->mnt_root;
>  	list_del_init(&mnt->mnt_child);
>  	list_del_init(&mnt->mnt_hash);
> -	old_path->dentry->d_mounted--;
> +	dentry_reset_mounted(old_path->mnt, old_path->dentry);
>  }
>  
>  void mnt_set_mountpoint(struct vfsmount *mnt, struct dentry *dentry,
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
> @@ -1015,7 +1026,7 @@ void umount_tree(struct vfsmount *mnt, i
>  		list_del_init(&p->mnt_child);
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
>  	atomic_t d_count;
>  	unsigned int d_flags;		/* protected by d_lock */
>  	spinlock_t d_lock;		/* per dentry lock */
> -	int d_mounted;
>  	struct inode *d_inode;		/* Where the name belongs to - NULL is
>  					 * negative */
>  	/*
> @@ -161,30 +160,31 @@ d_iput:		no		no		no       yes
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
>  extern spinlock_t dcache_lock;
>  extern seqlock_t rename_lock;
> @@ -372,7 +372,7 @@ extern void dput(struct dentry *);
>  
>  static inline int d_mountpoint(struct dentry *dentry)
>  {
> -	return dentry->d_mounted;
> +	return dentry->d_flags & DCACHE_MOUNTED;
>  }
>  
>  extern struct vfsmount *lookup_mnt(struct path *);
> Index: linux-2.6/fs/autofs4/expire.c
> ===================================================================
> --- linux-2.6.orig/fs/autofs4/expire.c
> +++ linux-2.6/fs/autofs4/expire.c
> @@ -276,7 +276,9 @@ struct dentry *autofs4_expire_direct(str
>  		struct autofs_info *ino = autofs4_dentry_ino(root);
>  		if (d_mountpoint(root)) {
>  			ino->flags |= AUTOFS_INF_MOUNTPOINT;
> -			root->d_mounted--;
> +			spin_lock(&root->d_lock);
> +			root->d_flags &= ~DCACHE_MOUNTED;
> +			spin_unlock(&root->d_lock);
>  		}
>  		ino->flags |= AUTOFS_INF_EXPIRING;
>  		init_completion(&ino->expire_complete);
> @@ -499,7 +501,9 @@ int autofs4_do_expire_multi(struct super
>  
>  		spin_lock(&sbi->fs_lock);
>  		if (ino->flags & AUTOFS_INF_MOUNTPOINT) {
> -			sb->s_root->d_mounted++;
> +			spin_lock(&sb->s_root->d_lock);
> +			sb->s_root->d_flags |= DCACHE_MOUNTED;
> +			spin_unlock(&sb->s_root->d_lock);
>  			ino->flags &= ~AUTOFS_INF_MOUNTPOINT;
>  		}
>  		ino->flags &= ~AUTOFS_INF_EXPIRING;

