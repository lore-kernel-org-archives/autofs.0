From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/18] autofs4: Add d_manage() dentry operation [ver #4]
Date: Fri, 14 Jan 2011 15:35:54 +0000
Message-ID: <5326.1295019354@redhat.com>
References: <AANLkTin7GaJq6RuQdWkzY7XnH12-=8Gebr24Pyy+fWG+@mail.gmail.com> <20110113215359.19406.37232.stgit@warthog.procyon.org.uk> <20110113215448.19406.58770.stgit@warthog.procyon.org.uk> <1295013099.2794.6.camel@perseus>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <AANLkTin7GaJq6RuQdWkzY7XnH12-=8Gebr24Pyy+fWG+@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Piggin <npiggin@gmail.com>
Cc: dhowells@redhat.com, Ian Kent <raven@themaw.net>, viro@zeniv.linux.org.uk, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Nick Piggin <npiggin@gmail.com> wrote:

> > On Thu, 2011-01-13 at 21:54 +0000, David Howells wrote:
> >> From: Ian Kent <raven@themaw.net>
> >> +     //spin_lock(&dcache_lock);  /////////////// JUST DELETE THIS LOCK?
> >> +     if (!d_mountpoint(dentry) && list_empty(&dentry->d_subdirs)) {
> >> +             spin_lock(&dentry->d_lock);
> >> +             if (!(dentry->d_flags & DCACHE_MANAGE_TRANSIT) &&
> >> +                  (dentry->d_flags & DCACHE_NEED_AUTOMOUNT))
> >> +                     __managed_dentry_set_transit(path->dentry);
> >> +             spin_unlock(&dentry->d_lock);
> >> +     }
> >> +     //spin_unlock(&dcache_lock);
> >
> > In this case I think the dcache_lock needs to be deleted and the d_lock
> > moved out of the if to protect the d_subdirs access.
> 
> Right. If you follow the vfs-scale-working git branch series of
> patches leading up to dcache_lock removal, it gives a pretty
> good template of how to convert old dcache_lock using code
> to new locking.
> 
> Although you can also just look at locking in fs/dcache.c and
> convert code from that.
> 
> Any time you are dealing with just a *single* dentry, then
> ->d_lock would be enough to replace dcache_lock (it
> actually protects more than dcache_lock alone did).

Does it make sense to leave the lock where it is and repeat the outer test
after we've taken the lock?

David
