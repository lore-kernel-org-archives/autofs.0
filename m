From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - fix false positive compile error
Date: Wed, 25 Jun 2014 20:49:39 +0800
Message-ID: <20140625124939.31035.84884.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:from:to:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=GbLCHwP4PR0gMQMgW0qcNEa
	ZyWA=; b=xUfWg3KSq9Q8PgYj+15h8mjx5codkM2tUeCzro0Bm2jY1xIZFZOHoOI
	Mwut4aWEOSSSAIbT4KKR7K4gNw624UJgEwx2rnDRXOS0CvB0wqHLUTLQ0qhmhYL6
	/S2DE6G+rxC5Ex44XpcRZLT/ALONS7qZTgEz8BlkUSnBOYr+eppM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:from:to:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=GbLCHwP4PR0gMQMgW0qcNEaZyWA=; b=czYnh/He0hJZgVU5+Xlo7zYT6sQT
	+xDugODg0TXa8ZzrXn4F7JXQrXSB/CRWzeHxNybSnwD8Jqu/D0/z57Ao8Nat7iTg
	tgoOd5RIoUBed0VHNUhw0gfN7QXHF8HGgiFLpjtiQJVGIsKvOIn8hH4zDuYAS4hZ
	wkury1izZdCNrFw=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On strict build environments we can see:

fs/autofs4/inode.c: In function 'autofs4_fill_super':
fs/autofs4/inode.c:312: error: 'pgrp' may be used uninitialized in this
function
make[2]: *** [fs/autofs4/inode.o] Error 1
make[1]: *** [fs/autofs4] Error 2
make: *** [fs] Error 2
make: *** Waiting for unfinished jobs....

This is due to the use of pgrp_set being used to indicate pgrp has
has been set rather than initializing pgrp itself.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index d7bd395..1c55388 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -210,7 +210,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	int pipefd;
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
-	int pgrp;
+	int pgrp = 0;
 	bool pgrp_set = false;
 	int ret = -EINVAL;
 

