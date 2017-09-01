From: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
Subject: [RFC PATCH 2/2] autofs: sent 32-bit sized packet for 32-bit process
Date: Fri, 01 Sep 2017 15:21:49 +0400
Message-ID: <20170901112149.2669.85432.stgit@localhost.localdomain>
References: <20170901110906.2669.1577.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170901110906.2669.1577.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, devel@openvz.org, ldv@altlinux.org

The structure autofs_v5_packet (except name) is not aligned by 8 bytes, which
leads to different sizes in 32 and 64-bit architectures.
Let's form 32-bit compatible packet when daemon has 32-bit addressation.

Suggested-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
---
 fs/autofs4/waitq.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 24a58bf..1f9b7d8 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -151,6 +151,11 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
 		struct autofs_v5_packet *packet = &pkt.v5_pkt.v5_packet;
 		struct user_namespace *user_ns = sbi->pipe->f_cred->user_ns;
 
+#ifdef CONFIG_COMPAT
+		if (sbi->is32bit)
+			pktsz = offsetofend(struct autofs_v5_packet, name);
+		else
+#endif
 		pktsz = sizeof(*packet);
 
 		packet->wait_queue_token = wq->wait_queue_token;

