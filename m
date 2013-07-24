From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/9] Series short description
Date: Wed, 24 Jul 2013 16:17:19 +0800
Message-ID: <20130724081610.722.84685.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=CQAx6c8S/72CTkmzPBPcj74
	wIiA=; b=Hz40en5rnANaESquztHClC0887Hto2ns72u/eTE7DS7rd2CEYc1tGdK
	J/XkbKtnnN8JrSFspIO57Vme4zhXFW71cqD/J13gdVRrU6qBi9VE4/6qHVbovkzY
	DPiYIK1kHbtBd0iUzbMrXoHrHjt3LbF//aZu4c35DYvy7yOVvlOQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=CQAx6c8S/72CTkmzPBPcj74wIiA=; b=QnUdcBkhekRGMfyosWWb71f+UBaV
	aTz33OA1m/UjN1kCyos0fASbz08We3N++pKUjsmPgyXf2fUo8HhGHFGnk2T8Fe4s
	OUniKL6X0AKhvtyrNRNmfMJjF8WtPFd0yI3Ch8Cxlh2gkx0euElfM47g5XH6pUcH
	cPlw1ZxQeQFPY7M=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

The following series implements...

---

Dustin Polke (1):
      autofs-5.0.7 - fix compilation of lookup_ldap.c without sasl

Ian Kent (1):
      autofs-5.0.7 - use LIBS for link libraries

Lan Yixun (dlan) (7):
      autofs-5.0.7 - fix typo forced-shutdown should be force-shutdown
      autofs-5.0.7 - fix hesiod check error and use correct $(LIBS) setting
      autofs-5.0.7 - fix dead LDAP symbolic link when LDAP support is disabled
      autofs-5.0.7 add missing libtirpc lib to mount_nfs.so when TIRPC enabled
      autofs-5.0.7 - use compiler determined by configure instead of hard-coded ones
      autofs-5.0.7 - remove hard-coded STRIP variable
      autofs-5.0.7 - unbundle NOTSTRIP from DEBUG so they wont depend on each other


 CHANGELOG             |    4 ++++
 Makefile.conf.in      |    3 +++
 Makefile.rules        |   30 +++++++++++++++---------------
 aclocal.m4            |   12 ++++++------
 configure             |   20 ++++++++++----------
 configure.in          |    2 +-
 daemon/Makefile       |    2 +-
 include/lookup_ldap.h |    4 ++--
 lib/Makefile          |    4 ++++
 modules/Makefile      |   20 ++++++++++++--------
 modules/lookup_ldap.c |   14 ++++++++++++--
 11 files changed, 70 insertions(+), 45 deletions(-)

-- 
Signature
