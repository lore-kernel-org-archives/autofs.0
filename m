From: Dan Carpenter <error27@gmail.com>
Subject: [patch] unlock_kernel() in autofs
Date: Tue, 7 Apr 2009 10:53:00 +0300 (EAT)
Message-ID: <alpine.DEB.2.00.0904070829180.522@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: hpa@zytor.com
Cc: autofs@linux.kernel.org

There are a couple missing unlock_kernel() calls on error paths in autofs 
version 2.6.29.

Found by smatch (http://repo.or.cz/w/smatch.git).  Compile tested.

regards,
dan carpenter

Signed-off-by: Dan Carpenter <error27@gmail.com>

--- orig/fs/autofs/root.c	2009-04-07 08:24:53.000000000 +0300
+++ devel/fs/autofs/root.c	2009-04-07 08:27:35.000000000 +0300
@@ -334,8 +334,10 @@
 	autofs_hash_insert(dh,ent);
 
 	inode = autofs_iget(dir->i_sb, ent->ino);
-	if (IS_ERR(inode))
+	if (IS_ERR(inode)) {
+		unlock_kernel();
 		return PTR_ERR(inode);
+	}
 
 	d_instantiate(dentry, inode);
 	unlock_kernel();
@@ -480,6 +482,7 @@
 	inode = autofs_iget(dir->i_sb, ino);
 	if (IS_ERR(inode)) {
 		drop_nlink(dir);
+		unlock_kernel();
 		return PTR_ERR(inode);
 	}
