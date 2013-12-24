From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/5] autofs-5.0.8 - fix ipv6 link local address handling
Date: Tue, 24 Dec 2013 16:02:12 +0800
Message-ID: <20131224080212.8321.83966.stgit@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=kkkyQVOJkVkeYSGU+iEoYZbga4k=; b=NmTOwTgW5ZrLINKEM8u3L//ROi6E
	hvBlYFBAzSECGge439qaXmJNJ7Fj0TH3v96FPXZZ16sZYhN/QjGPv13r3xl13eSV
	HVSaa8u/AF6FEN2hnC6A9OGyE+UYDw/ZctiWFcXdBur4zsgx6T9jCSIdnnpcoxej
	aeHJGFyB4f0lOmg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=kkkyQVOJkVkeYSGU+iEoYZ
	bga4k=; b=M1olRwLQSXOIgYJbzUNZMowlI3mmiXB+hi3wgxtiwCI5HYYavh4xFG
	5hERsML6zBDwZ6eA+i3ox1P9YdpSRb8kiYkXdM5yQ1l1z16EG2jee/HHEekbQ+xp
	Jf/exKeS2Kmz71g9qQkU3Kg30aJ1BMoATOcRa3s5tn7vcjqeneFcI=
In-Reply-To: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

Stop the validate_location() function from choking on link local
ipv6 addresses.
---
 lib/rpc_subs.c      |    6 ++++++
 modules/parse_sun.c |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 2365b6e..9d5b2f5 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -669,6 +669,12 @@ static int create_client(struct conn_info *info, CLIENT **client)
 			goto done;
 		if (ret == -EHOSTUNREACH)
 			goto out_close;
+		if (ret == -EINVAL) {
+			char buf[MAX_ERR_BUF];
+			char *estr = strerror_r(-ret, buf, MAX_ERR_BUF);
+			error(LOGOPT_ANY, "connect() failed: %s", estr);
+			goto out_close;
+		}
 
 		if (!info->client && fd != RPC_ANYSOCK) {
 			close(fd);
diff --git a/modules/parse_sun.c b/modules/parse_sun.c
index 30820b5..e5a4def 100644
--- a/modules/parse_sun.c
+++ b/modules/parse_sun.c
@@ -862,7 +862,7 @@ static int validate_location(unsigned int logopt, char *loc)
 			    *ptr == '-' || *ptr == '.' || *ptr == '_' ||
 			    *ptr == ',' || *ptr == '(' || *ptr == ')' ||
 			    *ptr == '#' || *ptr == '@' || *ptr == ':' ||
-			    *ptr == '[' || *ptr == ']')) {
+			    *ptr == '[' || *ptr == ']' || *ptr == '%')) {
 				error(logopt, "invalid character \"%c\" "
 				      "found in location %s", *ptr, loc);
 				return 0;

