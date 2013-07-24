From: Ian Kent <raven@themaw.net>
Subject: [PATCH 6/9] autofs-5.0.7 - remove hard-coded STRIP variable
Date: Wed, 24 Jul 2013 16:53:42 +0800
Message-ID: <20130724085341.3884.81155.stgit@perseus.fritz.box>
References: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=H1lvJDRZQ2gWiMUgSCHKP23luIQ=; b=iKDLZiWRLJU2VgB21Bff5i+s7+cL
	z/f3Bm4Ao0Zgg1tJiXABOLyQ4RraAdoDpdxT5Zm1yAXjhiYkjxF0IpsHDB0+y729
	jWIjw9gEHnOrZWRauY6mZ+ew7cIgebo+sa1Y2Gz2oE24MLnfSGDU/T/8qk9ZJRX9
	42Au6DCWyK180Nw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=H1lvJDRZQ2gWiMUgSCHKP2
	3luIQ=; b=RxgAJGia8zHUeUPGqektXKJj4gTqcSVLuSwVWcnUuqfYhftP3GX4Wl
	GNAFbXFoL+BHgn9PUFdfV9tUL52ezaVd9md1siQVt48RqexjRvHi8XTNyarx6syU
	wyiNqu4V7kBEqhn15j/4cKZ7rNnjyhmFNZ47g6T5dAfuK0pH4MrqI=
In-Reply-To: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

From: Lan Yixun (dlan) <dennis.yxun@gmail.com>

according to autoconf manual[1], build script should allow user override the CFLAGS, LDFLAGS
varible (passed via ./configure). And actually, we should not directly use CFLAGS,
LDFLAGS, but have to create another one (eg. AUTOFS_CFLAGS). FYI, see section "Variable: CFLAGS",
the last paragraph.

Here, I slightly modify the code so that we can still fallback to the default one.

[1] http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Preset-Output-Variables.html#Preset-Output-Variables

Edited by: Ian Kent <raven@themaw.net>
- allow for previous LDFLAGS patch.
- rename patch to reflect what's actually done but leave the original
  description in place as a reminder.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 CHANGELOG      |    1 +
 Makefile.rules |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index ebabf21..a0af868 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -62,6 +62,7 @@
 - fix dead LDAP symbolic link when LDAP support is disabled.
 - add missing libtirpc lib to mount_nfs.so when TIRPC enabled.
 - use compiler determined by configure instead of hard-coded ones.
+- remove hard-coded STRIP variable.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/Makefile.rules b/Makefile.rules
index 9aebd19..d00ba3c 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -25,16 +25,16 @@ endif
 ifdef DEBUG
 CFLAGS    ?= -g -Wall -DDEBUG
 LDFLAGS   ?= -g
-STRIP     = :
+STRIP     ?= :
 else
 ifdef DONTSTRIP
 CFLAGS    ?= -O2 -g
 LDFLAGS   ?= -g
-STRIP     = :
+STRIP     ?= :
 else
 CFLAGS    ?= -O2 -Wall
 LDFLAGS   ?= -s
-STRIP     = strip --strip-debug
+STRIP     ?= strip --strip-debug
 endif
 endif
 

