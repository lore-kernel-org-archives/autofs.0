From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 2/6] fix dead LDAP symbol link with LDAP support disabled
Date: Mon, 22 Jul 2013 22:59:50 +0800
Message-ID: <1374505194-22668-3-git-send-email-dennis.yxun@gmail.com>
References: <dennis.yxun@gmail.com>
 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oHUVkHf5QFMPmoTI+0Af7HfRdUqgZDf3Gu9TjJvauoE=;
        b=XvKXF47uFMcu+iTmCbHpMut20PRezX9jg3RxcqlP4wKh6FVG+e/oLl6ZA98qXeBsrM
         2fG1Cw5A4UwlCMoSdjQSd1kLhJ4TuARk6hojlItvE/ynf1vjKM+uDjCNlcNvHjng1CPt
         tymSAfCyrsA0ygEEAMJbwoUNRmKVTSb1OcQXUX78/vVT/nHOznIMKNb37hSM2td1sAOD
         LZzFCMMAplp1PmAO1pytoIcCwaTN2ZTp+RXs3pkJiZyUVHNlJ+sw6VwndgWVRheEgXmN
         D6T8r8499RzQ9jgS0mXoQSeMRw3r3qa3YQhfNvMaN4jlIaN2QxjJnJhh/9gIyQYDWeqw
         CUiw==
In-Reply-To: <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

autofs will create symbol link mandatory no matter ldap support
is enabled or not. so, without this patch, lookup_ldaps.so will become
a dead link.

---
Upstream Discussion:
  http://thread.gmane.org/gmane.linux.kernel.autofs/5371

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 modules/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/modules/Makefile b/modules/Makefile
index c5deb24..4bb1096 100644
--- a/modules/Makefile
+++ b/modules/Makefile
@@ -74,7 +74,9 @@ install: all
 	-rm -f $(INSTALLROOT)$(autofslibdir)/mount_smbfs.so
 	ln -fs lookup_file.so $(INSTALLROOT)$(autofslibdir)/lookup_files.so
 	ln -fs lookup_yp.so $(INSTALLROOT)$(autofslibdir)/lookup_nis.so
+ifeq ($(SASL), 1)
 	ln -fs lookup_ldap.so $(INSTALLROOT)$(autofslibdir)/lookup_ldaps.so
+endif
 	ln -fs mount_nfs.so $(INSTALLROOT)$(autofslibdir)/mount_nfs4.so
 ifeq ($(EXT2FS), 1)
  ifeq ($(EXT3FS), 1)
-- 
1.8.2.1

