From: Ian Kent <raven@themaw.net>
Subject: [PATCH 01/10] autofs4 - check for invalid dentry in getpath
Date: Thu, 12 Jun 2008 12:50:48 +0800
Message-ID: <20080612045048.25151.55358.stgit@raven.themaw.net>
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

Catch invalid dentry when calculating its path.

When autofs4_getpath() is called without the BKL (as it is when called
via ->unlocked_ioctl) it is possible to encounter a dentry that is in
the process of being freed which has a zero length name.

---

 fs/autofs4/waitq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 1fe28e4..75e5955 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -171,7 +171,7 @@ static int autofs4_getpath(struct autofs_sb_info *sbi,
 	for (tmp = dentry ; tmp != root ; tmp = tmp->d_parent)
 		len += tmp->d_name.len + 1;
 
-	if (--len > NAME_MAX) {
+	if (!len || --len > NAME_MAX) {
 		spin_unlock(&dcache_lock);
 		return 0;
 	}
