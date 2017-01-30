From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/7] autofs: update ioctl documentation regarding struct
 autofs_dev_ioctl
Date: Mon, 30 Jan 2017 18:20:56 +0800
Message-ID: <148577165630.9801.6081791213151121657.stgit@pluto.themaw.net>
References: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=qg/o0PPT/MlRLCD
        gyqm3rZRTso0=; b=YAPZfrfolHamObXhiW6/J8qIXUWuMQ35QBJBXhK+j8r+oa0
        AnMn7WN6NAV3+x5HYQsLSDto+iODcvxrirvzckwgQuDeLMg8E643UbhHdZT9EuUo
        KfBvaDLTHoXzYxv7ZNEE6xYqv7nPZJIPPVWcp3RwKugptLzb64KHoroGjRuc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=qg/o0PPT/MlRLCDgyqm3rZRTso0=; b=NzNJv9KXHn/8Y5gvA7vR
        N+SzAwI6f1/5TyeGdY/44PqlsnVNsiiE6vtBweJ6wP4tYyGaDzxLhjessYX/tG0l
        KKOZBK7lAMQKAB852JvrJI3O0YM4WnfBzu9AIOJDs9LfqENmW2EchEdWoLnu72SH
        GDxcx6QZ2E6m37+ZnD87vhE=
In-Reply-To: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

This is the same as bf72eda5 except that it's a different file.
Sync documentation with changes made by 730c9eec in 2009.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 .../filesystems/autofs4-mount-control.txt          |    1 +
 Documentation/filesystems/autofs4.txt              |   32 +++++++++++++-------
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
 

