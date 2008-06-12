From: Ian Kent <raven@themaw.net>
Subject: [PATCH 04/10] autofs4 - fix mntput, dput order bug
Date: Thu, 12 Jun 2008 12:51:04 +0800
Message-ID: <20080612045104.25151.30461.stgit@raven.themaw.net>
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

Fix a bug in autofs4_mount_busy() where mntput() was called before dput().
This is a hunk taken from an LKML submission by Jan Blunck <jblunck@suse.de>.

---

 fs/autofs4/expire.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index cfa12db..894fee5 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -73,8 +73,8 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 	status = 0;
 done:
 	DPRINTK("returning = %d", status);
-	mntput(mnt);
 	dput(dentry);
+	mntput(mnt);
 	return status;
 }
