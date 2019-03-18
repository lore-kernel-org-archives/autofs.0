From: Ian Kent <raven@themaw.net>
Subject: [PATCH 5/5] autofs - add description of ignore pseudo mount option
Date: Mon, 18 Mar 2019 09:00:46 +0800
Message-ID: <155287084617.12593.812733161112154904.stgit@pluto.themaw.net>
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

Add a idescription of the "ignore" pseudo mount option that can be
used to provide a generic indicator to applications that the mount
entry should be ignored when displaying mount information.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs.txt |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index 409e6411904d..3af38c7fd26d 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -526,6 +526,21 @@ directories.
 Catatonic mode can only be left via the
 **AUTOFS_DEV_IOCTL_OPENMOUNT_CMD** ioctl on the `/dev/autofs`.
 
+The "ignore" mount option
+-------------------------
+
+The "ignore" mount option can be used to provide a generic indicator
+to applications that the mount entry should be ignored when displaying
+mount information.
+
+In other OSes that provide autofs and that provide a mount list to user
+space based on the kernel mount list a no-op mount option ("ignore" is
+the one use on the most common OSes) is allowed so that autofs file
+system users can optionally use it.
+
+This is intended to be used by user space programs to exclude autofs
+mounts from consideration when reading the mounts list.
+
 autofs, name spaces, and shared mounts
 --------------------------------------
 

