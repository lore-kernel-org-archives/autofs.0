From: "Russell, Scott" <Scott.Russell@netapp.com>
Subject: [PATCH] autofs should try tcp before udp when requesting
	MOUNT EXPORTS
Date: Wed, 2 Sep 2009 15:44:45 -0400
Message-ID: <86FB7D63AF95574BB762C0C3E1F26915054A69A9@RTPMVEXC1-PRD.hq.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

The patch below changes autofs to prefer TCP instead of UDP when requesting a list of exports from the NFS server. This behavior bring autofs inline with how showmount and kshowmount issue mountd EXPORT requests. It also solves a possible problem where the export list could be larger than the size of the UDP packet.

diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index cafc775..0ecf447 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -938,16 +938,16 @@ exports rpc_get_exports(const char *host, long seconds, long micros, unsigned in
 	parms.pm_vers = info.version;
 	parms.pm_port = 0;
 
-	/* Try UDP first */
-	info.proto = getprotobyname("udp");
+	/* Try TCP first */
+	info.proto = getprotobyname("tcp");
 	if (!info.proto)
-		goto try_tcp;
+		goto try_udp;
 
 	parms.pm_prot = info.proto->p_proto;
 
 	info.port = rpc_portmap_getport(&info, &parms);
 	if (!info.port)
-		goto try_tcp;
+		goto try_udp;
 
 	memset(&exportlist, '\0', sizeof(exportlist));
 
@@ -955,8 +955,8 @@ exports rpc_get_exports(const char *host, long seconds, long micros, unsigned in
 	if (status)
 		return exportlist;
 
-try_tcp:
-	info.proto = getprotobyname("tcp");
+try_udp:
+	info.proto = getprotobyname("udp");
 	if (!info.proto)
 		return NULL;

--
Scott Russell <scott.russell@netapp.com>
