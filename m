From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs: fix wait name hash calculation in autofs_wait()
Date: Thu, 23 Sep 2021 15:13:39 +0800
Message-ID: <163238121836.315941.18066358755443618960.stgit@mickey.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

There's a mistake in commit 2be7828c9fefc ("get rid of autofs_getpath()")
that affects kernels from v5.13.0, basically missed because of me not
fully testing the change for Al.

The problem is that the hash calculation for the wait name qstr hasn't
been updated to account for the change to use dentry_path_raw(). This
prevents the correct matching an existing wait resulting in multiple
notifications being sent to the daemon for the same mount which must
not occur.

The problem wasn't discovered earlier because it only occurs when
multiple processes trigger a request for the same mount concurrently
so it only shows up in more aggressive testing.

Fixes: 2be7828c9fefc ("get rid of autofs_getpath()")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/waitq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 16b5fca0626e..54c1f8b8b075 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -358,7 +358,7 @@ int autofs_wait(struct autofs_sb_info *sbi,
 		qstr.len = strlen(p);
 		offset = p - name;
 	}
-	qstr.hash = full_name_hash(dentry, name, qstr.len);
+	qstr.hash = full_name_hash(dentry, qstr.name, qstr.len);
 
 	if (mutex_lock_interruptible(&sbi->wq_mutex)) {
 		kfree(name);


