From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs4 - remove hashed check in validate_wait()
Date: Sun, 7 Jun 2009 22:41:37 -0700
Message-ID: <20090607224137.e13be7f3.akpm@linux-foundation.org>
References: <20090608032537.7088.1870.stgit@zeus.themaw.net>
	<20090607220814.cc7519f6.akpm@linux-foundation.org>
	<4A2CA05C.3060808@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <4A2CA05C.3060808@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 08 Jun 2009 13:23:40 +0800 Ian Kent <raven@themaw.net> wrote:

> Andrew Morton wrote:
> > On Mon, 08 Jun 2009 11:25:37 +0800 Ian Kent <raven@themaw.net> wrote:
> > 
> >> The recent ->lookup() deadlock correction required the directory
> >> inode mutex to be dropped while waiting for expire completion. We
> >> were concerned about side effects from this change and one has
> >> been identified.
> >>
> >> When checking if a mount has already completed prior to adding a
> >> new mount request to the wait queue we check if the dentry is hashed
> >> and, if so, if it is a mount point. But, if a mount successfully
> >> completed while we slept on the wait queue mutex the dentry must
> >> exist for the mount to have completed so the test is not really
> >> needed.
> >>
> >> Mounts can also be done on top of a global root dentry, so for the
> >> above case, where a mount request completes and the wait queue entry
> >> has already been removed, the hashed test returning false can cause
> >> an incorrect callback to the daemon. Also, d_mountpoint() is not
> >> sufficient to check if a mount has completed for the multi-mount
> >> case when we don't have a real mount at the base of the tree.
> >>
> > 
> > I've been scratching my head trying to work out if this is a
> > needed-in-2.6.30 fix, but all I got was a bald spot.  Help?
> 
> Yeah, and why would you want to know that much about autofs, it's a
> wonder I have any hair at all, ;)
> 
> I think so if possible, as it resolves an issue that is a side effect of
> the last patch I sent, which resolved a deadlook in ->lookup(). The
> problem occurs due to dropping the directory inode mutex before waiting
> for an expire. What isn't obvious is that holding the mutex (as we did
> previously) causes processes wanting to request mounts for other
> directories to wait, so we don't see the contention for the mount
> request wait queue that this patch addresses.
> 
> However, the issue only surfaces when there are a number of processes
> all trying to perform mounts at the same time. The test I ran used 10
> processes all using the same map.

<scratch scratch> 
What are the user-visible effects of the thing-which-this-fixed?
