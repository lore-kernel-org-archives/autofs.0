From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 00/18] Introduce automount support in the VFS [ver #4]
Date: Fri, 14 Jan 2011 15:46:52 +0000
Message-ID: <20110114154652.GD19804@ZenIV.linux.org.uk>
References: <20110114070224.GB19804@ZenIV.linux.org.uk>
 <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
 <2443.1295005428@redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2443.1295005428@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Fri, Jan 14, 2011 at 11:43:48AM +0000, David Howells wrote:

> I presume that people aren't expected to do things like do_move_mount() here,
> but might they want to do a bind mount?  Or do we just say if they want to do
> something more exotic than do_add_mount(), they have to follow path (b)?

bind can be done just fine - all you need is to clone the vfsmount (or subtree)
you want to bind there and return the sucker.

> It would be simpler, perhaps, to allow d_automount() to return the list also:
> 
>    struct vfsmount *(*d_automount)(struct path *mountpoint,
> 				   struct list_head **expiry_list_to_use);
> 
> This pointer can then be passed directly to do_add_mount() and we don't have
> to worry about having an extra reference or cleaning up the list on error.

Let's not.  For one thing, getting rid of that argument in do_add_mount() is
a Good Thing(tm).  For another, I don't see any problem with having
	mnt_set_expiry(mnt, list)
and
	mnt_clear_expiry(mnt)
in fs/namespace.c.  Moreover, as you've mentioned in another followup, we
want the list to be non-empty until we either put the vfsmount in place
or decide to discard it, since we don't want fs to decide that the list is
empty and no expiry runs need to be scheduled anymore.

One more thing: do_add_mount() would happily get unexported and go to
fs/internal.h, which is also a good thing; it's too easy to abuse.
