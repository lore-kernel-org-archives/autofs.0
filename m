From: Ian Kent <raven@themaw.net>
Subject: [PATCH 03/37] autofs-5.1.2 - Fix compiler warning in try_remount()
Date: Tue, 25 Oct 2016 09:17:40 +0800
Message-ID: <20161025011740.7778.72349.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=cYHAYdZZRVVFSLJRFwlVTIfdjeM=; b=gdP9NoDDSxKSf1F9F2
        VqcF14eC+dUjEK4ZtIOAYhV5BfVat7lE5xFHJ7VVN+GRgHvitmR2OdQqUeckXWqp
        wj7pCcdjxqwsmQ70HivTs0Yrt/4DZpw65o/meSj7wO1cM2HatJR4s6JIJJvi8noG
        GzWVrgw/WWusnh+NNdja+4m5k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=cYHAYdZZRVVFSLJRFwlVTI
        fdjeM=; b=RGnMtEZkigYmUgMad8n2ty8Nu1nioLNFlUbRmDXlpngpSHHQRR6ptj
        BOHv8wyRaUR2d4TRPIXM1FIe92BOqwTUU2TCiwFJzKpZ0NJ7BM6IK5/gubwVxeRl
        n0HORi7yPk1QSb9Rtkb3L0SwR4l5K++kdc/33/ny+4n9MLzBfWZGU=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Fix below compiler (gcc5) warning which isn't autoconf result dependent.
mounts.c:1779:7: warning: variable 'ret' set but not used [-Wunused-but-set-variable]

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG    |    1 +
 lib/mounts.c |    5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 2e51f62..288d175 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -2,6 +2,7 @@ xx/xx/2016 autofs-5.1.3
 =======================
 - fix release date in CHANGELOG.
 - build: check for clock_gettime in librt.
+- fix compiler warning in try_remount().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/lib/mounts.c b/lib/mounts.c
index 1d1b4da..c67548e 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -1776,16 +1776,15 @@ static int remount_active_mount(struct autofs_point *ap,
 			*ioctlfd = -1;
 		}
 	} else {
-		int ret;
 		/*
 		 * What can I do if we can't remount the existing
 		 * mount(s) (possibly a partial failure), everything
 		 * following will be broken?
 		 */
 		if (type == t_indirect)
-			ret = do_remount_indirect(ap, fd, path);
+			do_remount_indirect(ap, fd, path);
 		else
-			ret = do_remount_direct(ap, fd, path);
+			do_remount_direct(ap, fd, path);
 	}
 
 	debug(ap->logopt, "re-connected to mount %s", path);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
