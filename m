From: Ian Kent <raven@themaw.net>
Subject: Re: autofs v5: Problem with @network in access_lists
Date: Thu, 25 Jan 2007 23:10:59 +0900
Message-ID: <1169734259.8575.9.camel@raven>
References: <6a5354cc0701241113x60461168p19f83943d7da6ff9@mail.gmail.com>
	<1169710669.8575.5.camel@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1169710669.8575.5.camel@raven>
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
To: Bill Maloy <bill.maloy@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-01-25 at 16:37 +0900, Ian Kent wrote:
> On Wed, 2007-01-24 at 13:13 -0600, Bill Maloy wrote:
> > Solaris NFS servers can be configured to use a network
> > specifier in the access_list of an NFS exported file
> > system.
> > 
> > >From <http://docs.sun.com/app/docs/doc/816-0211/6m6nc676n?a=view>
> > "The network or subnet component is preceded by an at-sign (@). "
> 
> *Sigh*
> I missed that as well when I updated to account for the Solaris export
> semantics.

How about trying this patch out.
I haven't had a chance to test this at all yet so beware.

Ian

diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index b4e9c91..a794d76 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -31,6 +31,7 @@
 #include <rpcsvc/ypclnt.h>
 #include <errno.h>
 #include <sys/ioctl.h>
+#include <pthread.h>
 
 #include "mount.h"
 #include "rpc_subs.h"
@@ -43,9 +44,14 @@
 #endif
 
 #define MAX_ERR_BUF	512
+/* Get numeric value of the n bits starting at position p */
+#define getbits(x, p, n)	((x >> (p + 1 - n)) & ~(~0 << n))
 
 static char *ypdomain = NULL;
 
+inline void dump_core(void);
+static pthread_mutex_t networks_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 /*
  * Create a UDP RPC client
  */
@@ -965,12 +971,127 @@ static int string_match(const char *myname, const char *pattern)
 	return ret;
 }
 
+static unsigned int get_networks_mask(struct netent *net)
+{
+	if (IN_CLASSC(net->n_net))
+		return 24;
+	else if (IN_CLASSB(net->n_net))
+		return 16;
+	else if (IN_CLASSA(net->n_net))
+		return 8;
+
+	return 0;
+}
+
+static unsigned int inet_get_net_len(uint32_t net)
+{
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		if (getbits(net, i, 1))
+			break;
+	}
+
+	return (unsigned int) i;
+}
+
+static char *inet_fill_net(const char *net_num, char *net)
+{
+	char *np;
+	unsigned int dots = 3;
+
+	*net = '\0';
+	strcpy(net, net_num);
+
+	np = net;
+	while (*np) {
+		if (*np++ == '.') {
+			dots--;
+			if (!*np && dots)
+				strcat(net, "0");
+		}
+	}
+
+	while (dots--)
+		strcat(net, ".0");
+
+	return net;
+}
+
+static int match_network(const char *network)
+{
+	struct netent *pnent, nent;
+	const char *pcnet;
+	char *net, cnet[17], mask[4], *pmask;
+	unsigned int size;
+	int status;
+
+	net = alloca(strlen(network) + 1);
+	if (!net)
+		return 0;
+	strcpy(net, network);
+
+	if ((pmask = strchr(net, '/')))
+		*pmask++ = '\0';
+
+	status = pthread_mutex_lock(&networks_mutex);
+	if (status)
+		fatal(status);
+
+	pnent = getnetbyname(net);
+	if (pnent)
+		memcpy(&nent, pnent, sizeof(struct netent));
+
+	status = pthread_mutex_unlock(&networks_mutex);
+	if (status)
+		fatal(status);
+
+	if (pnent) {
+		uint32_t n_net;
+
+		n_net = ntohl(nent.n_net);
+		pcnet = inet_ntop(nent.n_addrtype, &n_net, cnet, 16);
+		if (!pcnet)
+			return 0;
+
+		if (!pmask) {
+			size = get_networks_mask(&nent);
+			if (!size)
+				return 0;
+		}
+	} else {
+		struct in_addr addr;
+		int ret;
+
+		pcnet = inet_fill_net(net, cnet);
+		if (!pcnet)
+			return 0;
+
+		ret = inet_pton(AF_INET, pcnet, &addr);
+		if (ret <= 0)
+			return 0;
+
+		if (!pmask) {
+			size = inet_get_net_len(htonl(addr.s_addr));
+			if (!size)
+				return 0;
+		}
+	}
+
+	if (!pmask) {
+		if (sprintf(mask, "%u", size) <= 0)
+			return 0;
+		pmask = mask;
+	}
+
+	return masked_match(pcnet, mask);
+}
+
 static int host_match(char *pattern)
 {
 	unsigned int negate = (*pattern == '-');
 	const char *m_pattern = (negate ? pattern + 1 : pattern);
 	char myname[MAXHOSTNAMELEN + 1] = "\0";
-	struct in_addr tmp;
 	int ret = 0;
 
 	if (gethostname(myname, MAXHOSTNAMELEN))
@@ -982,26 +1103,13 @@ static int host_match(char *pattern)
 	if (*m_pattern == '@') {
 		if (ypdomain)
 			ret = innetgr(m_pattern + 1, myname, NULL, ypdomain);
-	} else if (inet_aton(m_pattern, &tmp) || strchr(m_pattern, '/')) {
-		size_t len = strlen(m_pattern) + 1;
-		char *addr, *mask;
-
-		addr = alloca(len);
-		if (!addr)
-			return 0;
-
-		memset(addr, 0, len);
-		memcpy(addr, m_pattern, len - 1);
-		mask = strchr(addr, '/');
-		if (mask) {
-			*mask++ = '\0';
-			ret = masked_match(addr, mask);
-		} else
-			ret = masked_match(addr, "32");
+		if (!ret)
+			ret = match_network(m_pattern + 1);
 	} else if (!strcmp(m_pattern, "gss/krb5")) {
 		/* Leave this to the GSS layer */
 		ret = 1;
-	} else
+	} else if ((ret = match_network(m_pattern))) ;
+	else
 		ret = string_match(myname, m_pattern);
 
 	if (negate)
