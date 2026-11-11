Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368454;
	b=IJI0Xv4MPgmDnDVFwvfT/J0Fb5AMk7Y5c0TmZX/U948J6wL3Bbr4+cpclAfUIOLvnkge
	 pWrIRL6fOiWANveyNFvYCW+/cQ5znCnY+xDm5cXXKa1qZAP4Sa/XzdA3jKBxy13nnywTg
	 qcHaHi0Tl+k7E8zDCR86e2W38tlEl3djjZUy3tVZQw3JlbzOonyuYnfc7WJ4GWlNZJMbI
	 5PuqhjzpS9rRQDQNFbPi6/IzO0OcvguIIIYbiYAQ9olzbsui0Tnu2xKqOLkeRSYaQ3pve
	 bBW/Ti5TPpcBHm1YeT2vgoP4zkOBRI+DNKFOrJE8rq6m2OiHJaojDmgbJ+3loy3/jVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368454;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WWwqaILC751VZYlViYX434qN/q4IV1E/53HHI1qnfNQ=;
	b=qN5JRpXen1kWFdDOr1wgrSa1ChW6rrXsAAvyyrD1t94hjL8GS1IJDZprzf3gsf4PC1LV
	 mgDmSpJVn1NkM3JQ4u+DYYI+QHwJGSzaPfKabo6wM9JpRwEButrnrv4pHsi18J07SfiPE
	 8mUWPzM6X9P8XP7tkOnnwlttpUbwDyvkwRLmu3a7QyQxbvLpWof6Cer3WWh13ANRlBNw/
	 kcZr6tpeXaVaovqtHENlIU6UGlbgBFWnSYAYXe9Cw8fdeVUXSyNrSoCT0rhToBo8qq4X5
	 bURA6czHAvV8/izeUe3PahveNENUBF34G+havL8UmwfSrdYkX/lI6xTToaEPJwMJDeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vW0S6Iyl;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10011606A31C;
	Wed, 11 Nov 2026 03:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10011606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vW0S6Iyl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vW0S6Iyl+fLhEuoh5DgEZ/BMZbJRhROmSpzEv0nx3OEt0K0dS2vDtU0ZoQlI602chNnCSpHnBwhxj
	 hS9ocBOemhdot5qNLGQAPy3nQd4DPB/J0FykeNMyzRmAxPaD+Ui7yHg5aDXuuU7r14j5qMy67hhmaV
	 E6WiT/V47j27X8so=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af3e3c1c64-73ae4;
	Wed, 11 Nov 2026 11:40:51 +0800 (CST)
X-RM-TRANSID:2ee46af3e3c1c64-73ae4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af3e3c2da9-cd16b;
	Wed, 11 Nov 2026 11:40:51 +0800 (CST)
X-RM-TRANSID:2ee56af3e3c2da9-cd16b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: raven@themaw.net
Cc: autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c6d286fd51860df64d9a@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] autofs: serialize allocation of global wait queue tokens
Date: Wed, 11 Nov 2026 11:40:50 +0800
Message-ID: <20261111034050.12573-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:autofs@vger.kernel.org>
List-Help: <mailto:autofs+help@vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
List-Owner: <mailto:autofs+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

autofs_next_wait_queue is shared by all autofs superblocks, while
sbi->wq_mutex only serializes requests on one superblock. Concurrent
requests on different mounts can therefore lose updates to the global
counter. A delayed update can also move it backwards, allowing an
outstanding token to be reused on a mount.

Protect token allocation with a global spinlock. Keep the existing token
type and the wraparound rule that reserves zero.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 fs/autofs/waitq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 92c0bbbf452b..22bc59c2f63e 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -5,12 +5,14 @@
  */
 
 #include <linux/sched/signal.h>
+#include <linux/spinlock.h>
 #include "autofs_i.h"
 
 /* We make this a static variable rather than a part of the superblock; it
  * is better if we don't reassign numbers easily even across filesystems
  */
 static autofs_wqt_t autofs_next_wait_queue = 1;
+static DEFINE_SPINLOCK(autofs_wait_queue_lock);
 
 static void autofs_catatonic_mode_locked(struct autofs_sb_info *sbi)
 {
@@ -396,9 +398,11 @@ int autofs_wait(struct autofs_sb_info *sbi,
 			return -ENOMEM;
 		}
 
+		spin_lock(&autofs_wait_queue_lock);
 		wq->wait_queue_token = autofs_next_wait_queue;
 		if (++autofs_next_wait_queue == 0)
 			autofs_next_wait_queue = 1;
+		spin_unlock(&autofs_wait_queue_lock);
 		wq->next = sbi->queues;
 		sbi->queues = wq;
 		init_waitqueue_head(&wq->queue);
-- 
2.51.0


