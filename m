From: Ryan Go <ryan@rentec.com>
Subject: Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Wed, 17 Sep 2003 09:14:38 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.56.0309170911480.12435@vulture.rentec.com>
References: <Pine.LNX.4.33.0309170825300.21012-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0309170825300.21012-100000@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: Arun Sharma <arun.sharma@intel.com>, autofs@linux.kernel.org

Hello Ian,

We have also seen the self-destruct message on boxes with autofs4 in
kernel 2.4.18 (w/ rmap12h patch) and autofs4-4.0.0pre10-10 userspace
daemon.

Thanks,
	<< ryan

On Wed, 17 Sep 2003, Ian Kent wrote:

> On Thu, 11 Sep 2003, Arun Sharma wrote:
>
> >
> > We've seen a few "VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day.." messages on a dual processor NFS client. Here's the use case:
> >
> > - Due to network load issues, the NFS server becomes unreachable for some time
> > - The automounter tries to expire the mount
> > - The unmount finds a couple of busy inodes. Putting some debug printks shows that typically two inodes are busy i.e. have inode->i_count == 1. But they don't have any waiters on inode->i_wait. Further, the inodes that are busy are
> > /mnt/foo     -> autofs mount point
> > /mnt/foo/bar -> bar is a symbolic link
> >
> > It's not clear if this is a NFS issue or a autofs issue, but it's seen often with autofs. Are there any known race conditions that have been fixed after 2.4.20 ? The two calls I'm worried about are:
> >
> > fs/autofs/root.c:305:    d_instantiate(dentry, iget(dir->i_sb,ent->ino));
> > fs/autofs/root.c:416:    d_instantiate(dentry, iget(dir->i_sb,ino));
> >
>
> This is in the autofs (aka v3) kernel module not autofs4.
>
> Please specify which version of the userspace daemon and kernel module?
>
> --
>
>    ,-._|\    Ian Kent
>   /      \   Perth, Western Australia
>   *_.--._/   E-mail: raven@themaw.net
>         v    Web: http://themaw.net/
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
