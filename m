From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs4 - track uid and gid of last mount requestor
Date: Thu, 28 Feb 2008 17:00:23 +0900
Message-ID: <1204185623.3501.84.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
	 <Pine.LNX.4.64.0802261208400.8490@raven.themaw.net>
	 <20080227204546.72e16e8d.akpm@linux-foundation.org>
	 <1204179747.3501.21.camel@raven.themaw.net>
	 <20080227223734.caab0165.akpm@linux-foundation.org>
	 <1204182500.3501.49.camel@raven.themaw.net>
	 <20080227232339.af6e904a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080227232339.af6e904a.akpm@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Pavel Emelyanov <xemul@openvz.org>, "Eric W. Biederman" <ebiederm@xmission.com>


On Wed, 2008-02-27 at 23:23 -0800, Andrew Morton wrote:
> On Thu, 28 Feb 2008 16:08:20 +0900 Ian Kent <raven@themaw.net> wrote:
> 
> > 
> > > 
> > > What problem are you actually trying to solve here?
> > 
> > The basic problem arises only when we want to restart the user space
> > daemon and there are active autofs managed mounts in place at exit (ie.
> > autofs mounts that have busy user mounts). They are left mounted and
> > processes using them continue to function. But then, when we startup
> > autofs we need to reconnect to these autofs mounts, some of which can
> > covered the by mounted file systems, and hence the need for another way
> > to open an ioctl descriptor to them.
> 
> So we want to store persistant state in the kernel across userspace process
> invokations.  That's normally done with a thing called a "file" ;) Could we
> stick all the necessary state into files in a pseudo-fs and have the daemon
> go and open and read them all when it restarts?

Nearly sent of a reply without thinking about this and it sounds like a
good idea initially. But, if we have a large number of autofs file
systems mounted (thousands?), duplicating the information already
present in the autofs file system seems untidy and unnecessary. I
thought of exposing this information in in sysfs, but that would make
the autofs module part of sysfs have many files, and there is the
problem that the same path could have more than one autofs file system
stacked on top of it, so isn't unique.

The other obvious place is in the mount options but that is one of the
reasons that only the device number is exposed their. If we have 5000 -
10000 mounts then scanning /proc/mounts becomes a big problem from a CPU
usage perspective (and is already a big problem for me, which is partly
addressed by the new bits in the implementation here). If I could think
of another way to expose the device number as well I would use it, even
if it was an additional ioctl, to avoid scanning /proc/mounts.

> 
> > It may have been overkill to re-implement all the current ioctls (and
> > add a couple of other much needed ones)
> 
> I don't understand that bit.  But then, I don't have a clue how autofs
> works.
> 
> > but I though it sensible for
> > completeness, and we get to identify any possible problems the current
> > ioctls might have had due to the use of the BKL (by the VFS when calling
> > the ioctls).
> 
> It isn't a good idea to wait for races to reveal themselves.  It will take
> years, especially with a system which has as low a call frequency as autofs
> mounting.  And once a bug _does_ reveal itself, by then we'll have tens of
> millions of machines out there running that bug.

Not sure I agree about the low call frequency.

It's quite normal for smaller sites to have hundreds of entries in maps
and equally common for them to do stupid things like run scripts that
scan the file systems, mounting every mount.

It's not quite the same order of magnitude, but I regularly use the
autofs connectathon suite for testing. It only ends up mounting several
hundred mounts but I can get mounting and expiring happening at the same
time so it's not an unreasonable way to test.
 
> 
> > So, why do we need the uid and gid? When someone walks over an autofs
> > dentry that is meant to cause a mount we send a request packet to the
> > daemon via a pipe
> 
> connector or genetlink would be more fashionable transports.

Right, I'll see what I can find on those topics.
My concern is that this will require considerable work in the daemon
which would be fine for version 5.1 but I need to resolve this problem
for the existing 5.0 implementation.

> 
> > which includes the process uid and gid, and as part of
> > the lookup we set macros for several mount map substitution variables,
> > derived from the uid and gid of the process requesting the mount and
> > they can be used within autofs maps.
> 
> yeah, could be a problem.  Hopefully the namespace people can advise. 
> Perhaps we need a concept of an exportable-to-userspace namespace-id+uid,
> namespace-id+gid, namespace-id+pid, etc for this sort of thing.  It has
> come up before.  Recently, but I forget what the context was.

I'm all ears to any feedback from others on this, please.

> 
> > This is all fine as long as we don't need to re-connect to these mounts
> > when starting up, since we don't get kernel requests for the mounts, we
> > need to obtain that information from the active mount itself.
> 

