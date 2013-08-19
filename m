From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/25] autofs-5.0.7 - fix a couple of compiler warnings
Date: Mon, 19 Aug 2013 09:12:06 +0800
Message-ID: <20130819011205.6472.98246.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=5eVH563aLRWgwVLPbUXcN9nzZnw=; b=ILuAi6jS8O/kX66TXXnuMeylAxd0
	VbgL+6QGnEy53RbdFFPILi0uQlE1dQl7FJ7BCseW2yerOqNxUems1Bys5YKZ/H+t
	njwaxCaXDPbedmM3E7IAkIc0wQ4wZOxBiH6BcUAjNfHLBQZlaf1MtoDuiqj+IjUw
	G+nzFlH8drifjrA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=5eVH563aLRWgwVLPbUXcN9
	nzZnw=; b=Ns4sr0Ty7EsugstrFOs6tHu/MrlGgxvP5Q1K6ce8EJNkLXxzV2/PTX
	SfdxEBxQ+XAm/WtNkoS2s3qLwLGLK4mHDd3k18EgxPSBTQWmFSbIoLCmhgYLIF5/
	7etWIfShoJPHkA5gdLfDNTX43Rya0GSTCf1oT1XIUUytI7AnFjJmQ=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

From: Ian Kent <ikent@redhat.com>

Quiet a couple of ompiler warnings by making intention explicit using brackets.
---
 CHANGELOG            |    1 +
 modules/mount_bind.c |    2 +-
 modules/mount_nfs.c  |    4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 37eac72..7749f01 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -54,6 +54,7 @@
 - misc man page fixes.
 - fix add null check in parse_server_string().
 - don't override LDFLAGS in make rules.
+- fix a couple of compiler warnings.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/modules/mount_bind.c b/modules/mount_bind.c
index 61a773c..2b70104 100644
--- a/modules/mount_bind.c
+++ b/modules/mount_bind.c
@@ -208,7 +208,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 			      MODPREFIX
 			      "failed to create local mount %s -> %s",
 			      fullpath, what);
-			if (ap->flags & MOUNT_FLAG_GHOST && !status)
+			if ((ap->flags & MOUNT_FLAG_GHOST) && !status)
 				if (mkdir_path(fullpath, 0555) && errno != EEXIST) {
 					char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 					error(ap->logopt,
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 3d2ccea..adf2002 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -202,8 +202,8 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	 */
 	if ((hosts && !hosts->next) &&
 	    mount_default_proto == 4 &&
-	    vers & NFS_VERS_MASK != 0 &&
-	    vers & NFS4_VERS_MASK != 0) {
+	    (vers & NFS_VERS_MASK) != 0 &&
+	    (vers & NFS4_VERS_MASK) != 0) {
 		unsigned int v4_probe_ok = 0;
 		struct host *tmp = new_host(hosts->name,
 					    hosts->addr, hosts->addr_len,

