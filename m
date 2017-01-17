From: kusumi.tomohiro@gmail.com
Subject: [PATCH 2/6] autofs: fix typo in Documentation
Date: Tue, 17 Jan 2017 23:42:29 +0900
Message-ID: <1484664153-20478-2-git-send-email-tkusumi@tuxera.com>
References: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/9yD5s/bJsV29d2NH25KtGpX5xs9zyTBQg61ItEvggM=;
        b=o7mOm0xmaAR6bEgq2LJKvUnSNE77CzHpdAc+yTGXQIvgYj0c+o3VtflBVhyDIkZSSp
         Ibcv5aC3XGnWA1gzyojm4tpUgPrifEONeltcOkn9Zi0JGkc/dWmAiwom4GPP9gpBo76P
         /zGfCq/iQ85TV/W4K9Sl6nYmNpTLsMqSaAsBqPuFVAmKeX5z5GQaG4l9eATYtk8OE9yT
         dgnKgaKNc8Bxpsr/wYWnOIuYEq5/TG80pgd7dr31x9StgFaAD2G+j2AFoH1685i8syXo
         26FLSbNgh2yjy9k8ctAMIKEUhJ1QTgCyVnXxgz5owdQpnv2nKDrriMTN+F8PoPTLW7r+
         k5bA==
In-Reply-To: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 Documentation/filesystems/autofs4.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/autofs4.txt b/Documentation/filesystems/autofs4.txt
index 8fac3fe..a5dc56f 100644
--- a/Documentation/filesystems/autofs4.txt
+++ b/Documentation/filesystems/autofs4.txt
@@ -65,7 +65,7 @@ directory is a mount trap only if the filesystem is mounted *direct*
 and the root is empty.
 
 Directories created in the root directory are mount traps only if the
-filesystem is mounted  *indirect* and they are empty.
+filesystem is mounted *indirect* and they are empty.
 
 Directories further down the tree depend on the *maxproto* mount
 option and particularly whether it is less than five or not.
@@ -352,7 +352,7 @@ Communicating with autofs: root directory ioctls
 ------------------------------------------------
 
 The root directory of an autofs filesystem will respond to a number of
-ioctls.   The process issuing the ioctl must have the CAP_SYS_ADMIN
+ioctls.  The process issuing the ioctl must have the CAP_SYS_ADMIN
 capability, or must be the automount daemon.
 
 The available ioctl commands are:
@@ -512,7 +512,7 @@ always be mounted "shared". e.g.
 
 > `mount --make-shared /autofs/mount/point`
 
-The automount daemon is only able to mange a single mount location for
+The automount daemon is only able to manage a single mount location for
 an autofs filesystem and if mounts on that are not 'shared', other
 locations will not behave as expected.  In particular access to those
 other locations will likely result in the `ELOOP` error
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
