From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] fix a file descriptor leak in rpc_subs.c
Date: Mon, 23 Aug 2004 13:08:19 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16682.9347.245335.724203@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Hi Ian, list,

We never close the file descriptors we open in the rpc ping path.  Here is
a patch which addresses this.  The patch appears in my latest rpms on my
people page.

Comments welcome.

-Jeff

--- autofs-4.1.3-devel/lib/rpc_subs.c~	2004-08-04 13:20:30.000000000 -0400
+++ autofs-4.1.3-devel/lib/rpc_subs.c	2004-08-18 13:37:14.123571936 -0400
@@ -34,6 +34,7 @@
 
 struct conn_info {
 	const char *host;
+	int fd;
 	unsigned short port;
 	unsigned long program;
 	unsigned long version;
@@ -48,7 +49,6 @@ struct conn_info {
  */
 static CLIENT* create_udp_client(struct conn_info *info)
 {
-	int fd = -1;
 	CLIENT *client;
 	struct sockaddr_in addr;
 	struct hostent *hp;
@@ -62,13 +62,14 @@ static CLIENT* create_udp_client(struct 
 	if (!hp)
 		return NULL;
 
+	info->fd = RPC_ANYSOCK;
 	addr.sin_family = AF_INET;
 	addr.sin_port = htons(info->port);
 	memcpy(&addr.sin_addr.s_addr, hp->h_addr, hp->h_length);
 
 	client = clntudp_bufcreate(&addr,
 				   info->program, info->version,
-				   info->timeout, &fd,
+				   info->timeout, &info->fd,
 				   info->send_sz, info->recv_sz);
 
 	return client;
@@ -169,6 +170,7 @@ static CLIENT* create_tcp_client(struct 
 	if (!client)
 		goto out_close;
 
+	info->fd = fd;
 	return client;
 
 out_close:
@@ -214,6 +216,7 @@ static unsigned short portmap_getport(st
 			 pmap_info.timeout);
 
 	clnt_destroy(client);
+	close(pmap_info.fd);
 
 	if (stat != RPC_SUCCESS)
 		return 0;
