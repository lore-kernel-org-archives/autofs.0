From: raven@themaw.net
Subject: Re: [patch] fix a file descriptor leak in rpc_subs.c
Date: Mon, 6 Sep 2004 21:50:09 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409062142310.13402@donald.themaw.net>
References: <16682.9347.245335.724203@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16682.9347.245335.724203@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 23 Aug 2004, Jeff Moyer wrote:

> Hi Ian, list,
> 
> We never close the file descriptors we open in the rpc ping path.  Here is
> a patch which addresses this.  The patch appears in my latest rpms on my
> people page.

While I was looking at the problem Bryce reported I got the impression 
that the socket leak patch may not have completely covered the closeing of 
open sockets. I'm probably wrong but I came up with this alternative patch 
which I've called autofs-4.1.3-sock-leak-fix-2.patch.

Any thoughts?

--- autofs-4.1.3/lib/rpc_subs.c.sock-leak-fix-2	2004-09-06 19:26:30.000000000 +0800
+++ autofs-4.1.3/lib/rpc_subs.c	2004-09-06 19:41:19.000000000 +0800
@@ -48,7 +48,7 @@
  */
 static CLIENT* create_udp_client(struct conn_info *info)
 {
-	int fd = -1;
+	int fd = RPC_ANYSOCK;
 	CLIENT *client;
 	struct sockaddr_in addr;
 	struct hostent *hp;
@@ -179,6 +179,12 @@
 	if (!client)
 		goto out_close;
 
+	/* Close socket fd on destroy, as is default for rpcowned fds */
+	if  (!clnt_control(client, CLSET_FD_CLOSE, NULL)) {
+		clnt_destroy(client);
+		goto out_close;
+	}
+
 	return client;
 
 out_close:
