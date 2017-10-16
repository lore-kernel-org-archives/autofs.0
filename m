From: Ian Kent <raven@themaw.net>
Subject: [PATCH 18/35] autofs-5.1.3 - fix ipv6 proto option handling
Date: Mon, 16 Oct 2017 13:07:49 +0800
Message-ID: <150813046950.25695.1103281677112793770.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If the option proto=(tcp6|udp6) is given on the NFS mount command line
autofs does not properly recognise it needs to probe only the given
protocol for matching address type.

Signed-off-by: Ian Kent <raven@themaw.net>
Reported-by: Andreas Steinmetz <ast@domdv.de>
---
 CHANGELOG            |    1 +
 include/replicated.h |    2 ++
 modules/mount_nfs.c  |   15 ++++++++++++++-
 modules/replicated.c |   29 +++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 94e79a0c..af8b099c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -16,6 +16,7 @@ xx/xx/2017 autofs-5.1.4
 - fix some man page problems.
 - add some more debug logging to get_nfs_info().
 - add some more debug logging to get_supported_ver_and_cost().
+- fix ipv6 proto option handling.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/include/replicated.h b/include/replicated.h
index 5e142f4f..69ab7800 100644
--- a/include/replicated.h
+++ b/include/replicated.h
@@ -37,6 +37,8 @@
 #define UDP_SUPPORTED		0x0002
 #define TCP_REQUESTED		TCP_SUPPORTED
 #define UDP_REQUESTED		UDP_SUPPORTED
+#define TCP6_REQUESTED		0x0100
+#define UDP6_REQUESTED		0x0200
 #define NFS_PROTO_MASK		(TCP_SUPPORTED|UDP_SUPPORTED)
 
 #define NFS2_TCP_SUPPORTED	NFS2_SUPPORTED
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 97f12c4d..63f16b19 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -172,9 +172,17 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 				} else if (_strncmp("proto=udp", cp, o_len) == 0 ||
 					   _strncmp("udp", cp, o_len) == 0) {
 					vers &= ~TCP_SUPPORTED;
+				} else if (_strncmp("proto=udp6", cp, o_len) == 0 ||
+					   _strncmp("udp6", cp, o_len) == 0) {
+					vers &= ~TCP_SUPPORTED;
+					vers |= UDP6_REQUESTED;
 				} else if (_strncmp("proto=tcp", cp, o_len) == 0 ||
 					   _strncmp("tcp", cp, o_len) == 0) {
 					vers &= ~UDP_SUPPORTED;
+				} else if (_strncmp("proto=tcp6", cp, o_len) == 0 ||
+					   _strncmp("tcp6", cp, o_len) == 0) {
+					vers &= ~UDP_SUPPORTED;
+					vers |= TCP6_REQUESTED;
 				}
 				/* Check for options that also make sense
 				   with bind mounts */
@@ -214,11 +222,16 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	 * configuration only probe NFSv4 and let mount.nfs(8) do fallback
 	 * to NFSv3 (if it can). If the NFSv4 probe fails then probe as
 	 * normal.
+	 *
+	 * Note: some NFS servers consider it a protocol violation to use
+	 * NFSv4 over UDP so if it has been requested in the mount options
+	 * we can't use this at all.
 	 */
 	if ((hosts && !hosts->next) &&
 	    mount_default_proto == 4 &&
 	    (vers & NFS_VERS_MASK) != 0 &&
-	    (vers & NFS4_VERS_MASK) != 0) {
+	    (vers & NFS4_VERS_MASK) != 0 &&
+	    !(vers & UDP6_REQUESTED)) {
 		unsigned int v4_probe_ok = 0;
 		struct host *tmp = new_host(hosts->name,
 					    hosts->addr, hosts->addr_len,
diff --git a/modules/replicated.c b/modules/replicated.c
index 634275b8..de5a4b06 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -484,6 +484,29 @@ done_ver:
 	return supported;
 }
 
+static int check_address_proto(unsigned logopt,
+			       struct host *host, unsigned int version)
+{
+	int ipv6_requested = version & (TCP6_REQUESTED | UDP6_REQUESTED);
+	int ret = 1;
+
+	/* If a protocol has been explicitly requested then don't
+	 * consider addresses that don't match the requested protocol.
+	 */
+	if (ipv6_requested) {
+		if (host->addr_len == INET_ADDRSTRLEN)
+			ret = 0;
+	} else {
+		if (host->addr_len == INET6_ADDRSTRLEN)
+			ret = 0;
+	}
+
+	if (!ret)
+		debug(logopt, "requested protocol does not match address");
+
+	return ret;
+}
+
 static int get_vers_and_cost(unsigned logopt, struct host *host,
 			     unsigned int version, int port)
 {
@@ -492,6 +515,9 @@ static int get_vers_and_cost(unsigned logopt, struct host *host,
 	unsigned int supported, vers = (NFS_VERS_MASK | NFS4_VERS_MASK);
 	int ret = 0;
 
+	if (!check_address_proto(logopt, host, version))
+		return 0;
+
 	memset(&pm_info, 0, sizeof(struct conn_info));
 	memset(&rpc_info, 0, sizeof(struct conn_info));
 
@@ -561,6 +587,9 @@ static int get_supported_ver_and_cost(unsigned logopt, struct host *host,
 		debug(logopt, "called with host %s version 0x%x",
 			host->name, version);
 
+	if (!check_address_proto(logopt, host, version))
+		return 0;
+
 	memset(&pm_info, 0, sizeof(struct conn_info));
 	memset(&rpc_info, 0, sizeof(struct conn_info));
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
