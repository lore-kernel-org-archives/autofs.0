From: Ian Kent <raven@themaw.net>
Subject: [PATCH 17/19] autofs-5.1.3 - add some more debug logging to
 get_supported_ver_and_cost()
Date: Wed, 02 Aug 2017 10:18:37 +0800
Message-ID: <150164031753.6106.4421854528420862733.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add some additional debug logging to get_supported_ver_and_cost() for failure cases.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 modules/replicated.c |    9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index a21da121..94e79a0c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -15,6 +15,7 @@ xx/xx/2017 autofs-5.1.4
 - fix mount.nfs blocks on first mount.
 - fix some man page problems.
 - add some more debug logging to get_nfs_info().
+- add some more debug logging to get_supported_ver_and_cost().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/replicated.c b/modules/replicated.c
index c44ed466..634275b8 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -615,16 +615,20 @@ static int get_supported_ver_and_cost(unsigned logopt, struct host *host,
 		int ret = rpc_portmap_getclient(&pm_info,
 				host->name, host->addr, host->addr_len,
 				proto, RPC_CLOSE_DEFAULT);
-		if (ret)
+		if (ret) {
+			debug(logopt, "failed to get portmap client");
 			return 0;
+		}
 
 		memset(&parms, 0, sizeof(struct pmap));
 		parms.pm_prog = NFS_PROGRAM;
 		parms.pm_prot = rpc_info.proto;
 		parms.pm_vers = vers;
 		ret = rpc_portmap_getport(&pm_info, &parms, &rpc_info.port);
-		if (ret < 0)
+		if (ret < 0) {
+			debug(logopt, "failed to get service port");
 			goto done;
+		}
 	}
 
 	if (rpc_info.proto == IPPROTO_UDP)
@@ -633,6 +637,7 @@ static int get_supported_ver_and_cost(unsigned logopt, struct host *host,
 		status = rpc_tcp_getclient(&rpc_info, NFS_PROGRAM, vers);
 	if (status == -EHOSTUNREACH) {
 		status = 0;
+		debug(logopt, "host not reachable getting RPC client");
 		goto done;
 	} else if (!status) {
 		clock_gettime(CLOCK_MONOTONIC, &start);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
