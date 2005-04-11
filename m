From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] autofs4 - expiring filesystem from under process
Date: Mon, 11 Apr 2005 00:01:04 -0700
Message-ID: <20050411000104.430e26fb.akpm@osdl.org>
References: <Pine.LNX.4.62.0504102048370.5212@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504102048370.5212@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: michael@kmaclub.com, linux-fsdevel@vger.kernel.org, jmoyer@redhat.com, autofs@linux.kernel.org

raven@themaw.net wrote:
>
>   static inline int autofs4_ispending(struct dentry *dentry)
>    {
>    	struct autofs_info *inf = autofs4_dentry_ino(dentry);
>  +	int pending;
> 
>  -	return (dentry->d_flags & DCACHE_AUTOFS_PENDING) ||
>  -		(inf != NULL && inf->flags & AUTOFS_INF_EXPIRING);
>  +	if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
>  +		return 1;
>  +
>  +	if (inf) {
>  +		spin_lock(&inf->sbi->fs_lock);
>  +		pending = inf->flags & AUTOFS_INF_EXPIRING;
>  +		spin_unlock(&inf->sbi->fs_lock);
>  +	}
>  +
>  +	return pending;

This can obviously return an uninitialised variable.

Were these patches very well tested?
