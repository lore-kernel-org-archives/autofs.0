From: Ian Kent <raven@themaw.net>
Subject: [PATCH 10/25] autofs-5.0.7 - add missing libtirpc lib to
 mount_nfs.so when TIRPC enabled
Date: Mon, 19 Aug 2013 09:13:01 +0800
Message-ID: <20130819011300.6472.11879.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=pM4/r+6eco8ZKnDAzM49RhxKayA=; b=M/DybZbFjfqFsg0YI0Ao+6NKvNu9
	2ULg85vBFnM6I2ua/1W+vNiI5WIH5bwz7yvszVmrn4kdqcJ0hU4Vi8CxitVkJh7m
	FpJRgZfQiBDStagPH1OklpelojKxS1fW/olXbYo7pxmVmKV3N2uYS1jy8niU62ZT
	Yqbj1VcLITtVZ5U=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=pM4/r+6eco8ZKnDAzM49Rh
	xKayA=; b=RNuMn/1ayCVqhLcnyD/muomCo/ncPa653cecOMrZg7XW8bpZA3oLy8
	6kKG8KFVQhs9MGqNVdsRzEdq7LgxLAWAmDwa4hBXHs8zrmNO3Vlrs4c1/xa9S28c
	2HOk2Gao11fiPxhc2wKB/SnYaXjCa2IpxN9guPEuGFfL1wjmEy4oE=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

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
index 296aaf8..679a469 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -62,6 +62,7 @@
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
 

