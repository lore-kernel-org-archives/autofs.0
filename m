From: Ian Kent <raven@themaw.net>
Subject: Re: Slow mounts when using large round robin sets
Date: Sat, 22 Dec 2007 16:11:59 +0900
Message-ID: <1198307519.3114.59.camel@raven.themaw.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1198304664.3114.49.camel@raven.themaw.net>
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

On Sat, 2007-12-22 at 15:24 +0900, Ian Kent wrote:
> On Fri, 2007-12-21 at 16:56 -0600, James Richardson wrote:
> > Jeff,
> > 
> >  
> > 
> > I applied the patch and here is what was recorded. 
> 
> What were the actions carried out from the start to the finish of this
> logging?
> 
> I think we'll also need to add the hostname to the logging.

Actually it looks like we're adding an entry for every host ip address
and but not using the address to probe availability.

So having multiple IPs associated with a host ends up being the same as
specifying several host names in a mount. autofs then checks to see
which is closest and calculates a load metric based on a ping to the NFS
NULL proc and chooses one.

I don't think we should be doing a name lookup for every address though
and that may be the source of the problem.

How about trying this patch.
I've added the host name and an extra report when an address is added.
I've also attempted to use the addresses from the original lookup.
It replaces Jeffs patch.

---
diff --git a/include/rpc_subs.h b/include/rpc_subs.h
index 3292e01..3f15ef5 100644
--- a/include/rpc_subs.h
+++ b/include/rpc_subs.h
@@ -46,6 +46,7 @@
 
 struct conn_info {
 	const char *host;
+	const char *addr;
 	unsigned short port;
 	unsigned long program;
 	unsigned long version;
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 5797639..0778558 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -66,6 +66,7 @@ static CLIENT *create_udp_client(struct conn_info
*info)
 	struct hostent *php = &hp;
 	struct hostent *result;
 	char buf[HOST_ENT_BUF_SIZE];
+	const char *haddr;
 	size_t len;
 
 	if (info->proto->p_proto != IPPROTO_UDP)
@@ -86,11 +87,13 @@ static CLIENT *create_udp_client(struct conn_info
*info)
 	memset(&raddr, 0, sizeof(raddr));
 
 	raddr.sin_family = AF_INET;
-	if (inet_aton(info->host, &raddr.sin_addr))
+	haddr = info->addr ? info->addr : info->host;
+	if (inet_aton(haddr, &raddr.sin_addr))
 		goto got_addr;
 
 	memset(&hp, 0, sizeof(struct hostent));
 
+	logerr("gethostbyname_r %s", info->host);
 	ret = gethostbyname_r(info->host, php,
 			buf, HOST_ENT_BUF_SIZE, &result, &ghn_errno);
 	if (ret || !result) {
@@ -276,6 +279,7 @@ static CLIENT *create_tcp_client(struct conn_info
*info)
 	struct hostent *php = &hp;
 	struct hostent *result;
 	char buf[HOST_ENT_BUF_SIZE];
+	const char *haddr;
 	int ret;
 
 	if (info->proto->p_proto != IPPROTO_TCP)
@@ -295,11 +299,13 @@ static CLIENT *create_tcp_client(struct conn_info
*info)
 	memset(&addr, 0, sizeof(addr));
 
 	addr.sin_family = AF_INET;
-	if (inet_aton(info->host, &addr.sin_addr))
+	haddr = info->addr ? info->addr : info->host;
+	if (inet_aton(haddr, &addr.sin_addr))
 		goto got_addr;
 
 	memset(&hp, 0, sizeof(struct hostent));
 
+	logerr("gethostbyname_r %s", info->host);
 	ret = gethostbyname_r(info->host, php,
 			buf, HOST_ENT_BUF_SIZE, &result, &ghn_errno);
 	if (ret || !result) {
@@ -418,6 +424,7 @@ int rpc_portmap_getclient(struct conn_info *info,
 		return 0;
 
 	info->host = host;
+	info->addr = NULL;
 	info->program = PMAPPROG;
 	info->port = PMAPPORT;
 	info->version = PMAPVERS;
@@ -462,6 +469,7 @@ unsigned short rpc_portmap_getport(struct conn_info
*info, struct pmap *parms)
 		client = info->client;
 	else {
 		pmap_info.host = info->host;
+		pmap_info.addr = NULL;
 		pmap_info.port = PMAPPORT;
 		pmap_info.program = PMAPPROG;
 		pmap_info.version = PMAPVERS;
@@ -589,6 +597,7 @@ static unsigned int __rpc_ping(const char *host,
 	struct pmap parms;
 
 	info.host = host;
+	info.addr = NULL;
 	info.program = NFS_PROGRAM;
 	info.version = version;
 	info.send_sz = 0;
@@ -769,6 +778,7 @@ exports rpc_get_exports(const char *host, long
seconds, long micros, unsigned in
 	int status;
 
 	info.host = host;
+	info.addr = NULL;
 	info.program = MOUNTPROG;
 	info.version = MOUNTVERS;
 	info.send_sz = 0;
diff --git a/modules/replicated.c b/modules/replicated.c
index 90b2925..d64f74a 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -551,6 +551,7 @@ static int get_vers_and_cost(unsigned logopt, struct
host *host,
 		timeout = RPC_TIMEOUT * 8;
 
 	rpc_info.host = host->name;
+	rpc_info.addr = host->addr;
 	rpc_info.program = NFS_PROGRAM;
 	rpc_info.timeout.tv_sec = timeout;
 	rpc_info.close_option = RPC_CLOSE_DEFAULT;
@@ -606,6 +607,7 @@ static int get_supported_ver_and_cost(unsigned
logopt, struct host *host,
 		timeout = RPC_TIMEOUT * 8;
 
 	rpc_info.host = host->name;
+	rpc_info.addr = host->addr;
 	rpc_info.program = NFS_PROGRAM;
 	rpc_info.timeout.tv_sec = timeout;
 	rpc_info.close_option = RPC_CLOSE_DEFAULT;
@@ -880,6 +882,7 @@ static int add_host_addrs(struct host **list, const
char *host, unsigned int wei
 	memset(buf, 0, MAX_IFC_BUF);
 	memset(&he, 0, sizeof(struct hostent));
 
+	logerr("gethostbyname_r %s", host);
 	ret = gethostbyname_r(host, phe,
 			buf, MAX_IFC_BUF, &result, &ghn_errno);
 	if (ret || !result) {
@@ -895,6 +898,7 @@ static int add_host_addrs(struct host **list, const
char *host, unsigned int wei
 		if (prx == PROXIMITY_ERROR)
 			return 0;
 
+		logerr("add host address %s", haddr);
 		if (!(new = new_host(host, *haddr, prx, weight)))
 			return 0;
