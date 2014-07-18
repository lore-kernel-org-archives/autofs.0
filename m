From: NeilBrown <neilb@suse.de>
Subject: [PATCH 5/5] autofs4: comment typo: remove a a doubled word.
Date: Fri, 18 Jul 2014 10:48:28 +1000
Message-ID: <20140718004828.19389.95882.stgit@notabene.brown>
References: <20140718004353.19389.48104.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140718004353.19389.48104.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

Signed-off-by: NeilBrown <neilb@suse.de>
Acked-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/root.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index fb202cadd4b3..cdb25ebccc4c 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -377,7 +377,7 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 		 * this because the leaves of the directory tree under the
 		 * mount never trigger mounts themselves (they have an autofs
 		 * trigger mount mounted on them). But v4 pseudo direct mounts
-		 * do need the leaves to to trigger mounts. In this case we
+		 * do need the leaves to trigger mounts. In this case we
 		 * have no choice but to use the list_empty() check and
 		 * require user space behave.
 		 */

