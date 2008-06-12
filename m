From: Ian Kent <raven@themaw.net>
Subject: [PATCH 07/10] autofs4 - don't release directory mutex if
	called in	oz_mode
Date: Thu, 12 Jun 2008 12:51:20 +0800
Message-ID: <20080612045120.25151.62414.stgit@raven.themaw.net>
References: <20080612044425.25151.58126.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080612044425.25151.58126.stgit@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jim Carter <jimc@math.ucla.edu>, autofs mailing list <autofs@linux.kernel.org>

Since we now delay hashing of dentrys until the ->mkdir() call,
droping and re-taking the directory mutex within the ->lookup()
function when we are being called by user space is not needed.
This can lead to a race when other processes are attempting to
access the same directory during mount point directory creation.

In this case we need to hang onto the mutex to ensure we don't
get user processes trying to create a mount request for a newly
created dentry after the mount point entry has already been
created. This ensures that when we need to check a dentry passed
to autofs4_wait(), if it is hashed, it is always the mount point
dentry and not a new dentry created by another lookup during
directory creation.

---

 fs/autofs4/root.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)


diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index a415ebd..8a94717 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -681,12 +681,11 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
 		spin_unlock(&dentry->d_lock);
-	}
-
-	if (dentry->d_op && dentry->d_op->d_revalidate) {
-		mutex_unlock(&dir->i_mutex);
-		(dentry->d_op->d_revalidate)(dentry, nd);
-		mutex_lock(&dir->i_mutex);
+		if (dentry->d_op && dentry->d_op->d_revalidate) {
+			mutex_unlock(&dir->i_mutex);
+			(dentry->d_op->d_revalidate)(dentry, nd);
+			mutex_lock(&dir->i_mutex);
+		}
 	}
 
 	/*
