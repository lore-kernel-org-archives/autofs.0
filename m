From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/10] autofs4 - fix sparse warning
	in	waitq.c:autofs4_expire_indirect()
Date: Thu, 12 Jun 2008 12:50:53 +0800
Message-ID: <20080612045053.25151.70437.stgit@raven.themaw.net>
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

Re-order some code in expire.c:autofs4_expire_indirect() to avoid compile
warning, reported by Harvey Harrison:

 CHECK   fs/autofs4/expire.c
fs/autofs4/expire.c:383:2: warning: context imbalance in
'autofs4_expire_indirect' - unexpected unlock

---

 fs/autofs4/expire.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)


diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index d96e5c1..cfa12db 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -333,7 +333,7 @@ static struct dentry *autofs4_expire_indirect(struct super_block *sb,
 			/* Can we expire this guy */
 			if (autofs4_can_expire(dentry, timeout, do_now)) {
 				expired = dentry;
-				break;
+				goto found;
 			}
 			goto next;
 		}
@@ -352,7 +352,7 @@ static struct dentry *autofs4_expire_indirect(struct super_block *sb,
 				inf->flags |= AUTOFS_INF_EXPIRING;
 				spin_unlock(&sbi->fs_lock);
 				expired = dentry;
-				break;
+				goto found;
 			}
 			spin_unlock(&sbi->fs_lock);
 		/*
@@ -363,7 +363,7 @@ static struct dentry *autofs4_expire_indirect(struct super_block *sb,
 			expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
 			if (expired) {
 				dput(dentry);
-				break;
+				goto found;
 			}
 		}
 next:
@@ -371,18 +371,16 @@ next:
 		spin_lock(&dcache_lock);
 		next = next->next;
 	}
-
-	if (expired) {
-		DPRINTK("returning %p %.*s",
-			expired, (int)expired->d_name.len, expired->d_name.name);
-		spin_lock(&dcache_lock);
-		list_move(&expired->d_parent->d_subdirs, &expired->d_u.d_child);
-		spin_unlock(&dcache_lock);
-		return expired;
-	}
 	spin_unlock(&dcache_lock);
-
 	return NULL;
+
+found:
+	DPRINTK("returning %p %.*s",
+		expired, (int)expired->d_name.len, expired->d_name.name);
+	spin_lock(&dcache_lock);
+	list_move(&expired->d_parent->d_subdirs, &expired->d_u.d_child);
+	spin_unlock(&dcache_lock);
+	return expired;
 }
 
 /* Perform an expiry operation */
