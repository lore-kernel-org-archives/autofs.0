From: kusumi.tomohiro@gmail.com
Subject: [PATCH 4/6] autofs: update ioctl documentation regarding struct autofs_dev_ioctl
Date: Tue, 17 Jan 2017 23:42:31 +0900
Message-ID: <1484664153-20478-4-git-send-email-tkusumi@tuxera.com>
References: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lx0/r/PZmYUp+C8+kVmZVzia/n6x90NaKpgx++ZTUG4=;
        b=Geyj6JHyzv4221TfHf5RLwfEC2PkYQlu2zUqD6wlvsgjVBozdI6vtnOGgvtaqa5McH
         uXG5KVz2LVGEAJwzzYmKF9ogUJI69GMpG7AfQw4Ie3nacFmQIPYc2N+jSasdpSXvedpf
         jZnLk3NpGzxB45xnZbhL4nF0OCt7P4MwITROUJ3Cpk8b/jQLED+ZI023qah5/TB+6W7J
         0JBIni3MePGGnhkIOQYzZUVjlmo1rtHeTET+blss3gm9oBA8Rbgn3OcarWhVeyGAC3l1
         OHqYPY9CNCqA1dC00JHHQeuu1nVNea7VS8LDsGHGktPHzpuJgkMDSFVbVsQD/afRe/+H
         fMIw==
In-Reply-To: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

This is the same as bf72eda5 except that it's a different file.
Sync documentation with changes made by 730c9eec in 2009.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 .../filesystems/autofs4-mount-control.txt          |  1 +
 Documentation/filesystems/autofs4.txt              | 32 ++++++++++++++--------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/autofs4-mount-control.txt b/Documentation/filesystems/autofs4-mount-control.txt
index 50a3e01..e5177cb 100644
--- a/Documentation/filesystems/autofs4-mount-control.txt
+++ b/Documentation/filesystems/autofs4-mount-control.txt
@@ -179,6 +179,7 @@ struct autofs_dev_ioctl {
 				 * including this struct */
 	__s32 ioctlfd;          /* automount command fd */
 
+	/* Command parameters */
 	union {
 		struct args_protover		protover;
 		struct args_protosubver		protosubver;
diff --git a/Documentation/filesystems/autofs4.txt b/Documentation/filesystems/autofs4.txt
index 7534863..f10dd59 100644
--- a/Documentation/filesystems/autofs4.txt
+++ b/Documentation/filesystems/autofs4.txt
@@ -425,8 +425,20 @@ Each ioctl is passed a pointer to an `autofs_dev_ioctl` structure:
                                          * including this struct */
                 __s32 ioctlfd;          /* automount command fd */
 
-                __u32 arg1;             /* Command parameters */
-                __u32 arg2;
+		/* Command parameters */
+		union {
+			struct args_protover		protover;
+			struct args_protosubver		protosubver;
+			struct args_openmount		openmount;
+			struct args_ready		ready;
+			struct args_fail		fail;
+			struct args_setpipefd		setpipefd;
+			struct args_timeout		timeout;
+			struct args_requester		requester;
+			struct args_expire		expire;
+			struct args_askumount		askumount;
+			struct args_ismountpoint	ismountpoint;
+		};
 
                 char path[0];
         };
@@ -446,24 +458,22 @@ Commands are:
     set version numbers.
 - **AUTOFS_DEV_IOCTL_OPENMOUNT_CMD**: return an open file descriptor
     on the root of an autofs filesystem.  The filesystem is identified
-    by name and device number, which is stored in `arg1`.  Device
-    numbers for existing filesystems can be found in
+    by name and device number, which is stored in `openmount.devid`.
+    Device numbers for existing filesystems can be found in
     `/proc/self/mountinfo`.
 - **AUTOFS_DEV_IOCTL_CLOSEMOUNT_CMD**: same as `close(ioctlfd)`.
 - **AUTOFS_DEV_IOCTL_SETPIPEFD_CMD**: if the filesystem is in
     catatonic mode, this can provide the write end of a new pipe
-    in `arg1` to re-establish communication with a daemon.  The
-    process group of the calling process is used to identify the
+    in `setpipefd.pipefd` to re-establish communication with a daemon.
+    The process group of the calling process is used to identify the
     daemon.
 - **AUTOFS_DEV_IOCTL_REQUESTER_CMD**: `path` should be a
     name within the filesystem that has been auto-mounted on.
-    On successful return, `arg1` and `arg2` will be the UID and GID
-    of the process which triggered that mount.
-
+    On successful return, `requester.uid` and `requester.gid` will be
+    the UID and GID of the process which triggered that mount.
 - **AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD**: Check if path is a
     mountpoint of a particular type - see separate documentation for
     details.
-
 - **AUTOFS_DEV_IOCTL_PROTOVER_CMD**:
 - **AUTOFS_DEV_IOCTL_PROTOSUBVER_CMD**:
 - **AUTOFS_DEV_IOCTL_READY_CMD**:
@@ -473,7 +483,7 @@ Commands are:
 - **AUTOFS_DEV_IOCTL_EXPIRE_CMD**:
 - **AUTOFS_DEV_IOCTL_ASKUMOUNT_CMD**:  These all have the same
     function as the similarly named **AUTOFS_IOC** ioctls, except
-    that **FAIL** can be given an explicit error number in `arg1`
+    that **FAIL** can be given an explicit error number in `fail.status`
     instead of assuming `ENOENT`, and this **EXPIRE** command
     corresponds to **AUTOFS_IOC_EXPIRE_MULTI**.
 
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
