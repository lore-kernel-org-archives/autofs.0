From: Eric Werme USG <werme@wasted.zk3.dec.com>
Subject: Re: [NFS] Re: multiple servers per automount
Date: Fri, 10 Oct 2003 13:02:06 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200310101702.h9AH26q0000921107@anw.zk3.dec.com>
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: aogden@unocal.com
Cc: autofs@linux.kernel.org

Ogden, Aaron A. wrote:

>Aha! Wisdom from the heavens... :-)
>I assume that the RPC code is doing that to comply with reserved-port
>restrictions, ie. ports < 1024.  Solaris needs to do the same thing
>(with nfssrv:nfs_portmon=1) so it seems that there would be an inherent
>limit of 1024 ports or mountpoints to work with.  Actually less, since
>some ports will be in use.  How does Sun get 260,000 active mounts if
>they can only use ports < 1024?  Do we really need one port for each
>mountpoint?

I can't speak for Solaris, but on HP's Tru64 UNIX we use one TCP
connection for all traffic per mount, and we close connections that
have been idle for 5 minutes and when there are "too many" connections
to one server.  For UDP, the NFS client uses a single port, in large part
do to problems with port number space exhaustion and the ripple effects
on other consumers of that space.  (We don't throttle the number of outstanding
NFS requests, but we have a fixed limit on the read/write nfsiod helper
threads.)  We generally ran into port number exhaustion on our mail server
which uses NFS (via aoutmount) to access /home/user/.forward files.  If one
production system went down, then the mail server would wind up with a 
big flock of sendmails all trying to access the .forwards until the port
number space was chewed up, then automount couldn't issue new mounts
whereupon no mail got delivered to anyone.

The NFS client gets its first look at a reply via a callback from UDP
code when it finds the port has been registered.  The callback figures
out what thread is waiting for the XID, saves the reply address in a
data structure and issues the wakeup.  When the code is processed for
real, it's NFS code that does the UDP checksum, thereby loading
the local cache with the data.  The inspiration was pretty simple as I
had to do the same demultiplexing in the NFS over TCP client.

BTW, the rationale behind the one TCP connection per mount was to
conform to TCP's congestion control design, but limit the amount of
cross mount locking and code complexity.  Typical NFS traffic
has multiple accesses on a mount at a time, so I figured it would be
a good compromise.  I know Solaris has one connection per server, I don't
know what other vendors do.

	-Ric Werme

-- 
Eric (Ric) Werme         |  werme@zk3.dec.com
Hewlett-Packard Co.      |  http://werme.8m.net/
