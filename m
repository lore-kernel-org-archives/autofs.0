From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - remove autofs dentry mount check
Date: Wed, 03 Apr 2013 11:10:53 +0800
Message-ID: <20130403031052.26816.9163.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=trUGZrWh086EIRIWph0nYKI
	54e0=; b=q8NhpzoCWt+ZHy4OJR6gXqLf1nDPMDuFgxljWoL0x0GRf7fuseNEtKz
	jp9mdRpVN8Rw1ga06COKQwgyx9uDzvpWBvH3q+F7wDjbY7IyMRLPfBK3hyA0eTOA
	JWINP4hBeAY7J2YiwFa2+4FlX28yBYZUtVlPEU6Fij8R+QQylb/Q=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=trUGZrWh086EIRIWph0nYKI54e0=; b=u1dwP3//ccyS4U1gyzTCdGGoxc2F
	oo8UaS9/IOBUdLXRSs8KqZfoLmGXHyErVWBUQoL8Pe2Uyk7MtuDT1V8+79dgRHT1
	es1YZ8jLaeSyxchas7rpZPohs9YmqF2e1FKR4uiDazDm3BVmNOkjlB/P0gsmmqup
	L4am8vwJ7rdqQPk=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, David Jeffery <djeffery@redhat.com>

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

