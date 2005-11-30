From: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 30 Nov 2005 08:49:21 -0800
Message-ID: <1133369361.27824.61.camel@localhost.localdomain>
References: <20051116101740.GA9551@RAM>
	 <Pine.LNX.4.63.0511271807100.2406@donald.themaw.net>
	 <438B3C34.2050509@us.ibm.com>
	 <1133219572.27824.24.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0511290918060.26303@wombat.indigo.net.au>
	 <438C82FB.50706@us.ibm.com>
	 <Pine.LNX.4.58.0511300850450.32520@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-R2xtBjPxUpVCJ73yHc/E"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0511300850450.32520@wombat.indigo.net.au>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: "William H. Taber" <wtaber@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>, smaneesh@in.ibm.com


--=-R2xtBjPxUpVCJ73yHc/E
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-11-30 at 09:02 -0500, Ian Kent wrote:
> On Tue, 29 Nov 2005, William H. Taber wrote:
> 
> > Ian Kent wrote:
> > > We'll need to do an analysis of all callers of the revalidate method.
> > You are right. Searching through the sources, it would appear that I 
> > missed fixing autofs and devfs.  Everyone else just defines a revalidate 
> > routine but doesn't call one.  You may find devfs to be interesting 
> > because they have code to determine whether they need to release the 
> > i_sem lock or not.  I am working on an updated patch to include the 
> > changes needed for these two modules.
> 
> I've looked at devfs before but that bit of code sounds interesting to me.
> 
> The other thing that concerns me is that we may be increasing the latency 
> of some code paths that need to be really fast. I was thinking that 
> perhaps it might be good to try a change more in line with the locking 
> used in link_patch_walk (ie. i_sem free revalidate) rather than that used 
> in lookup_one_len. My only justification being that lookup is called to 
> create stuff where revalidate is called to check stuff. I've been 
> poking around and this change looks fairly difficult as well (I seem to 
> remember you also looked at this).
> 
> Anyway, I'm keen to have a look at your patch.
> Thanks much for your interest and help.
> 
> Ian
> 

Again, I am posting Will's latest patch on his behalf.

Any thoughts on how acceptable are the VFS changes ?

Thanks,
Badari



--=-R2xtBjPxUpVCJ73yHc/E
Content-Disposition: attachment; filename=newautofs.patch
Content-Type: text/x-patch; name=newautofs.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch changes the semantics of d_revalidate so that it is always called
with the parent i_sem lock held.  This allows the autofs4 code to release the
lock if it needs to pend.  Without this patch the autofs has a race condition
in which it pends in the revalidate code while holding the parent i_sem lock
which prevents the mount from ever completing.  There have been other patches
proposed for this problem which check to see if the parent i_sem lock is held
before releasing it but those solutions ignore the possibility that the lock
may be held by another process.

This patch has been expanded to include changes to autofs and devfs.  The 
autofs changes mimic the changes to autofs4 in the original patch.  The devfs
changes remove the checking it did to try to determine where it was called 
from so that it could get its locking right.

diff -ur -x '*.orig' -x '*.new' linux-2.6.13.3/fs/autofs/root.c linux-2.6.13.3-autofspatch/fs/autofs/root.c
--- linux-2.6.13.3/fs/autofs/root.c	2005-10-03 16:27:35.000000000 -0700
+++ linux-2.6.13.3-autofspatch/fs/autofs/root.c	2005-11-29 03:58:24.000000000 -0800
@@ -104,7 +104,9 @@
 				/* Return a negative dentry, but leave it "pending" */
 				return 1;
 			}
+			up(&dentry->d_parent->d_inode->i_sem);
 			status = autofs_wait(sbi, &dentry->d_name);
+			down(&dentry->d_parent->d_inode->i_sem);
 		} while (!(ent = autofs_hash_lookup(&sbi->dirhash, &dentry->d_name)) );
 	}
 
@@ -124,7 +126,10 @@
 	/* If this is a directory that isn't a mount point, bitch at the
 	   daemon and fix it in user space */
 	if ( S_ISDIR(dentry->d_inode->i_mode) && !d_mountpoint(dentry) ) {
-		return !autofs_wait(sbi, &dentry->d_name);
+		up(&dentry->d_parent->d_inode->i_sem);
+		status = !autofs_wait(sbi, &dentry->d_name);
+		down(&dentry->d_parent->d_inode->i_sem);
+		return (status);
 	}
 
 	/* We don't update the usages for the autofs daemon itself, this
@@ -229,9 +234,7 @@
 	dentry->d_flags |= DCACHE_AUTOFS_PENDING;
 	d_add(dentry, NULL);
 
-	up(&dir->i_sem);
 	autofs_revalidate(dentry, nd);
-	down(&dir->i_sem);
 
 	/*
 	 * If we are still pending, check if we had to handle
diff -ur -x '*.orig' -x '*.new' linux-2.6.13.3/fs/autofs4/root.c linux-2.6.13.3-autofspatch/fs/autofs4/root.c
--- linux-2.6.13.3/fs/autofs4/root.c	2005-10-03 16:27:35.000000000 -0700
+++ linux-2.6.13.3-autofspatch/fs/autofs4/root.c	2005-11-28 04:22:52.000000000 -0800
@@ -302,7 +302,9 @@
 		DPRINTK("waiting for expire %p name=%.*s",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 
+		up(&dentry->d_parent->d_inode->i_sem);
 		status = autofs4_wait(sbi, dentry, NFY_NONE);
+		down(&dentry->d_parent->d_inode->i_sem);
 		
 		DPRINTK("expire done status=%d", status);
 		
@@ -324,7 +326,9 @@
 		DPRINTK("waiting for mount name=%.*s",
 			 dentry->d_name.len, dentry->d_name.name);
 
+		up(&dentry->d_parent->d_inode->i_sem);
 		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
+		down(&dentry->d_parent->d_inode->i_sem);
 		 
 		DPRINTK("mount done status=%d", status);
 
@@ -351,7 +355,9 @@
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
 		spin_unlock(&dentry->d_lock);
+		up(&dentry->d_parent->d_inode->i_sem);
 		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
+		down(&dentry->d_parent->d_inode->i_sem);
 
 		DPRINTK("mount done status=%d", status);
 
diff -ur -x '*.orig' -x '*.new' linux-2.6.13.3/fs/devfs/base.c linux-2.6.13.3-autofspatch/fs/devfs/base.c
--- linux-2.6.13.3/fs/devfs/base.c	2005-10-03 16:27:35.000000000 -0700
+++ linux-2.6.13.3-autofspatch/fs/devfs/base.c	2005-11-29 04:15:09.000000000 -0800
@@ -2155,34 +2155,12 @@
 	devfs_handle_t parent = get_devfs_entry_from_vfs_inode(dir);
 	struct devfs_lookup_struct *lookup_info = dentry->d_fsdata;
 	DECLARE_WAITQUEUE(wait, current);
-	int need_lock;
 
 	/*
-	 * FIXME HACK
-	 *
 	 * make sure that
 	 *   d_instantiate always runs under lock
 	 *   we release i_sem lock before going to sleep
-	 *
-	 * unfortunately sometimes d_revalidate is called with
-	 * and sometimes without i_sem lock held. The following checks
-	 * attempt to deduce when we need to add (and drop resp.) lock
-	 * here. This relies on current (2.6.2) calling coventions:
-	 *
-	 *   lookup_hash is always run under i_sem and is passing NULL
-	 *   as nd
-	 *
-	 *   open(...,O_CREATE,...) calls _lookup_hash under i_sem
-	 *   and sets flags to LOOKUP_OPEN|LOOKUP_CREATE
-	 *
-	 *   all other invocations of ->d_revalidate seem to happen
-	 *   outside of i_sem
 	 */
-	need_lock = nd &&
-	    (!(nd->flags & LOOKUP_CREATE) || (nd->flags & LOOKUP_PARENT));
-
-	if (need_lock)
-		down(&dir->i_sem);
 
 	if (is_devfsd_or_child(fs_info)) {
 		devfs_handle_t de = lookup_info->de;
@@ -2237,8 +2215,6 @@
 		read_unlock(&parent->u.dir.lock);
 
       out:
-	if (need_lock)
-		up(&dir->i_sem);
 	return 1;
 }				/*  End Function devfs_d_revalidate_wait  */
 
diff -ur -x '*.orig' -x '*.new' linux-2.6.13.3/fs/namei.c linux-2.6.13.3-autofspatch/fs/namei.c
--- linux-2.6.13.3/fs/namei.c	2005-10-03 16:27:35.000000000 -0700
+++ linux-2.6.13.3-autofspatch/fs/namei.c	2005-11-28 04:22:52.000000000 -0800
@@ -393,7 +393,6 @@
 	struct dentry * result;
 	struct inode *dir = parent->d_inode;
 
-	down(&dir->i_sem);
 	/*
 	 * First re-do the cached lookup just in case it was created
 	 * while we waited for the directory semaphore..
@@ -419,7 +418,6 @@
 			else
 				result = dentry;
 		}
-		up(&dir->i_sem);
 		return result;
 	}
 
@@ -427,7 +425,6 @@
 	 * Uhhuh! Nasty case: the cache was re-populated while
 	 * we waited on the semaphore. Need to revalidate.
 	 */
-	up(&dir->i_sem);
 	if (result->d_op && result->d_op->d_revalidate) {
 		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
 			dput(result);
@@ -676,13 +673,16 @@
 		     struct path *path)
 {
 	struct vfsmount *mnt = nd->mnt;
+	struct inode *parent = nd->dentry->d_inode;
 	struct dentry *dentry = __d_lookup(nd->dentry, name);
 
+	down(&parent->i_sem);
 	if (!dentry)
 		goto need_lookup;
 	if (dentry->d_op && dentry->d_op->d_revalidate)
 		goto need_revalidate;
 done:
+	up(&parent->i_sem);
 	path->mnt = mnt;
 	path->dentry = dentry;
 	__follow_mount(path);
@@ -703,6 +703,7 @@
 	goto need_lookup;
 
 fail:
+	up(&parent->i_sem);
 	return PTR_ERR(dentry);
 }
 
@@ -718,7 +719,7 @@
 {
 	struct path next;
 	struct inode *inode;
-	int err;
+	int err, reval;
 	unsigned int lookup_flags = nd->flags;
 	
 	while (*name=='/')
@@ -893,9 +894,17 @@
 		 */
 		if (nd->dentry && nd->dentry->d_sb &&
 		    (nd->dentry->d_sb->s_type->fs_flags & FS_REVAL_DOT)) {
+			struct dentry *nparent;
+
 			err = -ESTALE;
 			/* Note: we do not d_invalidate() */
-			if (!nd->dentry->d_op->d_revalidate(nd->dentry, nd))
+			/* Revalidate requires us to lock the parent.
+			 */
+			nparent = nd->dentry->d_parent;
+			down(&nparent->d_inode->i_sem);
+			reval = nd->dentry->d_op->d_revalidate(nd->dentry, nd);
+			up(&nparent->d_inode->i_sem);
+			if (!reval)
 				break;
 		}
 return_base:

--=-R2xtBjPxUpVCJ73yHc/E--

