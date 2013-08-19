From: Ian Kent <raven@themaw.net>
Subject: [PATCH 23/25] autofs-5.0.7 - only probe specific nfs version when
 requested
Date: Mon, 19 Aug 2013 09:14:29 +0800
Message-ID: <20130819011428.6472.91842.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=iyRANf1+Bpg5v6XFlLvx2aCLR9c=; b=cq2uAYi09Nca8XYYRFQzNJi6flz5
	AkeNfUHd0b058r2HDrTnxtNf0l8Ut8uDizzXnVAwlKE9fh1+H5ZNksWun3aPvfF6
	nzM2rBSYBJ8FQiFo6Sinua+6mPNaIbO7d8oLEr0ijS9pcGlNBK77y0oHEFhCJDhK
	eeYzXUNZcdfoWdY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=iyRANf1+Bpg5v6XFlLvx2a
	CLR9c=; b=gSjB0Bts801tw8vCu7ZMZqc+6hRyJUjzCc1DoGR+UGp4+RpNO42SbK
	V4PBu1NdGUquk0PLzjOjLcC2KBEw3EmcIRN9y/Mj8mFLqA0rsRFzxnXs7IWwHNfJ
	cLNGSYmPXvib+uy1O8Aoz+9Fe+HbaSflejhulewTNyCnBcenO7fcI=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

If a specific NFS version is given as an option the set the probe flags
to probe only that version.
---
 CHANGELOG           |    1 +
 modules/mount_nfs.c |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9639703..2499f1c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -74,6 +74,7 @@
 - fix syncronize handle_mounts() shutdown.
 - fix fix wildcard multi map regression.
 - improve timeout option description.
+- only probe specific nfs version if requested.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index adf2002..5a582ef 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -146,7 +146,15 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 				if (strncmp("vers=4", cp, o_len) == 0 ||
 				    strncmp("nfsvers=4", cp, o_len) == 0)
 					vers = NFS4_VERS_MASK | TCP_SUPPORTED;
-				else if (strstr(cp, "port=") == cp &&
+				else if (strncmp("vers=3", cp, o_len) == 0 ||
+					 strncmp("nfsvers=3", cp, o_len) == 0) {
+					vers &= ~(NFS4_VERS_MASK | NFS_VERS_MASK);
+					vers |= NFS3_REQUESTED;
+				} else if (strncmp("vers=2", cp, o_len) == 0 ||
+					 strncmp("nfsvers=2", cp, o_len) == 0) {
+					vers &= ~(NFS4_VERS_MASK | NFS_VERS_MASK);
+					vers |= NFS2_REQUESTED;
+				} else if (strstr(cp, "port=") == cp &&
 					 o_len - 5 < 25) {
 					char optport[25];
 

