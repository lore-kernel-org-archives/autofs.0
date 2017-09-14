From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH 1/2] autofs: set compat flag on sbi when daemon uses
 32bit addressation
Date: Thu, 14 Sep 2017 08:38:02 +0800
Message-ID: <e86c66c6-7430-00e2-518a-cb2b87ab4130@themaw.net>
References: <20170901110906.2669.1577.stgit@localhost.localdomain>
 <20170901112144.2669.1453.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=XsASarR7mtDxXC+18o
        oUwhU7OFwAsZeHqcK/Hxqcr4Q=; b=VcS0iUHOFon++JtYFkrycCK8LfSNNFhJRb
        q5uwIaIRbJuS/OQScvAn1bPlm7QhhHBmtErFUtBm+F4P1wNgM4h6J9InjDNE7cmk
        B9SkdIOtgupBPiqlyxa0sogiVHSORbtSbF130l/UO6BYaptHCQ9s0/EA84LjXYsZ
        /9sTgEINDXap7m/iRNJrYSMuaLERb6QHxe4BiPX66y2F0Y+TsKMKwPk9wUg7Zn1o
        VDFSyR6OT9TfE1vjLz2jUd3ypSd04mxr8iMoUeEAmXBxl7/Fniy/hoxLbn+FmTAw
        EpPpejvI4l8zegRg7USPz1iz2sJuJNwvUK4DdNKh0QmO3KwD5Law==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=XsASarR7mtDxXC+18ooUwhU7OFwAsZeHqcK/Hxqcr4Q=; b=k103FsMg
        csw0l58tPdDM6yXzT+ZreKvdmJHrUcmxxZ3ogWVlD3zQGOsE+eUNSraf/G0btuAX
        BAfXmJKAluPLcUmOsigNybBj1b85MHJV07YNQnxF7ioufhmwZYOeX/nyu2VvB6cZ
        bUnVJJp47GTDQH3d2KXVcIRBcrl8TphtXpOG2xmt5fwfTgl7RxW2RYdqwRXaLJi1
        Ar4gx5KnWlGzMPx2t2+k7N3RaNhGxFb23sK6y+FJlfNd+X1o1DhNMQM708GXOBxq
        SDIsMku32ZDMdAIISsS/qRNwk7v8d+q2fiQ0UBh4IfUxSaOjBoV8kT1vnxlP76yq
        hMbTYwDjEAp4Fw==
In-Reply-To: <20170901112144.2669.1453.stgit@localhost.localdomain>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, devel@openvz.org, ldv@altlinux.org

On 01/09/17 19:21, Stanislav Kinsburskiy wrote:
> Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
> ---
>  fs/autofs4/autofs_i.h  |    3 +++
>  fs/autofs4/dev-ioctl.c |    3 +++
>  fs/autofs4/inode.c     |    4 +++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
> index 4737615..3da105f 100644
> --- a/fs/autofs4/autofs_i.h
> +++ b/fs/autofs4/autofs_i.h
> @@ -120,6 +120,9 @@ struct autofs_sb_info {
>  	struct list_head active_list;
>  	struct list_head expiring_list;
>  	struct rcu_head rcu;
> +#ifdef CONFIG_COMPAT
> +	unsigned is32bit:1;
> +#endif
>  };
>  
>  static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
> diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
> index b7c816f..467d6c4 100644
> --- a/fs/autofs4/dev-ioctl.c
> +++ b/fs/autofs4/dev-ioctl.c
> @@ -397,6 +397,9 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
>  		sbi->pipefd = pipefd;
>  		sbi->pipe = pipe;
>  		sbi->catatonic = 0;
> +#ifdef CONFIG_COMPAT
> +		sbi->is32bit = is_compat_task();
> +#endif
>  	}
>  out:
>  	put_pid(new_pid);
> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> index 09e7d68..21d3c0b 100644
> --- a/fs/autofs4/inode.c
> +++ b/fs/autofs4/inode.c
> @@ -301,7 +301,9 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
>  	} else {
>  		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
>  	}
> -
> +#ifdef CONFIG_COMPAT
> +	sbi->is32bit = is_compat_task();
> +#endif
>  	if (autofs_type_trigger(sbi->type))
>  		__managed_dentry_set_managed(root);
>  
> 

Not sure about this.

Don't you think it would be better to avoid the in code #ifdefs by doing some
checks and defines in the header file and defining what's need to just use
is_compat_task().

Not sure 2 patches are needed for this either ......

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
