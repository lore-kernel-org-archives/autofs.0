From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs4 - fix string validation check order
Date: Tue, 28 Oct 2008 14:30:53 +0900
Message-ID: <20081028053053.29379.15598.stgit@zeus.themaw.net>
References: <20081028053047.29379.19919.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20081028053047.29379.19919.stgit@zeus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

In function validate_dev_ioctl() we check that the string we've
been sent is a valid path. The function that does this check
assumes the string is NULL terminated but our NULL termination
check isn't done until after this call. This patch changes the
order of the check.

Signed-off-by: Ian Kent <raven@themaw.net>
---

 fs/autofs4/dev-ioctl.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 3d5a327..4a084fa 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -124,7 +124,7 @@ static inline void free_dev_ioctl(struct autofs_dev_ioctl *param)
 
 /*
  * Check sanity of parameter control fields and if a path is present
- * check that it has a "/" and is terminated.
+ * check that it is terminated and contains at least one "/".
  */
 static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 {
@@ -137,15 +137,16 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 	}
 
 	if (param->size > sizeof(*param)) {
-		err = check_name(param->path);
+		err = invalid_str(param->path,
+				 (void *) ((size_t) param + param->size));
 		if (err) {
-			AUTOFS_WARN("invalid path supplied for cmd(0x%08x)",
-				    cmd);
+			AUTOFS_WARN(
+			  "path string terminator missing for cmd(0x%08x)",
+			  cmd);
 			goto out;
 		}
 
-		err = invalid_str(param->path,
-				 (void *) ((size_t) param + param->size));
+		err = check_name(param->path);
 		if (err) {
 			AUTOFS_WARN("invalid path supplied for cmd(0x%08x)",
 				    cmd);

