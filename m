From: Ian Kent <raven@themaw.net>
Subject: Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Wed, 17 Sep 2003 08:28:37 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0309170825300.21012-100000@wombat.indigo.net.au>
References: <3F610F3C.5040704@intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F610F3C.5040704@intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arun Sharma <arun.sharma@intel.com>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

On Thu, 11 Sep 2003, Arun Sharma wrote:

>
> We've seen a few "VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day.." messages on a dual processor NFS client. Here's the use case:
>
> - Due to network load issues, the NFS server becomes unreachable for some time
> - The automounter tries to expire the mount
> - The unmount finds a couple of busy inodes. Putting some debug printks shows that typically two inodes are busy i.e. have inode->i_count == 1. But they don't have any waiters on inode->i_wait. Further, the inodes that are busy are
> /mnt/foo     -> autofs mount point
> /mnt/foo/bar -> bar is a symbolic link
>
> It's not clear if this is a NFS issue or a autofs issue, but it's seen often with autofs. Are there any known race conditions that have been fixed after 2.4.20 ? The two calls I'm worried about are:
>
> fs/autofs/root.c:305:    d_instantiate(dentry, iget(dir->i_sb,ent->ino));
> fs/autofs/root.c:416:    d_instantiate(dentry, iget(dir->i_sb,ino));
>

This is in the autofs (aka v3) kernel module not autofs4.

Please specify which version of the userspace daemon and kernel module?

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
