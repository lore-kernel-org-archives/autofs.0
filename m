From: David Howells <dhowells@redhat.com>
Subject: Autofs vs shrink_dcache_for_umount() problem
Date: Fri, 30 Jun 2006 12:31:41 +0100
Message-ID: <22007.1151667101@warthog.cambridge.redhat.com>
References: <20060630032426.671acfac.akpm@osdl.org>
	<20060630030950.d9c75915.akpm@osdl.org>
	<12824.1151661289@warthog.cambridge.redhat.com>
	<200606300729.k5U7TXbs030525@shell0.pdx.osdl.net>
	<15084.1151661496@warthog.cambridge.redhat.com>
	<28248.1151662595@warthog.cambridge.redhat.com>
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060630032426.671acfac.akpm@osdl.org> 
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
Cc: David Howells <dhowells@redhat.com>, neilb@suse.de, aviro@redhat.com, autofs@linux.kernel.org, raven@themaw.net

Andrew Morton <akpm@osdl.org> wrote:

> But why was yum (or an RPM script) dinking with loop and
> mounting/unmounting things?

It may have restarted the automounter... this may cause mounts and unmounts...

I've done a bit of probing, and when both ext3 and NFS go into the superblock
squidger with a tree that only has a root dentry, that root dentry has a usage
count of 1:

	### Shrink root c629b088{1}
	-->shrink_dcache_for_umount_subtree(c629b088)
	- AT c629b088{0}
	  - consume c629b088{0}
	### Shrunk


	### Shrink root c621d710{1}
	-->shrink_dcache_for_umount_subtree(c621d710)
	- AT c621d710{0}
	  - consume c621d710{0}
	### Shrunk

But when autofs4 goes in there with a minimal tree:

	### Shrink root c6b714b0{2}
	-->shrink_dcache_for_umount_subtree(c6b714b0)
	- AT c6b714b0{1}
	  - consume c6b714b0{1}
	BUG: Dentry c6b714b0{i=1a80,n=/} still in use (1) [unmount of autofs autofs]
	------------[ cut here ]------------
	kernel BUG at fs/dcache.c:618!

It's got a usage count of *2*.  That means the root dentry is still in use
somewhere beyond the superblock s_root reference.

I think this in autofs4_fill_super() is the problem:

	/*
	 * Take a reference to the root dentry so we get a chance to
	 * clean up the dentry tree on umount.
	 * See autofs4_force_release.
	 */
	sbi->root = dget(root);

autofs4 violates the assumptions that I was told I could make.  autofs4
expects to clean up its dentries in autofs4_put_super(), when it should
perhaps really be overloading the kill_sb() op and doing it before calling
kill_anon_super().

I've attached the pair of debugging patches I used to generate the above.

David


diff --git a/fs/dcache.c b/fs/dcache.c
index 4fddd12..ae041da 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -597,7 +597,20 @@ static void shrink_dcache_for_umount_sub
 		do {
 			struct inode *inode;
 
-			BUG_ON(atomic_read(&dentry->d_count) != 0);
+			if (atomic_read(&dentry->d_count) != 0) {
+				printk(KERN_ERR
+				       "BUG: Dentry %p{i=%lx,n=%s}"
+				       " still in use (%d)"
+				       " [unmount of %s %s]\n",
+				       dentry,
+				       dentry->d_inode ?
+				       dentry->d_inode->i_ino : 0UL,
+				       dentry->d_name.name,
+				       atomic_read(&dentry->d_count),
+				       dentry->d_sb->s_type->name,
+				       dentry->d_sb->s_id);
+				BUG();
+			}
 
 			parent = dentry->d_parent;
 			if (parent == dentry)


diff --git a/fs/dcache.c b/fs/dcache.c
index ae041da..61159d2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -558,6 +558,8 @@ static void shrink_dcache_for_umount_sub
 
 	BUG_ON(!IS_ROOT(dentry));
 
+	printk("-->shrink_dcache_for_umount_subtree(%p)\n", dentry);
+
 	/* detach this root from the system */
 	spin_lock(&dcache_lock);
 	if (!list_empty(&dentry->d_lru)) {
@@ -568,6 +570,8 @@ static void shrink_dcache_for_umount_sub
 	spin_unlock(&dcache_lock);
 
 	for (;;) {
+		printk("- AT %p{%d}\n", dentry, atomic_read(&dentry->d_count));
+
 		/* descend to the first leaf in the current subtree */
 		while (!list_empty(&dentry->d_subdirs)) {
 			struct dentry *loop;
@@ -590,6 +594,8 @@ static void shrink_dcache_for_umount_sub
 			/* move to the first child */
 			dentry = list_entry(dentry->d_subdirs.next,
 					    struct dentry, d_u.d_child);
+
+			printk("- descend %p{%d}\n", dentry, atomic_read(&dentry->d_count));
 		}
 
 		/* consume the dentries from this leaf up through its parents
@@ -643,6 +649,7 @@ #endif
 				return;
 
 			dentry = parent;
+			printk("- ascend %p{%d}\n", dentry, atomic_read(&dentry->d_count));
 
 		} while (list_empty(&dentry->d_subdirs));
 
@@ -671,13 +678,17 @@ void shrink_dcache_for_umount(struct sup
 
 	dentry = sb->s_root;
 	sb->s_root = NULL;
+	printk("### Shrink root %p{%d}\n", dentry, atomic_read(&dentry->d_count));
 	atomic_dec(&dentry->d_count);
 	shrink_dcache_for_umount_subtree(dentry);
 
 	while (!hlist_empty(&sb->s_anon)) {
+		printk("### Shrink anon\n");
 		dentry = hlist_entry(sb->s_anon.first, struct dentry, d_hash);
 		shrink_dcache_for_umount_subtree(dentry);
 	}
+
+	printk("### Shrunk\n");
 }
 
 /*
