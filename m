From: raven@themaw.net
Subject: [PATCH 3/3] autofs4 - expiring filesystem from under process
Date: Sun, 10 Apr 2005 20:52:41 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504102050530.5212@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Michael Blandford <michael@kmaclub.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>


autofs4-2.6.12-rc1-mm4-version.patch

Bump autofs4 version so we know what's going on.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.12-rc1-mm4/include/linux/auto_fs4.h.version	2005-04-03 12:45:28.000000000 +0800
+++ linux-2.6.12-rc1-mm4/include/linux/auto_fs4.h	2005-04-03 12:47:01.000000000 +0800
@@ -23,7 +23,7 @@
  #define AUTOFS_MIN_PROTO_VERSION	3
  #define AUTOFS_MAX_PROTO_VERSION	4

-#define AUTOFS_PROTO_SUBVERSION         5
+#define AUTOFS_PROTO_SUBVERSION		6

  /* Mask for expire behaviour */
  #define AUTOFS_EXP_IMMEDIATE		1
