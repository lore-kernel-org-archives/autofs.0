From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/3] autofs - make dev ioctl version and ismountpoint user
 accessible
Date: Wed, 10 May 2017 12:18:43 +0800
Message-ID: <149438992338.26550.10884570110596019368.stgit@pluto.themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=7/62A3y/4yxanZZpNw
        fJunfGoJObkMbekvifbrXVkyU=; b=A1G40w+G8fHEF1m9OUidj8WIs5bBoojgU1
        h/qJdS4dsPc70X2G3TNzXC9hIrYzzripnvPtjYnvIcwDYdkqk2VpSvD/gj3wUD3S
        VF4SXaeW795fzTtHTe3AVXPSNulIc/CkbeAHh2XplrT9CSPlveM2VPZtJoP+PEB5
        7DfF3stpDuHi1eOiFkCU/iS0h+Mcib25GB8E5y2MSGC7sX1XUV/RUbK38F++TX62
        1X1QwOylQ18f8a8vZ3uvaeIURmDSpvkpvvFOb8t8zymhYKFoEOvEbMO11rqkgGMr
        ZL8r2ybku8Kd5vGarv196rIYpYR4SPPW8PjBxd04MI3LOfm4OMhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=7/62A3y/4yxanZZpNwfJunfGoJObkMbekvifbrXVkyU=; b=NolMLiCw
        U3kvsDDPV4hFo7rm+ayh1SXpvV2jduOVKWGbK2Y5ojix/BGim6DWP8CutgKljnda
        knrWPQD5ui+zT12KK+3bVbx+GJBCDiswvnsTWB5BD5rAD+Lck6nTVQLkHwhtGgRZ
        CgTy7K81h5mKvADn6Bf6r0/o6d/Bn/Fgupya8/eSj01q2H8MhAPfFRGeKnHzovDt
        xvnFp7rqeicB5esqWBN2EainV/DbwpOMo3A7QASq/SKe7dd2EDZv4b07fUGR8UNW
        6yqkTGm0Z9egjLwtsqGQjXysKvAUlv69+LMDfT8pcHlv94PSSwijrawh/ntyave1
        K4l3vPAQNhomOQ==
In-Reply-To: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Some of the autofs miscellaneous device ioctls need to be accessable to
user space applications without CAP_SYS_ADMIN to get information about
autofs mounts.

Start by making the autofs miscellaneous device ioctl header available
and allow applications to use version and ismountpoint ioctls.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Colin Walters <walters@redhat.com>
Cc: Ondrej Holy <oholy@redhat.com>
Cc: stable@vger.kernel.org
---
 fs/autofs4/dev-ioctl.c              |   12 ++++++++----
 include/uapi/linux/Kbuild           |    1 +
 include/uapi/linux/auto_dev-ioctl.h |    2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 9b58d6e..f8cb3f6 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -628,10 +628,6 @@ static int _autofs_dev_ioctl(unsigned int command,
 	ioctl_fn fn = NULL;
 	int err = 0;
 
-	/* only root can play with this */
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	cmd_first = _IOC_NR(AUTOFS_DEV_IOCTL_IOC_FIRST);
 	cmd = _IOC_NR(command);
 
@@ -640,6 +636,14 @@ static int _autofs_dev_ioctl(unsigned int command,
 		return -ENOTTY;
 	}
 
+	/* Only root can use ioctls other than AUTOFS_DEV_IOCTL_VERSION_CMD
+	 * and AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD
+	 */
+	if (cmd != AUTOFS_DEV_IOCTL_VERSION_CMD &&
+	    cmd != AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	/* Copy the parameters into kernel space. */
 	param = copy_dev_ioctl(user);
 	if (IS_ERR(param))
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index 662c592..1f22bbb 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -61,6 +61,7 @@ header-y += atm_zatm.h
 header-y += audit.h
 header-y += auto_fs4.h
 header-y += auto_fs.h
+header-y += auto_dev-ioctl.h
 header-y += auxvec.h
 header-y += ax25.h
 header-y += b1lli.h
diff --git a/include/uapi/linux/auto_dev-ioctl.h b/include/uapi/linux/auto_dev-ioctl.h
index 744b3d0..5558db8 100644
--- a/include/uapi/linux/auto_dev-ioctl.h
+++ b/include/uapi/linux/auto_dev-ioctl.h
@@ -16,7 +16,7 @@
 #define AUTOFS_DEVICE_NAME		"autofs"
 
 #define AUTOFS_DEV_IOCTL_VERSION_MAJOR	1
-#define AUTOFS_DEV_IOCTL_VERSION_MINOR	0
+#define AUTOFS_DEV_IOCTL_VERSION_MINOR	1
 
 #define AUTOFS_DEV_IOCTL_SIZE		sizeof(struct autofs_dev_ioctl)
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
