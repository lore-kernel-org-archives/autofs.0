From: Ian Kent <raven@themaw.net>
Subject: [PATCH 8/9] autofs-5.0.7 - unbundle NOTSTRIP from DEBUG so they
 dont depend on each other
Date: Wed, 24 Jul 2013 16:53:56 +0800
Message-ID: <20130724085355.3884.20045.stgit@perseus.fritz.box>
References: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=jKXKZteWcHd+xI43RONx7qytQS8=; b=FEnB4XAKu7E1NkflyWB/XMdW3TdT
	jG774OqyoCChDye5YmXAXEOeRGhAk9zA4BBHe9dcyZdu2TSyMZ2OAJc+ypWBqTre
	bZlOeTGVI3o5PbWl4jAK66ELlA+PSeZgFj8H7AoZ9c+c6ux4PQ4Ae4CxI4Y1jpRW
	fw8cOTgcjh9pi9o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=jKXKZteWcHd+xI43RONx7q
	ytQS8=; b=HF6oXQW4S1pTmUNxEcJLftIljvf+9MVIX7c01E2BifjkF7u9vkJ3bi
	uIqtTsNxqDp4NxpRzF/UOEiwdJtZ3IXfFBPYLXQanCl/vcD955yVSD94YHMwlWTz
	0Cw5hTF8pR8H2BlP3FLDfFUIHI1TkqImngdHuW+p9JrfnlthXf2eg=
In-Reply-To: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

From: Lan Yixun (dlan) <dennis.yxun@gmail.com>

Gentoo build system expects unstripped elf image from the build system,
seperate this, will allow us to better control the strip operation.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 CHANGELOG      |    1 +
 Makefile.rules |   10 ++++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 897a2b4..42ea627 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -64,6 +64,7 @@
 - use compiler determined by configure instead of hard-coded ones.
 - remove hard-coded STRIP variable.
 - use LIBS for link libraries.
+- unbundle NOTSTRIP from DEBUG so they dont depend on each other.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/Makefile.rules b/Makefile.rules
index fa53459..0754a00 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -25,18 +25,16 @@ endif
 ifdef DEBUG
 CFLAGS    ?= -g -Wall -DDEBUG
 LDFLAGS   ?= -g
-STRIP     ?= :
 else
+CFLAGS    ?= -O2 -Wall
+LDFLAGS   ?= -s
+endif
+
 ifdef DONTSTRIP
-CFLAGS    ?= -O2 -g
-LDFLAGS   ?= -g
 STRIP     ?= :
 else
-CFLAGS    ?= -O2 -Wall
-LDFLAGS   ?= -s
 STRIP     ?= strip --strip-debug
 endif
-endif
 
 CC        ?= gcc
 CXX       ?= g++

