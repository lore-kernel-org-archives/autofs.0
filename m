From: Ian Kent <raven@themaw.net>
Subject: [PATCH 03/13] autofs4 - use pr print in AUTOFS prints
Date: Mon, 03 Nov 2014 16:12:29 +0800
Message-ID: <20141103081229.6215.69137.stgit@perseus.themaw.net>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:subject:from:to:cc:date:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	 s=mesmtp; bh=UuZ0zz+dkkan0gsyUWmtVm/NzBU=; b=SUPyliCHYoA/Fa4z7W
	mndsxgsTU/ng9cggveV4HnU7ct7zUVDz/K1PkEwpnl7slzg4QV3Ls8G01DbACG8J
	1YU53PcSI9UV6awZ7w9w/yBO6urfo269r3eUSOPRJEvH7VkzpAOW9GxYACOC4leA
	1gPqJvY7sMkID8dYVKYQj8srA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:subject:from:to:cc:date
	:message-id:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=UuZ0zz+dkkan0gsyUWmtVm
	/NzBU=; b=dF8pjy797ec+8zPaPQHz7UlTnGkdxKYzM2oNGqoF4qQsXyTida7He1
	Vy12jyS/80MnBQUdcJW+3s/Bq+R8htmFvv6s65wkCCKcS2u9dUzSClIW+HTYMhtH
	mrEaz3oPHE/aHdz6+yzCynVbBssfInRkN8jGer1q6IAzZHSTlbvN8=
In-Reply-To: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Use the pr_*() print in AUTOFS_*() defines instead of printks.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/autofs_i.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 0a1fcdc..b33b939 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -41,11 +41,11 @@
 		current->pid, __func__, ##__VA_ARGS__)
 
 #define AUTOFS_WARN(fmt, ...)				\
-	printk(KERN_WARNING "pid %d: %s: " fmt "\n",	\
+	pr_warn("pid %d: %s: " fmt "\n",	\
 		current->pid, __func__, ##__VA_ARGS__)
 
 #define AUTOFS_ERROR(fmt, ...)				\
-	printk(KERN_ERR "pid %d: %s: " fmt "\n",	\
+	pr_err("pid %d: %s: " fmt "\n",	\
 		current->pid, __func__, ##__VA_ARGS__)
 
 /*

