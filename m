From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/6] autofs4 - collect version check return
Date: Thu, 23 Oct 2008 10:35:27 +0800
Message-ID: <20081023023527.4508.10819.stgit@raven.themaw.net>
References: <20081023023513.4508.54940.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20081023023513.4508.54940.stgit@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

The function check_dev_ioctl_version() returns an error code upon fail
but it isn't captured and returned in validate_dev_ioctl() as it should
be.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

---

 fs/autofs4/dev-ioctl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 304c1ff..63bfb5d 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -116,9 +116,9 @@ static inline void free_dev_ioctl(struct autofs_dev_ioctl *param)
  */
 static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 {
-	int err = -EINVAL;
+	int err;
 
-	if (check_dev_ioctl_version(cmd, param)) {
+	if ((err = check_dev_ioctl_version(cmd, param))) {
 		AUTOFS_WARN("invalid device control module version "
 		     "supplied for cmd(0x%08x)", cmd);
 		goto out;

