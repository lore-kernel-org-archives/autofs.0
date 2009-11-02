From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 10/27] BKL: Remove BKL from autofs4
Date: Mon, 02 Nov 2009 19:13:53 +0800
Message-ID: <4AEEBEF1.8050807@themaw.net>
References: <1257156307-24175-1-git-send-email-jblunck@suse.de> <1257156307-24175-11-git-send-email-jblunck@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1257156307-24175-11-git-send-email-jblunck@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jan Blunck <jblunck@suse.de>
Cc: linux-fsdevel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Moyer <jmoyer@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, autofs@linux.kernel.org

Jan Blunck wrote:
> BKL is only used in fill_super. It is safe to remove it.

Yes, I think so too.
Of course this will make co-coordinating the rename of autofs4 to autofs
a bit more painful, ;)

> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>
Acked-by: Ian Kent <raven@themaw.net>

> ---
>  fs/autofs4/inode.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> index 3adaba9..69c8142 100644
> --- a/fs/autofs4/inode.c
> +++ b/fs/autofs4/inode.c
> @@ -323,8 +323,6 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
>  	struct autofs_sb_info *sbi;
>  	struct autofs_info *ino;
>  
> -	lock_kernel();
> -
>  	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>  	if (!sbi)
>  		goto fail_unlock;
> @@ -420,7 +418,6 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
>  	 * Success! Install the root dentry now to indicate completion.
>  	 */
>  	s->s_root = root;
> -	unlock_kernel();
>  	return 0;
>  	
>  	/*
> @@ -442,7 +439,6 @@ fail_free:
>  	kfree(sbi);
>  	s->s_fs_info = NULL;
>  fail_unlock:
> -	unlock_kernel();
>  	return -EINVAL;
>  }
>  

