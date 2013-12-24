From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/5] autofs-5.0.8 - fix fix ipv6 libtirpc getport
Date: Tue, 24 Dec 2013 16:02:17 +0800
Message-ID: <20131224080217.8321.83919.stgit@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=8KN0IyqQaGeDUPSsxgyPGOBFrIQ=; b=fYWL7urHiijlcIWktdyEprQ+NAZw
	PXRSTA8HF8B7xIHFTPjWQPTfAiXpAv3pHduZnexSCJjWnuqnqXemGEEKLUb3XhlO
	rldp6f6vbafu5RV66SutjBcfvLNJKKW0EegP1peCAtPZfONDF6oWzkJAtGDZuC4m
	2+dPGLVRB4pgGqI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=8KN0IyqQaGeDUPSsxgyPGO
	BFrIQ=; b=OFLnBfuLxWpu3M4Dt9A2hLuEYVk8wTi2apj/5aD5GbN5nm20q1wxe+
	/4HviRU5nBB/iuXhJ+Qwv6DgcjwBTlw9e0Ar9xf2BrMt1muGliPZtC9+SNHcQ525
	4Ct/TldanNweuVZUM+SiL7XpKSZ3uhyS7eee7u+GAb6opNjVURNhk=
In-Reply-To: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

Remove a duplicated case entry and remove redundant check, since it
can never be reached, in rpc_rpcb_getport().
---
 lib/rpc_subs.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index 9d5b2f5..cfb63d2 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -524,7 +524,6 @@ static enum clnt_stat rpc_rpcb_getport(CLIENT *client,
 			if (rpcerr.re_vers.low > RPCBVERS4)
 				return status;
 			continue;
-		case RPC_PROCUNAVAIL:
 		case RPC_PROGUNAVAIL:
 			continue;
 		default:
@@ -533,10 +532,7 @@ static enum clnt_stat rpc_rpcb_getport(CLIENT *client,
 		}
 	}
 
-        if (s_port == 0)
-		return RPC_PROGNOTREGISTERED;
-
-        return RPC_PROCUNAVAIL;
+	return RPC_PROGNOTREGISTERED;
 }
 
 static enum clnt_stat rpc_getport(struct conn_info *info,

