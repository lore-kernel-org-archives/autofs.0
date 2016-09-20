From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Wed, 21 Sep 2016 07:00:13 +0800
Message-ID: <1474412413.22440.7.camel@themaw.net>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
         <20160914061445.24714.68331.stgit@pluto.themaw.net>
         <20160917201000.omswgttgyzcu7jt6@mguzik>
         <1474248973.3204.14.camel@themaw.net>
         <87oa3iikgf.fsf@x220.int.ebiederm.org>
         <1474411462.22440.2.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=ib4nMSaw7i8skW6OiKLWgb9UMMI=; b=GalJXC
        Yy30GSLpvgqroKHo5tMgis/d5UyaSueMRnscc/3bGGeJbk/lw9n5/fyWqqgHSYL1
        lB7SlCeJLU0/AwbEGXmgTN42qiLyAmiyHRQCtaS2iynf2Mfi7JiVla5+OjTkOyFZ
        bYYL9kB+546hxR+suvRiunRaQKLn3/j6fNZpo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ib4nMSaw7i8skW6
        OiKLWgb9UMMI=; b=T8wg5oOr7U5nBn3PCJuE1mHw3BiZu4vi+OPvG7qUYiFKFDn
        T0RtolHbXpLBvA47/5MwnfjJ6YHHAuJOCse960IjGIJweR6c4/Z86CS26W1T96ZL
        Xit0DwB27fWw4zg8301g4BskCim+0eFtn+vPrFUqqwq2qSAz6HfCDIioWdMk=
In-Reply-To: <1474411462.22440.2.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mateusz Guzik <mguzik@redhat.com>, NeilBrown <neilb@suse.com>, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Wed, 2016-09-21 at 06:44 +0800, Ian Kent wrote:
> On Tue, 2016-09-20 at 11:50 -0500, Eric W. Biederman wrote:
> > Ian Kent <raven@themaw.net> writes:
> > 
> > > On Sat, 2016-09-17 at 22:10 +0200, Mateusz Guzik wrote:
> > > > On Wed, Sep 14, 2016 at 02:14:45PM +0800, Ian Kent wrote:
> > > > > If an automount mount is clone(2)ed into a file system that is
> > > > > propagation private, when it later expires in the originating
> > > > > namespace subsequent calls to autofs ->d_automount() for that
> > > > > dentry in the original namespace will return ELOOP until the
> > > > > mount is manually umounted in the cloned namespace.
> > > > > 
> > > > > In the same way, if an autofs mount is triggered by automount(8)
> > > > > running within a container the dentry will be seen as mounted in
> > > > > the root init namespace and calls to ->d_automount() in that namespace
> > > > > will return ELOOP until the mount is umounted within the container.
> > > > > 
> > > > > Also, have_submounts() can return an incorect result when a mount
> > > > > exists in a namespace other than the one being checked.
> > > > > 
> > > > > @@ -460,7 +460,7 @@ static int autofs4_d_manage(struct dentry *dentry,
> > > > > bool
> > > > > rcu_walk)
> > > > >  
> > > > >  		if (ino->flags & AUTOFS_INF_WANT_EXPIRE)
> > > > >  			return 0;
> > > > > -		if (d_mountpoint(dentry))
> > > > > +		if (is_local_mountpoint(dentry))
> > > > >  			return 0;
> > > > >  		inode = d_inode_rcu(dentry);
> > > > >  		if (inode && S_ISLNK(inode->i_mode))
> > > > 
> > > > This change is within RCU lookup.
> > > > 
> > > > is_local_mountpoint may end up calling __is_local_mountpoint, which will
> > > > optionally take the namespace_sem lock, resulting in a splat:
> > > 
> > > Yes, that's a serious problem I missed.
> > > 
> > > snip ...
> > > 
> > > > I don't know this code. Perhaps it will be perfectly fine performance
> > > > wise
> > > > to
> > > > just drop out of RCU lookup in this case.
> > > 
> > > It's a bit worse than that.
> > > 
> > > I think being able to continue the rcu-walk for an already mounted dentry
> > > that
> > > is not being expired is an important part of the performance improvement
> > > given
> > > by the series that added this.
> > > 
> > > Can you confirm that Neil?
> > > 
> > > But for the case here the existing test can allow rcu-walk to continue for
> > > a
> > > dentry that would attempt to trigger an automount so it's also a bug in
> > > the
> > > existing code.
> > 
> > I don't think the existing code is buggy.  As I read __follow_mount_rcu
> > if DCACHE_NEED_AUTOMOUNT is set on the dentry after return from d_manage
> > the code will break out of the rcu walk.
> 
> That's right.
> 
> I'm working on follow up patches now.
> 
> > 
> > > Any thoughts on how we can handle this Neil, I'm having a bit of trouble
> > > working
> > > out how to resolve this one.
> > 
> > I believe in this case d_mountpoint is enough for the rcu walk case.  If
> > the mountpoint turns out not to be local __follow_mount_rcu will kick
> > out of the rcu walk as it will return false.  Because:
> > 	return !mounted && !(path->dentry->d_flags & DCACHE_NEED_AUTOMOUNT);
> > 
> > I am not quite certain about the non-rcu case.  That can't be
> > is_local_mountpoint as that is inside a spinlock and is_local_mountpoint
> > can sleep.  Perhaps d_mountpoint is simply correct for autofs4_d_manage.
> 
> That's right, I think I have other mistakes there too.
> 
> I'm checking those too.

It may be that is_local_mountpoint() isn't the right thing to use for this.

When I originally set out to do this I used a lookup_mnt() type check which
should be sufficient in this case so I might need to go back to that.

> 
> > 
> > Eric
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
