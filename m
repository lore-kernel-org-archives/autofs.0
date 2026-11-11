Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365367;
	b=zVn2mur7LEmx8hqaP2E4P83us3CJ5vsb4jv7DX9J2OB0nVL4FIC9Fc77jT0ALOXXkNH2
	 MOtF8OrzPeeuoVPrRuO3NU/h0A+peqEr2w5HYd7Jiv499XGd0cjtzaBw3Tr4Yy2svVWqP
	 4Ky5A7x+njQH2n+03sWWEhVezBOCa/h5yy1HUCaK5GQwJPEwAl6YyNhFMw0bBXsYc0Be9
	 tJ9MFrZXh++yaLh2okHAtf3EUBGPBj7XW2StgqqO9SCqvddab16H4euoxHwTeaE5Vo69X
	 i0AjhXbCLF/gpwH7AXsqN6/vIPPCOi/bDeXXqFJOxAS9NYeym9WvgSq6ERdYeV3ZKYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365367;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s2ig8gRXpGWoaUTlh1+U594YONM8wXZNHuXCR3R5T/M=;
	b=zlcGxcSI05Kqt6IQUaeovgmQSN3fbfhOsj+XI4wwGQ4YlR1UBLqeV2EhCRCJyls3oWWe
	 n195dFVSZIyC6cihPPZHC9bwZ+LPu8aJcIP3/zXEPBUlFUuAEKLYvEC4kylFTLm87q8ky
	 h92yQDmC9C2WdNvKwugBH048qrngANPyP3q8GfNbGrAonrzItExst4BdWxi2/msmTePMb
	 XFN/pwqX3yW0jMS5xgHMTB1j1D+eZe+CzWm6CvVvnkSC0le1Ut3CN9obvpKbz0DLnuA4w
	 5t/O17OF6XI7yn/wgGzrxs+94aY8zLsrTwfjqlTU4coI9Ww2E+d0AvSh130cdtalNIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mowmIcgb;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996E3606A320;
	Wed, 11 Nov 2026 02:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 996E3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mowmIcgb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=mowmIcgb+33kK7vsptwSyyhu5+x25LERfMk4vT7hWd2x1viuEYJrUSoQMcAvqxeyN30NbgJmjFIHL
	 W/W0ZN4hmVcYr7xdzdLOdmnkdUT8wHAS83CJcutcAXvPIzMh01lWMQqgP67j5S+PSMT77ht0so+Lyr
	 Iq98smNVRHfm3kfQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af3d7b4e73-9f686;
	Wed, 11 Nov 2026 10:49:24 +0800 (CST)
X-RM-TRANSID:2ee36af3d7b4e73-9f686
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af3d7b23a2-cb759;
	Wed, 11 Nov 2026 10:49:24 +0800 (CST)
X-RM-TRANSID:2ee56af3d7b23a2-cb759
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: raven@themaw.net
Cc: autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c6d286fd51860df64d9a@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] autofs: serialize allocation of global wait queue tokens
Date: Wed, 11 Nov 2026 10:49:22 +0800
Message-ID: <20261111024922.10051-1-zhujun2@cmss.chinamobile.com>
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


