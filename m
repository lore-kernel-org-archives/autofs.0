From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 12/12] autofs: Move inclusion of linux/limits.h to uapi
Date: Sun, 10 Jul 2016 17:07:53 +0900
Message-ID: <1468138073-4870-12-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gbym63WBVaf1oxQJkMNh0Hh/Tq6rMvoi+1LlVatMyG4=;
        b=CRRX2eD3rvBZ0LJwJ/Tl7lnbaEjjLoRQZpRQeER8dER2TpE5/cZeF0hR+Kik+jE/qd
         uYbmP9yM+FEm7vUgfTCfya1ExxtMyC8dC4A4RAnYJq9GHOHYnrsa6CLiyvDb7Ydo8/53
         Lfod+CcBoWpttOrjWzCfS+fjMxTXn8G/+bY+HkYrI4m0n+aBZIqDlz+UmKO52HsgauU9
         xdB6KHAcHQLg0y96g4+Uwr73jABHZ/tlXpO+Vsdo5s6bpQ60zaIfiOcpvkXtoKPj5Niw
         +t60Mr2ss7+CvFP+aauGul1014GzULFKQRU74QyIWOb6gpnlkKfKlAIHW50F8MHck0va
         1+pg==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

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
---
 include/linux/auto_fs.h      | 1 -
 include/uapi/linux/auto_fs.h | 1 +
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
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
