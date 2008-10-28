From: Ian Kent <raven@themaw.net>
Subject: [RESEND PATCH] autofs4 - remove string terminator check
Date: Tue, 28 Oct 2008 10:14:30 +0900
Message-ID: <20081028011430.4976.320.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

In a previous patch a comment was made that checking for the existence of
a NULL terminator in strings copied from userspace wasn't needed as this
is done in many places in the kernel without problem. This patch removes
this string terminator check.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---

 fs/autofs4/dev-ioctl.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 625abf5..304c1ff 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -51,18 +51,6 @@ static int check_name(const char *name)
 }
 
 /*
- * Check a string doesn't overrun the chunk of
- * memory we copied from user land.
- */
-static int invalid_str(char *str, void *end)
-{
-	while ((void *) str <= end)
-		if (!*str++)
-			return 0;
-	return -EINVAL;
-}
-
-/*
  * Check that the user compiled against correct version of autofs
  * misc device code.
  *
@@ -143,14 +131,6 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 				    cmd);
 			goto out;
 		}
-
-		err = invalid_str(param->path,
-				 (void *) ((size_t) param + param->size));
-		if (err) {
-			AUTOFS_WARN("invalid path supplied for cmd(0x%08x)",
-				    cmd);
-			goto out;
-		}
 	}
 
 	err = 0;

