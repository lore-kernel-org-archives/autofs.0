From: Ian Kent <raven@themaw.net>
Subject: [PATCH 07/35] autofs-5.1.3 - add version parameter to rpc_ping()
Date: Mon, 16 Oct 2017 13:06:35 +0800
Message-ID: <150813039572.25695.15796244248539609624.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add an version parameter to rpc_ping() to try and avoid NFS pings
to protocol or NFS version that isn't to be used.

When the port option is specified (possibly for NFS tunneling) it's
likely that the protocol is also specified which will reduce uneeded
NFS ping requests. But for this to work best (with the minimum delay)
the NFS version needs to also be specified in the NFS mount options.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 include/rpc_subs.h  |    2 +
 lib/rpc_subs.c      |   74 +++++++++++++++++++++++++++------------------------
 modules/mount_nfs.c |    2 +
 4 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index a56b2894..cc61f59e 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -5,6 +5,7 @@ xx/xx/2017 autofs-5.1.4
 - remove some redundant rpc library code.
 - add port parameter to rpc_ping().
 - dont probe NFSv2 by default.
+- add version parameter to rpc_ping().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/include/rpc_subs.h b/include/rpc_subs.h
index def80a2f..6e35eedf 100644
--- a/include/rpc_subs.h
+++ b/include/rpc_subs.h
@@ -69,7 +69,7 @@ void rpc_destroy_tcp_client(struct conn_info *);
 int rpc_portmap_getclient(struct conn_info *, const char *, struct sockaddr *, size_t, int, unsigned int);
 int rpc_portmap_getport(struct conn_info *, struct pmap *, unsigned short *);
 int rpc_ping_proto(struct conn_info *);
-int rpc_ping(const char *, int, long, long, unsigned int);
+int rpc_ping(const char *, int, unsigned int, long, long, unsigned int);
 double monotonic_elapsed(struct timespec, struct timespec);
 const char *get_addr_string(struct sockaddr *, char *, socklen_t);
 
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index a039e8ee..9a267e4f 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -43,6 +43,7 @@ const rpcvers_t rpcb_version = PMAPVERS;
 
 #include "mount.h"
 #include "rpc_subs.h"
+#include "replicated.h"
 #include "automount.h"
 
 /* #define STANDALONE */
@@ -1043,43 +1044,46 @@ static int __rpc_ping(const char *host,
 }
 
 int rpc_ping(const char *host, int port,
-	     long seconds, long micros, unsigned int option)
+	     unsigned int version, long seconds, long micros,
+	     unsigned int option)
 {
-	unsigned long vers4 = NFS4_VERSION;
-	unsigned long vers3 = NFS3_VERSION;
-	unsigned long vers2 = NFS2_VERSION;
-	int status;
+	int status = 0;
+
+	if ((version & NFS2_REQUESTED) && (version & TCP_REQUESTED)) {
+		status = __rpc_ping(host, NFS2_VERSION,
+				    IPPROTO_TCP, port, seconds, micros, option);
+		if (status > 0)
+			return RPC_PING_V2 | RPC_PING_TCP;
+	}
+
+	if ((version & NFS2_REQUESTED) && (version & UDP_REQUESTED)) {
+		status = __rpc_ping(host, NFS2_VERSION,
+				    IPPROTO_UDP, port, seconds, micros, option);
+		if (status > 0)
+			return RPC_PING_V2 | RPC_PING_UDP;
+	}
 
-	status = __rpc_ping(host, vers2,
-			    IPPROTO_UDP, port, seconds, micros, option);
-	if (status > 0)
-		return RPC_PING_V2 | RPC_PING_UDP;
-
-	status = __rpc_ping(host, vers3,
-			    IPPROTO_UDP, port, seconds, micros, option);
-	if (status > 0)
-		return RPC_PING_V3 | RPC_PING_UDP;
-
-	/* UDP isn't recommended for NFSv4, don't bother checking it.
-	status = __rpc_ping(host, vers4, IPPROTO_UDP, seconds, micros, option);
-	if (status > 0)
-		return RPC_PING_V4 | RPC_PING_UDP;
-	*/
-
-	status = __rpc_ping(host, vers2,
-			    IPPROTO_TCP, port, seconds, micros, option);
-	if (status > 0)
-		return RPC_PING_V2 | RPC_PING_TCP;
-
-	status = __rpc_ping(host, vers3, port,
-			    IPPROTO_TCP, seconds, micros, option);
-	if (status > 0)
-		return RPC_PING_V3 | RPC_PING_TCP;
-
-	status = __rpc_ping(host, vers4,
-			    IPPROTO_TCP, port, seconds, micros, option);
-	if (status > 0)
-		return RPC_PING_V4 | RPC_PING_TCP;
+	if ((version & NFS3_REQUESTED) && (version & TCP_REQUESTED)) {
+		status = __rpc_ping(host, NFS3_VERSION,
+				    IPPROTO_TCP, port, seconds, micros, option);
+		if (status > 0)
+			return RPC_PING_V3 | RPC_PING_TCP;
+	}
+
+	if ((version & NFS3_REQUESTED) && (version & UDP_REQUESTED)) {
+		status = __rpc_ping(host, NFS3_VERSION,
+				    IPPROTO_UDP, port, seconds, micros, option);
+		if (status > 0)
+			return RPC_PING_V3 | RPC_PING_UDP;
+	}
+
+	if (version & NFS4_REQUESTED) {
+		/* UDP isn't recommended for NFSv4, don't check it. */
+		status = __rpc_ping(host, NFS4_VERSION,
+				    IPPROTO_TCP, port, seconds, micros, option);
+		if (status > 0)
+			return RPC_PING_V4 | RPC_PING_TCP;
+	}
 
 	return status;
 }
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index a0ab656b..97f12c4d 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -358,7 +358,7 @@ dont_probe:
 			char *host = this->name ? this->name : "localhost";
 			int ret;
 
-			ret = rpc_ping(host, port, 2, 0, RPC_CLOSE_DEFAULT);
+			ret = rpc_ping(host, port, vers, 2, 0, RPC_CLOSE_DEFAULT);
 			if (ret <= 0)
 				goto next;
 		}

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
