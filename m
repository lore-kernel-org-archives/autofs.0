From: Greg Banks <gnb@sgi.com>
Subject: Re: Another (stupid) question: autofs vs nfs for
	automounting purposes
Date: Mon, 14 Jun 2004 21:39:27 +1000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040614113927.GA23149@sgi.com>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841AF@frodo.avalon.ru>
	<Pine.LNX.4.58.0406141803260.1394@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406141803260.1394@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On Mon, Jun 14, 2004 at 06:10:34PM +0800, raven@themaw.net wrote:
> On Mon, 14 Jun 2004, Dimitry V. Ketov wrote:
> 
> > > What has NFS to do with automounting?
> > Sorry, if I'm unclear.
> > I really meant communication protocol between kernel and the userspace
> > for automounting purposes.
> > As I know, early automounting solutions was (and current am-utils is)
> > based on userspace nfs server daemon that mount itself on the autmomount
> > points and then listen for filesystem traverses that trigger mounting.
> > I understand that nfs was designed for different purposes, but anyway
> > what reason to design new communication protocol and to complicate
> > kernel instead using already in-kernel nfs code?
> 
> I'm not really familiar with amd so I can't comment on that.
> 
> Historically there are two ways to implement automount one being 
> userspace, RPC based and the other being kernel based. autofs uses the 
> kernel based method. It doesn't seem to me using the in kernel NFS would 
> be sensible but someone would need to enlighten me on that.

One of the problems of the userspace-nfs-daemon approach to
autofs trigger nodes is that a necessary side effect of the
design is that the NFS mount points need to be somewhere
else in the filesystem with fake symlinks to them from the
trigger nodes.  This then shows up in /bin/pwd output and
applications get mightily confused.

For example, let's say we have an autofs node /hosts/foobar.

With the userspace-nfs-daemon approach, after the first
traversal /hosts/foobar is a symlink to /.automount/foobar/root/
which is the actual NFS mountpoint.  If an application does
a getcwd() call or runs /bin/pwd, the returned path will
start at /.automount/foobar/root/.  The typical failure mode
you see with this is that an application will save pathnames
like that in some persistent state (e.g. a compiler saving
the path to the .c file in the generated binary) and then after
the mount goes idle and is unmounted the pathname cannot be
reached (e.g. you start the debugger on the binary twenty
minutes later).

Years ago, I had no end of problems using with the SunOS 4
automounter, which behaved this way.

With the kernel approach, after the first traversal /hosts/foobar
is itself the NFS mountpoint, and applications doing a getcwd()
see paths starting with /hosts/foobar, which will still work
after the mount goes idle and is unmounted.

The price you pay is that bugs are harder to find and fix.

There are other problems with using NFS to talk to autofsd.
For one thing it means that you have an NFS mount all the time,
even when you're not mounting other machines, which means you're
running lockd all the time and can't shut it down, which on an
NFS server makes it really hard to failover NFS service to
another server.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
