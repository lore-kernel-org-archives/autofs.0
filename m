From: Jeff Layton <jtlayton@poochiereds.net>
Subject: [PATCH] mount_nfs replicated mounts patch (now sorts by
	subnet locality too)
Date: Mon, 18 Jul 2005 17:41:16 -0400
Message-ID: <1121722876.6710.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi all,

I sent this earlier from a different account but it never showed up, so
apologies if it's a duplicate...

Here's the latest patch for my mount_nfs overhaul. This version adds
a new sorting criteria that should bring the replicated mount behavior
pretty closely into line with Solaris. I've done some basic testing of
it and it seems to work, but will need some more extensive testing (like
the rest of the patch).

The new version now checks to see whether any address for a replicated
mount is on a subnet that is local to the client (by comparing the
address to the routing table in /proc/net/route). We then sort by this
criteria after "bindness" (if the mount is a bind mount) and before the
weight.

There's only one catch -- the mount program simply selects the first
address given by a gethostbyname() call. So if the host is multi-homed,
we may end up mounting across a router anyway, even if another address
is closer.

We could simply use the address instead of the hostname for the mount,
but then we lose the hostname information for the mount. This could
look very messy, especially with a lot of NFS mounts. So, what I'm
thinking is this:

Currently the 'addr=' mount option for nfs mounts is ignored. I'd like
to roll a patch for mount such that this option is instead treated as an
address hint. If the address provided by the 'addr=' option matches one
of the addresses returned by gethostbyname(), then the mount program
would use that address for the mount. Otherwise, the existing behavior
(use first address in list) would prevail.

Does this sound like a good plan, or does anyone else have another
suggestion on how to deal with this?

In any case, here is the current revision of the autofs patch
(unfortunately, it seems to have gotten too large to post directly to
the list):

http://poochiereds.net/autofs/autofs-replicated-mounts-overhaul.patch

I'll plan to add the code soon that will add the "addr=" option for
mounts that are on the local subnet, unless there are major objections
to that approach:

As always, comments and suggestions are appreciated...

-- Jeff
