From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Make stat/lstat/fstatat pass AT_NO_AUTOMOUNT to vfs_statx()
Date: Thu, 04 May 2017 23:30:16 +0100
Message-ID: <149393701678.21194.2478177197944898836.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 43E4380C16
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>

stat/lstat/fstatat need to pass AT_NO_AUTOMOUNT to vfs_statx() as the
pre-statx code didn't set LOOKUP_AUTOMOUNT, even though fstatat() accepted
the AT_NO_AUTOMOUNT flag.

Fixes: a528d35e8bfc ("statx: Add a system call to make enhanced file info available")
Reported-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Ian Kent <raven@themaw.net>
cc: stable@vger.kernel.org
---

 include/linux/fs.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5d62d2c47939..626a6aed4485 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2926,17 +2926,19 @@ extern int vfs_statx_fd(unsigned int, struct kstat *, u32, unsigned int);
 
 static inline int vfs_stat(const char __user *filename, struct kstat *stat)
 {
-	return vfs_statx(AT_FDCWD, filename, 0, stat, STATX_BASIC_STATS);
+	return vfs_statx(AT_FDCWD, filename, AT_NO_AUTOMOUNT,
+			 stat, STATX_BASIC_STATS);
 }
 static inline int vfs_lstat(const char __user *name, struct kstat *stat)
 {
-	return vfs_statx(AT_FDCWD, name, AT_SYMLINK_NOFOLLOW,
+	return vfs_statx(AT_FDCWD, name, AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT,
 			 stat, STATX_BASIC_STATS);
 }
 static inline int vfs_fstatat(int dfd, const char __user *filename,
 			      struct kstat *stat, int flags)
 {
-	return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
+	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
+			 stat, STATX_BASIC_STATS);
 }
 static inline int vfs_fstat(int fd, struct kstat *stat)
 {

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
