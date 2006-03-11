From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 - follow_link missing funtionality
Date: Sat, 11 Mar 2006 22:10:06 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0603112209360.30816@eagle.themaw.net>
References: <Pine.LNX.4.64.0603102003110.3032@eagle.themaw.net>
 <20060310145016.39b028be.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20060310145016.39b028be.akpm@osdl.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Fri, 10 Mar 2006, Andrew Morton wrote:

> Ian Kent <raven@themaw.net> wrote:
> >
> > @@ -337,10 +340,34 @@ static void *autofs4_follow_link(struct 
> >  	if (oz_mode || !lookup_type)
> >  		goto done;
> >  
> > +	/*
> > +	 * If the dentry contains directories then it is an
> > +	 * autofs multi-mount with no root offset. So don't
> > +	 * try to mount it again.
> > +	 */
> > +	spin_lock(&dcache_lock);
> > +	if (!list_empty(&dentry->d_subdirs)) {
> > +		spin_unlock(&dcache_lock);
> > +		goto done;
> > +	}
> > +	spin_unlock(&dcache_lock);
> > +
> 
> Can list_empty(&dentry->d_subdirs) become false right here, after the lock
> was dropped?  If so, what happens?

Yep. I think so.
Not what I want to happen.

> 
> 
> >  	status = try_to_fill_dentry(dentry, 0);
> 

