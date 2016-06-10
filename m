From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [PATCH] autofs4: Fix endless loop in autofs4_write
Date: Fri, 10 Jun 2016 19:07:39 +0200
Message-ID: <1465578459-8624-1-git-send-email-ldufour@linux.vnet.ibm.com>
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

The 'commit e9a7c2f1a548 ("autofs4: coding style fixes")' removed the
check done on the __vfs_write()'s returned value in autofs4_write().
This may lead to a spinning process which can't catch any signal.

Call stack showed in xmon could be :
[c0000003a76c7500] c00000000030df74 __vfs_write+0x134/0x1c0
(unreliable)
[c0000003a76c75a0] d0000000052a35d4 autofs4_notify_daemon+0x174/0x3f0
[autofs4]
[c0000003a76c7780] d0000000052a3fa0 autofs4_wait+0x750/0xa10 [autofs4]
[c0000003a76c78b0] d0000000052a24d8 autofs4_mount_wait+0x78/0x140
[autofs4]
[c0000003a76c7930] d0000000052a2f48 autofs4_d_automount+0x1d8/0x370
[autofs4]
[c0000003a76c79c0] c0000000003221e4 follow_managed+0x204/0x3a0
[c0000003a76c7a20] c000000000322c10 lookup_fast+0x220/0x420
[c0000003a76c7a90] c00000000032324c walk_component+0x5c/0x3e0
[c0000003a76c7b00] c000000000323794 link_path_walk+0x1c4/0x5f0
[c0000003a76c7b90] c000000000324b00 path_openat+0xf0/0x1620
[c0000003a76c7c90] c000000000327f6c do_filp_open+0xfc/0x170
[c0000003a76c7dc0] c00000000030d06c do_sys_open+0x1bc/0x2e0
[c0000003a76c7e30] c000000000009260 system_call+0x38/0x108
--- Exception: c01 (System Call) at 00003fffa38a0988

Cc: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Fixes: e9a7c2f1a548 ("autofs4: coding style fixes")
---
 fs/autofs4/waitq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 0146d911f468..106d94139281 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -66,11 +66,12 @@ static int autofs4_write(struct autofs_sb_info *sbi,
 	set_fs(KERNEL_DS);
 
 	mutex_lock(&sbi->pipe_mutex);
-	wr = __vfs_write(file, data, bytes, &file->f_pos);
-	while (bytes && wr) {
+	while (bytes) {
+		wr = __vfs_write(file, data, bytes, &file->f_pos);
+		if (wr < 0)
+			break;
 		data += wr;
 		bytes -= wr;
-		wr = __vfs_write(file, data, bytes, &file->f_pos);
 	}
 	mutex_unlock(&sbi->pipe_mutex);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
