From: Frank Cusack <fcusack@fcusack.com>
Subject: Re: Re: [autofs] VFS: Busy inodes after unmount on 2 way SMP
Date: Sun, 28 Sep 2003 20:27:58 -0700
Sender: nfs-admin@lists.sourceforge.net
Message-ID: <20030928202757.A21288@google.com>
References: <shsd6dyabju.fsf@charged.uio.no> <Pine.LNX.4.44.0309251614290.22478-100000@fubar.phlinux.com>
Mime-Version: 1.0
Return-path: <nfs-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309251614290.22478-100000@fubar.phlinux.com>; from wago@phlinux.com on Thu, Sep 25, 2003 at 04:17:54PM -0700
Errors-To: nfs-admin@lists.sourceforge.net
List-Help: <mailto:nfs-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:nfs@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=subscribe>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=nfs>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matt C <wago@phlinux.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Hering <olh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Arun Sharma <arun.sharma@intel.com>, autofs@linux.kernel.org, nfs@lists.sourceforge.net, Ian Kent <raven@themaw.net>

Does this patch help?

--- linux-2.4.22/fs/namei.c	2003-08-25 04:44:43.000000000 -0700
+++ linux-2.4.22-gg4/fs/namei.c	2003-09-26 00:03:16.000000000 -0700
@@ -893,6 +893,8 @@ static inline int check_sticky(struct in
  *  7. If we were asked to remove a directory and victim isn't one - ENOTDIR.
  *  8. If we were asked to remove a non-directory and victim isn't one - EISDIR.
  *  9. We can't remove a root or mountpoint.
+ * 10. We don't allow removal of NFS sillyrenamed files; it's handled by
+ *     nfs_async_unlink().
  */
 static inline int may_delete(struct inode *dir,struct dentry *victim, int isdir)
 {
@@ -916,6 +918,8 @@ static inline int may_delete(struct inod
 		return -EISDIR;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
+	if (victim->d_flags & DCACHE_NFSFS_RENAMED)
+		return -EBUSY;
 	return 0;
 }
 
@@ -1484,13 +1488,14 @@ int vfs_unlink(struct inode *dir, struct
 				lock_kernel();
 				error = dir->i_op->unlink(dir, dentry);
 				unlock_kernel();
-				if (!error)
+				if (!error &&
+				    !(dentry->d_flags & DCACHE_NFSFS_RENAMED))
 					d_delete(dentry);
 			}
 		}
 	}
 	up(&dir->i_zombie);
-	if (!error)
+	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED))
 		inode_dir_notify(dir, DN_DELETE);
 	return error;
 }


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/nfs
