From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs - fix fix symlinks arent checked for expiry
Date: Thu, 26 Dec 2013 13:42:53 -0800
Message-ID: <20131226134253.5f4b2f02a00e11b8de49770e@linux-foundation.org>
References: <20131224094459.20051.4889.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20131224094459.20051.4889.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 24 Dec 2013 17:44:59 +0800 Ian Kent <raven@themaw.net> wrote:

> When following a symlink the last_used counter is unconditionally
> updated causing the expire checks from user space to prevent
> expiry. Opps!

A bit unclear.  You're saying that userspace's act of checking expiry
status will itself disrupt the expiry process?

Also, it's rather unclear what the userspace impact is here, and how
severe it is.  Please always carefully describe the user-visible impact
so that others can decide which kernel version(s) need the patch.

> --- a/fs/autofs4/symlink.c
> +++ b/fs/autofs4/symlink.c
> @@ -14,8 +14,9 @@
>  
>  static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
>  {
> +	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
>  	struct autofs_info *ino = autofs4_dentry_ino(dentry);
> -	if (ino)
> +	if (ino && !autofs4_oz_mode(sbi))
>  		ino->last_used = jiffies;
>  	nd_set_link(nd, dentry->d_inode->i_private);
>  	return NULL;

What kernel is this against?  3.13-rc5 is quite different:

static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
{
	nd_set_link(nd, dentry->d_inode->i_private);
	return NULL;
}

