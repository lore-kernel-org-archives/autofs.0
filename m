From: Ryan Go <ryan@rentec.com>
Subject: Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Fri, 12 Sep 2003 10:23:20 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.56.0309121017180.7311@vulture.rentec.com>
References: <3F610F3C.5040704@intel.com> <3F611BE8.6040900@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F611BE8.6040900@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arun Sharma <arun.sharma@intel.com>, autofs@linux.kernel.org, nfs@lists.sourceforge.net

Hello,

We have seen the same message on a box with vanilla 2.4.18 kernel with
rmap12h patch. Mount version is 2.11b and autofs4-4.0.0pre10-10 (SuSe
package). If it matters, we are using only nisplus to get our maps.

I know the above setup is kinda old. We are still having some other issues
moving to a newer release.

	<< ryan

On Thu, 11 Sep 2003, H. Peter Anvin wrote:

> Arun Sharma wrote:
> >
> > We've seen a few "VFS: Busy inodes after unmount. Self-destruct in 5
> > seconds.  Have a nice day.." messages on a dual processor NFS client.
> > Here's the use case:
> >
> > - Due to network load issues, the NFS server becomes unreachable for
> > some time
> > - The automounter tries to expire the mount
> > - The unmount finds a couple of busy inodes. Putting some debug printks
> > shows that typically two inodes are busy i.e. have inode->i_count == 1.
> > But they don't have any waiters on inode->i_wait. Further, the inodes
> > that are busy are
> > /mnt/foo     -> autofs mount point
> > /mnt/foo/bar -> bar is a symbolic link
> >
> > It's not clear if this is a NFS issue or a autofs issue, but it's seen
> > often with autofs. Are there any known race conditions that have been
> > fixed after 2.4.20 ? The two calls I'm worried about are:
> >
> > fs/autofs/root.c:305:    d_instantiate(dentry, iget(dir->i_sb,ent->ino));
> > fs/autofs/root.c:416:    d_instantiate(dentry, iget(dir->i_sb,ino));
> >
>
> Which version of autofs are you running?  What version of mount(8)?
>
> It's possible NFS lets you umount a mount which has busy inodes under
> certain conditions.  autofs stresses mounting/umounting NFS in ways that
> sometimes exposes bugs that otherwise wouldn't be seen.
>
> 	-hpa
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
