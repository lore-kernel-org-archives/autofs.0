From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - second try - set fields size for pipe packet
Date: Wed, 22 Feb 2006 16:43:26 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0602221633520.19127@eagle.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>


I have made almost all the changes recommended by Christoph.

I'm reluctant to change the type of autofs_wqt_t as it is part of the 
existing autofs4 struture. While such a change shouldn't cause a problem 
I'd rather not change what's been there for a long time just in case there 
are unexpected side effects.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.16-rc4-mm1/include/linux/auto_fs4.h.set-fields-size-for-packet	2006-02-22 16:07:57.000000000 +0800
+++ linux-2.6.16-rc4-mm1/include/linux/auto_fs4.h	2006-02-22 16:08:29.000000000 +0800
@@ -65,11 +65,11 @@ struct autofs_v5_packet {
 	autofs_wqt_t wait_queue_token;
 	__u32 dev;
 	__u64 ino;
-	uid_t uid;
-	gid_t gid;
-	pid_t pid;
-	pid_t tgid;
-	int len;
+	__u32 uid;
+	__u32 gid;
+	__u32 pid;
+	__u32 tgid;
+	__u32 len;
 	char name[NAME_MAX+1];
 };
 
