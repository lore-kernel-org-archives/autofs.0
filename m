From: kusumi.tomohiro@gmail.com
Subject: [PATCH 6/6] autofs: remove duplicated AUTOFS_DEV_IOCTL_SIZE definition
Date: Tue, 17 Jan 2017 23:42:33 +0900
Message-ID: <1484664153-20478-6-git-send-email-tkusumi@tuxera.com>
References: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=smNmG9huQ+C6Z0mGeR8DH1zW1yW2eUoUDryNmdVyJ18=;
        b=IYQkpCOJ5jg7ORpj3lNWouJ/NAGT/ptcd5PTAMokdY+Vpzg2PZ4PB0DHRGDZx3QIVf
         Tac5BijZHRtfYWzRG6Dn7GmiZjP/2KzUpOv3ejhOlM2LpDN7zE8cr1QvTCvMRmKXKcg6
         TyLZY3SmXr5HC3zdGzUOhzYNNNZQByJ3QiPLUoGpCoc4rkeZ9Uf5RAHFuvnNi4kuM7Ks
         5Jr3P+QRCSWcJ8clyj2FWAIyeVOyH9qj36QWx9yY9csO6rbUmSemSFrfEhaVvhPb24Gy
         vULaG/HvQ6StWe5EJRsy7i1G46umcZpmKhThKv3+V0ncj41WpTSdLXSdYYsr5Ef6KNds
         LZUQ==
In-Reply-To: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

This macro is already defined in uapi header.
Also use this macro where possible.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 fs/autofs4/dev-ioctl.c              | 2 --
 include/uapi/linux/auto_dev-ioctl.h | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 6f48d67..806df74 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -38,8 +38,6 @@
  * which have been left busy at at service shutdown.
  */
 
-#define AUTOFS_DEV_IOCTL_SIZE	sizeof(struct autofs_dev_ioctl)
-
 typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *,
 			struct autofs_dev_ioctl *);
 
diff --git a/include/uapi/linux/auto_dev-ioctl.h b/include/uapi/linux/auto_dev-ioctl.h
index af107aa..744b3d0 100644
--- a/include/uapi/linux/auto_dev-ioctl.h
+++ b/include/uapi/linux/auto_dev-ioctl.h
@@ -113,10 +113,10 @@ struct autofs_dev_ioctl {
 
 static inline void init_autofs_dev_ioctl(struct autofs_dev_ioctl *in)
 {
-	memset(in, 0, sizeof(struct autofs_dev_ioctl));
+	memset(in, 0, AUTOFS_DEV_IOCTL_SIZE);
 	in->ver_major = AUTOFS_DEV_IOCTL_VERSION_MAJOR;
 	in->ver_minor = AUTOFS_DEV_IOCTL_VERSION_MINOR;
-	in->size = sizeof(struct autofs_dev_ioctl);
+	in->size = AUTOFS_DEV_IOCTL_SIZE;
 	in->ioctlfd = -1;
 }
 
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
