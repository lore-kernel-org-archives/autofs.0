From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4/root.c: quiet sparse noise
Date: Sat, 10 Sep 2011 14:12:18 +0800
Message-ID: <1315635138.3171.1.camel@perseus.themaw.net>
References: <201109091717.02975.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:from:to:cc:in-reply-to:references
	:content-type:date:message-id:mime-version
	:content-transfer-encoding; s=smtpout; bh=Vbo1MuFROt0FpZuX4/t8Uc
	mI9Ss=; b=HOesqnJPgWCa24AaWODDmWUJeypsFQ8iYGbvxPFJx8Qank4iRvTxT9
	ZIpHeeu1pvk+MxLjtmft4aXiKRG2f7tlpYw38pv43LuZMh6ZnGLefBpdvWyVI8qi
	kqKJ20F88JBCVpP3k2Syo4zExEXER/XW+qRC2JM4cTa0isHcHh0Rk=
In-Reply-To: <201109091717.02975.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org

On Fri, 2011-09-09 at 17:17 -0700, H Hartley Sweeten wrote:
> The function autofs4_d_manage is prototyped as a static function.
> Add static to the function to quiet the sparse noise:
> 
> warning: symbol 'autofs4_d_manage' was not declared. Should it be static?
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ian Kent <raven@themaw.net>

Thought I had done that in the original series ....
Acked-by: Ian Kent <raven@themaw.net>

> 
> ---
> 
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index f55ae23..366a9f2 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -427,7 +427,7 @@ done:
>  	return NULL;
>  }
>  
> -int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
> +static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
>  {
>  	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
>  

