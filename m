From: Ian Kent <raven@themaw.net>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Tue, 29 Nov 2005 00:03:29 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511282342320.2596@donald.themaw.net>
References: <1132670358.4039.37.camel@brilong-lnx>
	<1132674350.4039.52.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222351130.9982@donald.themaw.net>
	<Pine.LNX.4.63.0511231359220.20045@simba.math.ucla.edu>
	<1133189814.4126.16.camel@brilong-lnx>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1133189814.4126.16.camel@brilong-lnx>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Long <brilong@cisco.com>
Cc: autofs@linux.kernel.org

On Mon, 28 Nov 2005, Brian Long wrote:

> On Wed, 2005-11-23 at 14:46 -0800, Jim Carter wrote:
> > On Tue, 22 Nov 2005, Ian Kent wrote:
> > > On Tue, 22 Nov 2005, Brian Long wrote:
> > > > On Tue, 2005-11-22 at 09:39 -0500, Brian Long wrote:
> > > > > I have an auto.master deployed to thousands of hosts and it looks like
> >  -- snip --
> > > > > auto.home contains over 34,000 entries.  I've noticed in RHEL 3 U5 and
> >  -- snip --
> > > > > After looking at tcpdump data, it appears automounter is downloading the
> > > > > entire auto.home map when it fails to lookup "no-such-user".  This
> > > > > results in a > 700KB transfer from the NIS server  :(
> > 
> > I may have missed something in subsequent discussion, but why isn't 
> > automount querying just the missing map row?  If NIS agreed that it did not 
> > exist, fine, report an error to the client's opendir().  If it *did* exist, 
> > the new information could be added immediately and the filesystem could be 
> > mounted promptly.
> 
> Exactly; I believe this is a bug in the cache code as Jeff Moyer
> mentioned (and provided a patch for).

That's not quite the way it works.

autofs does query only the entry being requested when a mount is 
triggered. It's not possible to update the information there and then 
because the lookup is done in a subprocess while the autofs main 
program continues. So it's necessary to tell the parent process it needs 
to update the map info. Also, if there's one change you don't know how 
many others there might be.

Judging by the report the case that I don't handle correctly is the 
missing from NIS and not present in the mapent cache.

The patch I asked Jeff to review deals with this and another bug I noticed 
while checking out the reported problem. Please have a read of the 
description attached to the patch.

Most of the time mounts are not triggered by a readdir, they are triggered 
from the VFS lookup or revalidate callbacks. These can come from a number 
of sources such as chdir open or other calls that need to walk a file 
path.

> 
> > Browsing is nice but gets expensive if there are 34,000 potential mount 
> > points.  If browsing is turned off, the code that enumerates the map should 
> > delete rows in the kernel but not in the map, but should bypass adding rows 
> > in the map but not the kernel.  Could this be part of the cause of the 
> > original problem -- browsing being turned on inappropriately?
> 
> To my knowledge, browsing is not enabled by default.  We definitely do
> not have it enabled in our environment on purpose.

This is an interesting point.

Context is not held in the kernel except for the directories that are 
created in the autofs filesystem to provide a browsable map. Certainly a 
large amount of directories can slow things down heaps. That could 
certainly be a problem for the future.

Yes, browsing is turned of by default.

Ian
