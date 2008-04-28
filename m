From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 - use lookup access intent to support
	recursive bind mounts
Date: Mon, 28 Apr 2008 15:25:36 +0800
Message-ID: <1209367536.3243.16.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0804281410160.10684@raven.themaw.net>
	 <20080428062213.GB5882@ZenIV.linux.org.uk>
	 <1209364705.3243.1.camel@raven.themaw.net>
	 <20080428070514.GC5882@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080428070514.GC5882@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


On Mon, 2008-04-28 at 08:05 +0100, Al Viro wrote:
> On Mon, Apr 28, 2008 at 02:38:25PM +0800, Ian Kent wrote:
> > 
> > On Mon, 2008-04-28 at 07:22 +0100, Al Viro wrote:
> > > On Mon, Apr 28, 2008 at 02:14:54PM +0800, Ian Kent wrote:
> > > > 
> > > > Hi Andrew,
> > > > 
> > > > For autofs maps that recursively reference other map entries in their
> > > > mount point path we need to ensure that these mounts are performed
> > > > prior to the current mount request being done. We've used the access
> > > > system call, made just prior to performing the mount, to make this
> > > > happen. In the case of bind mounts, however, the lookup flags in 
> > > > the path walk don't trigger a mount. To do this we need to also
> > > > trigger a mount when we see the LOOKUP_ACCESS flag.
> > > 
> > > That's too fscking bad, since ->lookup() is about to lose access to
> > > nameidata *and* flags for anything but the last step.  IOW, we'll need
> > > cleaner solution...
> > 
> > Spell it out for me please!
> 
> ->lookup() and friends are going to stop getting struct nameidata *.
> ->follow_link() obviously will keep it; ->d_revalidate() should
> lose the sucker, but we might have to split it in two methods (which
> is probably what'll be needed in your case).

Right.

I don't see that yet in 2.6.25-mm1, are there any preliminary patches I
could look at?

> 
> At the same time struct open_intent is going to die, BTW, but that
> won't matter for autofs, AFAICT.

Yep, autofs doesn't care about this, it only cares about being able to
ask userspace to try a mount when needed.

Actually, using the flags to decide when to call back the daemon
wouldn't be needed at all except for mount storms caused by aggressive
GUI file system scanning and color ls and the like. 

Ian


