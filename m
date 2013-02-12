From: Tim Gardner <tim.gardner@canonical.com>
Subject: [PATCH linux-next] autofs4: autofs4_catatonic_mode(): remove redundant null check on kfree()
Date: Tue, 12 Feb 2013 10:12:18 -0700
Message-ID: <1360689138-59191-1-git-send-email-tim.gardner@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Tim Gardner <tim.gardner@canonical.com>, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

smatch analysis:

fs/autofs4/waitq.c:46 autofs4_catatonic_mode() info: redundant null
 check on wq->name.name calling kfree()

Cc: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 fs/autofs4/waitq.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 03bc1d3..3db70da 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -42,10 +42,8 @@ void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
 	while (wq) {
 		nwq = wq->next;
 		wq->status = -ENOENT; /* Magic is gone - report failure */
-		if (wq->name.name) {
-			kfree(wq->name.name);
-			wq->name.name = NULL;
-		}
+		kfree(wq->name.name);
+		wq->name.name = NULL;
 		wq->wait_ctr--;
 		wake_up_interruptible(&wq->queue);
 		wq = nwq;
-- 
1.7.9.5
