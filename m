From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/13] autofs4 - various cleanups,
	updates and bug fixes
Date: Wed, 18 Jan 2006 15:22:21 +0800
Message-ID: <200601180722.k0I7MLTB006112@eagle.themaw.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org, Kernel Mailing List <linux-kernel@vger.kernel.org>

Sincere appologies for the post without a Subject:
Here they are as they should be DOH!

This is the first set of patches for autofs in moving toward a
kernel <-> userspace communication protocol update.

The changes implemented in the patch set are:

1) lookup-cleanup - cleanup of whitespace and formating changes.
2) readdir-cleanup - changes readdir routines to use the cursor
   based routines in libfs.c.
3) failed-lookup - fix stale dentrys stopping mounts.
4) expire-cleanup - change return values and names of two functions
   to aid code readability.
5) expire-traversal-cleanup - simplify expire by adapting it to
   use the "next_entry" function from namespace.c.
6) expire-tree-false-negative - fix an expire case which returns
   busy on tree mounts when they are not.
7) expire-not-busy-only - alter expire semantics to match that
   needed for a rework of autofs direct mounts.
8) remove-update_atime - remove update of atime in favour of
   letting the VFS update it.
9) add-show_options - add show_options method to display autofs4
   mount options in the proc filesystem.
10) waitq-cleanup - whitespace cleanup of waitq.c
11) rename-simple_empty_nolock - rename function according to
   kernel conventions.
12) may_umount-to-boolean - change may_umount* functions to
  boolean to aid code readability.
