From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: improve scalability of direct mount path
 component creation
Date: Thu, 24 Mar 2016 09:23:08 +0800
Message-ID: <1458782588.2976.27.camel@themaw.net>
References: <56EC6897.7040409@suse.com> <56EC7267.6000103@suse.com>
	 <1458531845.3042.36.camel@themaw.net> <56F070F6.7030802@suse.com>
	 <1458606264.3014.20.camel@themaw.net> <56F0C11B.9000005@suse.com>
	 <56F152FA.1000205@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=4OMaHsurpEP343hnlilTI7jk/W8=; b=suzDLI
	wYG5VIRmOyJU2BZIbhBfyVP0Ah2j7aeEgb1uR2sQUgQqsdHiOnp0Eh07R9nd2H+c
	9Wv+0HLayUzTIsfj5X/fZXojK3ef3V0sldJYV1sGHbbUD+kmFfEIpcM7HmpaqyvS
	prRLAEpcqqDKpSrecNcyjZs0MltoxRtKcH5ZM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4OMaHsurpEP343h
	nlilTI7jk/W8=; b=B7Y31d5E1mzdkdve7ADtpETkEHiGljRR//o66RHrM+VCT3b
	WlSLU3Arr0xuMwXJerEA4reFLQ+mq5Qe9rvZ9OAhcqUV2Hv5luyGNaztWApnfuyA
	GR6rXdr4L0dzngH0LzF1y7tF3YgsLp4bNh5p/arjZ0ja/wsX9nWP39jTSSgg=
In-Reply-To: <56F152FA.1000205@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Mahoney <jeffm@suse.com>, autofs@vger.kernel.org

On Tue, 2016-03-22 at 10:13 -0400, Jeff Mahoney wrote:
> With direct mounts, we want to avoid creating path components on
> remote file systems unless that file system is the root file system.
> 
> The check boils down to allowing the mkdir if:
> 1/ If it's the root directory, or
> 2/ If it's not a remote file system, or
> 3/ If it's a remote file system that's the root file system
> 
> We can do that without parsing the mount table and can
> improve startup time for all cases.

This looks like it covers the important cases.

It's in the queue of patches I have for the next commit but I can't say
when that will be.

If there are other special cases that have been missed they'll need to
be reported and handled as they come up, the mount table traversal has
to go.

Thanks for your help.
Ian

> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  daemon/automount.c  | 56 +++++++++++++++++++++++++++++++++++++++-----
> ---------
>  include/automount.h |  2 ++
>  include/mounts.h    |  1 -
>  lib/mounts.c        | 45 ------------------------------------------
>  4 files changed, 44 insertions(+), 60 deletions(-)
> 
> diff --git a/daemon/automount.c b/daemon/automount.c
> index 74e62a1..9d07425 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -98,10 +98,25 @@ static int umount_all(struct autofs_point *ap, int
> force);
>  
>  extern struct master *master_list;
>  
> +static int is_remote_fstype(unsigned int fs_type)
> +{
> +	int ret = 0;
> +	switch (fs_type) {
> +	case SMB_SUPER_MAGIC:
> +	case CIFS_MAGIC_NUMBER:
> +	case NCP_SUPER_MAGIC:
> +	case NFS_SUPER_MAGIC:
> +		ret = 1;
> +		break;
> +	};
> +	return ret;
> +}
> +
>  static int do_mkdir(const char *parent, const char *path, mode_t
> mode)
>  {
>  	int status;
> -	struct stat st;
> +	mode_t mask;
> +	struct stat st, root;
>  	struct statfs fs;
>  
>  	/* If path exists we're done */
> @@ -114,24 +129,37 @@ static int do_mkdir(const char *parent, const
> char *path, mode_t mode)
>  	}
>  
>  	/*
> -	 * If we're trying to create a directory within an autofs fs
> -	 * or the path is contained in a localy mounted fs go ahead.
> +	 * We don't want to create the path on a remote file system
> +	 * unless it's the root file system.
> +	 * An empty parent means it's the root directory and always
> ok.
>  	 */
> -	status = -1;
> -	if (*parent)
> +	if (*parent) {
>  		status = statfs(parent, &fs);
> -	if ((status != -1 && fs.f_type == (__SWORD_TYPE)
> AUTOFS_SUPER_MAGIC) ||
> -	    contained_in_local_fs(path)) {
> -		mode_t mask = umask(0022);
> -		int ret = mkdir(path, mode);
> -		(void) umask(mask);
> -		if (ret == -1) {
> -			errno = EACCES;
> -			return 0;
> +		if (status == -1)
> +			goto fail;
> +
> +		if (is_remote_fstype(fs.f_type)) {
> +			status = stat(parent, &st);
> +			if (status == -1)
> +				goto fail;
> +
> +			status = stat("/", &root);
> +			if (status == -1)
> +				goto fail;
> +
> +			if (st.st_dev != root.st_dev)
> +				goto fail;
>  		}
> -		return 1;
>  	}
>  
> +	mask = umask(0022);
> +	status = mkdir(path, mode);
> +	(void) umask(mask);
> +	if (status == -1)
> +		goto fail;
> +
> +	return 1;
> +fail:
>  	errno = EACCES;
>  	return 0;
>  }
> diff --git a/include/automount.h b/include/automount.h
> index 2cf0611..c0f5fbf 100644
> --- a/include/automount.h
> +++ b/include/automount.h
> @@ -75,6 +75,8 @@ int load_autofs4_module(void);
>  #define AUTOFS_SUPER_MAGIC 0x00000187L
>  #define SMB_SUPER_MAGIC    0x0000517BL
>  #define CIFS_MAGIC_NUMBER  0xFF534D42L
> +#define NCP_SUPER_MAGIC    0x0000564CL
> +#define NFS_SUPER_MAGIC    0x00006969L
>  
>  /* This sould be enough for at least 20 host aliases */
>  #define HOST_ENT_BUF_SIZE	2048
> diff --git a/include/mounts.h b/include/mounts.h
> index cce646a..489025c 100644
> --- a/include/mounts.h
> +++ b/include/mounts.h
> @@ -101,7 +101,6 @@ int ext_mount_remove(struct list_head *, const
> char *);
>  struct mnt_list *get_mnt_list(const char *table, const char *path,
> int include);
>  struct mnt_list *reverse_mnt_list(struct mnt_list *list);
>  void free_mnt_list(struct mnt_list *list);
> -int contained_in_local_fs(const char *path);
>  int is_mounted(const char *table, const char *path, unsigned int
> type);
>  int has_fstab_option(const char *opt);
>  void tree_free_mnt_tree(struct mnt_list *tree);
> diff --git a/lib/mounts.c b/lib/mounts.c
> index 455bdca..1d1b4da 100644
> --- a/lib/mounts.c
> +++ b/lib/mounts.c
> @@ -941,51 +941,6 @@ void free_mnt_list(struct mnt_list *list)
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
