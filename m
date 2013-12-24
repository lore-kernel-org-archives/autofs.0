From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/5] autofs-5.0.8 - get_nfs_info() should query portmapper
 if port is not given
Date: Tue, 24 Dec 2013 16:02:22 +0800
Message-ID: <20131224080222.8321.98415.stgit@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=ODwiQTg+9J5dYlU8Ghm8Twjh6Ns=; b=e7Q3n1opO3KshHFa9KC5YUGKiPRZ
	G8xDwu11EJjINVdC0P5RAcHKUIWRP+QIMT/WFRlMWmTYFH3Db3Vo4Xw+nQuCFEhv
	sbouvftnslnijMI04bBCGDfL5etyqzWafRb5ElNRlHDgi9yoqlM9ZeR2wRXzfU6E
	k1oWnMnhqGIiku0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=ODwiQTg+9J5dYlU8Ghm8Tw
	jh6Ns=; b=Y5ZFDjH169wfsmcgkU4pfD72qEbinYAB1ziY5KC8A+TVnvhqcFdl50
	xZN429oqre2fht/6hXdFRD65vGsxfs0lOXcHgtTaeAfP/nAR5n1Abw0TWTfMWSEE
	asxf05jypaf4/6skNNOsuifnpXjo9KgwpZSmkIZc3TKTcTESJXxpU=
In-Reply-To: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

From: Scott Mayhew <smayhew@redhat.com>

It shouldn't just assume it can use port 2049.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 modules/replicated.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/modules/replicated.c b/modules/replicated.c
index 5fdd9d9..2463235 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -444,9 +444,12 @@ static unsigned int get_nfs_info(unsigned logopt, struct host *host,
 		      host->name, proto, version);
 
 	rpc_info->proto = proto;
-	if (port < 0)
-		rpc_info->port = NFS_PORT;
-	else if (port > 0)
+	if (port < 0) {
+		if (version & NFS4_REQUESTED)
+			rpc_info->port = NFS_PORT;
+		else
+			port = 0;
+	} else if (port > 0)
 		rpc_info->port = port;
 
 	memset(&parms, 0, sizeof(struct pmap));

