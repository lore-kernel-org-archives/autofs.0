From: Ian Kent <raven@themaw.net>
Subject: [PATCH 10/10] autofs - update MAINTAINERS entry for autofs
Date: Mon, 14 May 2018 11:04:56 +0800
Message-ID: <152626709611.28589.456596640024354223.stgit@pluto.themaw.net>
References: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Update the autofs entry in MAINTAINERS to reflect the rename of
autofs4 to autofs.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 MAINTAINERS |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58b9861ccf99..6189ff91fda7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7652,11 +7652,11 @@ W:	https://linuxtv.org
 S:	Maintained
 F:	drivers/media/radio/radio-keene*
 
-KERNEL AUTOMOUNTER v4 (AUTOFS4)
+KERNEL AUTOMOUNTER
 M:	Ian Kent <raven@themaw.net>
 L:	autofs@vger.kernel.org
 S:	Maintained
-F:	fs/autofs4/
+F:	fs/autofs/
 
 KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
 M:	Masahiro Yamada <yamada.masahiro@socionext.com>

