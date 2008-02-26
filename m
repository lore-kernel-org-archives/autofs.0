From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/4] autofs4 - autofs needs a miscelaneous device for ioctls
Date: Tue, 26 Feb 2008 12:21:58 +0900 (WST)
Message-ID: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


Hi Andrew,

There is a problem with active restarts in autofs (that is to
say restarting autofs when there are busy mounts).

Currently autofs uses "umount -l" to clear active mounts at
restart. While using lazy umount works for most cases, anything
that needs to walk back up the mount tree to construct a path,
such as getcwd(2) and the proc file system /proc/<pid>/cwd, no
longer works because the point from which the path is constructed
has been detached from the mount tree.

The actual problem with autofs is that it can't reconnect to
existing mounts. Immediately one things of just adding the
ability to remount autofs file systems would solve it, but
alas, that can't work. This is because autofs direct mounts
and the implementation of "on demand mount and expire" of
nested mount trees have the file system mounted on top of
the mount trigger dentry.

To resolve this a miscellaneous device node for routing ioctl
commands to these mount points has been implemented for the
autofs4 kernel module.

For those wishing to test this out an updated user space daemon
is needed. Checking out and building from the git repo or
applying all the current patches to the 5.0.3 tar distribution
will do the trick. This is all available at the usual location
on kernel.org.

Ian
