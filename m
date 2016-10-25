From: Ian Kent <raven@themaw.net>
Subject: [PATCH 18/37] autofs-5.1.2 - fix cachefs parse message not being
 logged
Date: Tue, 25 Oct 2016 09:19:01 +0800
Message-ID: <20161025011900.7778.92395.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=QBzQ+lp+71oZ5i6AITDR5PW51uU=; b=chk/4FF8Iof/MlUf1I
        wAOn6PxLxt5Z2MX2TO2SWEXgQtst81KyhWaStBuU/OmBIgZ2CAI2dvh0MoeMUjHv
        +85Gm2v4za9BhZSPrJQww7VuQ/7dyOgsJq5R6/6nRe7PUIWKWhc90RlQkfXwJx58
        PRZXfGbnvCWIOciATIRC3YYxQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=QBzQ+lp+71oZ5i6AITDR5P
        W51uU=; b=hM7InbMnIGL/4Yv44mnHRXp0z324kodXe7EslQCONCcbSldUY2qWnE
        GAVRoU2XPDts7EfdoNSJ7DhDuJx0ph+fr3dojXnzjVsd5Hk9Om+SgvibYG0G2kb+
        N23skYcc8wS4kb2HnNQEcbShaHLWtMFiIARj6EcAGr1zYEagwqrbU=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Signed-off-by: Ian Kent <raven@themaw.net>
---
 modules/amd_parse.y |    1 +
 1 file changed, 1 insertion(+)

diff --git a/modules/amd_parse.y b/modules/amd_parse.y
index ce8623d..bfa1d51 100644
--- a/modules/amd_parse.y
+++ b/modules/amd_parse.y
@@ -301,6 +301,7 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 		} else if (!strcmp($3, "cachefs")) {
 			sprintf(msg_buf, "file syatem %s is not "
 					 "supported by autofs, ignored", $3);
+			amd_msg(msg_buf);
 		} else {
 			amd_notify($1);
 			YYABORT;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
