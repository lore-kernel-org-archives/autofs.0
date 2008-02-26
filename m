From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/4] autofs4 - add mount option to display mount device
Date: Tue, 26 Feb 2008 13:29:07 +0900 (WST)
Message-ID: <Pine.LNX.4.64.0802261219500.8490@raven.themaw.net>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Hi Andrew,

Patch to add a display mount option to show the device number
of the autofs mount super block.

Signed-off-by: Ian Kent < raven@themaw.net>

Ian

---
diff -up linux-2.6.25-rc2-mm1/fs/autofs4/inode.c.add-mount-device-display-option linux-2.6.25-rc2-mm1/fs/autofs4/inode.c
--- linux-2.6.25-rc2-mm1/fs/autofs4/inode.c.add-mount-device-display-option	2008-02-20 13:01:06.000000000 +0900
+++ linux-2.6.25-rc2-mm1/fs/autofs4/inode.c	2008-02-20 13:03:45.000000000 +0900
@@ -190,6 +190,7 @@ static int autofs4_show_options(struct s
 	seq_printf(m, ",timeout=%lu", sbi->exp_timeout/HZ);
 	seq_printf(m, ",minproto=%d", sbi->min_proto);
 	seq_printf(m, ",maxproto=%d", sbi->max_proto);
+	seq_printf(m, ",dev=%d", autofs4_get_dev(sbi));
 
 	if (sbi->type & AUTOFS_TYPE_OFFSET)
 		seq_printf(m, ",offset");
@@ -332,7 +333,7 @@ int autofs4_fill_super(struct super_bloc
 	sbi->sb = s;
 	sbi->version = 0;
 	sbi->sub_version = 0;
-	sbi->type = 0;
+	sbi->type = AUTOFS_TYPE_INDIRECT;
 	sbi->min_proto = 0;
 	sbi->max_proto = 0;
 	mutex_init(&sbi->wq_mutex);
 
