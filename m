From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/5] autofs4 - dont make expiring dentry negative fix
Date: Tue, 01 Jul 2008 17:25:58 +0800
Message-ID: <20080701092557.12041.32586.stgit@raven.themaw.net>
References: <20080701092548.12041.69868.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080701092548.12041.69868.stgit@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

The correction to not make a dentry negative has an error.
Currently ->lookup() checks if an expire is in progress and removes
the entry from the list, before the expire is complete so if more
than one process is performing a lookup at this time only one will
wait for expire completion. We need to not remove the list entry
until after waiting for expire completion.

Signed-off-by: Ian Kent <raven@themaw.net>

---

 fs/autofs4/root.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)


diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 10add99..2a1a631 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -591,7 +591,6 @@ static struct dentry *autofs4_lookup_expiring(struct autofs_sb_info *sbi, struct
 			goto next;
 
 		if (d_unhashed(dentry)) {
-			list_del_init(&ino->expiring);
 			dget(dentry);
 			spin_unlock(&dentry->d_lock);
 			spin_unlock(&sbi->lookup_lock);
@@ -643,6 +642,10 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
 			autofs4_wait(sbi, expiring, NFY_NONE);
 			DPRINTK("request completed");
 		}
+		spin_lock(&sbi->lookup_lock);
+		if (!list_empty(&ino->expiring))
+			list_del_init(&ino->expiring);
+		spin_unlock(&sbi->lookup_lock);
 		dput(expiring);
 	}
 
