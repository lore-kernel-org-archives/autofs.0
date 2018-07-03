From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - fix slab out of bounds read in getname_kernel()
Date: Tue, 03 Jul 2018 14:45:15 +0800
Message-ID: <153060031527.26631.18306637892746301555.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomas Bortoli <tomasbortoli@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>

Initial patch contributed by Tomas Bortoli.

The autofs subsystem does not check that the "path" parameter is
present for all cases where it is required when it is passed in
via the "param" struct.

In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
ioctl command.

To solve it, modify validate_dev_ioctl() function to check that a
path has been provided for ioctl commands that require it.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com
---
 fs/autofs/dev-ioctl.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index ea4ca1445ab7..86eafda4a652 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -135,6 +135,15 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 				cmd);
 			goto out;
 		}
+	} else {
+		unsigned int inr = _IOC_NR(cmd);
+
+		if (inr == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD ||
+		    inr == AUTOFS_DEV_IOCTL_REQUESTER_CMD ||
+		    inr == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	err = 0;
@@ -271,7 +280,8 @@ static int autofs_dev_ioctl_openmount(struct file *fp,
 	dev_t devid;
 	int err, fd;
 
-	/* param->path has already been checked */
+	/* param->path has been checked in validate_dev_ioctl() */
+
 	if (!param->openmount.devid)
 		return -EINVAL;
 
@@ -433,10 +443,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
 	dev_t devid;
 	int err = -ENOENT;
 
-	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
-		err = -EINVAL;
-		goto out;
-	}
+	/* param->path has been checked in validate_dev_ioctl() */
 
 	devid = sbi->sb->s_dev;
 
@@ -521,10 +528,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 	unsigned int devid, magic;
 	int err = -ENOENT;
 
-	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
-		err = -EINVAL;
-		goto out;
-	}
+	/* param->path has been checked in validate_dev_ioctl() */
 
 	name = param->path;
 	type = param->ismountpoint.in.type;

