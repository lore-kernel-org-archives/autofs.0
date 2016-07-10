From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 07/12] autofs: Update struct autofs_dev_ioctl in Documentation
Date: Sun, 10 Jul 2016 17:07:48 +0900
Message-ID: <1468138073-4870-7-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yBPkbICBcCQfWoDmxPmDeCUB+ZH9YSKSb0vEbiBJRZM=;
        b=UEeNt+uhLXc8Uu0TtVeSJc8WGTv1ragTXxUCma7BIlJIeO4jMCdLB53kfJJO1KOa+Q
         MSCvBqVJ3jAxHxq3ktu/kZ2MSCSgjIBBFd4SakusWbAd8Iy+SbxJ+xkyfG80vO6j3tqq
         f4j7Aj1/r0ESrTMNv0DpOqtfQBFdQHvouF6WqOYFBBi7Rq2EM4r4b7G80/i8Se7cr8Zk
         bvysHl4tpva5kL8jJQ4t7M4DmMv9SZjfKpjbWX+5pRPTZfMi6LvsegVtDhNSfg6OZnpY
         4hlbjsRmzk8seyklvPlIpk0nwQSnAuE39eevL2nreRnBrZb4yqPdx1/MBn32IXqo4IE/
         NQpA==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Sync with changes made by 730c9eec which introduced an union for
various ioctl commands instead of having statically named arg1,2.

This commit simply replaces arg1,2 with the corresponding fields
without changing semantics.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 .../filesystems/autofs4-mount-control.txt          | 70 +++++++++++++---------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/Documentation/filesystems/autofs4-mount-control.txt b/Documentation/filesystems/autofs4-mount-control.txt
index 540d9a7..50a3e01 100644
--- a/Documentation/filesystems/autofs4-mount-control.txt
+++ b/Documentation/filesystems/autofs4-mount-control.txt
@@ -179,8 +179,19 @@ struct autofs_dev_ioctl {
 				 * including this struct */
 	__s32 ioctlfd;          /* automount command fd */
 
-	__u32 arg1;             /* Command parameters */
-	__u32 arg2;
+	union {
+		struct args_protover		protover;
+		struct args_protosubver		protosubver;
+		struct args_openmount		openmount;
+		struct args_ready		ready;
+		struct args_fail		fail;
+		struct args_setpipefd		setpipefd;
+		struct args_timeout		timeout;
+		struct args_requester		requester;
+		struct args_expire		expire;
+		struct args_askumount		askumount;
+		struct args_ismountpoint	ismountpoint;
+	};
 
 	char path[0];
 };
@@ -192,8 +203,8 @@ optionally be used to check a specific mount corresponding to a given
 mount point file descriptor, and when requesting the uid and gid of the
 last successful mount on a directory within the autofs file system.
 
-The fields arg1 and arg2 are used to communicate parameters and results of
-calls made as described below.
+The union is used to communicate parameters and results of calls made
+as described below.
 
 The path field is used to pass a path where it is needed and the size field
 is used account for the increased structure length when translating the
@@ -245,9 +256,9 @@ AUTOFS_DEV_IOCTL_PROTOVER_CMD and AUTOFS_DEV_IOCTL_PROTOSUBVER_CMD
 Get the major and minor version of the autofs4 protocol version understood
 by loaded module. This call requires an initialized struct autofs_dev_ioctl
 with the ioctlfd field set to a valid autofs mount point descriptor
-and sets the requested version number in structure field arg1. These
-commands return 0 on success or one of the negative error codes if
-validation fails.
+and sets the requested version number in version field of struct args_protover
+or sub_version field of struct args_protosubver. These commands return
+0 on success or one of the negative error codes if validation fails.
 
 
 AUTOFS_DEV_IOCTL_OPENMOUNT and AUTOFS_DEV_IOCTL_CLOSEMOUNT
@@ -256,9 +267,9 @@ AUTOFS_DEV_IOCTL_OPENMOUNT and AUTOFS_DEV_IOCTL_CLOSEMOUNT
 Obtain and release a file descriptor for an autofs managed mount point
 path. The open call requires an initialized struct autofs_dev_ioctl with
 the path field set and the size field adjusted appropriately as well
-as the arg1 field set to the device number of the autofs mount. The
-device number can be obtained from the mount options shown in
-/proc/mounts. The close call requires an initialized struct
+as the devid field of struct args_openmount set to the device number of
+the autofs mount. The device number can be obtained from the mount options
+shown in /proc/mounts. The close call requires an initialized struct
 autofs_dev_ioct with the ioctlfd field set to the descriptor obtained
 from the open call. The release of the file descriptor can also be done
 with close(2) so any open descriptors will also be closed at process exit.
@@ -272,10 +283,10 @@ AUTOFS_DEV_IOCTL_READY_CMD and AUTOFS_DEV_IOCTL_FAIL_CMD
 Return mount and expire result status from user space to the kernel.
 Both of these calls require an initialized struct autofs_dev_ioctl
 with the ioctlfd field set to the descriptor obtained from the open
-call and the arg1 field set to the wait queue token number, received
-by user space in the foregoing mount or expire request. The arg2 field
-is set to the status to be returned. For the ready call this is always
-0 and for the fail call it is set to the errno of the operation.
+call and the token field of struct args_ready or struct args_fail set
+to the wait queue token number, received by user space in the foregoing
+mount or expire request. The status field of struct args_fail is set to
+the errno of the operation. It is set to 0 on success.
 
 
 AUTOFS_DEV_IOCTL_SETPIPEFD_CMD
@@ -290,9 +301,10 @@ mount be catatonic (see next call).
 
 The call requires an initialized struct autofs_dev_ioctl with the
 ioctlfd field set to the descriptor obtained from the open call and
-the arg1 field set to descriptor of the pipe. On success the call
-also sets the process group id used to identify the controlling process
-(eg. the owning automount(8) daemon) to the process group of the caller.
+the pipefd field of struct args_setpipefd set to descriptor of the pipe.
+On success the call also sets the process group id used to identify the
+controlling process (eg. the owning automount(8) daemon) to the process
+group of the caller.
 
 
 AUTOFS_DEV_IOCTL_CATATONIC_CMD
@@ -323,8 +335,8 @@ mount on the given path dentry.
 
 The call requires an initialized struct autofs_dev_ioctl with the path
 field set to the mount point in question and the size field adjusted
-appropriately. Upon return the struct field arg1 contains the uid and
-arg2 the gid.
+appropriately. Upon return the uid field of struct args_requester contains
+the uid and gid field the gid.
 
 When reconstructing an autofs mount tree with active mounts we need to
 re-connect to mounts that may have used the original process uid and
@@ -342,8 +354,9 @@ this ioctl is called until no further expire candidates are found.
 The call requires an initialized struct autofs_dev_ioctl with the
 ioctlfd field set to the descriptor obtained from the open call. In
 addition an immediate expire, independent of the mount timeout, can be
-requested by setting the arg1 field to 1. If no expire candidates can
-be found the ioctl returns -1 with errno set to EAGAIN.
+requested by setting the how field of struct args_expire to 1. If no
+expire candidates can be found the ioctl returns -1 with errno set to
+EAGAIN.
 
 This call causes the kernel module to check the mount corresponding
 to the given ioctlfd for mounts that can be expired, issues an expire
@@ -356,7 +369,8 @@ Checks if an autofs mount point is in use.
 
 The call requires an initialized struct autofs_dev_ioctl with the
 ioctlfd field set to the descriptor obtained from the open call and
-it returns the result in the arg1 field, 1 for busy and 0 otherwise.
+it returns the result in the may_umount field of struct args_askumount,
+1 for busy and 0 otherwise.
 
 
 AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD
@@ -368,12 +382,12 @@ The call requires an initialized struct autofs_dev_ioctl. There are two
 possible variations. Both use the path field set to the path of the mount
 point to check and the size field adjusted appropriately. One uses the
 ioctlfd field to identify a specific mount point to check while the other
-variation uses the path and optionally arg1 set to an autofs mount type.
-The call returns 1 if this is a mount point and sets arg1 to the device
-number of the mount and field arg2 to the relevant super block magic
-number (described below) or 0 if it isn't a mountpoint. In both cases
-the the device number (as returned by new_encode_dev()) is returned
-in field arg1.
+variation uses the path and optionally in.type field of struct args_ismountpoint
+set to an autofs mount type. The call returns 1 if this is a mount point
+and sets out.devid field to the device number of the mount and out.magic
+field to the relevant super block magic number (described below) or 0 if
+it isn't a mountpoint. In both cases the the device number (as returned
+by new_encode_dev()) is returned in out.devid field.
 
 If supplied with a file descriptor we're looking for a specific mount,
 not necessarily at the top of the mounted stack. In this case the path
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
