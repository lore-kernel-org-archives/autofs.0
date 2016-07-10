From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 06/12] autofs: Fix Documentation regarding devid on ioctl
Date: Sun, 10 Jul 2016 17:07:47 +0900
Message-ID: <1468138073-4870-6-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/2PiajG+oUNwrXbkTZ+WDYM9SKenCskjsZM9Cmt9HvU=;
        b=jCQ4dTuYUyp/02MkpEON4wSShzeaf5Q8n5P0xb0lAvMOVFgt1P/fnJ/aL7X3EZGRNO
         pX5E9CZg6dna+iZww1WNNRA00w1iv4lmVnZejg8RXhO5jR1A4GxtB5FPtyl32MvJ/soO
         Su4bQQD70Z3DNv6NVxsaRZV7eRCJ8S7JvFW+zNiPLihvdKsWG45r3FguQQh6RfSM7xhb
         oHXZRDBZFAFJP16bSJ+eHfB3qcXu2dPmIpDpTXadduS0oJV79Jb1gmPugnd/oSLN6Nvy
         OKcGtmnnK0BkGrOqOLA2NUQUlRqlV4aSp81SS4B5c6udKtpjTOxmQdVK/oTzzGB+MOep
         l8ZQ==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

The explanation on how ioctl handles devid seems incorrect.
Userspace who calls this ioctl has no input regarding devid,
and ioctl implementation retrieves devid via superblock.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 Documentation/filesystems/autofs4-mount-control.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/autofs4-mount-control.txt b/Documentation/filesystems/autofs4-mount-control.txt
index aff2211..540d9a7 100644
--- a/Documentation/filesystems/autofs4-mount-control.txt
+++ b/Documentation/filesystems/autofs4-mount-control.txt
@@ -323,9 +323,8 @@ mount on the given path dentry.
 
 The call requires an initialized struct autofs_dev_ioctl with the path
 field set to the mount point in question and the size field adjusted
-appropriately as well as the arg1 field set to the device number of the
-containing autofs mount. Upon return the struct field arg1 contains the
-uid and arg2 the gid.
+appropriately. Upon return the struct field arg1 contains the uid and
+arg2 the gid.
 
 When reconstructing an autofs mount tree with active mounts we need to
 re-connect to mounts that may have used the original process uid and
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
