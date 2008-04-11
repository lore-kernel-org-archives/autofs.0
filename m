From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 4/4] autofs4 - add miscelaneous device for ioctls
Date: Fri, 11 Apr 2008 15:02:39 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0804111425290.32624@raven.themaw.net>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net> 
 <Pine.LNX.4.64.0802261218230.8490@raven.themaw.net> 
 <20080227211723.d5d27c09.akpm@linux-foundation.org> <1204302250.19890.22.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1204302250.19890.22.camel@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Graf <tgraf@redhat.com>

On Sat, 1 Mar 2008, Ian Kent wrote:

> 
> On Wed, 2008-02-27 at 21:17 -0800, Andrew Morton wrote:
> > On Tue, 26 Feb 2008 12:23:55 +0900 (WST) Ian Kent <raven@themaw.net> wrote:
> > 
> > > Hi Andrew,
> > > 
> > > Patch to add miscellaneous device to autofs4 module for
> > > ioctls.
> > 
> > Could you please document the new kernel interface which you're proposing? 
> > In Docmentation/ or in the changelog?
> > 
> > We seem to be passing some string into a miscdevice ioctl and getting some
> > results back.  Be aware that this won't be a terribly popular proposal, so
> > I'd suggest that you fully describe the problem which it's trying to solve,
> > and how it solves it, and why the various alternatives (sysfs, netlink,
> > mount options, etc) were judged unsuitable.
> 
> It appears I could do this with the generic netlink subsystem.
> I'll have a go at it.
> 

I've spent several weeks on this now and I'm having considerable 
difficulty with the expire function.

First, I think using a raw netlink implementation defeats the point of 
using this approach at all due to increased complexity. So I've used the 
generic netlink facility and the libnl library for user space. While the 
complexity on the kernel side is acceptable that isn't the case in user 
space, the code for the library to issue mount point control commands has 
more than doubled in size and is still not working for mount point 
expiration.  This has been made more difficult because libnl isn't 
thread safe, but I have overcome this limitation for everything but 
the expire function, I now can't determine whether the problem I have with 
receiving multicast messages, possibly out of order, on individual 
netlink sockets opened specifically for this purpose, is due to this or is 
something I'm doing wrong.

The generic netlink implementation allows only one message to be in flight 
at a time. But my expire selects an expire candidate (if possible), sends 
a request to the daemon to do the umount, obtains the result status and 
returns this as the result to the original expire request. Consequently, I 
need to spawn a kernel thread to do this and return, then listen for the
matching multicast message containing the result. I don't particularly 
like spawning a thread to do this because it opens the possibility of 
orphaned threads which introduces other difficulties cleaning them up if 
the user space application goes away or misbehaves. But I'm also having 
problems catching the multicast messages. This works fine in normal 
operation but fails badly when I have multiple concurrent expires 
happening, such as when shutting down the daemon with several hundred 
active mounts. I can't avoid the fact that netlink doesn't provide the 
same functionality as the ioctl interface and clearly isn't meant to.

So, the question is, what are the criteria to use for deciding that a 
netlink based implementation isn't appropriate because I think I'm well 
past it now?

Comments please.
Ian
