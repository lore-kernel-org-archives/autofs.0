From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: subdirs trying to be mounted when using ghosting
Date: Tue, 24 Jan 2006 12:17:31 -0500
Message-ID: <17366.24875.680488.918796@segfault.boston.redhat.com>
References: <43D6589B.6030102@framestore-cfc.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43D6589B.6030102@framestore-cfc.com>
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
Content-Type: text/plain; charset="us-ascii"
To: Johan van den Dorpe <johan.vandendorpe@framestore-cfc.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding [autofs] subdirs trying to be mounted when using ghosting; Johan van den Dorpe <johan.vandendorpe@framestore-cfc.com> adds:

johan.vandendorpe> Hi guys We're having a problem when trying to access a
johan.vandendorpe> subdir of an automount directory that isn't
johan.vandendorpe> mounted. Instead of looking up the mount entry for the
johan.vandendorpe> directory, a subdir is looked up instead. If the exact
johan.vandendorpe> dir of the entry is accessed, then it mounts fine.

Fixed by Ian in more recent kernels.  Patch was something like the
attached, though you'd do better to drop this part, I think:

-		return (dentry->d_time - jiffies <= AUTOFS_NEGATIVE_TIMEOUT);
+		return (dentry->d_time - jiffies <= 0);


-Jeff

diff -Nurp linux-2.6.12.orig/fs/autofs4/expire.c linux-2.6.12/fs/autofs4/expire.c
--- linux-2.6.12.orig/fs/autofs4/expire.c	2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.12/fs/autofs4/expire.c	2005-10-09 15:11:37.000000000 +0800
@@ -177,7 +177,7 @@ resume:
 		DPRINTK("dentry %p %.*s",
 			dentry, (int)dentry->d_name.len, dentry->d_name.name);
 
-		if (!list_empty(&dentry->d_subdirs)) {
+		if (!simple_empty_nolock(dentry)) {
 			this_parent = dentry;
 			goto repeat;
 		}
@@ -269,7 +269,7 @@ static struct dentry *autofs4_expire(str
 			goto next;
 		}
 
-		if ( simple_empty(dentry) )
+		if (simple_empty(dentry))
 			goto next;
 
 		/* Case 2: tree mount, expire iff entire tree is not busy */
diff -Nurp linux-2.6.12.orig/fs/autofs4/root.c linux-2.6.12/fs/autofs4/root.c
--- linux-2.6.12.orig/fs/autofs4/root.c	2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.12/fs/autofs4/root.c	2005-10-09 15:52:04.000000000 +0800
@@ -386,13 +386,13 @@ static int autofs4_revalidate(struct den
 
 	/* Negative dentry.. invalidate if "old" */
 	if (dentry->d_inode == NULL)
-		return (dentry->d_time - jiffies <= AUTOFS_NEGATIVE_TIMEOUT);
+		return (dentry->d_time - jiffies <= 0);
 
 	/* Check for a non-mountpoint directory with no contents */
 	spin_lock(&dcache_lock);
 	if (S_ISDIR(dentry->d_inode->i_mode) &&
 	    !d_mountpoint(dentry) && 
-	    list_empty(&dentry->d_subdirs)) {
+	    simple_empty_nolock(dentry)) {
 		DPRINTK("dentry=%p %.*s, emptydir",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
