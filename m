From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Mon, 19 Sep 2016 09:36:13 +0800
Message-ID: <1474248973.3204.14.camel@themaw.net>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
         <20160914061445.24714.68331.stgit@pluto.themaw.net>
         <20160917201000.omswgttgyzcu7jt6@mguzik>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=ous67wux1O0KgL8Ho1up2YzBVcI=; b=d9bbBz
        qzioN4GBbLmFmG1RC1VDeAqxFNdVtDwb44zgmtPsJyjYxajNydFsmnDihRR4KhWS
        OBE13zELQHzE0lmMF+oo4mcpIgbiaxlio/7UXKA9ECG4eYs0Hy8WpL6+ETWYjJh0
        zYDYgSZcf0VpLoCDTX9oW1l6MXPkalI0tV8rE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ous67wux1O0KgL8
        Ho1up2YzBVcI=; b=gDi7vdGt5C67SQ9Kx7Tv5YEtRJ9SNrX05iSc2/oqTBqO9nx
        N8mq/o3jOkpkRtb03T6l/ExL1JuV5ZnsArGlGTef5/bXJXa2dYX0kZMnam0iOPzk
        xw2AQMEx60l+Nkhd7+fMiS5ahcfs9VS6MbNDd7vLn+a4QbtnAaNVP1hz81OI=
In-Reply-To: <20160917201000.omswgttgyzcu7jt6@mguzik>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mateusz Guzik <mguzik@redhat.com>, NeilBrown <neilb@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Sat, 2016-09-17 at 22:10 +0200, Mateusz Guzik wrote:
> On Wed, Sep 14, 2016 at 02:14:45PM +0800, Ian Kent wrote:
> > If an automount mount is clone(2)ed into a file system that is
> > propagation private, when it later expires in the originating
> > namespace subsequent calls to autofs ->d_automount() for that
> > dentry in the original namespace will return ELOOP until the
> > mount is manually umounted in the cloned namespace.
> > 
> > In the same way, if an autofs mount is triggered by automount(8)
> > running within a container the dentry will be seen as mounted in
> > the root init namespace and calls to ->d_automount() in that namespace
> > will return ELOOP until the mount is umounted within the container.
> > 
> > Also, have_submounts() can return an incorect result when a mount
> > exists in a namespace other than the one being checked.
> > 
> > @@ -460,7 +460,7 @@ static int autofs4_d_manage(struct dentry *dentry, bool
> > rcu_walk)
> >  
> >  		if (ino->flags & AUTOFS_INF_WANT_EXPIRE)
> >  			return 0;
> > -		if (d_mountpoint(dentry))
> > +		if (is_local_mountpoint(dentry))
> >  			return 0;
> >  		inode = d_inode_rcu(dentry);
> >  		if (inode && S_ISLNK(inode->i_mode))
> 
> This change is within RCU lookup.
> 
> is_local_mountpoint may end up calling __is_local_mountpoint, which will
> optionally take the namespace_sem lock, resulting in a splat:

Yes, that's a serious problem I missed.

snip ...

> I don't know this code. Perhaps it will be perfectly fine performance wise to
> just drop out of RCU lookup in this case.

It's a bit worse than that.

I think being able to continue the rcu-walk for an already mounted dentry that
is not being expired is an important part of the performance improvement given
by the series that added this.

Can you confirm that Neil?

But for the case here the existing test can allow rcu-walk to continue for a
dentry that would attempt to trigger an automount so it's also a bug in the
existing code.

Any thoughts on how we can handle this Neil, I'm having a bit of trouble working
out how to resolve this one.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
