From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/9] autofs-5.0.7 - fix dead LDAP symbolic link when LDAP
 support is disabled
Date: Wed, 24 Jul 2013 16:53:20 +0800
Message-ID: <20130724085319.3884.27697.stgit@perseus.fritz.box>
References: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=BQLjdZNnQ8NzPT3RL2Gw6UIpO00=; b=Us3YJkwnujEg1KxpQNURVMWSqwmg
	P6NRgbEINLgnsn9+uJ3keGW4HkBv+56DEd/gi9TyYi8QwG+mmxNQzOuQTnADewH+
	Js+HmQoKI8zAVM9WdrzEkhm1tA1/pgjcQ6YFiWFKDp13BTBkK5nkHh6RjerAvTpr
	XaDuU8eAiLw2EtE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=BQLjdZNnQ8NzPT3RL2Gw6U
	IpO00=; b=HNFBMnc+mul2ClX1z74PE/ad4cD2kW4IOeDVn//5C8jbJc3clBPCA6
	q3ivjP5v/09fQLbzulS6Du8tR9O/sqEj5gFhn9W8XENezGe8Vm37J/lCmTcNwBET
	+TSoXYFm9Iyd2yFwkura4SelP7/NbBUZEPdxnf2kKQ7Fe3AOjX0sc=
In-Reply-To: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

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
index 3c829cf..9755e25 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -59,6 +59,7 @@
 - dont start readmap unless ready.
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

