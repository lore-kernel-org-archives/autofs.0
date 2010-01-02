From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super
 block info
Date: Sat, 2 Jan 2010 08:44:25 +0800
Message-ID: <20100102004423.GA2131@zeus.themaw.net>
References: <1261611423-4396-1-git-send-email-vaurora@redhat.com>
 <1261611423-4396-2-git-send-email-vaurora@redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=smtpout; bh=APxCr3o4fkY6lS+Ezap2WAZ5brY=; b=km6k+QRXYf/FA+UjdILRDt/pOF+hTolFg/cpRMfcO/qqzCPuP49uSJ9a1aIZIX+45FQvq7nhRJO7RV60pAPTyCT7VxjUVkw0DKBcBCWVvnb7zZFTaCBqvp7GsKOyM0yzvYlZ/PIvWp+w98uMT9Wmmrs0+gb2PziPrsoKbRZmczw=
Content-Disposition: inline
In-Reply-To: <1261611423-4396-2-git-send-email-vaurora@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valerie Aurora <vaurora@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>, autofs@linux.kernel.org

On Wed, Dec 23, 2009 at 03:36:57PM -0800, Valerie Aurora wrote:
> From: Jan Blunck <jblunck@suse.de>
> 
> This is a bugfix/replacement for commit
> 051d381259eb57d6074d02a6ba6e90e744f1a29f:
> 
>     During a path walk if an autofs trigger is mounted on a dentry,
>     when the follow_link method is called, the nameidata struct
>     contains the vfsmount and mountpoint dentry of the parent mount
>     while the dentry that is passed in is the root of the autofs
>     trigger mount.  I believe it is impossible to get the vfsmount of
>     the trigger mount, within the follow_link method, when only the
>     parent vfsmount and the root dentry of the trigger mount are
>     known.
> 
> The solution in this commit was to replace the path embedded in the
> parent's nameidata with the path of the link itself in
> __do_follow_link().  This is a relatively harmless misuse of the
> field, but union mounts ran into a bug during follow_link() caused by
> the nameidata containing the wrong path (we count on it being what it
> is all other places - the path of the parent).
> 
> A cleaner and easier to understand solution is to save the necessary
> vfsmount in the autofs superblock info when it is mounted.  Then we
> can easily update the vfsmount in autofs4_follow_link().
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>
> Signed-off-by: Valerie Aurora <vaurora@redhat.com>
Acked-by: <raven@themaw.net>

Don't know how I missed such an obvious solution when I did this.
Thanks, Ian

> Cc: Ian Kent <raven@themaw.net>
> Cc: autofs@linux.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/autofs4/autofs_i.h |    1 +
>  fs/autofs4/init.c     |   11 ++++++++++-
>  fs/autofs4/root.c     |    6 ++++++
>  fs/namei.c            |    7 ++-----
>  4 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
> index 8f7cdde..db2bfce 100644
> --- a/fs/autofs4/autofs_i.h
> +++ b/fs/autofs4/autofs_i.h
> @@ -130,6 +130,7 @@ struct autofs_sb_info {
>  	int reghost_enabled;
>  	int needs_reghost;
>  	struct super_block *sb;
> +	struct vfsmount *mnt;
>  	struct mutex wq_mutex;
>  	spinlock_t fs_lock;
>  	struct autofs_wait_queue *queues; /* Wait queue pointer */
> diff --git a/fs/autofs4/init.c b/fs/autofs4/init.c
> index 9722e4b..5e0dcd7 100644
> --- a/fs/autofs4/init.c
> +++ b/fs/autofs4/init.c
> @@ -17,7 +17,16 @@
>  static int autofs_get_sb(struct file_system_type *fs_type,
>  	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
>  {
> -	return get_sb_nodev(fs_type, flags, data, autofs4_fill_super, mnt);
> +	struct autofs_sb_info *sbi;
> +	int ret;
> +
> +	ret = get_sb_nodev(fs_type, flags, data, autofs4_fill_super, mnt);
> +	if (ret)
> +		return ret;
> +
> +	sbi = autofs4_sbi(mnt->mnt_sb);
> +	sbi->mnt = mnt;
> +	return 0;
>  }
>  
>  static struct file_system_type autofs_fs_type = {
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index b96a3c5..cb991b8 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -179,6 +179,12 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
>  	DPRINTK("dentry=%p %.*s oz_mode=%d nd->flags=%d",
>  		dentry, dentry->d_name.len, dentry->d_name.name, oz_mode,
>  		nd->flags);
> +
> +	dput(nd->path.dentry);
> +	mntput(nd->path.mnt);
> +	nd->path.mnt = mntget(sbi->mnt);
> +	nd->path.dentry = dget(dentry);
> +
>  	/*
>  	 * For an expire of a covered direct or offset mount we need
>  	 * to break out of follow_down() at the autofs mount trigger
> diff --git a/fs/namei.c b/fs/namei.c
> index d11f404..c768444 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -629,11 +629,8 @@ static __always_inline int __do_follow_link(struct path *path, struct nameidata
>  	touch_atime(path->mnt, dentry);
>  	nd_set_link(nd, NULL);
>  
> -	if (path->mnt != nd->path.mnt) {
> -		path_to_nameidata(path, nd);
> -		dget(dentry);
> -	}
> -	mntget(path->mnt);
> +	if (path->mnt == nd->path.mnt)
> +		mntget(nd->path.mnt);
>  	cookie = dentry->d_inode->i_op->follow_link(dentry, nd);
>  	error = PTR_ERR(cookie);
>  	if (!IS_ERR(cookie)) {
> -- 
> 1.5.6.5
> 
