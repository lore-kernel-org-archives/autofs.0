From: Ian Kent <raven@themaw.net>
Subject: [PATCH 0/5] Series short description
Date: Tue, 24 Dec 2013 15:52:02 +0800
Message-ID: <20131224074836.7875.32770.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=l1VgPic9qjjTV7SaKdGAi7H
	0aoM=; b=vqf7JMsfAO49urx6W5CaP4SYlPefbFX/LPX5Pn5BltuY6WyL7qOa+Fa
	UqIqv+w/fMRNwZYE8of0xf7+IZi5nVE91UYOV9zp5I8Wsk77Y+QTW27Oqq0GRBIv
	UFIXWbC88VuYU5dTP1msndTRyj8ym0T//C4fTOid444h6RwfnrJA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=l1VgPic9qjjTV7SaKdGAi7H0aoM=; b=OxDEXYYNcu89ogDQ6a7cDDkFr4sd
	P4Y8qA8vNV5gSpYqIJ8Ct10eRyRymmYK47W37LEq0xqO4xhzbV6rp7+EQL/07Vjv
	d01funIzLh0jBwxCFuazYY2Ad/G78m24Bmg6eR/W+HNNetITFnrdOjH/B/26HcJN
	FQzv4tTh4VgOEqw=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

The following series implements...

---

Ian Kent (4):
      autofs-5.0.8 - fix ipv6 link local address handling
      autofs-5.0.8 - fix fix ipv6 libtirpc getport
      autofs-5.0.8 - fix rpc_portmap_getport() proto not set
      autofs-5.0.8 - fix options compare

Scott Mayhew (1):
      From a22123dad2107a7a872ba44b0ebc478cc4d2367d Mon Sep 17 00:00:00 2001


 include/automount.h    |    1 +
 lib/cat_path.c         |    9 +++++++++
 lib/rpc_subs.c         |   14 +++++++++-----
 modules/mount_autofs.c |   12 ++++++------
 modules/mount_bind.c   |    2 +-
 modules/mount_ext2.c   |    2 +-
 modules/mount_nfs.c    |   34 +++++++++++++++++-----------------
 modules/parse_sun.c    |   22 +++++++++++-----------
 modules/replicated.c   |    9 ++++++---
 9 files changed, 61 insertions(+), 44 deletions(-)

-- 
Signature
