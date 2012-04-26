From: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2] Introduce a version6 of autofs interface, to fix design error.
Date: Thu, 26 Apr 2012 17:34:49 +0400
Message-ID: <1335447289-9909-1-git-send-email-mjt@msgid.tls.msk.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@vger.kernel.org, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, stable@kernel.org

This patch introduces a new autofs interface version, v6, which
is exactly the same as v5 but uses better defined packet structure
which does not change between architectures or platform bitness.
Old interface is supported still.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Cc: Ian Kent <raven@themaw.net>
Cc: Thomas Meyer <thomas@m3y3r.de>
Cc: stable@kernel.org
---
 fs/autofs4/waitq.c       |    6 ++++--
 include/linux/auto_fs4.h |   31 +++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index da8876d..97866e8 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -145,7 +145,7 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
 		break;
 	}
 	/*
-	 * Kernel protocol v5 packet for handling indirect and direct
+	 * Kernel protocol v5/v6 packet for handling indirect and direct
 	 * mount missing and expire requests
 	 */
 	case autofs_ptype_missing_indirect:
@@ -155,7 +155,9 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
 	{
 		struct autofs_v5_packet *packet = &pkt.v5_pkt.v5_packet;
 
-		pktsz = sizeof(*packet);
+		pktsz = (sbi->version == 5) ?
+			sizeof(struct autofs_v5_bad_packet) :
+			sizeof(struct autofs_v5_packet);
 
 		packet->wait_queue_token = wq->wait_queue_token;
 		packet->len = wq->name.len;
diff --git a/include/linux/auto_fs4.h b/include/linux/auto_fs4.h
index e02982f..fdef141 100644
--- a/include/linux/auto_fs4.h
+++ b/include/linux/auto_fs4.h
@@ -20,11 +20,11 @@
 #undef AUTOFS_MIN_PROTO_VERSION
 #undef AUTOFS_MAX_PROTO_VERSION
 
-#define AUTOFS_PROTO_VERSION		5
+#define AUTOFS_PROTO_VERSION		6
 #define AUTOFS_MIN_PROTO_VERSION	3
-#define AUTOFS_MAX_PROTO_VERSION	5
+#define AUTOFS_MAX_PROTO_VERSION	6
 
-#define AUTOFS_PROTO_SUBVERSION		2
+#define AUTOFS_PROTO_SUBVERSION		0
 
 /* Mask for expire behaviour */
 #define AUTOFS_EXP_IMMEDIATE		1
@@ -126,7 +126,7 @@ union autofs_packet_union {
 	struct autofs_packet_expire_multi expire_multi;
 };
 
-/* autofs v5 common packet struct */
+/* autofs v5/v6 common packet struct */
 struct autofs_v5_packet {
 	struct autofs_packet_hdr hdr;
 	autofs_wqt_t wait_queue_token;
@@ -138,6 +138,29 @@ struct autofs_v5_packet {
 	__u32 tgid;
 	__u32 len;
 	char name[NAME_MAX+1];
+
+	/* padding to make
+	 *   sizeof(autofs_v5_packet) % sizeof(__u64) == 0
+	 * on all arches */
+	char _pad[4];
+};
+
+/* earlier kernel interface used this structure for v5 packet,
+ * which is exactly the same as autofs_v5_packet above
+ * but does not have padding at the end.  The result was that
+ * sizeof it was 300 bytes on x86-32 and 304 bytes on x86-64.
+ * We keep it for compatibility with older userspace. */
+struct autofs_v5_bad_packet {
+	struct autofs_packet_hdr hdr;
+	autofs_wqt_t wait_queue_token;
+	__u32 dev;
+	__u64 ino;
+	__u32 uid;
+	__u32 gid;
+	__u32 pid;
+	__u32 tgid;
+	__u32 len;
+	char name[NAME_MAX+1];
 };
 
 typedef struct autofs_v5_packet autofs_packet_missing_indirect_t;
-- 
1.7.10
