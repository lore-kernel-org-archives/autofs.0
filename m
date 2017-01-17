From: kusumi.tomohiro@gmail.com
Subject: [PATCH 3/6] autofs: fix wrong ioctl documentation regarding devid
Date: Tue, 17 Jan 2017 23:42:30 +0900
Message-ID: <1484664153-20478-3-git-send-email-tkusumi@tuxera.com>
References: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JUzNCdDDAXtE71hp9h3Hm67vLbwCI7ikctVQ1834bLQ=;
        b=ghEmX9AyWrV+1bzxgadjgG8dsMTRYfFfQclRbGI4DO7WQZEBqi9k3W5lxkB5JR/Cud
         mg6pknKzCFIq6AIdyJRFVC0moUP32f1QmaXeCLOcs5lHKGVqJJmUYDN+KCv0U2Mu1V1P
         q4XLlzzPURfMjszd42vgD5de6pjZ2xNI6HThKzGKhQrF92hT3eN4w1IaSwvAVAGnJrlO
         s0buY5Zfu39vtB+r+ghJtPgcxgME99FyxUd0xPbFGJWPJj10u257o3SH7NK9D1OG+uVR
         fNW9TdKmIP5PBEswEnhSvv8n0ioBgpLIU1n2xwmXS9ViIUJcdVAWrRo3xHNgGeamCiWu
         I+7Q==
In-Reply-To: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

This is the same as d8732841 except that it's a different file.
A caller has no devid input, and devid is obtained via superblock.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 Documentation/filesystems/autofs4.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/autofs4.txt b/Documentation/filesystems/autofs4.txt
index a5dc56f..7534863 100644
--- a/Documentation/filesystems/autofs4.txt
+++ b/Documentation/filesystems/autofs4.txt
@@ -457,9 +457,8 @@ Commands are:
     daemon.
 - **AUTOFS_DEV_IOCTL_REQUESTER_CMD**: `path` should be a
     name within the filesystem that has been auto-mounted on.
-    arg1 is the dev number of the underlying autofs.  On successful
-    return, `arg1` and `arg2` will be the UID and GID of the process
-    which triggered that mount.
+    On successful return, `arg1` and `arg2` will be the UID and GID
+    of the process which triggered that mount.
 
 - **AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD**: Check if path is a
     mountpoint of a particular type - see separate documentation for
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
