From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/5] autofs - update mount control expire desription with
 AUTOFS_EXP_FORCED
Date: Mon, 18 Mar 2019 09:00:40 +0800
Message-ID: <155287084078.12593.15000931045413195778.stgit@pluto.themaw.net>
References: <155287082394.12593.6506084453911662450.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155287082394.12593.6506084453911662450.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Describe AUTOFS_EXP_FORCED in addition to AUTOFS_EXP_IMMEDIATE in the
description of the AUTOFS_DEV_IOCTL_EXPIRE_CMD ioctl.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs-mount-control.txt |    6 ++++--
 Documentation/filesystems/autofs.txt               |    5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/autofs-mount-control.txt b/Documentation/filesystems/autofs-mount-control.txt
index 45edad6933cc..acc02fc57993 100644
--- a/Documentation/filesystems/autofs-mount-control.txt
+++ b/Documentation/filesystems/autofs-mount-control.txt
@@ -354,8 +354,10 @@ this ioctl is called until no further expire candidates are found.
 
 The call requires an initialized struct autofs_dev_ioctl with the
 ioctlfd field set to the descriptor obtained from the open call. In
-addition an immediate expire, independent of the mount timeout, can be
-requested by setting the how field of struct args_expire to 1. If no
+addition an immediate expire that's independent of the mount timeout,
+and a forced expire that's independent of whether the mount is busy,
+can be requested by setting the how field of struct args_expire to
+AUTOFS_EXP_IMMEDIATE or AUTOFS_EXP_FORCED, respectively . If no
 expire candidates can be found the ioctl returns -1 with errno set to
 EAGAIN.
 
diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index 8fe43c97cb96..409e6411904d 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -410,6 +410,11 @@ The available ioctl commands are:
      **AUTOFS_EXP_IMMEDIATE** causes `last_used` time to be ignored
      and objects are expired if the are not in use.
 
+     **AUTOFS_EXP_FORCED** causes the in use status to be ignored
+     and objects are expired ieven if they are in use. This assumes
+     that the daemon has requested this because it is capable of
+     performing the umount.
+
      **AUTOFS_EXP_LEAVES** will select a leaf rather than a top-level
      name to expire.  This is only safe when *maxproto* is 4.
 

