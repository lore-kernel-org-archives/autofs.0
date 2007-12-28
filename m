From: Ian Kent <raven@themaw.net>
Subject: Re: Slow mounts when using large round robin sets
Date: Fri, 28 Dec 2007 15:21:49 +0900
Message-ID: <1198822909.3089.28.camel@raven.themaw.net>
References: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724431C0@sbs01.xiss.private>
	<1196921804.3089.28.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private>
	<x49zlwm5hf1.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D7244386E@sbs01.xiss.private>
	<1198241367.3488.26.camel@raven.themaw.net>
	<x49odck175r.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724438C2@sbs01.xiss.private>
	<x49fxxvzpp5.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724438CB@sbs01.xiss.private>
	<1198304664.3114.49.camel@raven.themaw.net>
	<1198307519.3114.59.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D72443928@sbs01.xiss.private>
	<1198739265.3169.81.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D72443981@sbs01.xiss.private>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <98E55D6E1B3CFD43BDA59EEB56DD7D72443981@sbs01.xiss.private>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: James Richardson <jrichardson@x-iss.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-12-27 at 15:47 -0600, James Richardson wrote:
> Ian,
> 
>  
> 
> I updated your patch a little to provide clearer debug output in the
> 'add_host' function. I've attached the patch to this e-mail. (I'm
> still getting familiar with git, my apologies if the diff is not in
> the correct format). I updated the logerr call in replicated.c to:

And here's another try at this.

---
diff --git a/include/replicated.h b/include/replicated.h
index 672f853..88cd08a 100644
--- a/include/replicated.h
+++ b/include/replicated.h
@@ -52,6 +52,7 @@
 struct host {
 	char *name;
 	char *addr;
+	size_t addr_len;
 	char *path;
 	unsigned int version;
 	unsigned int proximity;
diff --git a/include/rpc_subs.h b/include/rpc_subs.h
index 3292e01..e20a89d 100644
--- a/include/rpc_subs.h
+++ b/include/rpc_subs.h
@@ -46,6 +46,8 @@
 
 struct conn_info {
 	const char *host;
+	const char *addr;
+	size_t addr_len;
 	unsigned short port;
 	unsigned long program;
 	unsigned long version;
@@ -61,7 +63,7 @@ int rpc_udp_getclient(struct conn_info *, unsigned int, unsigned int);
 void rpc_destroy_udp_client(struct conn_info *);
 int rpc_tcp_getclient(struct conn_info *, unsigned int, unsigned int);
 void rpc_destroy_tcp_client(struct conn_info *);
-int rpc_portmap_getclient(struct conn_info *, const char *, const char *, unsigned int);
+int rpc_portmap_getclient(struct conn_info *, const char *, const char *, size_t, const char *, unsigned int);
 unsigned short rpc_portmap_getport(struct conn_info *, struct pmap *);
 int rpc_ping_proto(struct conn_info *);
 int rpc_ping(const char *, long, long, unsigned int);
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 5797639..be2955d 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -86,11 +86,17 @@ static CLIENT *create_udp_client(struct conn_info *info)
 	memset(&raddr, 0, sizeof(raddr));
 
 	raddr.sin_family = AF_INET;
+	if (info->addr) {
+		memcpy(&raddr.sin_addr.s_addr, info->addr, info->addr_len);
+		goto got_addr;
+	}
+
 	if (inet_aton(info->host, &raddr.sin_addr))
 		goto got_addr;
 
 	memset(&hp, 0, sizeof(struct hostent));
 
+	logerr("gethostbyname_r %s", info->host);
 	ret = gethostbyname_r(info->host, php,
 			buf, HOST_ENT_BUF_SIZE, &result, &ghn_errno);
 	if (ret || !result) {
@@ -295,11 +301,18 @@ static CLIENT *create_tcp_client(struct conn_info *info)
 	memset(&addr, 0, sizeof(addr));
 
 	addr.sin_family = AF_INET;
+
+	if (info->addr) {
+		memcpy(&addr.sin_addr.s_addr, info->addr, info->addr_len);
+		goto got_addr;
+	}
+
 	if (inet_aton(info->host, &addr.sin_addr))
 		goto got_addr;
 
 	memset(&hp, 0, sizeof(struct hostent));
 
+	logerr("gethostbyname_r %s", info->host);
 	ret = gethostbyname_r(info->host, php,
 			buf, HOST_ENT_BUF_SIZE, &result, &ghn_errno);
 	if (ret || !result) {
@@ -407,8 +420,8 @@ void rpc_destroy_tcp_client(struct conn_info *info)
 }
 
 int rpc_portmap_getclient(struct conn_info *info,
-			  const char *host, const char *proto,
-			  unsigned int option)
+			  const char *host, const char *addr, size_t addr_len,
+			  const char *proto, unsigned int option)
 {
 	struct protoent *pe_proto;
 	CLIENT *client;
@@ -418,6 +431,8 @@ int rpc_portmap_getclient(struct conn_info *info,
 		return 0;
 
 	info->host = host;
+	info->addr = addr;
+	info->addr_len = addr_len;
 	info->program = PMAPPROG;
 	info->port = PMAPPORT;
 	info->version = PMAPVERS;
@@ -462,6 +477,8 @@ unsigned short rpc_portmap_getport(struct conn_info *info, struct pmap *parms)
 		client = info->client;
 	else {
 		pmap_info.host = info->host;
+		pmap_info.addr = info->addr;
+		pmap_info.addr_len = info->addr_len;
 		pmap_info.port = PMAPPORT;
 		pmap_info.program = PMAPPROG;
 		pmap_info.version = PMAPVERS;
@@ -589,6 +606,8 @@ static unsigned int __rpc_ping(const char *host,
 	struct pmap parms;
 
 	info.host = host;
+	info.addr = NULL;
+	info.addr_len = 0;
 	info.program = NFS_PROGRAM;
 	info.version = version;
 	info.send_sz = 0;
@@ -769,6 +788,8 @@ exports rpc_get_exports(const char *host, long seconds, long micros, unsigned in
 	int status;
 
 	info.host = host;
+	info.addr = NULL;
+	info.addr_len = 0;
 	info.program = MOUNTPROG;
 	info.version = MOUNTVERS;
 	info.send_sz = 0;
diff --git a/modules/replicated.c b/modules/replicated.c
index 90b2925..0030ab1 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -225,7 +225,9 @@ static unsigned int get_proximity(const char *host_addr, int addr_len)
 	return PROXIMITY_OTHER;
 }
 
-static struct host *new_host(const char *name, const char *addr, unsigned int proximity, unsigned int weight)
+static struct host *new_host(const char *name,
+			     const char *addr, size_t addr_len,
+			     unsigned int proximity, unsigned int weight)
 {
 	struct host *new;
 	char *tmp1, *tmp2;
@@ -237,11 +239,12 @@ static struct host *new_host(const char *name, const char *addr, unsigned int pr
 	if (!tmp1)
 		return NULL;
 
-	tmp2 = strdup(addr);
+	tmp2 = malloc(addr_len);
 	if (!tmp2) {
 		free(tmp1);
 		return NULL;
 	}
+	memcpy(tmp2, addr, addr_len);
 
 	new = malloc(sizeof(struct host));
 	if (!new) {
@@ -253,6 +256,7 @@ static struct host *new_host(const char *name, const char *addr, unsigned int pr
 	memset(new, 0, sizeof(struct host));
 
 	new->name = tmp1;
+	new->addr_len = addr_len;
 	new->addr = tmp2;
 	new->proximity = proximity;
 	new->weight = weight;
@@ -437,7 +441,8 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
 v3_ver:
 	if (!have_port_opt) {
 		status = rpc_portmap_getclient(pm_info,
-				 host->name, proto, RPC_CLOSE_DEFAULT);
+				host->name, host->addr, host->addr_len,
+				proto, RPC_CLOSE_DEFAULT);
 		if (!status)
 			goto done_ver;
 	}
@@ -551,6 +556,8 @@ static int get_vers_and_cost(unsigned logopt, struct host *host,
 		timeout = RPC_TIMEOUT * 8;
 
 	rpc_info.host = host->name;
+	rpc_info.addr = host->addr;
+	rpc_info.addr_len = host->addr_len;
 	rpc_info.program = NFS_PROGRAM;
 	rpc_info.timeout.tv_sec = timeout;
 	rpc_info.close_option = RPC_CLOSE_DEFAULT;
@@ -606,6 +613,8 @@ static int get_supported_ver_and_cost(unsigned logopt, struct host *host,
 		timeout = RPC_TIMEOUT * 8;
 
 	rpc_info.host = host->name;
+	rpc_info.addr = host->addr;
+	rpc_info.addr_len = host->addr_len;
 	rpc_info.program = NFS_PROGRAM;
 	rpc_info.timeout.tv_sec = timeout;
 	rpc_info.close_option = RPC_CLOSE_DEFAULT;
@@ -652,7 +661,8 @@ static int get_supported_ver_and_cost(unsigned logopt, struct host *host,
 			return 0;
 	} else {
 		int ret = rpc_portmap_getclient(&pm_info,
-				 host->name, proto, RPC_CLOSE_DEFAULT);
+				host->name, host->addr, host->addr_len,
+				proto, RPC_CLOSE_DEFAULT);
 		if (!ret)
 			return 0;
 
@@ -868,7 +878,7 @@ static int add_host_addrs(struct host **list, const char *host, unsigned int wei
 		if (prx == PROXIMITY_ERROR)
 			return 0;
 
-		if (!(new = new_host(host, thost, prx, weight)))
+		if (!(new = new_host(host, thost, sizeof(saddr.sin_addr), prx, weight)))
 			return 0;
 
 		if (!add_host(list, new))
@@ -880,6 +890,7 @@ static int add_host_addrs(struct host **list, const char *host, unsigned int wei
 	memset(buf, 0, MAX_IFC_BUF);
 	memset(&he, 0, sizeof(struct hostent));
 
+	logerr("gethostbyname_r %s", host);
 	ret = gethostbyname_r(host, phe,
 			buf, MAX_IFC_BUF, &result, &ghn_errno);
 	if (ret || !result) {
@@ -891,11 +902,15 @@ static int add_host_addrs(struct host **list, const char *host, unsigned int wei
 	}
 
 	for (haddr = phe->h_addr_list; *haddr; haddr++) {
+		struct in_addr tt;
+
 		prx = get_proximity(*haddr, phe->h_length);
 		if (prx == PROXIMITY_ERROR)
 			return 0;
 
-		if (!(new = new_host(host, *haddr, prx, weight)))
+		memcpy(&tt, *haddr, sizeof(struct in_addr));
+		logerr("add host %s address %s", host, inet_ntoa(tt));
+		if (!(new = new_host(host, *haddr, phe->h_length, prx, weight)))
 			return 0;
 
 		if (!add_host(list, new)) {
