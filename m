From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/4] autofs4 - autofs needs a miscelaneous device for
	ioctls
Date: Thu, 28 Feb 2008 15:07:18 +0900
Message-ID: <1204178838.3501.5.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
	 <20080227204002.49f4c5fb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080227204002.49f4c5fb.akpm@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


On Wed, 2008-02-27 at 20:40 -0800, Andrew Morton wrote:
> On Tue, 26 Feb 2008 12:21:58 +0900 (WST) Ian Kent <raven@themaw.net> wrote:
> 
> > 
> > Hi Andrew,
> > 
> > There is a problem with active restarts in autofs (that is to
> > say restarting autofs when there are busy mounts).
> > 
> > Currently autofs uses "umount -l" to clear active mounts at
> > restart. While using lazy umount works for most cases, anything
> > that needs to walk back up the mount tree to construct a path,
> > such as getcwd(2) and the proc file system /proc/<pid>/cwd, no
> > longer works because the point from which the path is constructed
> > has been detached from the mount tree.
> > 
> > The actual problem with autofs is that it can't reconnect to
> > existing mounts. Immediately one things of just adding the
> > ability to remount autofs file systems would solve it, but
> > alas, that can't work. This is because autofs direct mounts
> > and the implementation of "on demand mount and expire" of
> > nested mount trees have the file system mounted on top of
> > the mount trigger dentry.
> > 
> > To resolve this a miscellaneous device node for routing ioctl
> > commands to these mount points has been implemented for the
> > autofs4 kernel module.
> > 
> > For those wishing to test this out an updated user space daemon
> > is needed. Checking out and building from the git repo or
> > applying all the current patches to the 5.0.3 tar distribution
> > will do the trick. This is all available at the usual location
> > on kernel.org.
> > 
> 
> Could we please be a bit more specific than "the usual location"?

Yes, I should have been more specific.
I'll fix that.

> 
> Should autofs userspace have an entry in Documentation/Changes?

Sound like a sensible thing to do.
I'll include a patch for that when I re-post the patch set.

Ian


