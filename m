From: Ian Kent <raven@themaw.net>
Subject: [PATCH 03/25] autofs-5.0.7 - add after sssd dependency to unit file
Date: Mon, 19 Aug 2013 09:12:13 +0800
Message-ID: <20130819011212.6472.2554.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=Mh2GH8ygOT9Z/qaC/MXjfNfgKFs=; b=eOvGVbkZq+MbLK33Ii3o8Yth3qXx
	oIWIOchi7ploqnvxOCyFn/soon4F1dvQVUGL6lIrpJ9tx5wMd7TgnM9MhazDIFgD
	4bcPrDB+Rr/q5HdkZsJcLfJm52CZHzSi8sD84b3Pm97OMOoHRI8v++jBUP8edN1v
	1guMsU+Ko17oru8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=Mh2GH8ygOT9Z/qaC/MXjfN
	fgKFs=; b=dxEaz70HhGG8QsbUPXJocx+MtA7UoIaU5AXZlVlXlissZfpM344f0S
	CyPCWH2NcDejrcuhxVk472GeKv3pGxGbSHee9k5kPfERlJ/qMAnl2TitwmxT5f/H
	8uA+xO145E0hG0toIG2gzKltPTAV2K7DDU9Ir5ZKmZiG7e4xGiiZA=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

From: Ian Kent <ikent@redhat.com>

When using sss as a map source autofs can sometimes start before
sssd is ready.
---
 CHANGELOG                 |    1 +
 samples/autofs.service.in |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 7749f01..2734fe3 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -55,6 +55,7 @@
 - fix add null check in parse_server_string().
 - don't override LDFLAGS in make rules.
 - fix a couple of compiler warnings.
+- add after sssd dependency to unit file.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/samples/autofs.service.in b/samples/autofs.service.in
index 056ab5e..777463d 100644
--- a/samples/autofs.service.in
+++ b/samples/autofs.service.in
@@ -1,6 +1,6 @@
 [Unit]
 Description=Automounts filesystems on demand
-After=network.target ypbind.service
+After=network.target ypbind.service sssd.service
 
 [Service]
 Type=forking

