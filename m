From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/9] autofs-5.0.7 - add missing libtirpc lib to mount_nfs.so
 when TIRPC enabled
Date: Wed, 24 Jul 2013 16:53:27 +0800
Message-ID: <20130724085326.3884.34440.stgit@perseus.fritz.box>
References: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=qq/G/KuG/TauMNLUjn09n8Z08Fs=; b=BNaQ312KelzXHkZTcnNS57yg61hr
	E54IZqWPyPtFq0vD67++mVXIdggS1SYA7fzM0EvHduRVTxy6yVftKnayW8CfPeKC
	vF/4fxgIVwZZ4AI6k/rlqKHQdJbr1JJ3fPRhkuasxbJbvqdXMFEzfdlWV0UYhIyl
	DlZobAbg/SZNgJM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=qq/G/KuG/TauMNLUjn09n8
	Z08Fs=; b=ULmTS1j7Re8lJeVrAhRIrxd6+B8PqvF6WNbOL/EbS04HKxjZ2OQnk+
	+KsnnrBmu9R5iURY1/RnCZ71j0QoBxPfgJaIrwhlqUgJrDzeiwpTppa0pdognYGm
	sZY3QyYXZMsUPznE8fr6JNYr3rUgrs4Pz62Raa8gWkHaeOET8syx4=
In-Reply-To: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

From: Lan Yixun (dlan) <dennis.yxun@gmail.com>

this is need when libtirpc is enabled, otherwise autofs fail to start
due to it can't find symbol clnt_dg_create (which is provided by libtirpc)

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
 CHANGELOG        |    1 +
 modules/Makefile |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9755e25..72d9135 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -60,6 +60,7 @@
 - fix typo forced-shutdown should be force-shutdown.
 - fix hesiod check error and use correct $(LIBS) setting.
 - fix dead LDAP symbolic link when LDAP support is disabled.
+- add missing libtirpc lib to mount_nfs.so when TIRPC enabled.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/modules/Makefile b/modules/Makefile
index 8c0df18..e61e338 100644
--- a/modules/Makefile
+++ b/modules/Makefile
@@ -116,6 +116,6 @@ lookup_ldap.so: lookup_ldap.c dclist.o base64.o $(SASL_OBJ)
 
 mount_nfs.so: mount_nfs.c replicated.o
 	$(CC) $(SOLDFLAGS) $(CFLAGS) -o mount_nfs.so \
-		mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBNSL)
+		mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBNSL) $(TIRPCLIB)
 	$(STRIP) mount_nfs.so
 

