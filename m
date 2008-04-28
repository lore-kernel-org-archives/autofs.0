From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - fix compile warning in waitq.c:autofs4_expire_indirect()
Date: Mon, 28 Apr 2008 14:19:06 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0804281417080.10684@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


Hi Andrew,

This patch re-orders some code in expire.c:autofs4_expire_indirect()
to avoid compile warning, reported by Harvey Harrison:

 CHECK   fs/autofs4/expire.c
fs/autofs4/expire.c:383:2: warning: context imbalance in
'autofs4_expire_indirect' - unexpected unlock

Signed-off-by: Ian Kent <raven@themaw.net>

---
diff -up linux-2.6.25-mm1/fs/autofs4/expire.c.cleanup-expire-indirect linux-2.6.25-mm1/fs/autofs4/expire.c
--- linux-2.6.25-mm1/fs/autofs4/expire.c.cleanup-expire-indirect	2008-04-28 11:38:55.000000000 +0800
+++ linux-2.6.25-mm1/fs/autofs4/expire.c	2008-04-28 11:39:17.000000000 +0800
@@ -333,7 +333,7 @@ static struct dentry *autofs4_expire_ind
 			/* Can we expire this guy */
 			if (autofs4_can_expire(dentry, timeout, do_now)) {
 				expired = dentry;
-				break;
+				goto found;
 			}
 			goto next;
 		}
@@ -352,7 +352,7 @@ static struct dentry *autofs4_expire_ind
 				inf->flags |= AUTOFS_INF_EXPIRING;
 				spin_unlock(&sbi->fs_lock);
 				expired = dentry;
-				break;
+				goto found;
 			}
 			spin_unlock(&sbi->fs_lock);
 		/*
@@ -363,7 +363,7 @@ static struct dentry *autofs4_expire_ind
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
