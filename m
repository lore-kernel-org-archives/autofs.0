From: Ian Kent <raven@themaw.net>
Subject: Re: [NFS] Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Wed, 1 Oct 2003 00:44:59 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0310010036060.3492-100000@raven.themaw.net>
References: <Pine.LNX.4.44.0309300849180.27055-100000@guppy.limebrokerage.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309300849180.27055-100000@guppy.limebrokerage.com>
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
To: Ion Badulescu <lists@cs.columbia.edu>
Cc: autofs@linux.kernel.org, Arun Sharma <arun.sharma@intel.com>, "H. Peter Anvin" <hpa@zytor.com>

On Tue, 30 Sep 2003, Ion Badulescu wrote:

> Hi Ian,
> 
> On Tue, 30 Sep 2003, Ian Kent wrote:
> 
> > On Mon, 29 Sep 2003, Ion Badulescu wrote:
> > > The daemon version doesn't matter, any daemon will do. All you need is to 
> > > kill -9 automountd while something is mounted, and then unmount everything 
> > > by hand without removing the mountpoint directories.
> > > 
> > 
> > Yes, your'e exactly right. That's expected behaviour as the directory 
> > dentries still exist and there is no daemon to remove them.
> 
> Hmm. Expected behaviour, you say? Maybe, maybe not, it's hard to tell 
> what's to be expected here, since the autofs umount semantics are so 
> different from a regular filesystems.

For autofs v4 anyway possibly v3 also. Cause of the nature of it.

> 
> Normally a filesystem is allowed to be unmounted if it is not busy, right?
> But with autofs it's different, it should be unmounted only if it is
> completely empty, with no entries at all -- and I'm not convinced the VFS
> layer is up to the task of dealing with this requirement.  Alternatively
> the autofs code should be prepared to clean up after itself, but that
> might not be possible in all circumstances.
> 
> > Hence the message. Seeing this message has always been a signal to me
> > that the daemon has a bug.
> 
> Oh, you're absolutely right here (although we're talking about different
> daemons, I'm using--and expanding, and debugging--amd's autofs support).
> :-) Nonetheless, it's a bug in the kernel code that should be remedied.
> 
> > I have been thinking that implementing a umount_begin routine in the 
> > super_operations for autofs4 would remedy the problem. I believe that, 
> > correct me if I'm wrong, the umount must be done with a force option in 
> > this case, so the umount_begin would be called.
> 
> No, you're right, you need MNT_FORCE for umount_begin to be called.
> 
> That, however, would be a reasonable solution if the filesystem also
> prevented its own unmounting when it is not empty (by having each entry
> hold a reference to the vfsmount in its private data, perhaps, I'm not
> sure). Then, inside umount_begin, and only if the filesystem is catatonic,
> it would garbage-collect any entries not mounted upon and not busy. That
> should work, I think...

As you point out I am talking about autofs not amd.

I think it's a lot simpler than it sounds above. Granted if the tree is 
busy with mounts you can probably only give up but much of the time it's 
not. The logic to traverse the filesystem would be similar to what I have 
used in my rewrite of the expire module in autofs4. Check it out at 
ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4 and let me know if 
you think the idea has merit.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
