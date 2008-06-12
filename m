From: Ian Kent <raven@themaw.net>
Subject: [PATCH 03/10] autofs4 - fix incorrect return
	from	root.c:try_to_fill_dentry()
Date: Thu, 12 Jun 2008 12:50:58 +0800
Message-ID: <20080612045058.25151.69743.stgit@raven.themaw.net>
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

From: Jeff Moyer <jmoyer@redhat.com>

Jeff Moyer has identified a case where the autofs4 function

root.c:try_to_fill_dentry() can return -EBUSY when it should return 0.

Jeff's description of the way this happens is:

"automount starts an expire for directory d.  after the callout to the daemon,
but before the rmdir, another process tries to walk into the same directory.
It puts itself onto the waitq, pending the expiration.

When the expire finishes, the second process is woken up.  In
try_to_fill_dentry, it does this check:

                status = d_invalidate(dentry);
                if (status != -EBUSY)
                        return -EAGAIN;

And status is EBUSY.  The dentry still has a non-zero d_inode, and the
flags do not contain LOOKUP_CONTINUE or LOOKUP_DIRECTORY

So, we fall through and return -EBUSY to the caller."

---

 fs/autofs4/root.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 2bbcc81..2c5dfe8 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -242,7 +242,7 @@ static int try_to_fill_dentry(struct dentry *dentry, int flags)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
-	int status = 0;
+	int status;
 
 	/* Block on any pending expiry here; invalidate the dentry
            when expiration is done to trigger mount request with a new
@@ -318,7 +318,7 @@ static int try_to_fill_dentry(struct dentry *dentry, int flags)
 	spin_lock(&dentry->d_lock);
 	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
 	spin_unlock(&dentry->d_lock);
-	return status;
+	return 1;
 }
 
 /* For autofs direct mounts the follow link triggers the mount */
