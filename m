From: raven@themaw.net
Subject: Re: rpc_ping always uses UDP
Date: Thu, 13 May 2004 20:38:31 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405132027360.1562@donald.themaw.net>
References: <16546.29772.254542.152548@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0405121404250.1416@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405121404250.1416@simba.math.ucla.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org

On Wed, 12 May 2004, Jim Carter wrote:

> On Wed, 12 May 2004, Jeff Moyer wrote:
> > I had a user report an issue which is summed up in the subject.  Basically,
> > he disallowed UDP traffic to his NFS server.  Because the autofs code uses
> > UDP in the rpc_ping function to determine if a server is alive, it would
> > conclude that the server was not alive.  He was, of course, using NFSv4
> > over TCP.
> 
> Would it be possible to change the paradigm: attempt the mount from one
> server, and if the filesystem doesn't appear promptly, rename the mount
> point (later attempting to unmount it), and attempt the mount from another
> server.  That way, someone else takes complete responsibility for _how_ the
> mount is done.  Likely the needed timeouts are about the same for an actual
> mount as for rpc_ping.  The reason for renaming is in case the mount
> eventually succeeds.  Maybe it would be better to always mount on a
> temporary name and then always rename the successful mount point (if any)
> to the requested name, so the mount point name doesn't change at random 
> times while other kernel threads are trying to use it.  You would use 
> "mount --move olddir newdir" (kernel 2.5.x and above only).
> 
> An alternative that will never happen: have a "no-op" option to mount,
> which determines if the mount could be done (for NFS, this is the rpc_ping
> thing) but doesn't actually mount anything.

Sorry, I can't agree with this approach at all.

This process must be simple to be useful and these checks here are out of 
context for the time the check needs to happen. Much of this information 
is not available at that time.

Ian
