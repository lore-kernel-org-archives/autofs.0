From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: fix contained_in_local_fs and improve
 scalability
Date: Mon, 21 Mar 2016 11:44:05 +0800
Message-ID: <1458531845.3042.36.camel@themaw.net>
References: <56EC6897.7040409@suse.com> <56EC7267.6000103@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=pEjpP5fOJwd+wNjg6/TBVMcpx8w=; b=sV2NeK
	8T69TSPs2QKWuosr3S+G4VkGVyFshIFW+Lg4K3CwDKeMC8fkzewA1Dul+dYnmDxd
	/3Z0yHiBORl5cXlwfy8/ldIuqVT+bOpOMfHsEoos3dCkehqCeS92Rk5wwo5RwKJB
	YsZjW3G54SjuL/KKAT+SKhWP/sRqR+cIjsTdE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=pEjpP5fOJwd+wNj
	g6/TBVMcpx8w=; b=CBznKQzCoVBpTYaqZ9f1GsB1eQ+Mjt6FdRdT9NeVSNyLk6Z
	RKzF359aJe/GK6AGDNnegjHCPVHNhzy10ngj0wrZ9XUWj7z0eAcXoKMnKuHG34em
	notzhnriI4o9twD/6N8EdMraYR0F9ZolcPZxZek0Jyw7fy/kpTBsfqW8R8TY=
In-Reply-To: <56EC7267.6000103@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Mahoney <jeffm@suse.com>, autofs@vger.kernel.org

On Fri, 2016-03-18 at 17:25 -0400, Jeff Mahoney wrote:
> Commit d3ce65e05d1 (autofs-5.0.3 - allow directory create on NFS
> root),
> introduced a bug where contained_in_local_fs would *always* return
> true. 
> 
> Since the goal of contained_in_local_fs is only to determine if the
> path would be created on a local file system, it's enough to check a
> few things directly without parsing the mount table at all.
> 
> We can check via stat calls:
> 1) If parent is the root directory
> 2) If the parent is located on the root file system
> 3) If the parent is located within a file system mounted
>    via a block device
> 
> Large numbers of direct mounts when using /proc/self/mounts instead
> of /etc/mtab result in very slow startup time.  In testing, we
> observed
> ~8k mounts taking over 6 hours to complete.

When this was originally done the mtab was (usually) an actual file so
the autofs mounts weren't present. So mostly it was fairly small.

But now, with the symlinking of the mtab to a proc filesystem, this is a
big problem. 

> 
> This is due to reading /proc/self/mounts for every path component of
> every mount.  For my test case, that turns out to be about 119k times
> for a total of just under 400 GB read.  If it were a flat file, it
> would be also be slow, but /proc/self/mounts is dynamically generated
> every time it's read.
> 
> By avoiding reading /proc/self/mounts many times, startup time with 8k
> direct mounts drops from ~6 hours to about 25 seconds.

Yeah, I get that.

In some tests done before the symlinking became the norm I saw direct
mount tables of over 20k entries taking between 20-30 seconds or a bit
more (can't quite remember now, it was a long time ago) but nothing like
this.

I thought that was bad so this really needs to be fixed.

I am puzzled why I haven't seen other bug reports.

> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  daemon/automount.c |   47
> ++++++++++++++++++++++++++++++++++++++++++++---
>  include/mounts.h   |    1 -
>  lib/mounts.c       |   45 -------------------------------------------
> --
>  3 files changed, 44 insertions(+), 49 deletions(-)
> 
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -98,6 +98,46 @@ static int umount_all(struct autofs_poin
>  
>  extern struct master *master_list;
>  
> +#define SYSFS_PATTERN "/sys/dev/block/%d:%d"
> +static int contained_in_local_fs(const char *parent)
> +{
> +	char buf[128];
> +	struct stat st, root;
> +	int ret;
> +
> +	/* The root directory is always considered local, even if
> it's not. */
> +	if (!*parent)
> +		return 1;
> +
> +	ret = stat("/", &root);
> +	if (ret != 0) {
> +		logerr("error: stat failed on /: %s",
> strerror(errno));
> +		return 0;
> +	}
> +
> +	ret = stat(parent, &st);
> +	if (ret)
> +		return 0;
> +	/*
> +	 * If the parent is on the root file system, it's local.
> +	 */
> +	if (root.st_dev == st.st_dev)
> +		return 1;

I'm struggling to remember now.

I think the problem was only when the root itself was an NFS file system
and automount was trying to create a directory.

> +
> +	/*
> +	 * If the sysfs node for the block device exists, it's local.
> +	 */
> +	ret = snprintf(buf, sizeof(buf), SYSFS_PATTERN,
> +		       major(st.st_dev), minor(st.st_dev));
> +	if (ret != 0) {
> +		logerr("error: not enough space for sysfs path");
> +		return 0;
> +	}

This is the only bit that concerns me.

Not because I think it's wrong, on the contrary, it looks ok.

I just can't think of cases where it might not cover what's needed.

After all, it's already been checked if the parent is an autofs
filesystem which should take care of the bulk of cases except for longer
direct mount paths, but will often not be the case for offset mounts.

For example a mount entry with offset mounts like:

<direct or indirect key>     /      server:/path \
                             /other server:/otherpath \
                             ...

But the intermediate path components of a direct mount path (and offset
mount path) must already exist if within a remote mount. So the existenc
e case, checked before this, should cover these cases.

Let me think about it a little longer.

> +
> +	ret = stat(buf, &st);
> +	return (ret == 0);
> +}
> +
>  static int do_mkdir(const char *parent, const char *path, mode_t
> mode)
>  {
>  	int status;
> @@ -114,14 +154,15 @@ static int do_mkdir(const char *parent,
>  	}
>  
>  	/*
> -	 * If we're trying to create a directory within an autofs fs
> -	 * or the path is contained in a localy mounted fs go ahead.
> +	 * If we're trying to create a directory within an autofs fs,
> +	 * the parent is the root directory, or the path is contained
> +	 * in a locally mounted fs go ahead.
>  	 */
>  	status = -1;
>  	if (*parent)
>  		status = statfs(parent, &fs);
>  	if ((status != -1 && fs.f_type == (__SWORD_TYPE)
> AUTOFS_SUPER_MAGIC) ||
> -	    contained_in_local_fs(path)) {
> +	    contained_in_local_fs(parent)) {
>  		mode_t mask = umask(0022);
>  		int ret = mkdir(path, mode);
>  		(void) umask(mask);
> --- a/include/mounts.h
> +++ b/include/mounts.h
> @@ -96,7 +96,6 @@ char *make_mnt_name_string(char *path);
>  struct mnt_list *get_mnt_list(const char *table, const char *path,
> int include);
>  struct mnt_list *reverse_mnt_list(struct mnt_list *list);
>  void free_mnt_list(struct mnt_list *list);
> -int contained_in_local_fs(const char *path);
>  int is_mounted(const char *table, const char *path, unsigned int
> type);
>  int has_fstab_option(const char *opt);
>  char *get_offset(const char *prefix, char *offset,
> --- a/lib/mounts.c
> +++ b/lib/mounts.c
> @@ -636,51 +636,6 @@ void free_mnt_list(struct mnt_list *list
>  	}
>  }
>  
> -int contained_in_local_fs(const char *path)
> -{
> -	struct mnt_list *mnts, *this;
> -	size_t pathlen = strlen(path);
> -	int ret;
> -
> -	if (!path || !pathlen || pathlen > PATH_MAX)
> -		return 0;
> -
> -	mnts = get_mnt_list(_PATH_MOUNTED, "/", 1);
> -	if (!mnts)
> -		return 0;
> -
> -	ret = 0;
> -
> -	for (this = mnts; this != NULL; this = this->next) {
> -		size_t len = strlen(this->path);
> -
> -		if (!strncmp(path, this->path, len)) {
> -			if (len > 1 && pathlen > len && path[len] !=
> '/')
> -				continue;
> -			else if (len == 1 && this->path[0] == '/') {
> -				/*
> -				 * always return true on rootfs, we
> don't
> -				 * want to break diskless clients.
> -				 */
> -				ret = 1;
> -			} else if (this->fs_name[0] == '/') {
> -				if (strlen(this->fs_name) > 1) {
> -					if (this->fs_name[1] != '/')
> -						ret = 1;
> -				} else
> -					ret = 1;
> -			} else if (!strncmp("LABEL=", this->fs_name,
> 6) ||
> -				   !strncmp("UUID=", this->fs_name,
> 5))
> -				ret = 1;
> -			break;
> -		}
> -	}
> -
> -	free_mnt_list(mnts);
> -
> -	return ret;
> -}
> -
>  static int table_is_mounted(const char *table, const char *path,
> unsigned int type)
>  {
>  	struct mntent *mnt;
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
