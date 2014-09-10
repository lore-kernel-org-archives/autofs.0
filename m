From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - remove obsolete d_invalidate() from expire
Date: Wed, 10 Sep 2014 09:56:22 +0800
Message-ID: <20140910015622.4059.66829.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:from:to:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=9SIBlcxqlFtCo/jM0GL7pWK
	oihg=; b=krMEO4bjFjjAkpcLFMl36nx2kHZQcpoUfql+s0EnfITL0EQ6cwaFEJ5
	vQs2VaMKyU/2MnDedK4jP3jvA5DtURCArS6uSCLgwRqZBhJp3wFBKs+rrjsBk8Hp
	x1bJb1dE+hFlCmRg3e4DzhtJZ/feraPL0/vfPhu7BP172KtMnhqM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:from:to:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=9SIBlcxqlFtCo/jM0GL7pWKoihg=; b=RjihNVKaVB11nilkSjaPVSTx6slY
	echs0NP5jMq9eg1uthD0xqGiaAR+tm6M9xD2KkVD+dwc51ju1Uz6XZ2d9VOgYSiq
	u1sPDQoFploec3aCiJ43GuEkT0O+oFfhWiSxutLfuDJBzZgYNATZb0iti/w6uQQX
	jECTO0bJ5kVlyEM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>

Biederman's commit c4625721f changes d_invalidate() to sumarily remove
mounts under the passed in dentry regardless of whether they are busy
or not. So calling this in fs/autofs4/expire.c:autofs4_tree_busy() is
definitely the wrong thing to do becuase it will silently umount entries
instead of just cleaning stale dentrys.

But this call shouldn't be needed and testing shows that automounting
continues to function without it.

As Al Viro correctly surmises the original intent of the call was to
perform what shrink_dcache_parent() does.

If at some time in the future I see stale dentries accumulating
following failed mounts I'll revisit the issue and possibly add a
shrink_dcache_parent() call if needed.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/autofs4/expire.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index d97a761..b45fe2c 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -249,12 +249,6 @@ static int autofs4_tree_busy(struct vfsmount *mnt,
 			struct autofs_info *ino = autofs4_dentry_ino(p);
 			unsigned int ino_count = atomic_read(&ino->count);
 
-			/*
-			 * Clean stale dentries below that have not been
-			 * invalidated after a mount fail during lookup
-			 */
-			d_invalidate(p);
-
 			/* allow for dget above and top is already dgot */
 			if (p == top)
 				ino_count += 2;
