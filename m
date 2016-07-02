From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH] autofs: Fix typos in Documentation/filesystems/autofs4.txt
Date: Sun,  3 Jul 2016 03:36:58 +0900
Message-ID: <1467484618-1908-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4+Vg0BiVeHtvIRqL+b8TMDaBkkNA7O7rDRlXd/Uf3Gs=;
        b=Z5kyCCy5jbHgc9aU1BxNhnnAFUXolFPOx/zVUbFRzI+ev1aErNGyHv6RUIcaXI9T3Y
         6pM3t3JR9bEhbng4oQRwJePSd3YIj1yS9hQTkO56io8voTbqR1T0ovRiM23Gt2IDUsxy
         NtJRyoFjCivA2rs4MHxw7PE5reS+vLF9L2Udaw495g+THkIN6e1AjSM021Ezi83U4pgZ
         0BJav1wKZG2bX4q/Vco0J2tBvLW2tr5T+CNK3FYvzcHiGlS53neCC5QTEcXaYQk99hto
         F7twlGnjWKKr7O/Xogd/X/ScmYYlAjC+9oeeLm+xl2aEgnNyT6QZP7SpMV+C5DWETiR0
         7+eQ==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

plus minor whitespace fixes.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 Documentation/filesystems/autofs4.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/autofs4.txt b/Documentation/filesystems/autofs4.txt
index 39d02e1..8fac3fe 100644
--- a/Documentation/filesystems/autofs4.txt
+++ b/Documentation/filesystems/autofs4.txt
@@ -203,9 +203,9 @@ initiated or is being considered, otherwise it returns 0.
 Mountpoint expiry
 -----------------
 
-The VFS has a mechansim for automatically expiring unused mounts,
+The VFS has a mechanism for automatically expiring unused mounts,
 much as it can expire any unused dentry information from the dcache.
-This is guided by the MNT_SHRINKABLE flag.  This  only applies to
+This is guided by the MNT_SHRINKABLE flag.  This only applies to
 mounts that were created by `d_automount()` returning a filesystem to be
 mounted.  As autofs doesn't return such a filesystem but leaves the
 mounting to the automount daemon, it must involve the automount daemon
@@ -298,7 +298,7 @@ remove directories and symlinks using normal filesystem operations.
 autofs knows whether a process requesting some operation is the daemon
 or not based on its process-group id number (see getpgid(1)).
 
-When an autofs filesystem it mounted the pgid of the mounting
+When an autofs filesystem is mounted the pgid of the mounting
 processes is recorded unless the "pgrp=" option is given, in which
 case that number is recorded instead.  Any request arriving from a
 process in that process group is considered to come from the daemon.
@@ -450,7 +450,7 @@ Commands are:
     numbers for existing filesystems can be found in
     `/proc/self/mountinfo`.
 - **AUTOFS_DEV_IOCTL_CLOSEMOUNT_CMD**: same as `close(ioctlfd)`.
-- **AUTOFS_DEV_IOCTL_SETPIPEFD_CMD**: if the  filesystem is in
+- **AUTOFS_DEV_IOCTL_SETPIPEFD_CMD**: if the filesystem is in
     catatonic mode, this can provide the write end of a new pipe
     in `arg1` to re-establish communication with a daemon.  The
     process group of the calling process is used to identify the
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
