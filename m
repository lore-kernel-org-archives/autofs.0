From: Ian Kent <raven@themaw.net>
Subject: [PATCH 21/37] autofs-5.1.1 - fix create_client() RPC client handling
Date: Tue, 25 Oct 2016 09:19:16 +0800
Message-ID: <20161025011916.7778.76609.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=z824Ld2C0KyXbyM5es0P9qKck5Q=; b=nGOFFDpPzrQ+oLehUP
        A+ll+MNnEJjknqTE9a/5ywGJURalK/HBb/+n5Wr8GwbpCZKhT5gjubsk+/cRNvt8
        lA+kfmJnI8VYbQhWBiukspP6pMeioKeOVp7FmBmHCgcf5WHCoOeEDq7OAo5nz+et
        JSvb3bzO0fF3y0kujP0iauFPM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=z824Ld2C0KyXbyM5es0P9q
        Kck5Q=; b=NKDsd6UDPBcT2k9lTLFddBKyJ69JSV415+ooCbNpZxmoj05L0jHI+d
        d9Cj13XtXUT47pUQcXCoXG8fEO7LmHZOKyIHUbf/pNGtfaEvbVEn3meDDAPvCfYi
        kAFcl8C2rsEPJ/RklSA9RyOv6/QrG5dp24gpwlXTj7NZ7r0GXIQQA=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The autofs socket minimization strategy is to reuse the socket
descriptor when creating an RPC client for the same protocol.

But in create_client() there is a case where the socket descriptor
can be obtained from RPC client, the RPC client destroyed, but
not cleared in the persistent data structure.

In create_client(), once an attempt is done to get the socket
descriptor, the RPC client should always be destroyed and cleared
in the persistent data structure.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 lib/rpc_subs.c |   21 ++++++++-------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 940c6ba..4e2e482 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -18,6 +18,7 @@ xx/xx/2016 autofs-5.1.3
 - Avoid local variable name shadowing another.
 - fix argc off by one in mount_autofs.c.
 - fix _strncmp() usage.
+- fix create_client() RPC client handling.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 8995996..d0d4cf5 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -654,14 +654,12 @@ static int create_client(struct conn_info *info, CLIENT **client)
 	*client = NULL;
 
 	if (info->client) {
-		if (!clnt_control(info->client, CLGET_FD, (char *) &fd)) {
-			fd = RPC_ANYSOCK;
-			clnt_destroy(info->client);
-			info->client = NULL;
-		} else {
+		if (clnt_control(info->client, CLGET_FD, (char *) &fd))
 			clnt_control(info->client, CLSET_FD_NCLOSE, NULL);
-			clnt_destroy(info->client);
-		}
+		else
+			fd = RPC_ANYSOCK;
+		clnt_destroy(info->client);
+		info->client = NULL;
 	}
 
 	if (info->addr) {
@@ -677,7 +675,7 @@ static int create_client(struct conn_info *info, CLIENT **client)
 			goto out_close;
 		}
 
-		if (!info->client && fd != RPC_ANYSOCK) {
+		if (fd != RPC_ANYSOCK) {
 			close(fd);
 			fd = RPC_ANYSOCK;
 		}
@@ -695,7 +693,6 @@ static int create_client(struct conn_info *info, CLIENT **client)
 	if (ret) {
 		error(LOGOPT_ANY,
 		      "hostname lookup failed: %s", gai_strerror(ret));
-		info->client = NULL;
 		goto out_close;
 	}
 
@@ -714,7 +711,7 @@ static int create_client(struct conn_info *info, CLIENT **client)
 			goto out_close;
 		}
 
-		if (!info->client && fd != RPC_ANYSOCK) {
+		if (fd != RPC_ANYSOCK) {
 			close(fd);
 			fd = RPC_ANYSOCK;
 		}
@@ -726,7 +723,6 @@ static int create_client(struct conn_info *info, CLIENT **client)
 
 done:
 	if (!*client) {
-		info->client = NULL;
 		ret = -ENOTCONN;
 		goto out_close;
 	}
@@ -734,7 +730,6 @@ done:
 	/* Close socket fd on destroy, as is default for rpcowned fds */
 	if  (!clnt_control(*client, CLSET_FD_CLOSE, NULL)) {
 		clnt_destroy(*client);
-		info->client = NULL;
 		ret = -ENOTCONN;
 		goto out_close;
 	}
@@ -742,7 +737,7 @@ done:
 	return 0;
 
 out_close:
-	if (fd != -1)
+	if (fd != RPC_ANYSOCK)
 		close(fd);
 	return ret;
 }

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
