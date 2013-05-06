From: Ian Kent <raven@themaw.net>
Subject: [REPOST PATCH] autofs - remove autofs dentry mount check
Date: Mon, 06 May 2013 13:49:30 +0800
Message-ID: <20130506054929.6107.5469.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=trUGZrWh086EIRIWph0nYKI
	54e0=; b=Znk0yoXHiF9Wvnasnd47aDJhp3TRLKWNL21iOcrtn8lWQSZEJ1VKCQ0
	pU61W/csSHK7yAfIZmZ0SvlEnH2vuHv1Rb7bx+VMRjPNf7giZwB1FE6Z273plyOZ
	XMda7Zt/QMXTvgBfIzpR5tf9Efg+WE/A57amEzthiNXZp29Pxd5c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=trUGZrWh086EIRIWph0nYKI54e0=; b=FHnaKR5vS1Xa+87QMLB0lKe4x9oD
	ksod0tcv6/kq6iayAFjDer4RHHpW/Jr9KuglcNDBaysWwIpGIN/VCSMho5+GU3H8
	yIzcuLgaimBeFkMfjYnHVe/0Do1lL1ShvWdF7z+wLyODggGxBl3qeOBEF8oJEaLJ
	9YQ+cer3E+upU54=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, David Jeffery <djeffery@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org

From: David Jeffery <djeffery@redhat.com>

When checking if an autofs mount point is busy it isn't sufficient to
only check if it's a mount point.

For example, if the mount of an offset mountpoint in a tree is denied
for this host by its export and the dentry becomes a process working
directory the check incorrectly returns the mount as not in use at expire.

This can happen since the default when mounting within a tree is nostrict,
which means ingnore mount fails on mounts within the tree and continue. The
nostrict option is meant to allow mounting in this case.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Cc: stable@vger.kernel.org
---
 fs/autofs4/expire.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 01443ce..13ddec9 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -61,15 +61,6 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 		/* This is an autofs submount, we can't expire it */
 		if (autofs_type_indirect(sbi->type))
 			goto done;
-
-		/*
-		 * Otherwise it's an offset mount and we need to check
-		 * if we can umount its mount, if there is one.
-		 */
-		if (!d_mountpoint(path.dentry)) {
-			status = 0;
-			goto done;
-		}
 	}
 
 	/* Update the expiry counter if fs is busy */

