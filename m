From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/autofs4 files
Date: Sun, 18 Jul 2004 11:59:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040718185909.22648.qmail@web53801.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264389AbUGRS7K@vger.kernel.org>
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lkml <linux-kernel@vger.kernel.org>
Cc: raven@themaw.net, autofs@linux.kernel.org

diff -ru linux-2.6.7-orig/fs/autofs4/autofs_i.h linux-2.6.7-new/fs/autofs4/autofs_i.h
--- linux-2.6.7-orig/fs/autofs4/autofs_i.h      2004-06-15 22:19:42.000000000 -0700
+++ linux-2.6.7-new/fs/autofs4/autofs_i.h       2004-07-18 08:49:11.000000000 -0700
@@ -138,7 +138,6 @@
 }

 struct inode *autofs4_get_inode(struct super_block *, struct autofs_info *);
-struct autofs_info *autofs4_init_inf(struct autofs_sb_info *, mode_t mode);
 void autofs4_free_ino(struct autofs_info *);

 /* Expiration */
