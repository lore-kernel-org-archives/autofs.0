From: Ian Kent <raven@themaw.net>
Subject: [PATCH 16/19] autofs-5.1.3 - add some more debug logging to
 get_nfs_info()
Date: Wed, 02 Aug 2017 10:18:32 +0800
Message-ID: <150164031207.6106.8216008074611453459.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add some additional debug logging to get_nfs_info() for failure cases.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 modules/replicated.c |   36 +++++++++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index c6423ce8..a21da121 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -14,6 +14,7 @@ xx/xx/2017 autofs-5.1.4
 - set systemd KillMode to process.
 - fix mount.nfs blocks on first mount.
 - fix some man page problems.
+- add some more debug logging to get_nfs_info().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/replicated.c b/modules/replicated.c
index c5c4f392..c44ed466 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -266,20 +266,29 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
 				host->name, host->addr, host->addr_len,
 				proto, RPC_CLOSE_DEFAULT);
 		if (status == -EHOSTUNREACH) {
+			debug(logopt,
+			      "host not reachable getting portmap client");
 			supported = status;
 			goto done_ver;
-		} else if (status)
+		} else if (status) {
+			debug(logopt, "error 0x%d getting portmap client");
 			goto done_ver;
+		}
 		parms.pm_vers = NFS4_VERSION;
 		status = rpc_portmap_getport(pm_info, &parms, &rpc_info->port);
 		if (status == -EHOSTUNREACH || status == -ETIMEDOUT) {
+			debug(logopt,
+			      "host not reachable or timedout getting service port");
 			supported = status;
 			goto done_ver;
 		} else if (status < 0) {
 			if (version & NFS_VERS_MASK)
 				goto v3_ver; /* MOUNT_NFS_DEFAULT_PROTOCOL=4 */
-			else
+			else {
+				debug(logopt,
+				      "error 0x%d getting service port");
 				goto done_ver;
+			}
 		}
 	}
 
@@ -288,6 +297,7 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
 	else
 		status = rpc_tcp_getclient(rpc_info, NFS_PROGRAM, NFS4_VERSION);
 	if (status == -EHOSTUNREACH) {
+		debug(logopt, "host not reachable getting RPC client");
 		supported = status;
 		goto done_ver;
 	} else if (!status) {
@@ -295,6 +305,7 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
 		status = rpc_ping_proto(rpc_info);
 		clock_gettime(CLOCK_MONOTONIC, &end);
 		if (status == -ETIMEDOUT) {
+			debug(logopt, "host NFS ping timed out");
 			supported = status;
 			goto done_ver;
 		} else if (status > 0) {
@@ -326,16 +337,23 @@ v3_ver:
 				host->name, host->addr, host->addr_len,
 				proto, RPC_CLOSE_DEFAULT);
 		if (status == -EHOSTUNREACH) {
+			debug(logopt,
+			      "host not reachable getting portmap client");
 			supported = status;
 			goto done_ver;
-		} else if (status)
+		} else if (status) {
+			debug(logopt,
+			      "error 0x%d getting getting portmap client");
 			goto done_ver;
+		}
 	}
 
 	if (!port) {
 		parms.pm_vers = NFS3_VERSION;
 		status = rpc_portmap_getport(pm_info, &parms, &rpc_info->port);
 		if (status == -EHOSTUNREACH || status == -ETIMEDOUT) {
+			debug(logopt,
+			      "host not reachable or timedout getting service port");
 			supported = status;
 			goto done_ver;
 		} else if (status < 0)
@@ -347,6 +365,7 @@ v3_ver:
 	else
 		status = rpc_tcp_getclient(rpc_info, NFS_PROGRAM, NFS3_VERSION);
 	if (status == -EHOSTUNREACH) {
+		debug(logopt, "host not reachable getting RPC client");
 		supported = status;
 		goto done_ver;
 	} else if (!status) {
@@ -354,6 +373,7 @@ v3_ver:
 		status = rpc_ping_proto(rpc_info);
 		clock_gettime(CLOCK_MONOTONIC, &end);
 		if (status == -ETIMEDOUT) {
+			debug(logopt, "host NFS ping timed out");
 			supported = status;
 			goto done_ver;
 		} else if (status > 0) {
@@ -382,6 +402,8 @@ v2_ver:
 				host->name, host->addr, host->addr_len,
 				proto, RPC_CLOSE_DEFAULT);
 		if (status == -EHOSTUNREACH) {
+			debug(logopt,
+			      "host not reachable getting portmap client");
 			supported = status;
 			goto done_ver;
 		} else if (status)
@@ -392,6 +414,8 @@ v2_ver:
 		parms.pm_vers = NFS2_VERSION;
 		status = rpc_portmap_getport(pm_info, &parms, &rpc_info->port);
 		if (status == -EHOSTUNREACH || status == -ETIMEDOUT) {
+			debug(logopt,
+			      "host not reachable or timedout getting service port");
 			supported = status;
 			goto done_ver;
 		} else if (status < 0)
@@ -403,15 +427,17 @@ v2_ver:
 	else
 		status = rpc_tcp_getclient(rpc_info, NFS_PROGRAM, NFS2_VERSION);
 	if (status == -EHOSTUNREACH) {
+		debug(logopt, "host not reachable getting RPC client");
 		supported = status;
 		goto done_ver;
 	} else if (!status) {
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		status = rpc_ping_proto(rpc_info);
 		clock_gettime(CLOCK_MONOTONIC, &end);
-		if (status == -ETIMEDOUT)
+		if (status == -ETIMEDOUT) {
+			debug(logopt, "host NFS ping timed out");
 			supported = status;
-		else if (status > 0) {
+		} else if (status > 0) {
 			double reply;
 			if (random_selection) {
 				/* Random value between 0 and 1 */

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
