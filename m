From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/5] autofs: drop wrong comment
Date: Wed, 16 Aug 2017 10:31:31 +0800
Message-ID: <150285069148.4670.17959501481201077445.stgit@pluto.themaw.net>
References: <150285067347.4670.11494624644273072003.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150285067347.4670.11494624644273072003.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

This comment was correct when it was added in 8d7b48e0 in 2008,
but not after 4e44b685 in 2009 which introduced find_autofs_mount().

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/dev-ioctl.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index b8b66d55266d..a990c9d0f893 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -258,11 +258,6 @@ static int autofs_dev_ioctl_open_mountpoint(const char *name, dev_t devid)
 		if (err)
 			goto out;
 
-		/*
-		 * Find autofs super block that has the device number
-		 * corresponding to the autofs fs we want to open.
-		 */
-
 		filp = dentry_open(&path, O_RDONLY, current_cred());
 		path_put(&path);
 		if (IS_ERR(filp)) {

