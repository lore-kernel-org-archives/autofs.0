From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] fs/autofs: Fix sparse warning: context imbalance in
 'autofs4_d_automount' - different lock contexts for basic block
Date: Wed, 09 Jan 2013 15:16:56 +0800
Message-ID: <1357715816.11178.23.camel@perseus.themaw.net>
References: <1357224733-31251-1-git-send-email-peterhuewe@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=EK6ZR8S2j8BL8Ra9DoNEfZXXVQI=; b=OT0D5Mr7pBKhGPrX4MeOKAuxyPkS
	TLKgCPwbvr1P7UrSo+Fp6F/10cu7YHF+NuP13XjHaqiw3YqW78OR0N7GZim1czyg
	hABptyF+LNhoA7MGdkbNDfHyaDrxn4I68PQs0AV0iY8b+N2jL0VjIWFJKNDC4Mrx
	Vsx8vkNpZ7IBcwY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=EK6ZR8S2j8BL8Ra9DoNEfZXXVQI=; b=uMX
	moillyVik3HEVUbk3OLpumd199s+7GgI3X3W7M9an7Iofp7k9N1Tgz2pvyqhjf/F
	AySUgAyk/krUCTF7dfGFevQoWV4BhUdkW/6eU816tCThVgXUJU0eEsgTlkverW3W
	jhjmXsqpv29j2P5mucYYx7ZP/4qCb/1IvFV2dZ1Y=
In-Reply-To: <1357224733-31251-1-git-send-email-peterhuewe@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Peter Huewe <peterhuewe@gmx.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>

Hi all,

I see this hasn't been merged yet.
Do I need to re-post this (perhaps to Linus)?

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

