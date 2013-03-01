From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs4 - autofs4_catatonic_mode(): remove redundant
 null check on kfree()
Date: Fri, 01 Mar 2013 19:46:48 +0800
Message-ID: <20130301114647.28560.84229.stgit@perseus.fritz.box>
References: <20130301114639.28560.27407.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=id39djIusliTjL93AH2mmfwTkLs=; b=unKe5uX9+vX5RsXCvkUp9iziB8Er
	5kDbVsYIHo5octQz6TL6wj+/Nz5k39e6uuDEuJQRGblcmydFpsXDrCmtzf3e1eHx
	1UZWdFG7dii2sZ1//mUczGDIrdIYyCgWTtgMTGGQmDHUVgIRyA5HnghzFmW63n45
	aSU8reaRIcs7OG8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=id39djIusliTjL93AH2mmf
	wTkLs=; b=DxLpBygY3Nnpdto//xzt1l6WWeFaXfUuVzoi8OnSsi3/USA91GUeDt
	x8ViLnKl1Rf3ifcyD9Ckf4X/gpEEfnIuxVtS+EUVEPmyuTdpRGgTGc8ISnZ0eCQw
	WKdq63d/vZrYKfz0szKvMm7oedkqod5XdKhmxJbUUV9cSZ/U0aw6w=
In-Reply-To: <20130301114639.28560.27407.stgit@perseus.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tim Gardner <tim.gardner@canonical.com>

smatch analysis:

fs/autofs4/waitq.c:46 autofs4_catatonic_mode() info: redundant null
 check on wq->name.name calling kfree()

Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
---
 fs/autofs4/waitq.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 03bc1d3..3db70da 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -42,10 +42,8 @@ void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
 	while (wq) {
 		nwq = wq->next;
 		wq->status = -ENOENT; /* Magic is gone - report failure */
-		if (wq->name.name) {
-			kfree(wq->name.name);
-			wq->name.name = NULL;
-		}
+		kfree(wq->name.name);
+		wq->name.name = NULL;
 		wq->wait_ctr--;
 		wake_up_interruptible(&wq->queue);
 		wq = nwq;
