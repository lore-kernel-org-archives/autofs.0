From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/3] autofs - make dev ioctl version and ismountpoint user
 accessible
Date: Tue, 08 Aug 2017 12:27:05 +0800
Message-ID: <150216642517.11652.2338933266137331637.stgit@pluto.themaw.net>
References: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Ondrej Holy <oholy@redhat.com>, Colin Walters <walters@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Some of the autofs miscellaneous device ioctls need to be accessable to
user space applications without CAP_SYS_ADMIN to get information about
autofs mounts.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Colin Walters <walters@redhat.com>
Cc: Ondrej Holy <oholy@redhat.com>
---
 fs/autofs4/dev-ioctl.c              |   12 ++++++++----
 include/uapi/linux/auto_dev-ioctl.h |    2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 218a4ecc75cc..ea8b3a1cddd2 100644
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
diff --git a/include/uapi/linux/auto_dev-ioctl.h b/include/uapi/linux/auto_dev-ioctl.h
index 744b3d060968..5558db8e6646 100644
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
