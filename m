From: Ion Badulescu <lists@news.cs.columbia.edu>
Subject: Re: [NFS] VFS: Busy inodes after unmount on 2 way SMP
Date: Fri, 12 Sep 2003 19:58:30 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0309121957040.9830-100000@moisil.badula.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Sorry, I got the autofs list address wrong the first time around. -Ion

---------- Forwarded message ----------

On Thu, 11 Sep 2003 17:11:40 -0700, Arun Sharma <arun.sharma@intel.com> wrote:

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

I don't know if it's the same issue, but I've seen it many many times 
while testing amd's autofs functionality. It occurs when a non-empty 
autofs filesystem is unmounted, e.g. if it has some leftover 
subdirectories from previous mounts. Therefore I'd say it's quite 
clearly an autofs issue, at least in my case.

Do you see it when shutting down the automounter, or in other cases as 
well?

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
