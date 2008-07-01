From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/5] autofs4 - check kernel communication pipe is valid for
	write
Date: Tue, 01 Jul 2008 17:26:15 +0800
Message-ID: <20080701092613.12041.19457.stgit@raven.themaw.net>
References: <20080701092548.12041.69868.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080701092548.12041.69868.stgit@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

It is possible for an autofs mount to become catatonic (and for the
daemon communication pipe to become NULL) after a wait has been
initiallized but before the request has been sent to the daemon. We
need to check for this before sending the request packet.

Signed-off-by: Ian Kent <raven@themaw.net>

---

 fs/autofs4/waitq.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)


diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index f8dee31..aa7b526 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -99,6 +99,7 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
 		union autofs_packet_union v4_pkt;
 		union autofs_v5_packet_union v5_pkt;
 	} pkt;
+	struct file *pipe = NULL;
 	size_t pktsz;
 
 	DPRINTK("wait id = 0x%08lx, name = %.*s, type=%d",
@@ -164,8 +165,19 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
 		return;
 	}
 
-	if (autofs4_write(sbi->pipe, &pkt, pktsz))
-		autofs4_catatonic_mode(sbi);
+	/* Check if we have become catatonic */
+	mutex_lock(&sbi->wq_mutex);
+	if (!sbi->catatonic) {
+		pipe = sbi->pipe;
+		get_file(pipe);
+	}
+	mutex_unlock(&sbi->wq_mutex);
+
+	if (pipe) {
+		if (autofs4_write(pipe, &pkt, pktsz))
+			autofs4_catatonic_mode(sbi);
+		fput(pipe);
+	}
 }
 
 static int autofs4_getpath(struct autofs_sb_info *sbi,
