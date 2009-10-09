From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc][patch] fs: dcache remove d_mounted
Date: Fri, 9 Oct 2009 09:42:11 +0200
Message-ID: <20091009074211.GD2983@wotan.suse.de>
References: <20091009025621.GB4287@wotan.suse.de> <4ACECE68.70009@themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4ACECE68.70009@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

On Fri, Oct 09, 2009 at 01:47:20PM +0800, Ian Kent wrote:
> Nick Piggin wrote:
> > Hi,
> > 
> > I'd just like to ask you to look at autofs4 in the context of this change.
> > I don't really know what needs to be considered there. If this is a
> > generally visible dentry that any other users may mount filesystems on,
> > then this might be difficult to get working here.
> > 
> > I'm not quite sure what games you're playing here with d_mounted... In the
> > simplest case we might be able to just remove DCACHE_MOUNTED.
> 
> Hahaha, "games", harsh but true.
> 
> My need is fairly simple really.
> 
> I must be able to stop the follow down at the mount point for some cases
> of a covered dentry. Which, IIRC, means that d_mountpoint() needs to be
> sensitive to this requirement, and that's about all.
> 
> This was always questionable, but seemed like the best way to do it at
> the time, without adding autofs specific code to the VFS. Since we are
> changing this part of the VFS now with this patch, it is a good time to
> fix it in a generic non-autofs specific way.

I guess you could have a flag in the vfsmount which you could then set
to have lookup_mnt (and hence follow_mount etc) ignore it.

Unsetting / decrementing d_mounted I guess works, but I would just
be worried if other mounts can be attached to the dentry then you
might ignore that other mount or even follow your autofs mount.i

If there is no way to have anything else mounted here, then there
shouldn't be a problem and indeed unsetting d_mounted might be the
easiest approach. However you still have to be careful of a racing
lookup that has found d_mounted to be true, but is yet to look up
the mount hash table -- that might be tricky and is a case where
the vfsmount flag approach should work better.


> > Anyway this would be great if we can make it work so I can replace the
> > member with d_seq for my path walk patches and not bloat dentry. Can you
> > take a look please if you have a chance?
> 
> Sure, let me have a look around and think about it for a while.
> 
> >From a quick look it appears that all I could just change the
> DCACHE_MOUNTED flag and check the actual mounted status when restoring it.

OK, thanks. I'll do that as an intermediate hack here, and if you
find a problem with it or if we devise a better generic approach,
then I'll rip it out.

Thanks,
Nick

