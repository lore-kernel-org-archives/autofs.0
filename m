From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Wed, 23 Nov 2005 14:46:27 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0511231359220.20045@simba.math.ucla.edu>
References: <1132670358.4039.37.camel@brilong-lnx>
	<1132674350.4039.52.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222351130.9982@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511222351130.9982@donald.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Tue, 22 Nov 2005, Ian Kent wrote:
> On Tue, 22 Nov 2005, Brian Long wrote:
> > On Tue, 2005-11-22 at 09:39 -0500, Brian Long wrote:
> > > I have an auto.master deployed to thousands of hosts and it looks like
 -- snip --
> > > auto.home contains over 34,000 entries.  I've noticed in RHEL 3 U5 and
 -- snip --
> > > After looking at tcpdump data, it appears automounter is downloading the
> > > entire auto.home map when it fails to lookup "no-such-user".  This
> > > results in a > 700KB transfer from the NIS server  :(

I may have missed something in subsequent discussion, but why isn't 
automount querying just the missing map row?  If NIS agreed that it did not 
exist, fine, report an error to the client's opendir().  If it *did* exist, 
the new information could be added immediately and the filesystem could be 
mounted promptly.

Raven asked what people thought should be the semantics when a map is 
proven to be out of date.  If there were no constraints from other parts of 
automount, I would have a fast path like described above, but to detect 
deletions I would have automount poll the order number (modification 
timestamp) from the server every so often -- once an hour?  If the order 
number has changed, re-enumerate the map.  To minimize thrashing, if 
possible, I'd do a "diff" between the latest map and the kernel's data: add 
rows absent in the kernel, remove rows absent in the map, and don't touch 
rows present in both (unless per-row mount options had changed).

If the fast path's NIS query revealed a map row we didn't know about, early 
polling should be triggered, in case there were other additions or 
deletions.  This only applies if browsing is turned on.  Or since userspace 
has to obtain the whole map anyway to recognize deletions, maybe it should 
cache the map, but only in the case of browsing should it install every row 
in the kernel.

Suppose mounting is attempted but fails.  I think automount should also 
trigger early polling.  This costs you a query for one row (the order 
number), and if the map has changed then your nonexistent mount point will 
go away -- or not go away, cheaply, if the problem is with the NFS server.

Remember that NIS UDP timeouts are a fact of life on an overloaded network.

Browsing is nice but gets expensive if there are 34,000 potential mount 
points.  If browsing is turned off, the code that enumerates the map should 
delete rows in the kernel but not in the map, but should bypass adding rows 
in the map but not the kernel.  Could this be part of the cause of the 
original problem -- browsing being turned on inappropriately?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
