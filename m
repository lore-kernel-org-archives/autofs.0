From: joe@perches.com
Subject: [PATCH] [276/2many] MAINTAINERS - KERNEL AUTOMOUNTER (AUTOFS)
Date: Sun, 12 Aug 2007 23:30:39 -0700
Message-ID: <46bffa8f.1p/wvIRMYzk7ZcWd%joe@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S971272AbXHMJLl@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, hpa@zytor.com, autofs@linux.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index d61676a..dc0823d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2641,6 +2641,7 @@ P:	H. Peter Anvin
 M:	hpa@zytor.com
 L:	autofs@linux.kernel.org
 S:	Odd Fixes
+F:	fs/autofs/
 
 KERNEL AUTOMOUNTER v4 (AUTOFS4)
 P:	Ian Kent
