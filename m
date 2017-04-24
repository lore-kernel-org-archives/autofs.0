From: Ian Kent <raven@themaw.net>
Subject: [PATCH 06/34] autofs-5.1.2 - check NFS server availability on local
 mount fallback
Date: Mon, 24 Apr 2017 09:00:44 +0800
Message-ID: <149299564395.23475.5766574950066223989.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=XrvHs41zX1oSKeN83Y
        xUf19//wFyPvI94qx64e6YJq4=; b=PpJ424cBI/efkH/uva0O1ncwMHZIIZ3Lp5
        eRlTWqH2db+Km5OcxCrFVhSxTdOOwUBS+W/9hmNI2bArT77YxMhKua3kP+dOlZlv
        xjpNq0eNsDPATBMB9Wz59FAWizDkDkPbyVnKGchZRU+11f4QP8JEQRvAG91fOKZG
        aK8amxm+3QgbfoeNQFnPuhf8t2igrHZrpvkvxUkAsjE2ZKlbeaFkIecCxDUnGT1A
        0pX9OOS/wuX4n7+L2muYRT9oYfVO/S6M4WAQ06/qKJHMv0xKNQwOqFxdZtzNcyo9
        qFHnKkF4Ug2I4P/QM1qXAZpt6+wQgSm7GKMR6dhfBIYrj6oYmsvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=XrvHs41zX1oSKeN83YxUf19//wFyPvI94qx64e6YJq4=; b=i8VgNusw
        jT00lZZjtYxTdr+67f/x9Gqg2ShjwLvDEDm2uyz6znUJW6makQTFzicMG+Yns+W2
        elcB3yLCkC9BkGxyOtSKOu5uMhah2brwkyC7s7Hc8Je6rBfcmTR6zUXGFd4FTgF0
        dfpbtM/Lv9zhdcnzBW7h39AbkPwPqeaK55oBZt91hZhcju+Dlvby6Zv4VxPsoTEO
        RQMeaLZffCcrM52STV+Li+XokrQS1IBYyFjgFYujIKHvyM6wpmXzzv/Uh6WNq+BX
        OptkWN+r6yk+GXoSaHqMexOetLvsSMmRf224QRqVOHnvTspOd6nA+3ba8eO14nej
        UwbU/ioEOzFd1Q==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The availability probe isn't done for anything autofs thinks is a
local mount because it's the local machine.

It first tries a bind mount and if that fails it falls back to trying
a local NFS mount. If the local NFS server is not running mount.nfs(8)
can suffer a lengthy timeout.

So check for the bind mount fallback case and check if an NFS server
is responding before trying the mount.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 lib/rpc_subs.c      |   11 +++++++++++
 modules/mount_nfs.c |   15 ++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 408edf8..c43ebc9 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -32,6 +32,7 @@ xx/xx/2016 autofs-5.1.3
 - set sane default master read wait timeout.
 - don't return until after master map retry read.
 - make lookup_nss_read_master() return nss status.
+- check NFS server availability on local mount fallback.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index d0d4cf5..386c7ba 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -1039,6 +1039,7 @@ static int __rpc_ping(const char *host,
 
 int rpc_ping(const char *host, long seconds, long micros, unsigned int option)
 {
+	unsigned long vers4 = NFS4_VERSION;
 	unsigned long vers3 = NFS3_VERSION;
 	unsigned long vers2 = NFS2_VERSION;
 	int status;
@@ -1051,6 +1052,12 @@ int rpc_ping(const char *host, long seconds, long micros, unsigned int option)
 	if (status > 0)
 		return RPC_PING_V3 | RPC_PING_UDP;
 
+	/* UDP isn't recommended for NFSv4, don't bother checking it.
+	status = __rpc_ping(host, vers4, IPPROTO_UDP, seconds, micros, option);
+	if (status > 0)
+		return RPC_PING_V4 | RPC_PING_UDP;
+	*/
+
 	status = __rpc_ping(host, vers2, IPPROTO_TCP, seconds, micros, option);
 	if (status > 0)
 		return RPC_PING_V2 | RPC_PING_TCP;
@@ -1059,6 +1066,10 @@ int rpc_ping(const char *host, long seconds, long micros, unsigned int option)
 	if (status > 0)
 		return RPC_PING_V3 | RPC_PING_TCP;
 
+	status = __rpc_ping(host, vers4, IPPROTO_TCP, seconds, micros, option);
+	if (status > 0)
+		return RPC_PING_V4 | RPC_PING_TCP;
+
 	return status;
 }
 
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 0af814b..2712140 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -348,6 +348,19 @@ dont_probe:
 		strcat(loc, ":");
 		strcat(loc, this->path);
 
+		/* If this is a fallback from a bind mount failure
+		 * check if the local NFS server is available to try
+		 * and prevent lengthy mount failure waits.
+		 */
+		if (this->proximity == PROXIMITY_LOCAL) {
+			char *host = this->name ? this->name : "localhost";
+			int ret;
+
+			ret = rpc_ping(host, 2, 0, RPC_CLOSE_DEFAULT);
+			if (ret <= 0)
+				goto next;
+		}
+
 		if (nfsoptions && *nfsoptions) {
 			debug(ap->logopt,
 			      MODPREFIX "calling mount -t %s " SLOPPY 
@@ -370,7 +383,7 @@ dont_probe:
 			free_host_list(&hosts);
 			return 0;
 		}
-
+next:
 		free(loc);
 		this = this->next;
 	}

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
