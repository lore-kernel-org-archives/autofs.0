From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] fs/autofs: Fix sparse warning: context imbalance in
 'autofs4_d_automount' - different lock contexts for basic block
Date: Fri, 04 Jan 2013 07:54:01 +0800
Message-ID: <1357257241.2207.2.camel@perseus.themaw.net>
References: <1357224733-31251-1-git-send-email-peterhuewe@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=iYSwJ6r4nseTXKwcHWC5/RiGoMg=; b=DODbaXd0/6VVxSyQPaSfnRcRFchY
	ciLozIAcI2G7qQ4lk5joW99jcdSZqoYgxlQutJ0003kn+mSR5atcW3nDHZpdxvHw
	vMNFP/aLYMIhDOpTzccKQaC5uK9RPmKIff78vqfzesnv5wSNQmB81UBP2CWIjsLg
	e1YnfzuBPPm89OM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=iYSwJ6r4nseTXKwcHWC5/RiGoMg=; b=aWU
	q8LsDYqUk0cf5dsPu/KIYxO00oI96TgyOdoN/q4MQt+unwT963jxoaSgT1t23Rvw
	GxXCQEv1IQD+MmG1XYnXGyoOJVYsBaSj2HCN9xS1j0YaQ2rExomvIuH/yO6RGr3n
	Z1V7xxocibTxnsxwzqTIiILBqK3t0OPWFNeJts+M=
In-Reply-To: <1357224733-31251-1-git-send-email-peterhuewe@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Peter Huewe <peterhuewe@gmx.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>

On Thu, 2013-01-03 at 15:52 +0100, Peter Huewe wrote:
> Sparse complains:
> + fs/autofs4/root.c:409:9: sparse: context imbalance in
> 'autofs4_d_automount' - different lock contexts for basic block
> 
> This was introduced by commit
> f55fb0c243 autofs4 - dont clear DCACHE_NEED_AUTOMOUNT on rootless mount
> 
> The function autofs4_d_automount can be left with the (&sbi->fs_lock)
> held if sbi->version <= 4 and simple_empty(dentry) == false so the warning seems valid.
> 
> --> Add an spin_unlock in this case before we jump to done
> 
> Unfortunately compile tested only.
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Yes, good catch, it looks right to me.
Acked-by: Ian Kent <raven@themaw.net>

> ---
>  fs/autofs4/root.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index c934476..74a299f 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -383,8 +383,10 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
>  				goto done;
>  			}
>  		} else {
> -			if (!simple_empty(dentry))
> +			if (!simple_empty(dentry)) {
> +				spin_unlock(&sbi->fs_lock);
>  				goto done;
> +			}
>  		}
>  		ino->flags |= AUTOFS_INF_PENDING;
>  		spin_unlock(&sbi->fs_lock);

