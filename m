From: Ian Kent <raven@themaw.net>
Subject: Re: Long timeout on broken DNS server
Date: Mon, 24 Mar 2008 12:25:31 +0900
Message-ID: <1206329131.2993.3.camel@raven.themaw.net>
References: <20080320050635.E2FA33C3B0@xena.cft.ca.us>
	<1205995564.30292.10.camel@raven.themaw.net>
	<Pine.LNX.4.64.0803200846190.16309@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0803200846190.16309@simba.math.ucla.edu>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org


On Thu, 2008-03-20 at 08:51 -0700, Jim Carter wrote:
> On Thu, 20 Mar 2008, Ian Kent wrote:
> > On Wed, 2008-03-19 at 22:06 -0700, Jim Carter wrote:
> > > Today I upgraded one of my three DNS servers, the first listed in
> > > /etc/resolv.conf, and until I got it back on the air, autofs mounting
> > > was glacial...
> > 
> > Not sure about the 5 seconds, I thought the timeout was longer, but I
> > think autofs is doing DNS lookus for the same name more often than it
> > needs to.
> 
> The current man page for resolv.conf(5) says the default timeout is 5 secs, 
> and the apps behave as if that were true.  There's an option to tweak the 
> timeout, and it's been suggested to shorten the time, since on a local 
> lookup if you don't get an answer in 1 sec you're never going to get it -- 
> but the timeout applies to global lookups too, which can take longer 
> legitimately, if several stages of forwarders and recursion are involved.
> 
> > I'll have a look and see if I can put something together for you to
> > test.
> 
> Thanks for looking into this -- I'll test the package on one of the 
> machines running 5.0.2 presently.  

Try this patch and let me know what happens.
Not sure it will actually make much difference.
I've made it against the autofs in opensuse, revision 30.2.

---
diff -up autofs-5.0.2/include/rpc_subs.h.dns-name-lookup autofs-5.0.2/include/rpc_subs.h
--- autofs-5.0.2/include/rpc_subs.h.dns-name-lookup	2007-06-18 15:18:08.000000000 +0800
+++ autofs-5.0.2/include/rpc_subs.h	2008-03-24 12:08:04.000000000 +0900
@@ -46,6 +46,8 @@
 
 struct conn_info {
 	const char *host;
+	const char *addr;
+	size_t addr_len;
 	unsigned short port;
 	unsigned long program;
 	unsigned long version;
@@ -61,7 +63,7 @@ int rpc_udp_getclient(struct conn_info *
 void rpc_destroy_udp_client(struct conn_info *);
 int rpc_tcp_getclient(struct conn_info *, unsigned int, unsigned int);
 void rpc_destroy_tcp_client(struct conn_info *);
-int rpc_portmap_getclient(struct conn_info *, const char *, const char *, unsigned int);
+int rpc_portmap_getclient(struct conn_info *, const char *, const char *, size_t, const char *, unsigned int);
 unsigned short rpc_portmap_getport(struct conn_info *, struct pmap *);
 int rpc_ping_proto(struct conn_info *);
 int rpc_ping(const char *, long, long, unsigned int);
diff -up autofs-5.0.2/include/replicated.h.dns-name-lookup autofs-5.0.2/include/replicated.h
--- autofs-5.0.2/include/replicated.h.dns-name-lookup	2007-06-18 15:18:08.000000000 +0800
+++ autofs-5.0.2/include/replicated.h	2008-03-24 12:08:04.000000000 +0900
@@ -52,6 +52,7 @@
 struct host {
 	char *name;
 	char *addr;
+	size_t addr_len;
 	char *path;
 	unsigned int version;
 	unsigned int proximity;
diff -up autofs-5.0.2/modules/replicated.c.dns-name-lookup autofs-5.0.2/modules/replicated.c
--- autofs-5.0.2/modules/replicated.c.dns-name-lookup	2007-06-18 15:18:08.000000000 +0800
+++ autofs-5.0.2/modules/replicated.c	2008-03-24 12:18:39.000000000 +0900
@@ -227,7 +227,9 @@ static unsigned int get_proximity(const 
 	return PROXIMITY_OTHER;
 }
 
-static struct host *new_host(const char *name, const char *addr, unsigned int proximity, unsigned int weight)
+static struct host *new_host(const char *name,
+			     const char *addr, size_t addr_len,
+			     unsigned int proximity, unsigned int weight)
 {
 	struct host *new;
 	char *tmp1, *tmp2;
@@ -239,11 +241,12 @@ static struct host *new_host(const char 
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
@@ -255,6 +258,7 @@ static struct host *new_host(const char 
 	memset(new, 0, sizeof(struct host));
 
 	new->name = tmp1;
+	new->addr_len = addr_len;
 	new->addr = tmp2;
 	new->proximity = proximity;
 	new->weight = weight;
@@ -439,7 +443,8 @@ static unsigned int get_nfs_info(struct 
 v3_ver:
 	if (!have_port_opt) {
 		status = rpc_portmap_getclient(pm_info,
-				 host->name, proto, RPC_CLOSE_DEFAULT);
+				host->name, host->addr, host->addr_len,
+				proto, RPC_CLOSE_DEFAULT);
 		if (!status)
 			goto done_ver;
 	}
@@ -551,6 +556,8 @@ static int get_vers_and_cost(struct host
 		timeout = RPC_TIMEOUT * 8;
 
 	rpc_info.host = host->name;
+	rpc_info.addr = host->addr;
+	rpc_info.addr_len = host->addr_len;
 	rpc_info.program = NFS_PROGRAM;
 	rpc_info.timeout.tv_sec = timeout;
 	rpc_info.close_option = RPC_CLOSE_DEFAULT;
@@ -600,6 +607,8 @@ static int get_supported_ver_and_cost(st
 		timeout = RPC_TIMEOUT * 8;
 
 	rpc_info.host = host->name;
+	rpc_info.addr = host->addr;
+	rpc_info.addr_len = host->addr_len;
 	rpc_info.program = NFS_PROGRAM;
 	rpc_info.timeout.tv_sec = timeout;
 	rpc_info.close_option = RPC_CLOSE_DEFAULT;
@@ -627,7 +636,8 @@ static int get_supported_ver_and_cost(st
 			return 0;
 	} else {
 		int ret = rpc_portmap_getclient(&pm_info,
-				 host->name, proto, RPC_CLOSE_DEFAULT);
+				host->name, host->addr, host->addr_len,
+				proto, RPC_CLOSE_DEFAULT);
 		if (!ret)
 			return 0;
 
@@ -840,7 +850,7 @@ static int add_host_addrs(struct host **
 		if (prx == PROXIMITY_ERROR)
 			return 0;
 
-		if (!(new = new_host(host, thost, prx, weight)))
+		if (!(new = new_host(host, thost, sizeof(saddr.sin_addr), prx, weight)))
 			return 0;
 
 		if (!add_host(list, new))
@@ -865,11 +875,14 @@ static int add_host_addrs(struct host **
 	}
 
 	for (haddr = phe->h_addr_list; *haddr; haddr++) {
+		struct in_addr tt;
+
 		prx = get_proximity(*haddr, phe->h_length);
 		if (prx == PROXIMITY_ERROR)
 			return 0;
 
-		if (!(new = new_host(host, *haddr, prx, weight)))
+		memcpy(&tt, *haddr, sizeof(struct in_addr));
+		if (!(new = new_host(host, *haddr, phe->h_length, prx, weight)))
 			return 0;
 
 		if (!add_host(list, new)) {
diff -up autofs-5.0.2/lib/rpc_subs.c.dns-name-lookup autofs-5.0.2/lib/rpc_subs.c
--- autofs-5.0.2/lib/rpc_subs.c.dns-name-lookup	2007-06-18 15:18:08.000000000 +0800
+++ autofs-5.0.2/lib/rpc_subs.c	2008-03-24 12:12:56.000000000 +0900
@@ -89,6 +89,11 @@ static CLIENT *create_udp_client(struct 
 	memset(&raddr, 0, sizeof(raddr));
 
 	raddr.sin_family = AF_INET;
+	if (info->addr) {
+		memcpy(&raddr.sin_addr.s_addr, info->addr, info->addr_len);
+		goto got_addr;
+	}
+
 	if (inet_aton(info->host, &raddr.sin_addr))
 		goto got_addr;
 
@@ -298,6 +303,11 @@ static CLIENT *create_tcp_client(struct 
 	memset(&addr, 0, sizeof(addr));
 
 	addr.sin_family = AF_INET;
+	if (info->addr) {
+		memcpy(&addr.sin_addr.s_addr, info->addr, info->addr_len);
+		goto got_addr;
+	}
+
 	if (inet_aton(info->host, &addr.sin_addr))
 		goto got_addr;
 
@@ -410,8 +420,8 @@ void rpc_destroy_tcp_client(struct conn_
 }
 
 int rpc_portmap_getclient(struct conn_info *info,
-			  const char *host, const char *proto,
-			  unsigned int option)
+			  const char *host, const char *addr, size_t addr_len,
+			  const char *proto, unsigned int option)
 {
 	struct protoent *pe_proto;
 	CLIENT *client;
@@ -421,6 +431,8 @@ int rpc_portmap_getclient(struct conn_in
 		return 0;
 
 	info->host = host;
+	info->addr = addr;
+	info->addr_len = addr_len;
 	info->program = PMAPPROG;
 	info->port = PMAPPORT;
 	info->version = PMAPVERS;
@@ -465,6 +477,8 @@ unsigned short rpc_portmap_getport(struc
 		client = info->client;
 	else {
 		pmap_info.host = info->host;
+		pmap_info.addr = info->addr;
+		pmap_info.addr_len = info->addr_len;
 		pmap_info.port = PMAPPORT;
 		pmap_info.program = PMAPPROG;
 		pmap_info.version = PMAPVERS;
@@ -592,6 +606,8 @@ static unsigned int __rpc_ping(const cha
 	struct pmap parms;
 
 	info.host = host;
+	info.addr = NULL;
+	info.addr_len = 0;
 	info.program = NFS_PROGRAM;
 	info.version = version;
 	info.send_sz = 0;
@@ -1339,6 +1355,8 @@ exports rpc_get_exports(const char *host
 	int status;
 
 	info.host = host;
+	info.addr = NULL;
+	info.addr_len = 0;
 	info.program = MOUNTPROG;
 	info.version = MOUNTVERS;
 	info.send_sz = 0;
