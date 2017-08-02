From: Ian Kent <raven@themaw.net>
Subject: [PATCH 04/19] autofs-5.1.3 - remove some redundant rpc library code
Date: Wed, 02 Aug 2017 10:17:26 +0800
Message-ID: <150164024631.6106.12730002968796920067.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Remove some redundant code that was used long long ago for testing.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 include/rpc_subs.h |    1 -
 lib/rpc_subs.c     |   86 ----------------------------------------------------
 3 files changed, 1 insertion(+), 87 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 91225cf0..977dfcda 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -2,6 +2,7 @@ xx/xx/2017 autofs-5.1.4
 - fix spec file url.
 - fix unset tsd group name handling.
 - Add -c option when calling /bin/umount - if supported.
+- remove some redundant rpc library code.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/include/rpc_subs.h b/include/rpc_subs.h
index e744e893..a344ed16 100644
--- a/include/rpc_subs.h
+++ b/include/rpc_subs.h
@@ -71,7 +71,6 @@ int rpc_portmap_getport(struct conn_info *, struct pmap *, unsigned short *);
 int rpc_ping_proto(struct conn_info *);
 int rpc_ping(const char *, long, long, unsigned int);
 double monotonic_elapsed(struct timespec, struct timespec);
-int rpc_time(const char *, unsigned int, unsigned int, long, long, unsigned int, double *);
 const char *get_addr_string(struct sockaddr *, char *, socklen_t);
 
 #endif
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 386c7bac..5828a447 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -1084,31 +1084,6 @@ double monotonic_elapsed(struct timespec start, struct timespec end)
 	return t2 - t1;
 }
 
-int rpc_time(const char *host,
-	     unsigned int ping_vers, unsigned int ping_proto,
-	     long seconds, long micros, unsigned int option, double *result)
-{
-	int status;
-	double taken;
-	struct timespec start, end;
-	int proto = (ping_proto & RPC_PING_UDP) ? IPPROTO_UDP : IPPROTO_TCP;
-	unsigned long vers = ping_vers;
-
-	clock_gettime(CLOCK_MONOTONIC, &start);
-	status = __rpc_ping(host, vers, proto, seconds, micros, option);
-	clock_gettime(CLOCK_MONOTONIC, &end);
-
-	if (status == RPC_PING_FAIL || status < 0)
-		return status;
-
-	taken = monotonic_elapsed(start, end);
-
-	if (result != NULL)
-		*result = taken;
-
-	return status;
-}
-
 static int rpc_get_exports_proto(struct conn_info *info, exports *exp)
 {
 	CLIENT *client;
@@ -1281,64 +1256,3 @@ const char *get_addr_string(struct sockaddr *sa, char *name, socklen_t len)
 
 	return inet_ntop(sa->sa_family, addr, name, len);
 }
-
-#if 0
-#include <stdio.h>
-
-int main(int argc, char **argv)
-{
-	int ret;
-	double res = 0.0;
-	exports exportlist, tmp;
-	groups grouplist;
-	int n, maxlen;
-
-/*
-	ret = rpc_ping("budgie", 10, 0, RPC_CLOSE_DEFAULT);
-	printf("ret = %d\n", ret);
-
-	res = 0.0;
-	ret = rpc_time("budgie", NFS2_VERSION, RPC_PING_TCP, 10, 0, RPC_CLOSE_DEFAULT, &res);
-	printf("v2 tcp ret = %d, res = %f\n", ret, res);
-
-	res = 0.0;
-	ret = rpc_time("budgie", NFS3_VERSION, RPC_PING_TCP, 10, 0, RPC_CLOSE_DEFAULT, &res);
-	printf("v3 tcp ret = %d, res = %f\n", ret, res);
-
-	res = 0.0;
-	ret = rpc_time("budgie", NFS2_VERSION, RPC_PING_UDP, 10, 0, RPC_CLOSE_DEFAULT, &res);
-	printf("v2 udp ret = %d, res = %f\n", ret, res);
-
-	res = 0.0;
-	ret = rpc_time("budgie", NFS3_VERSION, RPC_PING_UDP, 10, 0, RPC_CLOSE_DEFAULT, &res);
-	printf("v3 udp ret = %d, res = %f\n", ret, res);
-*/
-	exportlist = rpc_get_exports("budgie", 10, 0, RPC_CLOSE_NOLINGER);
-	exportlist = rpc_exports_prune(exportlist);
-
-	maxlen = 0;
-	for (tmp = exportlist; tmp; tmp = tmp->ex_next) {
-		if ((n = strlen(tmp->ex_dir)) > maxlen)
-			maxlen = n;
-	}
-
-	if (exportlist) {
-		while (exportlist) {
-			printf("%-*s ", maxlen, exportlist->ex_dir);
-			grouplist = exportlist->ex_groups;
-			if (grouplist) {
-				while (grouplist) {
-					printf("%s%s", grouplist->gr_name,
-						grouplist->gr_next ? "," : "");
-					grouplist = grouplist->gr_next;
-				}
-			}
-			printf("\n");
-			exportlist = exportlist->ex_next;
-		}
-	}
-	rpc_exports_free(exportlist);
-
-	exit(0);
-}
-#endif

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
