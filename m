From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Tue, 29 Nov 2005 20:16:44 -0500
Message-ID: <17292.64892.680738.833917@segfault.boston.redhat.com>
References: <20051116101740.GA9551@RAM>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20051116101740.GA9551@RAM>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ram Pai <linuxram@us.ibm.com>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

==> Regarding [autofs] [RFC PATCH]autofs4: hang and proposed fix; linuxram@us.ibm.com (Ram Pai) adds:

linuxram> Autofs4 assumes that its ->revalidate() function gets called with
linuxram> the parent_dentry's_inode_semaphore released. This is true mostly
linuxram> but not in one particular case.

linuxram> Process P1 calls autofs4's ->lookup(). The lookup finds that the
linuxram> dentry does not exist. It creates a dentry and adds to the
linuxram> cache. Releases the parent's inode's semaphore and than calls
linuxram> ->revalidate().

linuxram> Process P2 meanwhile comes in and cached_lookup() gets called. It
linuxram> finds the dentry in the cache and finds ->revalidate() function
linuxram> exists. So it calls ->revalidate() holding the parent's inode's
linuxram> semaphore.

Can't we simply fix this case?  It seems like it should be perfectly safe
to drop the parent's i_sem before calling revalidate in cached_lookup.  In
fact, there are comments in the NFS code that would lead one to believe
that revalidate is not supposed to be called with the parent's i_sem held:

static int nfs_lookup_revalidate(struct dentry * dentry, struct nameidata *nd)
{
...
	/*
	 * Note: we're not holding inode->i_sem and so may be racing with
	 * operations that change the directory. We therefore save the
	 * change attribute *before* we do the RPC call.
	 */

Can you try out a patch which does this?

-Jeff

--- linux-2.6.14/fs/namei.c.orig	2005-11-29 20:14:30.000000000 -0500
+++ linux-2.6.14/fs/namei.c	2005-11-29 20:14:48.000000000 -0500
@@ -332,10 +332,12 @@ static struct dentry * cached_lookup(str
 		dentry = d_lookup(parent, name);
 
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
+		up(&parent->d_inode->i_sem);
 		if (!dentry->d_op->d_revalidate(dentry, nd) && !d_invalidate(dentry)) {
 			dput(dentry);
 			dentry = NULL;
 		}
+		down(&parent->d_inode->i_sem);
 	}
 	return dentry;
 }
