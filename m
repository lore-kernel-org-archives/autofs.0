From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/7] autofs: fix wrong ioctl documentation regarding devid
Date: Mon, 30 Jan 2017 18:20:51 +0800
Message-ID: <148577165119.9801.16967562019122274820.stgit@pluto.themaw.net>
References: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=QKi1w2h/NeZcv4p
        7ZUc8RR3zIcc=; b=yi15FLZWI4oAJx8s0t/ughVSyFBIt3FrESLbMMTalYrIPrI
        6yGvmpcm7/NClTygRSF1zpTuTG8Yll+xxTdDXxgJgWeg9NF9iYy618P1LosM7HHe
        15brr3Pb0TFPJpxmAlB+JpAI1Jm8kbTT5w37BjOrsZTXFN7ZRtiUEAgfizTs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=QKi1w2h/NeZcv4p7ZUc8RR3zIcc=; b=W55KOCc+zDE38Z1E092A
        SF18jEsnDk33feli2v6Hb9aEjMy3PN3g5HyHQXikIeNxj1epreqhc+WyA9y4tCc9
        ylsUnwktrRPER7bzvjHwIkp6bJiL90x+LNablXTK71G+eWUjsWlKDBRIWd09t6/x
        vadewYSj3HQEnze44B1otl0=
In-Reply-To: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

This is the same as d8732841 except that it's a different file.
A caller has no devid input, and devid is obtained via superblock.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs4.txt |    5 ++---
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

