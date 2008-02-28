From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] autofs4 - track uid and gid of last mount requestor
Date: Wed, 27 Feb 2008 22:37:34 -0800
Message-ID: <20080227223734.caab0165.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
	<Pine.LNX.4.64.0802261208400.8490@raven.themaw.net>
	<20080227204546.72e16e8d.akpm@linux-foundation.org>
	<1204179747.3501.21.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1204179747.3501.21.camel@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Pavel Emelyanov <xemul@openvz.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, 28 Feb 2008 15:22:27 +0900 Ian Kent <raven@themaw.net> wrote:

> 
> > > +++ linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c	2008-02-20 13:10:23.000000000 +0900
> > > @@ -363,6 +363,38 @@ int autofs4_wait(struct autofs_sb_info *
> > >  
> > >  	status = wq->status;
> > >  
> > > +	/*
> > > +	 * For direct and offset mounts we need to track the requestor
> > > +	 * uid and gid in the dentry info struct. This is so it can be
> > > +	 * supplied, on request, by the misc device ioctl interface.
> > > +	 * This is needed during daemon resatart when reconnecting
> > > +	 * to existing, active, autofs mounts. The uid and gid (and
> > > +	 * related string values) may be used for macro substitution
> > > +	 * in autofs mount maps.
> > > +	 */
> > > +	if (!status) {
> > > +		struct dentry *de = NULL;
> > > +
> > > +		/* direct mount or browsable map */
> > > +		ino = autofs4_dentry_ino(dentry);
> > > +		if (!ino) {
> > > +			/* If not lookup actual dentry used */
> > > +			de = d_lookup(dentry->d_parent, &dentry->d_name);
> > > +			ino = autofs4_dentry_ino(de);
> > > +		}
> > > +
> > > +		/* Set mount requestor */
> > > +		if (ino) {
> > > +			if (ino) {
> > > +				ino->uid = wq->uid;
> > > +				ino->gid = wq->gid;
> > > +			}
> > > +		}
> > > +
> > > +		if (de)
> > > +			dput(de);
> > > +	}
> > > +
> > 
> > But uids and gids are no longer system-wide-unique.  Two different users
> > can have the same identifiers in different namespaces.  What happens then?
> 
> That's a tricky question.
> 
> Presumably, the process requesting the mount has the user space daemon
> running in the namespace within which the uid and gid are to be looked
> up, by the daemon.
> 
> Am I missing something?
> 

err, you assume more knowledge at this end about what you're trying to do
than actually exists :)

You seem to imply that if a machine is running 100 user namespaces then it
needs to run 100 mount daemons.  Doesn't seem good.

What problem are you actually trying to solve here?
