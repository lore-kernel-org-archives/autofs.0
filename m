From: Jeff Layton <jtlayton@poochiereds.net>
Subject: [PATCH] replicated mounts fix, also possible bug in beta2?
Date: Sat, 02 Apr 2005 06:55:29 -0500
Message-ID: <1112442929.5055.18.camel@tleilax.poochiereds.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

I've been working on a patch for the userspace portion of autofs to
change the way that replicated mounts are handled. This patch changes
mount_nfs.c such that it parses all of the mounts in the list, sorts
them, and then tries to mount each in turn. The existing code breaks
(fails to mount) if it picks a mount in the list that the client does
not have permission to mount. I originally worked up the patch for a
version of the autofs daemon in RHEL, but I'd like to have it considered
for inclusion upstream as well.

The problem I've hit is that the latest version (autofs-4.1.4_beta2)
seems to break replicated mounts. The newest version no longer seems to
pass the entire mount string to mount_mount() in mount_nfs.c -- it only
seems to pass the first mount in a (whitespace separated) list. This is
a show-stopper for my patch, but also seems to break replicated mounts
in the existing code as well (unless I'm missing something).

In any case, the current revision of my mount_nfs.c is at:

http://poochiereds.net/svn/autofs/autofs-4.1.4_beta2/modules/mount_nfs.c

I can generate diffs if you like, but the patch is pretty large (an
overhaul, really), so it's probably easier to look at the file itself.

I believe it retains all of the current functionality of mount_nfs.c,
but I can't really test on the latest rev it until I work out the
problem above. I got the basic code working on the RHEL-patched version
of autofs, so it's pretty close.

Comments and suggestions are appreciated, but this is my first real
project in C, so be gentle :-)

-- Jeff
