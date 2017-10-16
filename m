From: Ian Kent <raven@themaw.net>
Subject: [PATCH 11/35] autofs-5.1.3 - fix incorrect status return in
 get_nfs_info()
Date: Mon, 16 Oct 2017 13:07:05 +0800
Message-ID: <150813042579.25695.9739435507722315307.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If the host is unreachable getting the RPC client in get_nfs_info()
should set status to zero as response time taken hasn't been calculated.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 modules/replicated.c |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 72c3ee70..6492fab3 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -9,6 +9,7 @@ xx/xx/2017 autofs-5.1.4
 - fix typo in autofs config file comments.
 - fix typos in autofs man pages.
 - use pkg-config to search for libtirpc to fix cross-compilation.
+- fix incorrect status return in get_nfs_info().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/replicated.c b/modules/replicated.c
index 315e3000..c5c4f392 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -605,9 +605,10 @@ static int get_supported_ver_and_cost(unsigned logopt, struct host *host,
 		status = rpc_udp_getclient(&rpc_info, NFS_PROGRAM, vers);
 	else
 		status = rpc_tcp_getclient(&rpc_info, NFS_PROGRAM, vers);
-	if (status == -EHOSTUNREACH)
+	if (status == -EHOSTUNREACH) {
+		status = 0;
 		goto done;
-	else if (!status) {
+	} else if (!status) {
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		status = rpc_ping_proto(&rpc_info);
 		clock_gettime(CLOCK_MONOTONIC, &end);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
