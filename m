From: SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 1/5] MAINTAINERS: Fix a dead URL to ftp.kernel.org
Date: Mon, 27 Mar 2017 14:47:27 +0900
Message-ID: <20170327054731.31882-2-sj38.park@gmail.com>
References: <20170327054731.31882-1-sj38.park@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Pu6fT2beTiCW2CpuqQIm4X6T6t9K1KKjoTzbihGoWI=;
        b=k/04qKmgLnSCSOVjyZ1tIwHWKmwi6+skQras5n/6gyr+g/wT7XO211+p2lVaknUJ8p
         t4oYEx5jHbsoapnmYNFKtOYQiwH1yTCs1XmX9p09y4O9eS3FU2a2cxznWHO7bY317gtj
         KSrwltWYn4Hrw0WTX3QxtbfB8ETuk6BvWeiCAIHHNDFaquNoA2yIaYAsvKh9iXt0IEcn
         GwkWhPWBqbGmyyxsy16JAaq8EkN+CQpj67GoBHy9aK+b/Td5aYOxIz326mvuk6oclRDF
         F7HkkMrAZ5/g5lvPWO2OEeCNIk7WGtZuIHwTGJz0b4WkcgskCs9sJYLB0T7sj/F7+fhf
         HBWg==
In-Reply-To: <20170327054731.31882-1-sj38.park@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rml@tech9.net, axboe@fb.com, shli@kernel.org, raven@themaw.net, yamada.masahito@socionext.com, mmarek@suse.com
Cc: linux-raid@vger.kernel.org, autofs@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, SeongJae Park <sj38.park@gmail.com>

As ftp.kernel.org is closed [0], this commit fixes a dead URL to
ftp.kernel.org in MAINTAINERS file to use www.kernel.org instead.

[0] https://www.kernel.org/shutting-down-ftp-services.html

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c768d79cf3f..6367f0739394 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10158,7 +10158,7 @@ W:	http://sourceforge.net/projects/accel-pptp
 PREEMPTIBLE KERNEL
 M:	Robert Love <rml@tech9.net>
 L:	kpreempt-tech@lists.sourceforge.net
-W:	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel
+W:	https://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel
 S:	Supported
 F:	Documentation/preempt-locking.txt
 F:	include/linux/preempt.h
-- 
2.10.0

