From: David Howells <dhowells@redhat.com>
Subject: [PATCH] autofs4: Use no_printk() for no-op DPRINTK() and use
 __VA_ARGS__ too
Date: Tue, 18 Jan 2011 22:29:59 +0000
Message-ID: <20110118222959.2318.84777.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: viro@zeniv.linux.org.uk, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

Use no_printk() for autofs's no-op DPRINTK() to prevent unused statements from
becoming accidentally obsolete, and use __VA_ARGS__ too as that's the standard
way.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/autofs4/autofs_i.h |   10 +++++++---
 fs/autofs4/waitq.c    |    3 ++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 54f9237..ef89828 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -40,13 +40,17 @@
 /* #define DEBUG */
 
 #ifdef DEBUG
-#define DPRINTK(fmt, args...)				\
+#define DPRINTK(fmt, ...)				\
 do {							\
 	printk(KERN_DEBUG "pid %d: %s: " fmt "\n",	\
-		current->pid, __func__, ##args);	\
+		current->pid, __func__, ##__VA_ARGS__);	\
 } while (0)
 #else
-#define DPRINTK(fmt, args...) do {} while (0)
+#define DPRINTK(fmt, ...)					\
+do {								\
+	no_printk(KERN_DEBUG "pid %d: %s: " fmt "\n",		\
+		  current->pid, __func__, ##__VA_ARGS__);	\
+} while (0)
 #endif
 
 #define AUTOFS_WARN(fmt, args...)			\
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 5601005..4d169cf 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -104,7 +104,8 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
 	size_t pktsz;
 
 	DPRINTK("wait id = 0x%08lx, name = %.*s, type=%d",
-		wq->wait_queue_token, wq->name.len, wq->name.name, type);
+		(unsigned long)wq->wait_queue_token,
+		wq->name.len, wq->name.name, type);
 
 	memset(&pkt,0,sizeof pkt); /* For security reasons */
 

