From: Ian Kent <raven@themaw.net>
Subject: [PATCH 11/13] autofs4 - rename simple_empty_nolock function
Date: Wed, 18 Jan 2006 15:24:19 +0800
Message-ID: <200601180724.k0I7OJr3006202@eagle.themaw.net>
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org, Kernel Mailing List <linux-kernel@vger.kernel.org>

This patch renames the function simple_empty_nolock to
__simple_empty in line with kernel naming conventions.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-mm3/fs/autofs4/autofs_i.h.rename-simple_empty_nolock	2006-01-13 16:27:45.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/autofs_i.h	2006-01-13 16:28:06.000000000 +0800
@@ -200,7 +200,7 @@ static inline int simple_positive(struct
 	return dentry->d_inode && !d_unhashed(dentry);
 }
 
-static inline int simple_empty_nolock(struct dentry *dentry)
+static inline int __simple_empty(struct dentry *dentry)
 {
 	struct dentry *child;
 	int ret = 0;
--- linux-2.6.15-mm3/fs/autofs4/root.c.rename-simple_empty_nolock	2006-01-13 16:27:09.000000000 +0800
+++ linux-2.6.15-mm3/fs/autofs4/root.c	2006-01-13 16:28:07.000000000 +0800
@@ -343,7 +343,7 @@ static int autofs4_revalidate(struct den
 	spin_lock(&dcache_lock);
 	if (S_ISDIR(dentry->d_inode->i_mode) &&
 	    !d_mountpoint(dentry) && 
-	    simple_empty_nolock(dentry)) {
+	    __simple_empty(dentry)) {
 		DPRINTK("dentry=%p %.*s, emptydir",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
