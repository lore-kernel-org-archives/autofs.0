From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 6/8] autofs - use path_is_mountpoint() to fix unreliable
 d_mountpoint() checks
Date: Thu, 27 Oct 2016 10:51:40 +0800
Message-ID: <1477536700.2898.16.camel@themaw.net>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
         <20161011053418.27645.15241.stgit@pluto.themaw.net>
         <20161027021753.GJ19539@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-me-sender:x-sasl-enc:message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=mesmtp; bh=RP6Of/kzTRmMdt81CGuXq+d
        P8vM=; b=BQhfYAvUaDA4awzm6AtZg3PcfkA9XF1GsKDZHyoAHUW4xxyUEFsbuEC
        g6olzT8vsVut+YFNlJnCF/pFQaHljJ/k0hdDY+AkRoSB4Me8LmakE5garHVWEvbl
        EecP3bJXkhGlLIBVwxhubzjenz0pnhOAwKLebLZGnEezzGW97AoU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-me-sender:x-sasl-enc:message-id:subject
        :from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=smtpout; bh=RP6Of/kzT
        RmMdt81CGuXq+dP8vM=; b=l+DUH72qvyAUC+egihpUohG2GYOBHEw6FKgOYn2uO
        Grc7WiMdqwkIsfdKK0+1Tg1Qog0StzIPjk9lyAPvDoSGo2w9gAhIznTeJ3NK6gzq
        w3d3k+NBF6dMse3JvFB2Z7D5zPAwBi0mIv8/OYaLBVs4TQ/mIh9xUSfcpgUd9d5+
        fU=
In-Reply-To: <20161027021753.GJ19539@ZenIV.linux.org.uk>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Thu, 2016-10-27 at 03:17 +0100, Al Viro wrote:
> On Tue, Oct 11, 2016 at 01:34:18PM +0800, Ian Kent wrote:
> > 
> > +	path = file->f_path;
> > +
> >  	/*
> >  	 * An empty directory in an autofs file system is always a
> >  	 * mount point. The daemon must have failed to mount this
> > @@ -123,7 +126,7 @@ static int autofs4_dir_open(struct inode *inode, struct
> > file *file)
> >  	 * it.
> >  	 */
> >  	spin_lock(&sbi->lookup_lock);
> > -	if (!d_mountpoint(dentry) && simple_empty(dentry)) {
> > +	if (!path_is_mountpoint(&path) && simple_empty(dentry)) {
> Why not &file->f_path, provided that you constify that thing properly?

Yep, my bad, as pointed out by Eric.

Patches to fix that and constify a bunch of things will follow.

> 
> > 
> > +		if (rcu_walk) {
> > +			if (!path_is_mountpoint_rcu(path))
> > +				return -EISDIR;
> > +		} else {
> > +			if (!path_is_mountpoint(path))
> > +				return -EISDIR;
> IDGI.  What's the point of _having_ the _rcu() variant, anyway?  Here you
> are probably paying more in terms of i-cache footprint/branch prediction
> than you win on not doing that rcu_read_lock()/rcu_read_unlock()...
> 
> _rcu variants make sense when non-RCU case does something you can't do
> under RCU; here your path_is_mountpoint() is pretty close to being
> rcu_read_lock()+path_is_mountpoint_rcu()+rcu_read_unlock() anyway...

Again, my bad, I'll merge these two and post along with the follow up patches
above.

Thanks Al,
Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
