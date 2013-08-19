From: Ian Kent <raven@themaw.net>
Subject: [PATCH 12/25] autofs-5.0.7 - remove hard-coded STRIP variable
Date: Mon, 19 Aug 2013 09:13:14 +0800
Message-ID: <20130819011313.6472.89011.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=czGJ6xF4OPAsaZp85G4xmBKwrao=; b=lr1n0FS/uKQDZAoJ86G9zW9dhNyp
	+jSYU+dr6wgux6w/fggxy7Sgi3UM+Z1zc1+PZVDuCv4vKoDU58jiwzA4KCknqqEr
	RecEBpXvyPRafvN1OPvpAHR4Xd+UG9GERJg71M6yXY/7nlm2XNOP3tlGWjRB4LLR
	tshbl8bZ50NERTE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=czGJ6xF4OPAsaZp85G4xmB
	Kwrao=; b=ba7jnFnfjnDRezk9PgYOjXR+OGQFoRO3F1hi9BxRExFeBVWevZnmC7
	wYNNYEDvFkx+bIvcBZP+gOKyrtwLsNoyqO1uOv7hhMcbCdGYe3bYNQBVPiK+JYMH
	iccpWzOOlB+0IOUW+lrT3u5IwsLUCskZYGxcgf1QYIjPYooYtmWk0=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

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
index 8f349a2..ec9d7f0 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -64,6 +64,7 @@
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
 

