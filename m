From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] autofs4 - follow_link missing funtionality
Date: Fri, 10 Mar 2006 14:50:16 -0800
Message-ID: <20060310145016.39b028be.akpm@osdl.org>
References: <Pine.LNX.4.64.0603102003110.3032@eagle.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0603102003110.3032@eagle.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:
>
> @@ -337,10 +340,34 @@ static void *autofs4_follow_link(struct 
>  	if (oz_mode || !lookup_type)
>  		goto done;
>  
> +	/*
> +	 * If the dentry contains directories then it is an
> +	 * autofs multi-mount with no root offset. So don't
> +	 * try to mount it again.
> +	 */
> +	spin_lock(&dcache_lock);
> +	if (!list_empty(&dentry->d_subdirs)) {
> +		spin_unlock(&dcache_lock);
> +		goto done;
> +	}
> +	spin_unlock(&dcache_lock);
> +

Can list_empty(&dentry->d_subdirs) become false right here, after the lock
was dropped?  If so, what happens?


>  	status = try_to_fill_dentry(dentry, 0);
