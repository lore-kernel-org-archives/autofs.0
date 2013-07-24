From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH] add missing libtirpc lib to mount_nfs.so when TIRPC enabled
Date: Wed, 24 Jul 2013 10:37:00 +0800
Message-ID: <1374633420-28235-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=HBRDdclCSKU/9onqfKvj78HGgty5GFQ74ZHSV77OBok=;
        b=GYyFhJe8Oyou+ibaWFrjoZzSImrcmE77aMrU7jqsbUBRqGYY8DKa+spFNiRYtLF/qK
         i5/unl33fz0xk5F3lOhJGvUSoGLGq2yA1joBJ/16ND3VqUDCjqM8ikdjxu8qjBiNdp8k
         jJ/U3KlJyb5Nb1Xf7UvAGghOvBqFrW+aA4ardJ37xsfn/iVb7wvFwjTmn3pS8HaHFpVC
         MZgsHi+4Y0U0hWUVwB5IvHbAvqkFHUr2JH1cylBX5i+/Ai67zppUIS9KixuFEiLA4KP/
         rcXEWkdbaPiu+wtPTwHXnzsEGfC2TNXE1mYB7ULf1J8Ace8NUbIVsNY7Lb50Jr8bcNVe
         k4Zw==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

this is need when libtirpc is enabled, otherwise autofs fail to start
due to it can't find symbol clnt_dg_create (which is provided by libtirpc)

---
autofs error log from /var/log/message:

Jul 23 12:11:58 ofire automount[25699]: open_mount:244: parse(sun): cannot open mount module
nfs (/usr/lib64/autofs/mount_nfs.so: undefined symbol: clnt_dg_create)
Jul 23 12:11:58 ofire automount[25699]: lookup(file): failed to open parse context

without this patch, mount_nfs.so fail link to libtirpc.so
 # ldd /usr/lib64/autofs/mount_nfs.so |grep tirpc

with this patch applied:
 # ldd /usr/lib64/autofs/mount_nfs.so |grep tirpc
        libtirpc.so.1 => /lib64/libtirpc.so.1 (0x00007f7d94920000)

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 modules/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules/Makefile b/modules/Makefile
index 4bb1096..0fe8ae8 100644
--- a/modules/Makefile
+++ b/modules/Makefile
@@ -116,6 +116,6 @@ lookup_ldap.so: lookup_ldap.c dclist.o base64.o $(SASL_OBJ)
 
 mount_nfs.so: mount_nfs.c replicated.o
 	$(CC) $(SOLDFLAGS) $(CFLAGS) -o mount_nfs.so \
-		mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBNSL)
+		mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBNSL) $(TIRPCLIB)
 	$(STRIP) mount_nfs.so
 
-- 
1.8.3.2

