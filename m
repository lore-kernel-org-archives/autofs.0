From: SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 2/5] drivers/block: Fix a dead URL to ftp.kernel.org
Date: Mon, 27 Mar 2017 14:47:28 +0900
Message-ID: <20170327054731.31882-3-sj38.park@gmail.com>
References: <20170327054731.31882-1-sj38.park@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ci4W0cTFaRB3W1Sgge3KRwys9k3k1TM5/ndVXeMWNY8=;
        b=g3iIE2Ln+dsDLGZ07+8/1XIGMoaURfqedtguFGuaxXvfh84NEDa1a0r0jqdxyGcL53
         yCWV+bqqO2Ufgb06Dy8IebIe6hwR5YEcaiOHsSsUYghw3U6atbQeE8zJUWp72mv4glBI
         mMjnkwrdCzdq1nQXUCvuZJit/EZyVwJUld1LwB9EpUuAd5/AX9ysPv3gR0T5GcW6KDFw
         vy4hjnsO1RPfGYTQX4SzQlYH4lK/pHOrg3OrfA/m++bnbqtwSDNn7dq3oKXWSx7Hfgxj
         1EuJvXTOUxz+6WUnb55BWQx8JllNPG9pX3nJdEn81vlVtrTVR1a+3VHGXfE/7mfZuX0U
         8HRg==
In-Reply-To: <20170327054731.31882-1-sj38.park@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rml@tech9.net, axboe@fb.com, shli@kernel.org, raven@themaw.net, yamada.masahito@socionext.com, mmarek@suse.com
Cc: linux-raid@vger.kernel.org, autofs@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, SeongJae Park <sj38.park@gmail.com>

As ftp.kernel.org is closed [0], this commit fixes a dead URL to
ftp.kernel.org in drivers/block/ to use www.kernel.org instead.

[0] https://www.kernel.org/shutting-down-ftp-services.html

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 drivers/block/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index f744de7a0f9b..7b608cf2516f 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -219,7 +219,7 @@ config BLK_DEV_LOOP
 
 	  To use the loop device, you need the losetup utility, found in the
 	  util-linux package, see
-	  <ftp://ftp.kernel.org/pub/linux/utils/util-linux/>.
+	  <https://www.kernel.org/pub/linux/utils/util-linux/>.
 
 	  The loop device driver can also be used to "hide" a file system in
 	  a disk partition, floppy, or regular file, either using encryption
-- 
2.10.0

