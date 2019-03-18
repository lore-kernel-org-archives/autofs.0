From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/5] autofs - fix some word usage odities in autofs.txt
Date: Mon, 18 Mar 2019 09:00:24 +0800
Message-ID: <155287082394.12593.6506084453911662450.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Alter a few word usages in Documentation/filesystems/autofs.txt
and correct some spelling mistakes.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs.txt |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index 373ad25852d3..05da806b1e88 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -116,7 +116,7 @@ that purpose there is another flag.
 **DCACHE_MANAGE_TRANSIT**
 
 If a dentry has DCACHE_MANAGE_TRANSIT set then two very different but
-related behaviors are invoked, both using the `d_op->d_manage()`
+related behaviours are invoked, both using the `d_op->d_manage()`
 dentry operation.
 
 Firstly, before checking to see if any filesystem is mounted on the
@@ -193,8 +193,8 @@ VFS remain in RCU-walk mode, but can only tell it to get out of
 RCU-walk mode by returning `-ECHILD`.
 
 So `d_manage()`, when called with `rcu_walk` set, should either return
--ECHILD if there is any reason to believe it is unsafe to end the
-mounted filesystem, and otherwise should return 0.
+-ECHILD if there is any reason to believe it is unsafe to enter the
+mounted filesystem, otherwise it should return 0.
 
 autofs will return `-ECHILD` if an expiry of the filesystem has been
 initiated or is being considered, otherwise it returns 0.
@@ -210,7 +210,7 @@ mounts that were created by `d_automount()` returning a filesystem to be
 mounted.  As autofs doesn't return such a filesystem but leaves the
 mounting to the automount daemon, it must involve the automount daemon
 in unmounting as well.  This also means that autofs has more control
-of expiry.
+over expiry.
 
 The VFS also supports "expiry" of mounts using the MNT_EXPIRE flag to
 the `umount` system call.  Unmounting with MNT_EXPIRE will fail unless
@@ -225,7 +225,7 @@ unmount any filesystems mounted on the autofs filesystem or remove any
 symbolic links or empty directories any time it likes.  If the unmount
 or removal is successful the filesystem will be returned to the state
 it was before the mount or creation, so that any access of the name
-will trigger normal auto-mount processing.  In particlar, `rmdir` and
+will trigger normal auto-mount processing.  In particular, `rmdir` and
 `unlink` do not leave negative entries in the dcache as a normal
 filesystem would, so an attempt to access a recently-removed object is
 passed to autofs for handling.
@@ -242,7 +242,7 @@ time stamp on each directory or symlink.  For symlinks it genuinely
 does record the last time the symlink was "used" or followed to find
 out where it points to.  For directories the field is a slight
 misnomer.  It actually records the last time that autofs checked if
-the directory or one of its descendents was busy and found that it
+the directory or one of its descendants was busy and found that it
 was.  This is just as useful and doesn't require updating the field so
 often.
 
@@ -255,7 +255,7 @@ up.
 
 There is an option with indirect mounts to consider each of the leaves
 that has been mounted on instead of considering the top-level names.
-This is intended for compatability with version 4 of autofs and should
+This is intended for compatibility with version 4 of autofs and should
 be considered as deprecated.
 
 When autofs considers a directory it checks the `last_used` time and
@@ -273,7 +273,7 @@ mounts.  If it finds something in the root directory to expire it will
 return the name of that thing.  Once a name has been returned the
 automount daemon needs to unmount any filesystems mounted below the
 name normally.  As described above, this is unsafe for non-toplevel
-mounts in a version-5 autofs.  For this reason the current `automountd`
+mounts in a version-5 autofs.  For this reason the current `automount(8)`
 does not use this ioctl.
 
 The second mechanism uses either the **AUTOFS_DEV_IOCTL_EXPIRE_CMD** or
@@ -345,7 +345,7 @@ The `wait_queue_token` is a unique number which can identify a
 particular request to be acknowledged.  When a message is sent over
 the pipe the affected dentry is marked as either "active" or
 "expiring" and other accesses to it block until the message is
-acknowledged using one of the ioctls below and the relevant
+acknowledged using one of the ioctls below with the relevant
 `wait_queue_token`.
 
 Communicating with autofs: root directory ioctls
@@ -367,15 +367,14 @@ The available ioctl commands are:
     This mode is also entered if a write to the pipe fails.
 - **AUTOFS_IOC_PROTOVER**:  This returns the protocol version in use.
 - **AUTOFS_IOC_PROTOSUBVER**: Returns the protocol sub-version which
-    is really a version number for the implementation.  It is
-    currently 2.
+    is really a version number for the implementation.
 - **AUTOFS_IOC_SETTIMEOUT**:  This passes a pointer to an unsigned
     long.  The value is used to set the timeout for expiry, and
     the current timeout value is stored back through the pointer.
 - **AUTOFS_IOC_ASKUMOUNT**:  Returns, in the pointed-to `int`, 1 if
     the filesystem could be unmounted.  This is only a hint as
     the situation could change at any instant.  This call can be
-    use to avoid a more expensive full unmount attempt.
+    used to avoid a more expensive full unmount attempt.
 - **AUTOFS_IOC_EXPIRE**: as described above, this asks if there is
     anything suitable to expire.  A pointer to a packet:
 
@@ -415,7 +414,7 @@ which can be used to communicate directly with the autofs filesystem.
 It requires CAP_SYS_ADMIN for access.
 
 The `ioctl`s that can be used on this device are described in a separate
-document `autofs-mount-control.txt`, and are summarized briefly here.
+document `autofs-mount-control.txt`, and are summarised briefly here.
 Each ioctl is passed a pointer to an `autofs_dev_ioctl` structure:
 
         struct autofs_dev_ioctl {

