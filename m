From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/3] autofs4 - expiring filesystem from under process
Date: Mon, 11 Apr 2005 16:52:07 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504111645330.18235@wombat.indigo.net.au>
References: <Pine.LNX.4.62.0504102048370.5212@donald.themaw.net>
 <20050411000104.430e26fb.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20050411000104.430e26fb.akpm@osdl.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: michael@kmaclub.com, linux-fsdevel@vger.kernel.org, jmoyer@redhat.com, autofs@linux.kernel.org

On Mon, 11 Apr 2005, Andrew Morton wrote:

> raven@themaw.net wrote:
> >
> >   static inline int autofs4_ispending(struct dentry *dentry)
> >    {
> >    	struct autofs_info *inf = autofs4_dentry_ino(dentry);
> >  +	int pending;
> > 
> >  -	return (dentry->d_flags & DCACHE_AUTOFS_PENDING) ||
> >  -		(inf != NULL && inf->flags & AUTOFS_INF_EXPIRING);
> >  +	if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
> >  +		return 1;
> >  +
> >  +	if (inf) {
> >  +		spin_lock(&inf->sbi->fs_lock);
> >  +		pending = inf->flags & AUTOFS_INF_EXPIRING;
> >  +		spin_unlock(&inf->sbi->fs_lock);
> >  +	}
> >  +
> >  +	return pending;
> 
> This can obviously return an uninitialised variable.
> 
> Were these patches very well tested?

Minimal testing in 2.6.
There's been some fairly heavy use of the 2.4 version.

Never the less this is sloppy.
Perhaps you should reject them, rather than burn your time on it, and I 
will resubmit when I've gone over them and sorted out the issues.

Ian



