From: Ian Kent <raven@themaw.net>
Subject: [PATCH 05/19] autofs-5.1.3 - add port parameter to rpc_ping()
Date: Wed, 02 Aug 2017 10:17:31 +0800
Message-ID: <150164025183.6106.12184932772046307079.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Commit 4914be96 introduced an NFS ping probe to check availability on
fallback from bind mount failure but failed to take into account the
case where the port option had been given to avoid bind mounting.

Change rpc_ping() and __rpc_ping() to take a port parameter and don't
contact the portmapper or rpcbind if it is valid.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 include/rpc_subs.h  |    2 +-
 lib/rpc_subs.c      |   41 ++++++++++++++++++++++++++---------------
 modules/mount_nfs.c |    2 +-
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 977dfcda..1aa1dbb5 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -3,6 +3,7 @@ xx/xx/2017 autofs-5.1.4
 - fix unset tsd group name handling.
 - Add -c option when calling /bin/umount - if supported.
 - remove some redundant rpc library code.
+- add port parameter to rpc_ping().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/include/rpc_subs.h b/include/rpc_subs.h
index a344ed16..def80a2f 100644
--- a/include/rpc_subs.h
+++ b/include/rpc_subs.h
@@ -69,7 +69,7 @@ void rpc_destroy_tcp_client(struct conn_info *);
 int rpc_portmap_getclient(struct conn_info *, const char *, struct sockaddr *, size_t, int, unsigned int);
 int rpc_portmap_getport(struct conn_info *, struct pmap *, unsigned short *);
 int rpc_ping_proto(struct conn_info *);
-int rpc_ping(const char *, long, long, unsigned int);
+int rpc_ping(const char *, int, long, long, unsigned int);
 double monotonic_elapsed(struct timespec, struct timespec);
 const char *get_addr_string(struct sockaddr *, char *, socklen_t);
 
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 5828a447..a039e8ee 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -1001,12 +1001,11 @@ int rpc_ping_proto(struct conn_info *info)
 }
 
 static int __rpc_ping(const char *host,
-		      unsigned long version, int proto,
+		      unsigned long version, int proto, int port,
 		      long seconds, long micros, unsigned int option)
 {
 	int status;
 	struct conn_info info;
-	struct pmap parms;
 
 	info.proto = proto;
 	info.host = host;
@@ -1023,32 +1022,41 @@ static int __rpc_ping(const char *host,
 
 	status = RPC_PING_FAIL;
 
-	parms.pm_prog = NFS_PROGRAM;
-	parms.pm_vers = version;
-	parms.pm_prot = info.proto;
-	parms.pm_port = 0;
 
-	status = rpc_portmap_getport(&info, &parms, &info.port);
-	if (status < 0)
-		return status;
+	if (port > 0)
+		info.port = port;
+	else {
+		struct pmap parms;
+
+		parms.pm_prog = NFS_PROGRAM;
+		parms.pm_vers = version;
+		parms.pm_prot = info.proto;
+		parms.pm_port = 0;
+		status = rpc_portmap_getport(&info, &parms, &info.port);
+		if (status < 0)
+			return status;
+	}
 
 	status = rpc_ping_proto(&info);
 
 	return status;
 }
 
-int rpc_ping(const char *host, long seconds, long micros, unsigned int option)
+int rpc_ping(const char *host, int port,
+	     long seconds, long micros, unsigned int option)
 {
 	unsigned long vers4 = NFS4_VERSION;
 	unsigned long vers3 = NFS3_VERSION;
 	unsigned long vers2 = NFS2_VERSION;
 	int status;
 
-	status = __rpc_ping(host, vers2, IPPROTO_UDP, seconds, micros, option);
+	status = __rpc_ping(host, vers2,
+			    IPPROTO_UDP, port, seconds, micros, option);
 	if (status > 0)
 		return RPC_PING_V2 | RPC_PING_UDP;
 
-	status = __rpc_ping(host, vers3, IPPROTO_UDP, seconds, micros, option);
+	status = __rpc_ping(host, vers3,
+			    IPPROTO_UDP, port, seconds, micros, option);
 	if (status > 0)
 		return RPC_PING_V3 | RPC_PING_UDP;
 
@@ -1058,15 +1066,18 @@ int rpc_ping(const char *host, long seconds, long micros, unsigned int option)
 		return RPC_PING_V4 | RPC_PING_UDP;
 	*/
 
-	status = __rpc_ping(host, vers2, IPPROTO_TCP, seconds, micros, option);
+	status = __rpc_ping(host, vers2,
+			    IPPROTO_TCP, port, seconds, micros, option);
 	if (status > 0)
 		return RPC_PING_V2 | RPC_PING_TCP;
 
-	status = __rpc_ping(host, vers3, IPPROTO_TCP, seconds, micros, option);
+	status = __rpc_ping(host, vers3, port,
+			    IPPROTO_TCP, seconds, micros, option);
 	if (status > 0)
 		return RPC_PING_V3 | RPC_PING_TCP;
 
-	status = __rpc_ping(host, vers4, IPPROTO_TCP, seconds, micros, option);
+	status = __rpc_ping(host, vers4,
+			    IPPROTO_TCP, port, seconds, micros, option);
 	if (status > 0)
 		return RPC_PING_V4 | RPC_PING_TCP;
 
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index c558a738..a0ab656b 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -358,7 +358,7 @@ dont_probe:
 			char *host = this->name ? this->name : "localhost";
 			int ret;
 
-			ret = rpc_ping(host, 2, 0, RPC_CLOSE_DEFAULT);
+			ret = rpc_ping(host, port, 2, 0, RPC_CLOSE_DEFAULT);
 			if (ret <= 0)
 				goto next;
 		}

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
