From: Ian Kent <raven@themaw.net>
Subject: [PATCH 09/25] autofs-5.0.7 - fix dead LDAP symbolic link when LDAP
 support is disabled
Date: Mon, 19 Aug 2013 09:12:54 +0800
Message-ID: <20130819011253.6472.46618.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=9vuTcY1PHyMGKYJxW9l4HMg0XF4=; b=FkVaFYLaOluPRlisL0sbgr9c3DcR
	NIwR1Aj1rBGMSR01Salyt9y71YJfNjLsxNDFHS7qZoUXTrVC7gqPOXmU/Rl1hccL
	zUdzpxfsU2LfeM8sPP3Retx8eLbX1bqQtSGNKdCh52kVyd9QPukQzuzRG3mbQLkd
	f8aAqOqwb9M0Tv4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=9vuTcY1PHyMGKYJxW9l4HM
	g0XF4=; b=UwiOxAnT6nbNu/6m2V4GyvEYT2kH+PkcPPDEZ5FC+Fwh7yFZLoMJHe
	eAGTBayFSB1tHV4Gxl0wRSo+1MjdHULBZ9YxcR/Zc/O55Eps08USg9vnN9p5HjJ7
	pnhEn9QBVIiKR+nNE9rtbhRfcypsKVRART1JohIUWkN0dL84KpXnQ=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

From: Lan Yixun (dlan) <dennis.yxun@gmail.com>

autofs will create symbol link mandatory no matter ldap support
is enabled or not. so, without this patch, lookup_ldaps.so will become
a dead link.

Edited by: Ian Kent <raven@themaw.net>
- change check from SASL to LDAP since the ldaps lookup module may
  still be used by ldaps:// as long as LDAP support is built.
---
 CHANGELOG        |    1 +
 modules/Makefile |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 647504b..296aaf8 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -61,6 +61,7 @@
 - fix compile error with heimdal support enabled.
 - fix typo forced-shutdown should be force-shutdown.
 - fix hesiod check error and use correct $(LIBS) setting.
+- fix dead LDAP symbolic link when LDAP support is disabled.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/modules/Makefile b/modules/Makefile
index c5deb24..8c0df18 100644
--- a/modules/Makefile
+++ b/modules/Makefile
@@ -74,7 +74,9 @@ install: all
 	-rm -f $(INSTALLROOT)$(autofslibdir)/mount_smbfs.so
 	ln -fs lookup_file.so $(INSTALLROOT)$(autofslibdir)/lookup_files.so
 	ln -fs lookup_yp.so $(INSTALLROOT)$(autofslibdir)/lookup_nis.so
+ifeq ($(LDAP), 1)
 	ln -fs lookup_ldap.so $(INSTALLROOT)$(autofslibdir)/lookup_ldaps.so
+endif
 	ln -fs mount_nfs.so $(INSTALLROOT)$(autofslibdir)/mount_nfs4.so
 ifeq ($(EXT2FS), 1)
  ifeq ($(EXT3FS), 1)

