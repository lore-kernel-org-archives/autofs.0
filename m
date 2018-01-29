From: NeilBrown <neilb@suse.com>
Subject: [PATCH 1/3] use_hostname_for_mounts shouldn't prevent selection
 among replicas
Date: Mon, 29 Jan 2018 18:19:54 +1100
Message-ID: <151721039458.27355.1715698671902330307.stgit@noble>
References: <151721021295.27355.1968703903360394469.stgit@noble>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151721021295.27355.1968703903360394469.stgit@noble>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

If several replicas have been specified for a mount point,
and use_hostname_for_mount is set to "yes", the selection
between these replicas is currently disabled and the last in
the list is always chosen.

There is little point selecting between different addresses
for the one host in this case, but it is still worth
selecting between different hosts, particularly if different
weights have been specified.

This patch restores the "prune_host_list()" functionality
when use_hostname_for_mount is set, and modifies it slightly
so that only on IP address for any host:/path entry in the
config file is willl be successfully probed.  After a
success, further addresses from the same entry are skipped.
This is achieved by tracking an entry number ("ent_num") for
each 'struct host'.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/replicated.h |    3 ++-
 modules/mount_nfs.c  |    2 +-
 modules/replicated.c |   35 ++++++++++++++++++++---------------
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/replicated.h b/include/replicated.h
index 69ab7800d96b..0f482d210066 100644
--- a/include/replicated.h
+++ b/include/replicated.h
@@ -57,6 +57,7 @@
 
 struct host {
 	char *name;
+	int ent_num;
 	struct sockaddr *addr;
 	size_t addr_len;
 	unsigned int rr;
@@ -70,7 +71,7 @@ struct host {
 };
 
 void seed_random(void);
-struct host *new_host(const char *, struct sockaddr *, size_t,
+struct host *new_host(const char *, int, struct sockaddr *, size_t,
 		      unsigned int, unsigned int, unsigned int);
 void free_host_list(struct host **);
 int parse_location(unsigned, struct host **, const char *, unsigned int);
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index bf712a9374ca..304bef29eec7 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -236,7 +236,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	    (vers & NFS4_VERS_MASK) != 0 &&
 	    !(vers & UDP6_REQUESTED)) {
 		unsigned int v4_probe_ok = 0;
-		struct host *tmp = new_host(hosts->name,
+		struct host *tmp = new_host(hosts->name, 0,
 					    hosts->addr, hosts->addr_len,
 					    hosts->proximity,
 					    hosts->weight, hosts->options);
diff --git a/modules/replicated.c b/modules/replicated.c
index 3ac4c70f4062..c10efcd91deb 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -83,7 +83,7 @@ void seed_random(void)
 	return;
 }
 
-struct host *new_host(const char *name,
+struct host *new_host(const char *name, int ent_num,
 		      struct sockaddr *addr, size_t addr_len,
 		      unsigned int proximity, unsigned int weight,
 		      unsigned int options)
@@ -116,6 +116,7 @@ struct host *new_host(const char *name,
 	memset(new, 0, sizeof(struct host));
 
 	new->name = tmp1;
+	new->ent_num = ent_num;
 	new->addr_len = addr_len;
 	new->addr = tmp2;
 	new->proximity = proximity;
@@ -714,7 +715,7 @@ done:
 int prune_host_list(unsigned logopt, struct host **list,
 		    unsigned int vers, int port)
 {
-	struct host *this, *last, *first;
+	struct host *this, *last, *first, *prev;
 	struct host *new = NULL;
 	unsigned int proximity, selected_version = 0;
 	unsigned int v2_tcp_count, v3_tcp_count, v4_tcp_count;
@@ -726,12 +727,6 @@ int prune_host_list(unsigned logopt, struct host **list,
 	if (!*list)
 		return 0;
 
-	/* If we're using the host name then there's no point probing
-	 * avialability and respose time.
-	 */
-	if (defaults_use_hostname_for_mounts())
-		return 1;
-
 	/* Use closest hosts to choose NFS version */
 
 	first = *list;
@@ -877,11 +872,18 @@ int prune_host_list(unsigned logopt, struct host **list,
 
 	first = last;
 	this = first;
+	prev = NULL;
 	while (this) {
 		struct host *next = this->next;
 		if (!this->name) {
 			remove_host(list, this);
 			add_host(&new, this);
+		} else if (defaults_use_hostname_for_mounts() && prev &&
+			   prev->ent_num == this->ent_num) {
+			/* When we use the hostname to mount, there is no
+			 * point in probing every address it has, just one is
+			 * enough.  Skip the rest.
+			 */
 		} else {
 			status = get_supported_ver_and_cost(logopt, this,
 						selected_version, port);
@@ -889,6 +891,7 @@ int prune_host_list(unsigned logopt, struct host **list,
 				this->version = selected_version;
 				remove_host(list, this);
 				add_host(&new, this);
+				prev = this;
 			}
 		}
 		this = next;
@@ -901,7 +904,7 @@ int prune_host_list(unsigned logopt, struct host **list,
 }
 
 static int add_new_host(struct host **list,
-			const char *host, unsigned int weight,
+			const char *host, int ent_num, unsigned int weight,
 			struct addrinfo *host_addr,
 			unsigned int rr, unsigned int options)
 {
@@ -940,7 +943,7 @@ static int add_new_host(struct host **list,
 	else
 		return 0;
 
-	new = new_host(host, host_addr->ai_addr, addr_len, prx, weight, options);
+	new = new_host(host, ent_num, host_addr->ai_addr, addr_len, prx, weight, options);
 	if (!new)
 		return 0;
 
@@ -953,7 +956,7 @@ static int add_new_host(struct host **list,
 	return 1;
 }
 
-static int add_host_addrs(struct host **list, const char *host,
+static int add_host_addrs(struct host **list, const char *host, int ent_num,
 			  unsigned int weight, unsigned int options)
 {
 	struct addrinfo hints, *ni, *this;
@@ -988,7 +991,7 @@ static int add_host_addrs(struct host **list, const char *host,
 
 	this = ni;
 	while (this) {
-		ret = add_new_host(list, host, weight, this, 0, options);
+		ret = add_new_host(list, host, ent_num, weight, this, 0, options);
 		if (!ret)
 			break;
 		this = this->ai_next;
@@ -1027,7 +1030,7 @@ try_name:
 		rr++;
 	this = ni;
 	while (this) {
-		ret = add_new_host(list, host, weight, this, rr, options);
+		ret = add_new_host(list, host, ent_num, weight, this, rr, options);
 		if (!ret)
 			break;
 		this = this->ai_next;
@@ -1120,6 +1123,7 @@ int parse_location(unsigned logopt, struct host **hosts,
 {
 	char *str, *p, *delim;
 	unsigned int empty = 1;
+	int ent_num = 1;
 
 	if (!list)
 		return 0;
@@ -1177,7 +1181,7 @@ int parse_location(unsigned logopt, struct host **hosts,
 				}
 
 				if (p != delim) {
-					if (!add_host_addrs(hosts, p, weight, options)) {
+					if (!add_host_addrs(hosts, p, ent_num, weight, options)) {
 						if (empty) {
 							p = next;
 							continue;
@@ -1199,7 +1203,7 @@ int parse_location(unsigned logopt, struct host **hosts,
 				*delim = '\0';
 				next = delim + 1;
 
-				if (!add_host_addrs(hosts, p, weight, options)) {
+				if (!add_host_addrs(hosts, p, ent_num, weight, options)) {
 					p = next;
 					continue;
 				}
@@ -1213,6 +1217,7 @@ int parse_location(unsigned logopt, struct host **hosts,
 			return 0;
 		}
 
+		ent_num ++;
 		p = next;
 	}
 


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
