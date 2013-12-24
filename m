From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/5] autofs-5.0.8 - fix rpc_portmap_getport() proto not set
Date: Tue, 24 Dec 2013 16:02:28 +0800
Message-ID: <20131224080228.8321.27468.stgit@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=0JKcmGiBSAMi6DE4ZxQo5/TqLls=; b=aGJppEtAuqUaxcgcfnYOBI4CESSA
	l0b6bNsPrndiMCRzqyuwUQfJkcE0CIQJiEXFrhyFX/VvV2rHCY4rhNkFkbmiLUcz
	qxw/g9dIlIGAwE7s6nKsOPaK3NdsiKAz0sRMSps+nRbyV5XuovQSp0jalvHAVAk7
	fFVokC2XDQMro7k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=0JKcmGiBSAMi6DE4ZxQo5/
	TqLls=; b=Oi2C0dUXoweSfBpkcZP3KNDePUozqDcVcgOIt7K2jdEwyAHdh2nwQ7
	KMpVupa+o/bTfib8F0nz/q4+tRprkALkczyKJXvcWcAlIcomG0KdwZmuNpVNhIZE
	qng0ayhsrabcBlvXTgJfVjSE4CLNMkE7TfnWo/t+nwfeI7BoIvQHM=
In-Reply-To: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

Recent changes to fix libtirpc usage problems when getting a server
exports list cause later server probing to fail.

When getting an exports list a new rpc client is always created for
the query, which includes setting the protocol in the parameters
structure. But when probing availability the client is reused where
possible and the protocol is not set in the parameters structure in
this case.

The rpc_portmap_getport() changes require that the protocol is set
in oder to function.
---
 lib/rpc_subs.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index cfb63d2..7c99ea8 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -877,6 +877,8 @@ int rpc_portmap_getport(struct conn_info *info,
 
 	memset(&pmap_info, 0, sizeof(struct conn_info));
 
+	pmap_info.proto = proto;
+
 	if (proto == IPPROTO_TCP)
 		pmap_info.timeout.tv_sec = PMAP_TOUT_TCP;
 	else

