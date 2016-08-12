From: Ian Kent <raven@themaw.net>
Subject: [PATCH 17/18] autofs: Move inclusion of linux/limits.h to uapi
Date: Fri, 12 Aug 2016 10:48:56 +0800
Message-ID: <20160812024856.12352.24092.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=XWYKwbDJh/l4wlpdimTuIzj6gYU=; b=BJNsuT
	kFuIjKE6XQYiSNUR/f1XYfA1VqyGQx/5ejp8eWjusDbFM/n2+4N1Cx/5qkqeGk2s
	Cz+LqK10rp2Rkpkrb7z7qv5Q6aDLj4z2qpzlV7efAP9sFX2t8fMdNcxK29sOfQg7
	BxNMbxZ5kXJ+taWGGItbT08iIkyk9Ob4JhCmk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=XWYKwbDJh/l4wlp
	dimTuIzj6gYU=; b=NELiVvIkOd9BAC0vSRpRbXAXBwASmbPJTSoL/YnP9iacrz9
	aI+dErjf3rd4TP1AXHITGjnb09dI4iZUW4KuIdmYb8vhmji8AgxmkGLvV3DsA76X
	CrotLVuNSjLCV2m6BREUzXtpUi0mu9eKTAgP5lr+mIuzXJnUYuXgwl5AmFQk=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

linux/limits.h should be included by uapi instead of linux/auto_fs.h
so as not to cause compile error in userspace.

 # cat << EOF > ./test1.c
 > #include <stdio.h>
 > #include <linux/auto_fs.h>
 > int main(void) {
 >     return 0;
 > }
 > EOF
 # gcc -Wall -g ./test1.c
 In file included from ./test1.c:2:0:
 /usr/include/linux/auto_fs.h:54:12: error: 'NAME_MAX' undeclared here (not in a function)
   char name[NAME_MAX+1];
             ^

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <ikent@redhat.com>
---
 include/linux/auto_fs.h      |    1 -
 include/uapi/linux/auto_fs.h |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/auto_fs.h b/include/linux/auto_fs.h
index b4066bb..b8f814c 100644
--- a/include/linux/auto_fs.h
+++ b/include/linux/auto_fs.h
@@ -10,7 +10,6 @@
 #define _LINUX_AUTO_FS_H
 
 #include <linux/fs.h>
-#include <linux/limits.h>
 #include <linux/ioctl.h>
 #include <uapi/linux/auto_fs.h>
 #endif /* _LINUX_AUTO_FS_H */
diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index 9175a1b..1bfc3ed 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -12,6 +12,7 @@
 #define _UAPI_LINUX_AUTO_FS_H
 
 #include <linux/types.h>
+#include <linux/limits.h>
 #ifndef __KERNEL__
 #include <sys/ioctl.h>
 #endif /* __KERNEL__ */

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
