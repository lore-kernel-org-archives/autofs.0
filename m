From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/2] autofs - Fix sparse warning: context imbalance in
 autofs4_d_automount() different lock contexts for basic block
Date: Fri, 01 Mar 2013 19:46:40 +0800
Message-ID: <20130301114639.28560.27407.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=qLdca00Op46vlAu3cHCjV64
	DOd8=; b=ZqbMK7wPB53mUdbKMfMUwmHQCGMsgZJShTIH+MVXiwB2IwB7elGvmIR
	+Xy6hqrpEm2q5f4VRgySXNpDNUkHTSiWmJRtXtAHjeoz0Q+lrWVGacwWlX7o8Xyk
	zzJBIHgrsrPV65mxriwcVwPJ9dWVQ+KizxBhxEmDUJVW7eJ02z2o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=qLdca00Op46vlAu3cHCjV64DOd8=; b=M5g1hMZUAJvk8/HoVI6kn53Oujyo
	7vmOKGcvXorvafgYYdoohufX+6KwLizWuBQHKs1SpqnolfaFpksBOVJQDd8LcQoC
	3E3tVMdmAGD6mr22Z2B6V1+ZIiKGjLrvTHX+fJBgPJVA1f5mG0GB6rYkXdqej+1u
	gL7lGsQ6Cc6UN3o=
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Peter Huewe <peterhuewe@gmx.de>

Sparse complains:
+ fs/autofs4/root.c:409:9: sparse: context imbalance in
'autofs4_d_automount' - different lock contexts for basic block

This was introduced by commit
f55fb0c243 autofs4 - dont clear DCACHE_NEED_AUTOMOUNT on rootless mount

The function autofs4_d_automount can be left with the (&sbi->fs_lock)
held if sbi->version <= 4 and simple_empty(dentry) == false so the warning seems valid.

--> Add an spin_unlock in this case before we jump to done

Unfortunately compile tested only.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
Acked-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/root.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 230bd2a..9bd1625 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -383,8 +383,10 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 				goto done;
 			}
 		} else {
-			if (!simple_empty(dentry))
+			if (!simple_empty(dentry)) {
+				spin_unlock(&sbi->fs_lock);
 				goto done;
+			}
 		}
 		ino->flags |= AUTOFS_INF_PENDING;
 		spin_unlock(&sbi->fs_lock);

