From: Ion Badulescu <lists@news.cs.columbia.edu>
Subject: Re: [NFS] Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Mon, 29 Sep 2003 08:19:50 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0309290812430.21173-100000@guppy.limebrokerage.com>
References: <3F691E75.6040807@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F691E75.6040807@zytor.com>
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
Cc: autofs@linux.kernel.org, Arun Sharma <arun.sharma@intel.com>, nfs@lists.sourceforge.net, Ian Kent <raven@themaw.net>

On Wed, 17 Sep 2003, H. Peter Anvin wrote:

> > Why do you bring the daemon into the picture, it is irrelevant here. 
> 
> Because it makes it a lot harder to debug the problem.

Ok, fair enough.

The daemon version doesn't matter, any daemon will do. All you need is to 
kill -9 automountd while something is mounted, and then unmount everything 
by hand without removing the mountpoint directories.

> > # cat /proc/mounts
> > [snip]
> > boxter:(pid29327) /bar autofs rw 0 0
> > boxter:(pid29327) /net autofs rw 0 0
> > boxter:(pid29327) /src autofs rw 0 0
> > boxter:(pid29327) /misc autofs rw 0 0
> > buggy:/n/buggy/misc/homes /misc/homes nfs rw,v3,rsize=8192,wsize=8192,hard,intr,tcp,lock,addr=buggy 0 0
> > # umount /misc/homes
> > # umount /misc
> > # dmesg |tail
> > VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> 
> OK.  Did you try Olaf's NFS patch?

This is not an NFS problem. The message occurs regardless of what is 
mounted on /misc/homes (NFS, local ext2, bind mount, whatever).

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
