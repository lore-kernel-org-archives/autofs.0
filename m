From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] proper prototype for autofs4_dentry_release()
Date: Sun, 26 Mar 2006 23:06:34 +0200
Message-ID: <20060326210634.GS4053@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751078AbWCZVGg@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

This patch adds a proper prototype for autofs4_dentry_release() to 
autofs_i.h.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/autofs4/autofs_i.h |    3 +++
 fs/autofs4/inode.c    |    1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16-mm1-full/fs/autofs4/autofs_i.h.old	2006-03-26 19:55:17.000000000 +0200
+++ linux-2.6.16-mm1-full/fs/autofs4/autofs_i.h	2006-03-26 19:56:53.000000000 +0200
@@ -230,3 +230,6 @@
 out:
 	return ret;
 }
+
+void autofs4_dentry_release(struct dentry *);
+
--- linux-2.6.16-mm1-full/fs/autofs4/inode.c.old	2006-03-26 19:57:06.000000000 +0200
+++ linux-2.6.16-mm1-full/fs/autofs4/inode.c	2006-03-26 19:57:16.000000000 +0200
@@ -292,7 +292,6 @@
 	return ino;
 }
 
-void autofs4_dentry_release(struct dentry *);
 static struct dentry_operations autofs4_sb_dentry_operations = {
 	.d_release      = autofs4_dentry_release,
 };
