From: Ian Kent <raven@themaw.net>
Subject: Re: [NFS] Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Tue, 30 Sep 2003 20:24:46 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0309302012010.2982-100000@raven.themaw.net>
References: <Pine.LNX.4.44.0309290812430.21173-100000@guppy.limebrokerage.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309290812430.21173-100000@guppy.limebrokerage.com>
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
To: Ion Badulescu <lists@news.cs.columbia.edu>
Cc: autofs@linux.kernel.org, Arun Sharma <arun.sharma@intel.com>, nfs@lists.sourceforge.net, "H. Peter Anvin" <hpa@zytor.com>

On Mon, 29 Sep 2003, Ion Badulescu wrote:

> On Wed, 17 Sep 2003, H. Peter Anvin wrote:
> 
> > > Why do you bring the daemon into the picture, it is irrelevant here. 
> > 
> > Because it makes it a lot harder to debug the problem.
> 
> Ok, fair enough.
> 
> The daemon version doesn't matter, any daemon will do. All you need is to 
> kill -9 automountd while something is mounted, and then unmount everything 
> by hand without removing the mountpoint directories.
> 

Yes, your'e exactly right. That's expected behaviour as the directory 
dentries still exist and there is no daemon to remove them. Hence the 
message. Seeing this message has always been a signal to me that the 
daemon has a bug.

I have been thinking that implementing a umount_begin routine in the 
super_operations for autofs4 would remedy the problem. I believe that, 
correct me if I'm wrong, the umount must be done with a force option in 
this case, so the umount_begin would be called.

snip ...

> > 
> > OK.  Did you try Olaf's NFS patch?
> 
> This is not an NFS problem. The message occurs regardless of what is 
> mounted on /misc/homes (NFS, local ext2, bind mount, whatever).

I must admit, reading through the thread, I was wondering how it could 
be an NFS problem.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
